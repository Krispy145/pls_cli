#!/bin/bash
check_and_configure() {
    ENVIRONMENT=$1
    
    case $ENVIRONMENT in
        "Dev")
            SUFFIX="dev"
            ENV="development"
            ;;
        "Stage")
            SUFFIX="stg"
            ENV="staging"
            ;;
        "Prod")
            SUFFIX="prod"
            ENV="production"
            ;;
        *)
            echo "Invalid environment: $ENVIRONMENT"
            return 1
            ;;
    esac

    CONFIG_FILE="lib/firebase/firebase_options_${SUFFIX}.dart"

    if [ ! -f "$CONFIG_FILE" ]; then
        echo "Firebase $ENVIRONMENT configuration not found."
        read -p "Do you want to configure Firebase for the $ENVIRONMENT environment? (y/n): " -n 1 -r
        echo

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            firebase projects:create -n "{{#titleCase}}{{project_name.paramCase()}}{{/titleCase}}-$ENVIRONMENT" {{project_name.paramCase()}}-$SUFFIX
            echo "Finalising Firebase $ENVIRONMENT project creation..."
            sleep 5
            echo "Firebase $ENVIRONMENT project created successfully."
            echo "Configuring Firebase $ENVIRONMENT project for platforms..."
            flutterfire config \
                --yes \
                --project="{{project_name.paramCase()}}-$SUFFIX" \
                --out="$CONFIG_FILE" \
                --ios-bundle-id="{{application_id}}.$SUFFIX" \
                --android-package-name="{{application_id_android}}.$SUFFIX" \
                --platforms="ios,android,web"

             # Move google-services.json for Android
            mkdir -p android/src/$ENV
            mv android/app/google-services.json android/app/src/$ENV/

            # Move GoogleService-Info.plist for iOS
            mkdir -p ios/Firebase/$ENV
            mv ios/Runner/GoogleService-Info.plist ios/Firebase/$ENV/
        else
            echo "Skipping configuration for $ENVIRONMENT environment."
        fi
    fi
}

echo "This will attempt to create 3 Firebase projects. Named:"
echo "{{project_name.paramCase()}}-dev"
echo "{{project_name.paramCase()}}-stage"
echo "{{project_name.paramCase()}}-prod"

read -p "Are you sure? " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

# Configure for each environment
check_and_configure "Dev"
check_and_configure "Stage"
check_and_configure "Prod"

