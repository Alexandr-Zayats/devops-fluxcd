#!/bin/bash
sed -i -e 's/^/    /g' db.sql
sed -i '' 's/\`/\\`/g' db.sql
sed -i -e 's/$/ \\/g' db.sql
sed -i '' 's/; \\/;/g' db.sql
sed -i '' '/^    -- /d' db.sql
sed -i '' '/^     \\/d' db.sql
