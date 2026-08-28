# Student Solution – SELinux Permanent File Context

```bash
#!/bin/bash

# ============================================================
# SELinux Permanent File Context Assignment
# ============================================================
#
# Student Name:
# Register Number:
#
# Complete all TODO sections.
# Do not modify the test files.
# ============================================================

set -u

echo "=========================================="
echo " SELinux Permanent File Context Assignment"
echo "=========================================="

# ------------------------------------------------------------
# TODO 1:
# Create the directory /webdata/files
# ---mkdir -p /webdata/files---------------------------------------------------------


# ------------------------------------------------------------
# TODO 2:
# Create the file /webdata/files/index.html
# -----touch /webdata/files/index.html-------------------------------------------------------


# ------------------------------------------------------------
# TODO 3:
# Display the current SELinux context
# of /webdata and index.hls -Zd /webdata
ls -Z /webdata/files/index.htmltml
# ------------------------------------------------------------


# ------------------------------------------------------------
# TODO 4:
# Add a permanent SELinux file-context rule.
#
# Required:
#   Directory pattern : /webdata(/.*)?
#   SELinux type      : httpd_sys_content_t
#
# Use semanage fcontext
# -semanage fcontext -a -t httpd_sys_content_t-----------------------------------------------------------


# ------------------------------------------------------------
# TODO 5:
# Apply the permanent SELinux rule
# using restorecon recursively.
# restorecon -R -v /webdata------------------------------------------------------------


# ------------------------------------------------------------
# TODO 6:
# Verify the final SELinux contexts
# of /webdata and index.html
# ls -Zd /webdata
ls -Z /webdata/files/index.html------------------------------------------------------------


echo "=========================================="
echo " Assignment completed"
echo "=========================================="

exit 0
```
