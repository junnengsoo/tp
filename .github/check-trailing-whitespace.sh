#!/bin/sh
# Checks for trailing whitespace

git grep -I -n --no-color -P '[ \t]+$' -- ':/' |
awk '
    BEGIN {
        FS = ":"
        OFS = ":"
        ret = 0
    }
    {
        # Only warn for markdown files (*.md) to accommodate text editors
        # which do not properly handle trailing whitespace.
        # (e.g. GitHub web editor)
        if ($1 ~ /\.md$/) {
            severity = "WARN"
            ret = 1
        } else {
            severity = "ERROR"
            ret = 1
        }
        print severity, $1, $2, " trailing whitespace."
    }
    END {
        exit ret
    }
'
