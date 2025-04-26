#!/bin/sh

# Get the commit message (first argument is the name of the file that contains the message)
COMMIT_MSG_FILE=$1
COMMIT_MSG=$(cat "$COMMIT_MSG_FILE")

# Define the pattern for your commit message format
# format: type: subject
# matching your branch naming convention types (feat, api, config, fix)
PATTERN="^(feat|api|config|fix)(\([a-z0-9-]+\))?: .{1,100}$"

# Check if the commit message follows the convention
if ! echo "$COMMIT_MSG" | grep -qE "$PATTERN"; then
  echo "❌ ERROR: Commit message format is invalid."
  echo "✅ Commit messages must follow this format:"
  echo "   type: subject"
  echo "   or"
  echo "   type(scope): subject"
  echo ""
  echo "   Valid types matching branch conventions: feat, api, config, fix"
  echo "   Scope: optional, describes section of codebase (e.g. onboarding, auth)"
  echo "   Subject: short description of the change (max 100 chars)"
  echo ""
  echo "   Examples:"
  echo "     feat: add user onboarding flow"
  echo "     feat(onboarding): implement welcome screen"
  echo "     api(onboarding): integrate user registration endpoint"
  echo "     config: setup husky pre-commit hooks"
  echo "     fix(onboarding): resolve login button alignment"
  echo "     fix: fix authentication token refresh logic"
  exit 1
fi

echo "✅ Commit message format is valid!"
exit 0