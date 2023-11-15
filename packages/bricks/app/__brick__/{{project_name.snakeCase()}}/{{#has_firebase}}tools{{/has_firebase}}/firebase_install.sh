#!/bin/bash
check_and_configure() {
    ENVIRONMENT=$1

    case $ENVIRONMENT in
        "Dev")
            SUFFIX="dev"
            ;;
        "Stage")
            SUFFIX="stage"
            ;;
        "Prod")
            SUFFIX="prod"
            ;;
        *)
            echo "Invalid environment: $ENVIRONMENT"
            return 1
            ;;
    esac

    CONFIG_FILE="lib/firebase/firebase_options_${SUFFIX}.dart"

    if [ ! -f "$CONFIG_FILE" ]; then
        echo "Configuration file $CONFIG_FILE not found."
        read -p "Do you want to configure Firebase for the $ENVIRONMENT environment? (y/n): " -n 1 -r
        echo

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            firebase projects:create -n "{{#titleCase}}{{project_name.paramCase()}}-{{/titleCase}}$ENVIRONMENT" {{project_name.paramCase()}}-$SUFFIX
            flutterfire config \
                --yes \
                --project="{{project_name.paramCase()}}-$SUFFIX" \
                --out="$CONFIG_FILE" \
                --ios-bundle-id="{{application_id}}.$SUFFIX" \
                --android-package-name="{{application_id_android}}.$SUFFIX" \
                --platforms="ios,android,web"
        else
            echo "Skipping configuration for $ENVIRONMENT environment."
        fi
    fi
}

echo "This will create 3 Firebase projects. Named:"
echo "{{project_name.paramCase()}}-dev"
echo "{{project_name.paramCase()}}-stage"
echo "{{project_name.paramCase()}}-prod"

read -p "Are you sure? " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

# Configure for each environment
check_and_configure "development"
check_and_configure "staging"
check_and_configure "production"


# echo "This will create 3 Firebase projects. Named:"
# echo "{{project_name.paramCase()}}-dev"
# echo "{{project_name.paramCase()}}-stage"
# echo "{{project_name.paramCase()}}-prod"
# read -p "Are you sure? " -n 1 -r
# echo    
# if [[ ! $REPLY =~ ^[Yy]$ ]]
# then
#     [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
# fi

# firebase projects:create -n "{{#titleCase}}{{project_name.paramCase()}}-dev{{/titleCase}}" {{project_name.paramCase()}}-dev
# firebase projects:create -n "{{#titleCase}}{{project_name.paramCase()}}-stage{{/titleCase}}" {{project_name.paramCase()}}-stage
# firebase projects:create -n "{{#titleCase}}{{project_name.paramCase()}}-prod{{/titleCase}}" {{project_name.paramCase()}}-prod

# # DEV =====================================================================

# flutterfire config \
# 	--yes \
# 	--project={{project_name.paramCase()}}-dev \
# 	--out=lib/firebase/firebase_options_development.dart \
# 	--ios-bundle-id={{application_id}}.dev \
# 	--android-package-name={{application_id_android}}.dev \	
# 	--platforms="ios,android,web"

# flutterfire config \
# 	--yes \
# 	--project={{project_name.paramCase()}}-dev \
# 	--out=lib/firebase/firebase_options_development.dart \
# 	--ios-bundle-id={{application_id}}.dev \
# 	--android-package-name={{application_id_android}}.dev \	
# 	--platforms="ios,android,web"

# # Staging =====================================================================

# flutterfire config \
# 	--yes \
# 	--project={{project_name.paramCase()}}-stage \
# 	--out=lib/firebase/firebase_options_staging.dart \
# 	--ios-bundle-id={{application_id}}.stage \
# 	--android-package-name={{application_id_android}}.stage \	
# 	--platforms="ios,android,web"

# flutterfire config \
# 	--yes \
# 	--project={{project_name.paramCase()}}-stage \
# 	--out=lib/firebase/firebase_options_staging.dart \
# 	--ios-bundle-id={{application_id}}.stage \
# 	--android-package-name={{application_id_android}}.stage \	
# 	--platforms="ios,android,web"

# # Production =====================================================================

# flutterfire config \
# 	--yes \
# 	--project={{project_name.paramCase()}}-prod \
# 	--out=lib/firebase/firebase_options_production.dart \
# 	--ios-bundle-id={{application_id}}.prod \
# 	--android-package-name={{application_id_android}}.prod \	
# 	--platforms="ios,android,web"

# flutterfire config \
# 	--yes \
# 	--project={{project_name.paramCase()}}-prod \
# 	--out=lib/firebase/firebase_options_production.dart \
# 	--ios-bundle-id={{application_id}}.prod \
# 	--android-package-name={{application_id_android}}.prod \	
# 	--platforms="ios,android,web"
