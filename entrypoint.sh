#!/bin/bash
m=$(sed -n '/localhost/=' src/flux/nylas-api.coffee); 
echo "
@@ -$m,0 +$((m+1)),3 @@
+    else if env in ['selfhosted']
+      @AppID = 'n/a'
+      @APIRoot = '$ENGINE_URL'" > /tmp/nylas-api.patch
patch /tmp/N1/src/flux/nylas-api.coffee /tmp/nylas-api.patch
echo nylas config file patched !

cd /tmp/N1 && script/build && script/grunt mkdeb
