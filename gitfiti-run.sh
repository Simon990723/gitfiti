#!/bin/bash

# Configuration
# =================================================

# Your Gitfiti array copied from the online editor
GITFITI_ARRAY=(
  44403330200002011104000400033303330222022201110111000
  40000300220022010104400400030303030202000200010001000
  40000300222222010104040400033303330202000200010001000
  44400300202202010104040400000300030202000201110111000
  00400300200002010104040400000300030202000201000001000
  00400300200002010104004400000300030202000201000001000
  44403330200002011104000400033303330222000201110111000
)

# Your GitHub username and email
GIT_AUTHOR="Simon990723"
GIT_EMAIL="simonsohliwei@gmail.com"

# Git repository to use
REPO_URL="https://github.com/Simon990723/gitfiti.git"
REPO_PATH="/c/Users/simon/Downloads/gitfiti-main"

# =================================================

cd "$REPO_PATH" || exit 1

# Initialize the repository and set the remote
git init
git remote add origin "$REPO_URL"

# Clear out any existing commits
git checkout --orphan temp_branch
git add -A
git commit -m "Initial commit"
git branch -D main
git branch -m main
git push -f origin main

# Iterate through the Gitfiti array to create commits
for ((week=0; week<${#GITFITI_ARRAY[@]}; week++)); do
  line=${GITFITI_ARRAY[week]}
  for ((day=0; day<${#line}; day++)); do
    count=${line:$day:1}
    for ((i=0; i<count; i++)); do
      # Calculate the date.
      date_string=$(date -d "$((week * 7 + day)) days ago" +'%Y-%m-%d %H:%M:%S')

      # Create an empty commit.
      GIT_AUTHOR_DATE="$date_string" \
      GIT_COMMITTER_DATE="$date_string" \
      git commit --allow-empty -m "Gitfiti commit"
    done
  done
done

# Push the final changes
git push -f origin main