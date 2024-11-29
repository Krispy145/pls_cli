#!/bin/bash

# Function to show usage
usage() {
    echo "Usage: $0 [-M | -m | -p]"
    echo "  -M    Increment major version"
    echo "  -m    Increment minor version"
    echo "  -p    Increment patch version"
    exit 1
}

# Parse command-line options
while getopts ":Mmp" opt; do
    case ${opt} in
    M)
        increment="major"
        ;;
    m)
        increment="minor"
        ;;
    p)
        increment="patch"
        ;;
    \?)
        usage
        ;;
    esac
done
shift $((OPTIND - 1))

# Check if an increment type was provided
if [ -z "$increment" ]; then
    usage
fi

# Navigate out of scripts to the extension root directory
cd .. || {
    echo "Directory not found"
    exit 1
}

# Update the version tag in package.json
current_version=$(jq -r '.version' package.json)
IFS='.' read -r -a version_parts <<<"$current_version"

case $increment in
major)
    version_parts[0]=$((version_parts[0] + 1))
    version_parts[1]=0
    version_parts[2]=0
    ;;
minor)
    version_parts[1]=$((version_parts[1] + 1))
    version_parts[2]=0
    ;;
patch)
    version_parts[2]=$((version_parts[2] + 1))
    ;;
esac

new_version="${version_parts[0]}.${version_parts[1]}.${version_parts[2]}"
jq --arg new_version "$new_version" '.version = $new_version' package.json >temp.json && mv temp.json package.json

# Run npm build
npm run build

# Install vsce if not already installed
if ! command -v vsce &>/dev/null; then
    npm install -g vsce
fi

# Package the VS Code extension
vsce package

# Remove previous lets-yak.vsix file if it exists
rm -f lets-yak.vsix

# Rename the newly created .vsix file to lets-yak.vsix
mv *.vsix lets-yak.vsix

# Install the VS Code extension
code --install-extension lets-yak.vsix

echo "VS Code extension updated to version $new_version, built, and installed successfully."
