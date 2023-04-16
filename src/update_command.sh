# Read the yaml file and retrieve app information
readarray -t apps < <(yq e '.apps | keys | .[]' "$CONFIG_FILE")

# Initialize variables for non-GitHub URLs
non_github_apps=""

for app in "${apps[@]}"; do
    # Retrieve the current version of the app from the yaml file
    current_version=$(yq e ".apps.$app.replacements" "$CONFIG_FILE" | sed 's/.*VERSION=\([^[:space:]]*\).*/\1/')

    # Retrieve the changelog URL from the yaml file
    changelog_url=$(yq e ".apps.$app.changelog" "$CONFIG_FILE")

    # Check if the changelog URL is for GitHub
    if [[ "$changelog_url" == *"github.com"* ]]; then
        # Extract the GitHub username and repo name from the changelog URL using jq
        github_info=$(echo "$changelog_url" | jq -R 'split("/") | select(.[2] == "github.com") | {username: .[3], repo_name: .[4]}')
        username=$(echo "$github_info" | jq -r '.username')
        repo_name=$(echo "$github_info" | jq -r '.repo_name')

        # Use the GitHub API to retrieve the latest release version
        latest_version=$(curl -sfL "https://api.github.com/repos/$username/$repo_name/releases/latest" | jq -r ".tag_name")

        # Check if a new version is available
        if [[ "$latest_version" != "" && "$latest_version" != *"$current_version"* ]]; then
            echo "$app: new version available ($latest_version)"
        fi
    else
        # Add the app to the list of non-GitHub URLs
        non_github_apps+="$app: Current Version: $current_version -> $changelog_url"$'\n'
    fi
done

# Check for non-GitHub Apps
if [[ -n "$non_github_apps" ]]; then
    printf "\nNon-GitHub Apps:\n%s" "$non_github_apps"
fi
