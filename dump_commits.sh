#!/bin/bash
commits=$(git log -n 10 --format="%H")
for commit in $commits; do
    echo "Checking commit: $commit"
    git show $commit:lib/features/discovery/presentation/events/events_page.dart | grep -n "Inspire.backdropBlur"
done
