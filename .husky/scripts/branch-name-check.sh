#!/bin/sh

# This script checks branch names against this project's convention
# Project patterns: feat/, api/, config/, fix/

# Get the new branch name from the command arguments
BRANCH_NAME=$(echo "$2" | grep -oE '[^/]+$')

# Define your specific branch naming pattern
PATTERN="^(feat|api|config|fix)\/[a-z0-9]+(-[a-z0-9]+)*$"

# Skip check if it's one of the default branches or no branch detected
if [ "$BRANCH_NAME" = "main" ] || [ "$BRANCH_NAME" = "master" ] || [ "$BRANCH_NAME" = "develop" ] || [ -z "$BRANCH_NAME" ]; then
  exit 0
fi

# Check if the branch name follows the convention
if ! echo "$BRANCH_NAME" | grep -qE "$PATTERN"; then
  echo "❌ ERROR: Branch name '$BRANCH_NAME' doesn't follow the naming convention."
  echo "✅ Branch names should follow this pattern: type/descriptive-name"
  echo "   Valid types for this project: feat, api, config, fix"
  echo "   Examples: feat/onboarding, api/onboarding, config/husky, fix/onboarding"
  exit 1
fi

echo "✅ Branch name follows the project convention!"
exit 0