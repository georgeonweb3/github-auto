#!/bin/bash

echo "🚀 Starting 100 commits over 20 days (5/day)..."

COMMIT_NUM=1

for day in $(seq 19 -1 0)
do
  for commit in {1..5}
  do
    # Spread commits across working hours: 9am, 11am, 1pm, 3pm, 5pm
    HOUR=$((9 + (commit - 1) * 2))
    COMMIT_DATE=$(date -d "$day days ago" +"%Y-%m-%dT$(printf '%02d' $HOUR):00:00")

    echo "Commit $COMMIT_NUM - $COMMIT_DATE" >> activity.txt
    git add .

    GIT_AUTHOR_DATE="$COMMIT_DATE" \
    GIT_COMMITTER_DATE="$COMMIT_DATE" \
    git commit -m "update: activity $COMMIT_NUM"

    echo "✅ $COMMIT_NUM/100 committed — $COMMIT_DATE"
    COMMIT_NUM=$((COMMIT_NUM + 1))
  done
done

echo ""
echo "🎉 Done! 100 commits across 20 days created."
echo "📤 Now run: git push origin main"
