import os
import re
import subprocess

# This script performs several tasks related to configuring AdMob and adding it as a Flutter dependency.

# Before running this script, ensure that you have Python installed globally on your system.
# If you don't have Python installed, you can install it using Homebrew (brew) on macOS or Linux.
# Follow these steps to install Python using Homebrew:
# 1. Open a terminal window.
# 2. Install Homebrew (if not already installed):    
# 3. Once Homebrew is installed, you can install Python by running:
#    brew install python
# 4. Verify Installation: In the terminal, run 'python --version' or 'python3 --version'.
#    You should see the installed Python version.
# 5. (Optional) If Python is not in your system's PATH, you can add it to your PATH by
#    adding the following line to your shell profile file (e.g., ~/.bashrc, ~/.zshrc):
#    export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Get the current directory of the script
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))

# Prompt the user for Android AdMob Application Identifier
ANDROID_APPLICATION_ID = input("Enter Android AdMob Application Identifier: ")

# Prompt the user for iOS AdMob Application Identifier
IOS_GAD_APPLICATION_IDENTIFIER = input("Enter iOS AdMob Application Identifier: ")

# Define file paths
ANDROID_MANIFEST_PATH = os.path.join(
    CURRENT_DIR, "android/app/src/main/AndroidManifest.xml"
)
IOS_INFO_PLIST_PATH = os.path.join(CURRENT_DIR, "ios/Runner/Info.plist")

# AndroidManifest.xml snippet
ANDROID_MANIFEST_SNIPPET = f"""
        <!-- Admob -->
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="{ANDROID_APPLICATION_ID}"/>"""

# iOS Info.plist snippet
IOS_INFO_PLIST_SNIPPET = f"""
    <!-- Admob -->
    <key>GADApplicationIdentifier</key>
    <string>{IOS_GAD_APPLICATION_IDENTIFIER}</string>
    <key>io.flutter.embedded_views_preview</key>
    <true/>
    <key>NSUserTrackingUsageDescription</key>
    <string>This identifier will be used to deliver personalized ads to you.</string>"""

# Add AndroidManifest.xml snippet
with open(ANDROID_MANIFEST_PATH, "r") as android_manifest_file:
    android_manifest_content = android_manifest_file.read()

android_manifest_content = re.sub(
    r"(</application>\s*</manifest>)",
    f"{ANDROID_MANIFEST_SNIPPET}\n\\1",
    android_manifest_content,
)

with open(ANDROID_MANIFEST_PATH, "w") as android_manifest_file:
    android_manifest_file.write(android_manifest_content)

# Add iOS Info.plist snippet
with open(IOS_INFO_PLIST_PATH, "r") as ios_info_plist_file:
    ios_info_plist_content = ios_info_plist_file.read()

ios_info_plist_content = re.sub(
    r"(</dict>\s*</plist>)", f"{IOS_INFO_PLIST_SNIPPET}\n\\1", ios_info_plist_content
)

with open(IOS_INFO_PLIST_PATH, "w") as ios_info_plist_file:
    ios_info_plist_file.write(ios_info_plist_content)


# Prompt the user for AdMob ad unit IDs
BANNER_AD_UNIT_ID = input("Enter your Banner Ad Unit ID: ")
INTERSTITIAL_AD_UNIT_ID = input("Enter your Interstitial Ad Unit ID: ")
REWARD_AD_UNIT_ID = input("Enter your Reward Ad Unit ID: ")

# Import statement to be added
IMPORT_CODE = "import 'package:admob/ads/store.dart';"

# Code snippet to be added
ADMOB_SETUP_CODE = f"""
    ..registerLazySingleton<AdMobStore>(() => AdMobStore(
      bannerAdUnitId: '{BANNER_AD_UNIT_ID}',
      interstitialAdUnitId: '{INTERSTITIAL_AD_UNIT_ID}',
      rewardAdUnitId: '{REWARD_AD_UNIT_ID}',
    ),)
"""

# Getter to be added
GETTER_CODE = "  AdMobStore get adMobStore => _serviceLocator.get<AdMobStore>();"

# Determine the path to injection_container.dart in the current directory
INJECTION_CONTAINER_PATH = os.path.join(
    CURRENT_DIR, "lib/dependency_injection/injection_container.dart"
)

# Read the content of injection_container.dart
with open(INJECTION_CONTAINER_PATH, "r") as file:
    content = file.read()

# Add the import statement after the last import
content = re.sub(r"(import .+;)(?!.*import .+;)", r"\1\n" + IMPORT_CODE, content, 1)

# Find the comment "///END OF CORE" and insert the AdMob setup code just before it
content = re.sub(
    r"(;\s*\n\s*\n\s*///END OF CORE)", f"{ADMOB_SETUP_CODE.strip()}\\1", content
)

# Add the getter at the end of the class
content = re.sub(r"(})(?![\s\S]*\})", GETTER_CODE + r"\n\1", content, 1)

# Write the updated content back to injection_container.dart
with open(INJECTION_CONTAINER_PATH, "w") as file:
    file.write(content)

print("Import statement added to injection_container.dart")
print("AdMob setup code added to injection_container.dart")
print("AdMobStore getter added to injection_container.dart")

# Run the Flutter command to add the dependency
# Define the dependency and path
admob = "/Users/davidkisbey-green/Desktop/Digital_Oasis/admob/"

try:
    result = subprocess.run(
        ["flutter", "pub", "add", "admob", f"--path={admob}"],
        check=True,
        text=True,
        stdout=subprocess.PIPE,
    )
    print(result.stdout)
except subprocess.CalledProcessError as e:
    print(f"Error: {e}")
except Exception as e:
    print(f"An unexpected error occurred: {e}")
print("AdMob package added to dependancies")
