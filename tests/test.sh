# `tests/test.sh`

```bash
#!/bin/bash

# ============================================================
# SELinux fcontext Assignment - Autograder
# ============================================================

SCRIPT="student_solution.sh"

TOTAL=100
SCORE=0

echo "================================================"
echo " SELinux Permanent File Context Autograder"
echo "================================================"

# ------------------------------------------------------------
# Check student solution file
# ------------------------------------------------------------

if [ ! -f "$SCRIPT" ]; then
    echo "ERROR: $SCRIPT was not found."
    exit 1
fi

echo "Student solution found: $SCRIPT"
echo

# ------------------------------------------------------------
# Test 1 - Create /webdata/files
# 10 Marks
# ------------------------------------------------------------

if grep -Eq 'mkdir[[:space:]]+-p[[:space:]]+/webdata/files' "$SCRIPT"; then
    echo "PASS: Create /webdata/files .............. 10/10"
    SCORE=$((SCORE + 10))
else
    echo "FAIL: Create /webdata/files .............. 0/10"
fi

# ------------------------------------------------------------
# Test 2 - Create index.html
# 10 Marks
# ------------------------------------------------------------

if grep -Eq 'touch[[:space:]]+/webdata/files/index\.html' "$SCRIPT"; then
    echo "PASS: Create index.html .................. 10/10"
    SCORE=$((SCORE + 10))
else
    echo "FAIL: Create index.html .................. 0/10"
fi

# ------------------------------------------------------------
# Test 3 - Check SELinux context
# 10 Marks
# ------------------------------------------------------------

if grep -Eq 'ls[[:space:]]+-Zd[[:space:]]+/webdata' "$SCRIPT" && \
   grep -Eq 'ls[[:space:]]+-Z[[:space:]]+/webdata/files/index\.html' "$SCRIPT"; then

    echo "PASS: Check SELinux context .............. 10/10"
    SCORE=$((SCORE + 10))
else
    echo "FAIL: Check SELinux context .............. 0/10"
fi

# ------------------------------------------------------------
# Test 4 - semanage fcontext
# 25 Marks
# ------------------------------------------------------------

if grep -Eq 'semanage[[:space:]]+fcontext' "$SCRIPT" && \
   grep -Eq 'httpd_sys_content_t' "$SCRIPT"; then

    echo "PASS: semanage fcontext rule ............. 25/25"
    SCORE=$((SCORE + 25))
else
    echo "FAIL: semanage fcontext rule ............. 0/25"
fi

# ------------------------------------------------------------
# Test 5 - Correct recursive pattern
# 15 Marks
# ------------------------------------------------------------

if grep -Fq '/webdata(/.*)?' "$SCRIPT"; then
    echo "PASS: Correct recursive pattern .......... 15/15"
    SCORE=$((SCORE + 15))
else
    echo "FAIL: Correct recursive pattern .......... 0/15"
fi

# ------------------------------------------------------------
# Test 6 - restorecon
# 15 Marks
# ------------------------------------------------------------

if grep -Eq 'restorecon[[:space:]]+-Rv[[:space:]]+/webdata' "$SCRIPT"; then
    echo "PASS: restorecon -Rv /webdata ........... 15/15"
    SCORE=$((SCORE + 15))
else
    echo "FAIL: restorecon -Rv /webdata ........... 0/15"
fi

# ------------------------------------------------------------
# Test 7 - Final verification
# 15 Marks
# ------------------------------------------------------------

# We require the context commands to appear.
# The student should use them after restorecon as instructed.

RESTORE_LINE=$(grep -n 'restorecon[[:space:]]\+-Rv[[:space:]]\+/webdata' "$SCRIPT" | tail -1 | cut -d: -f1)

FINAL_LS=$(grep -n 'ls[[:space:]]\+-Zd[[:space:]]\+/webdata' "$SCRIPT" | tail -1 | cut -d: -f1)

FINAL_FILE=$(grep -n 'ls[[:space:]]\+-Z[[:space:]]\+/webdata/files/index\.html' "$SCRIPT" | tail -1 | cut -d: -f1)

if [ -n "$RESTORE_LINE" ] && \
   [ -n "$FINAL_LS" ] && \
   [ -n "$FINAL_FILE" ] && \
   [ "$FINAL_LS" -gt "$RESTORE_LINE" ] && \
   [ "$FINAL_FILE" -gt "$RESTORE_LINE" ]; then

    echo "PASS: Final context verification ........ 15/15"
    SCORE=$((SCORE + 15))
else
    echo "FAIL: Final context verification ........ 0/15"
fi

# ------------------------------------------------------------
# Final score
# ------------------------------------------------------------

echo
echo "================================================"
echo " FINAL RESULT"
echo "================================================"

echo "Score: $SCORE / $TOTAL"

if [ "$SCORE" -eq "$TOTAL" ]; then
    echo "STATUS: PASS"
    echo "Excellent! All required commands were found."
    exit 0
else
    echo "STATUS: FAIL"
    echo "Please review the failed test cases."
    exit 1
fi
```
