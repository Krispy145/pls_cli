flutter pub add firebase_core firebase_analytics firebase_crashlytics
echo "This will create 3 Firebase projects. Named:"
echo "{{project_name.paramCase()}}-dev"
echo "{{project_name.paramCase()}}-stage"
echo "{{project_name.paramCase()}}-prod"
read -p "Are you sure? " -n 1 -r
echo    
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

firebase projects:create -n "{{#titleCase}}{{project_name.paramCase()}}-dev{{/titleCase}}" {{project_name.paramCase()}}-dev
firebase projects:create -n "{{#titleCase}}{{project_name.paramCase()}}-stage{{/titleCase}}" {{project_name.paramCase()}}-stage
firebase projects:create -n "{{#titleCase}}{{project_name.paramCase()}}-prod{{/titleCase}}" {{project_name.paramCase()}}-prod

# DEV =====================================================================

flutterfire config \
	--yes \
	--project={{project_name.paramCase()}}-dev \
	--out=lib/firebase/firebase_options_development.dart \
	--ios-bundle-id={{application_id}}.dev \
	--android-package-name={{application_id_android}}.dev \
	--android-out=/android/app/src/development/google-services.json \
	--ios-out=ios/Firebase/development/GoogleService-Info.plist \
	--ios-build-config=Debug-development \
	--platforms="ios,android"

flutterfire config \
	--yes \
	--project={{project_name.paramCase()}}-dev \
	--out=lib/firebase/firebase_options_development.dart \
	--ios-bundle-id={{application_id}}.dev \
	--android-package-name={{application_id_android}}.dev \
	--android-out=/android/app/src/development/google-services.json \
	--ios-out=ios/Firebase/development/GoogleService-Info.plist \
	--ios-build-config=Release-development \
	--platforms="ios,android"

# Staging =====================================================================

flutterfire config \
	--yes \
	--project={{project_name.paramCase()}}-stage \
	--out=lib/firebase/firebase_options_staging.dart \
	--ios-bundle-id={{application_id}}.stage \
	--android-package-name={{application_id_android}}.stage \
	--android-out=/android/app/src/staging/google-services.json \
	--ios-out=ios/Firebase/staging/GoogleService-Info.plist \
	--ios-build-config=Debug-staging \
	--platforms="ios,android"

flutterfire config \
	--yes \
	--project={{project_name.paramCase()}}-stage \
	--out=lib/firebase/firebase_options_staging.dart \
	--ios-bundle-id={{application_id}}.stage \
	--android-package-name={{application_id_android}}.stage \
	--android-out=/android/app/src/staging/google-services.json \
	--ios-out=ios/Firebase/staging/GoogleService-Info.plist \
	--ios-build-config=Release-staging \
	--platforms="ios,android"

# Production =====================================================================

flutterfire config \
	--yes \
	--project={{project_name.paramCase()}}-prod \
	--out=lib/firebase/firebase_options_production.dart \
	--ios-bundle-id={{application_id}}.prod \
	--android-package-name={{application_id_android}}.prod \
	--android-out=/android/app/src/production/google-services.json \
	--ios-out=ios/Firebase/production/GoogleService-Info.plist \
	--ios-build-config=Debug-production \
	--platforms="ios,android"

flutterfire config \
	--yes \
	--project={{project_name.paramCase()}}-prod \
	--out=lib/firebase/firebase_options_production.dart \
	--ios-bundle-id={{application_id}}.prod \
	--android-package-name={{application_id_android}}.prod \
	--android-out=/android/app/src/production/google-services.json \
	--ios-out=ios/Firebase/production/GoogleService-Info.plist \
	--ios-build-config=Release-production \
	--platforms="ios,android"
