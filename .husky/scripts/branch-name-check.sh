#!/bin/sh

# This script checks branch names against this project's convention
# Project patterns: feat/, api/, config/, fix/

# Get the current branch name
BRANCH_NAME=$(git symbolic-ref --short HEAD)

# Define your specific branch naming pattern
PATTERN="^(feat|api|config|fix)\/[a-z0-9]+(-[a-z0-9]+)*$"

# Skip check if it's one of the default branches
if [ "$BRANCH_NAME" = "main" ] || [ "$BRANCH_NAME" = "master" ] || [ "$BRANCH_NAME" = "develop" ]; then
  exit 0
fi

# Check if the branch name follows the convention
if ! echo "$BRANCH_NAME" | grep -qE "$PATTERN"; then
  echo "❌ ERROR: Branch name '$BRANCH_NAME' doesn't follow the naming convention."
  echo "✅ Branch names should follow this pattern: type/descriptive-name"
  echo "   Valid types for this project: feat, api, config, fix"
  echo "   Examples: feat/onboarding, api/onboarding, config/husky, fix/onboarding"
  echo ""
  echo "Your push has been blocked. Please rename your branch and try again."
  echo "You can rename your branch with: git branch -m $BRANCH_NAME <newname>"
  echo "For example: git branch -m $BRANCH_NAME feat/$BRANCH_NAME"
  exit 1
fi

echo "✅ Branch name follows the project convention!"
exit 0