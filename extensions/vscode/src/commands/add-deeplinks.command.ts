import * as vscode from "vscode";
import * as fs from "fs";
import { Uri, window, workspace } from "vscode";
import {
  getFeatureFilePath,
  getTargetDirectory,
} from "../utils/get-target-directory";
import {
  addInjectionAndGetter,
  appendAfterMarkerInContent,
  appendBeforeMarkerInContent,
  upsertFileToPathAndGetContents,
} from "../utils/add_to_files";
import { addFlutterPackageFromPath } from "../utils/add_flutter_package";
import { compareGradleVersions } from "../utils/compare_gradle_versions";
import {
  formatFiles,
  runCommandInWorkspaceFolder,
} from "../utils/build_runner";

export const addDeepLinks = async (args: Uri) => {
  var liveKey = await window.showInputBox({
    prompt: "Branch Live Key",
    placeHolder: "Branch Live Key",
  });
  if (!liveKey) {
    window.showErrorMessage("Branch Live Key is required");
    liveKey = await window.showInputBox({
      prompt: "Branch Live Key",
      placeHolder: "Example: live_key_1234567890",
    });
  }

  const testKey = await window.showInputBox({
    prompt: "Branch Test Key",
    placeHolder: "Branch Test Key",
  });

  var linkDomainPrefix = await window.showInputBox({
    prompt: "Branch Link Domain Prefix",
    placeHolder: "Branch Link Domain Prefix",
  });
  if (!linkDomainPrefix) {
    window.showErrorMessage("Branch Link Domain Prefix is required");
    linkDomainPrefix = await window.showInputBox({
      prompt: "Branch Link Domain Prefix",
      placeHolder: "Example: {PREFIX}.app.link",
    });
  }

  // Prompt user to select local, push, or both notification packages
  const deepLinkConfigurationType = await vscode.window.showQuickPick(
    ["All", "Android", "iOS", "Web"],
    { placeHolder: "Select Deeplinks configuration type" }
  );

  if (!liveKey || !linkDomainPrefix) {
    window.showErrorMessage(
      "Branch Live Key and Link Domain Prefix are required"
    );
    return;
  }

  switch (deepLinkConfigurationType) {
    case "Android":
      addAndroidFiles(liveKey, testKey, linkDomainPrefix);
      break;
    case "iOS":
      addIosFiles(liveKey, testKey, linkDomainPrefix);
      break;
    case "Web":
      addWebFiles(liveKey);
      break;
    default:
      addAndroidFiles(liveKey, testKey, linkDomainPrefix);
      addIosFiles(liveKey, testKey, linkDomainPrefix);
      addWebFiles(liveKey);
      break;
  }

  const injectionContainerPath = getFeatureFilePath(
    "lib/dependencies/injection.dart"
  );

  var fileContent = fs.readFileSync(injectionContainerPath, "utf-8");

  const injectionCode = `
  ..registerSingleton(DeepLinksStore.new)
  `;

  const getterCode = `
/// [DeepLinksStore] getter
DeepLinksStore get deepLinksStore => _serviceLocator.get<DeepLinksStore>();
`;
  fileContent = addInjectionAndGetter({
    fileContent: fileContent,
    storeName: "Deep Links",
    importCode: "import 'package:deeplinks/store.dart';",
    injectionCode,
    getterCode,
    injectInto: "CORE",
  });

  fs.writeFileSync(injectionContainerPath, fileContent);

  const deeplinksPath =
    "/Users/davidkisbey-green/Desktop/Digital_Oasis/deeplinks/";

  addFlutterPackageFromPath("deeplinks", deeplinksPath);
  await formatFiles();
};

function addAndroidFiles(
  liveKey: string,
  testKey: string | undefined,
  linkDomainPrefix: string
) {
  updateAppBuildGradle();
  updateAndroidManifest(liveKey, testKey, linkDomainPrefix);
  addProGuardRules();
}

function addIosFiles(
  liveKey: string,
  testKey: string | undefined,
  linkDomainPrefix: string
) {
  updateInfoPlist(liveKey, testKey, linkDomainPrefix);
}

function addWebFiles(liveKey: string) {
  const webIndexHtmlPath = getFeatureFilePath("web/index.html");
  var webIndexHtmlContent = fs.readFileSync(webIndexHtmlPath, "utf8");
  const newContent = `
  <script>
(function(b,r,a,n,c,h,_,s,d,k){if(!b[n]||!b[n]._q){for(;s<_.length;)c(h,_[s++]);d=r.createElement(a);d.async=1;d.src="https://cdn.branch.io/branch-latest.min.js";k=r.getElementsByTagName(a)[0];k.parentNode.insertBefore(d,k);b[n]=h}})(window,document,"script","branch",function(b,r){b[r]=function(){b._q.push([r,arguments])}},{_q:[],_v:1},"addListener applyCode autoAppIndex banner closeBanner closeJourney creditHistory credits data deepview deepviewCta first getCode init link logout redeem referrals removeListener sendSMS setBranchViewData setIdentity track validateCode trackCommerceEvent logEvent disableTracking".split(" "), 0);
branch.init(${liveKey});
</script>
  `;

  if (webIndexHtmlContent.includes(newContent)) {
    return;
  }
  webIndexHtmlContent = appendAfterMarkerInContent(
    webIndexHtmlContent,
    newContent,
    RegExp("<body>")
  );
  fs.writeFileSync(webIndexHtmlPath, webIndexHtmlContent);
}

