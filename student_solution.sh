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
# ------------------------------------------------------------


# ------------------------------------------------------------
# TODO 2:
# Create the file /webdata/files/index.html
# ------------------------------------------------------------


# ------------------------------------------------------------
# TODO 3:
# Display the current SELinux context
# of /webdata and index.html
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
# ------------------------------------------------------------


# ------------------------------------------------------------
# TODO 5:
# Apply the permanent SELinux rule
# using restorecon recursively.
# ------------------------------------------------------------


# ------------------------------------------------------------
# TODO 6:
# Verify the final SELinux contexts
# of /webdata and index.html
# ------------------------------------------------------------


echo "=========================================="
echo " Assignment completed"
echo "=========================================="

exit 0
```