function updateAppBuildGradle() {
  const appBuildGradlePath = getFeatureFilePath("android/app/build.gradle");
  var content = fs.readFileSync(appBuildGradlePath, "utf8");

  content = appendAfterMarkerInContent(
    content,
    ", 'proguard-rules.pro'",
    /(\s*proguardFiles getDefaultProguardFile\('proguard-android.txt'\),)/
  );
  fs.writeFileSync(appBuildGradlePath, content);
}

function addProGuardRules() {
  upsertFileToPathAndGetContents(
    "android/app",
    "proguard-rules.pro",
    `
    #Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class com.google.android.gms.ads.identifier.** { *; }
-keep class com.google.android.gms.* {*;}
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient {
    com.google.android.gms.ads.identifier.AdvertisingIdClient$Info getAdvertisingIdInfo(android.content.Context);
}
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient$Info {
    java.lang.String getId();
    boolean isLimitAdTrackingEnabled();
}
`
  );
}

function updateAndroidManifest(
  liveKey: string,
  testKey: string | undefined,
  linkDomainPrefix: string
) {
  const manifestPath = getFeatureFilePath(
    "android/app/src/main/AndroidManifest.xml"
  );
  var androidManifestContent = fs.readFileSync(manifestPath, "utf8");

  androidManifestContent = appendBeforeMarkerInContent(
    androidManifestContent,
    `
    <intent-filter>
				<action android:name="android.intent.action.MAIN" />
				<category android:name="android.intent.category.LAUNCHER" />
			</intent-filter>

			<!-- Branch URI Scheme -->
			<intent-filter>				
				<data android:scheme="${linkDomainPrefix}" android:host="open" />
				<action android:name="android.intent.action.VIEW" />
				<category android:name="android.intent.category.DEFAULT" />
				<category android:name="android.intent.category.BROWSABLE" />
			</intent-filter>

			<!-- Branch App Links - Live App -->
			<intent-filter android:autoVerify="true">
				<action android:name="android.intent.action.VIEW" />
				<category android:name="android.intent.category.DEFAULT" />
				<category android:name="android.intent.category.BROWSABLE" />				
				<data android:scheme="https" android:host="${linkDomainPrefix}.app.link" />				
				<data android:scheme="https" android:host="${linkDomainPrefix}-alternate.app.link" />
			</intent-filter>

			<!-- Branch App Links - Test App -->
			<intent-filter android:autoVerify="true">
				<action android:name="android.intent.action.VIEW" />
				<category android:name="android.intent.category.DEFAULT" />
				<category android:name="android.intent.category.BROWSABLE" />
				<data android:scheme="https" android:host="${linkDomainPrefix}.test-app.link" />	
				<data android:scheme="https" android:host="${linkDomainPrefix}-alternate.test-app.link" />
			</intent-filter>
    `,
    /(\s*<\/activity>)/
  );

  androidManifestContent = appendBeforeMarkerInContent(
    androidManifestContent,
    `
        <!-- Branch init -->		
		<meta-data android:name="io.branch.sdk.BranchKey" android:value="${liveKey}" />				
        `,
    /(\s*<\/application>)/
  );

  if (testKey) {
    androidManifestContent = appendBeforeMarkerInContent(
      androidManifestContent,
      `
      <meta-data android:name="io.branch.sdk.BranchKey.test" android:value="key_test_XXX" />		
      <meta-data android:name="io.branch.sdk.TestMode" android:value="true" />
          `,
      /(\s*<\/application>)/
    );
  }
  fs.writeFileSync(manifestPath, androidManifestContent);
}

function updateInfoPlist(
  liveKey: string,
  testKey: string | undefined,
  linkDomainPrefix: string
) {
  const infoPlistPath = getFeatureFilePath("ios/Runner/Info.plist");
  var infoPlistContent = fs.readFileSync(infoPlistPath, "utf8");

  infoPlistContent = appendBeforeMarkerInContent(
    infoPlistContent,
    `    
		<key>branch_universal_link_domains</key>
		<array>
			<string>${linkDomainPrefix}.app.link</string>
			<string>${linkDomainPrefix}-alternate.app.link</string>
			<string>${linkDomainPrefix}.test.app.link</string>
		</array>
		<key>CFBundleURLTypes</key>
		<array>
			<dict>
				<key>CFBundleTypeRole</key>
				<string>Editor</string>
				<key>CFBundleURLSchemes</key>
				<array>
					<string>branchsters</string>
				</array>
				<key>CFBundleURLName</key>
				<string>io.Branch.Branchsters</string>
			</dict>
		</array>
		<key>branch_key</key>
		<dict>
			<key>live</key>
			<string>${liveKey}</string>			
		</dict>
    `,
    new RegExp("</dict>\n</plist>")
  );

  if (testKey) {
    infoPlistContent = appendBeforeMarkerInContent(
      infoPlistContent,
      `
            <key>test</key>
            <string>${testKey}</string>        
        `,
      RegExp(`s*<key>live<\/key>\s*<string>${liveKey}<\/string>`)
    );
  }
  fs.writeFileSync(infoPlistPath, infoPlistContent);
}
