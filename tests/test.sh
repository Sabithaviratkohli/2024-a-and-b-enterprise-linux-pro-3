# Autograder – SELinux Permanent File Context

```bash
#!/bin/bash

# ============================================================
# SELinux fcontext Autograder
# ============================================================

SCRIPT="${1:-student_solution.sh}"

TOTAL=100
SCORE=0
FAILED=0

echo "=========================================="
echo " SELinux fcontext Autograder"
echo "=========================================="

# ------------------------------------------------------------
# Check whether student_solution.sh exists
# ------------------------------------------------------------

if [ ! -f "$SCRIPT" ]; then
    echo "FAIL: $SCRIPT not found"
    exit 1
fi

echo
echo "Checking student solution..."
echo

# ------------------------------------------------------------
# TEST 1 – Create /webdata/files
# 10 Marks
# ------------------------------------------------------------

if grep -Eq 'mkdir[[:space:]]+-p[[:space:]]+/webdata/files' "$SCRIPT"; then
    echo "PASS [10/10] Directory creation command found"
    SCORE=$((SCORE + 10))
else
    echo "FAIL [0/10] mkdir -p /webdata/files not found"
    FAILED=1
fi


# ------------------------------------------------------------
# TEST 2 – Create index.html
# 10 Marks
# ------------------------------------------------------------

if grep -Eq 'touch[[:space:]]+/webdata/files/index\.html' "$SCRIPT"; then
    echo "PASS [10/10] index.html creation command found"
    SCORE=$((SCORE + 10))
else
    echo "FAIL [0/10] index.html creation command not found"
    FAILED=1
fi


# ------------------------------------------------------------
# TEST 3 – Check SELinux context
# 10 Marks
# ------------------------------------------------------------

if grep -Eq 'ls[[:space:]]+-Zd[[:space:]]+/webdata' "$SCRIPT" \
   && grep -Eq 'ls[[:space:]]+-Z[[:space:]]+/webdata/files/index\.html' "$SCRIPT"; then

    echo "PASS [10/10] SELinux context checking commands found"
    SCORE=$((SCORE + 10))
else
    echo "FAIL [0/10] Required ls -Z / ls -Zd commands not found"
    FAILED=1
fi


# ------------------------------------------------------------
# TEST 4 – semanage fcontext
# 25 Marks
# ------------------------------------------------------------

if grep -Eq 'semanage[[:space:]]+fcontext' "$SCRIPT" \
   && grep -Eq 'httpd_sys_content_t' "$SCRIPT"; then

    echo "PASS [25/25] semanage fcontext rule found"
    SCORE=$((SCORE + 25))
else
    echo "FAIL [0/25] Required semanage fcontext rule not found"
    FAILED=1
fi


# ------------------------------------------------------------
# TEST 5 – Correct recursive pattern
# 15 Marks
# ------------------------------------------------------------

if grep -Fq '/webdata(/.*)?' "$SCRIPT"; then
    echo "PASS [15/15] Correct /webdata(/.*)? pattern found"
    SCORE=$((SCORE + 15))
else
    echo "FAIL [0/15] Required /webdata(/.*)? pattern not found"
    FAILED=1
fi


# ------------------------------------------------------------
# TEST 6 – restorecon
# 15 Marks
# ------------------------------------------------------------

if grep -Eq 'restorecon[[:space:]]+-Rv[[:space:]]+/webdata' "$SCRIPT"; then
    echo "PASS [15/15] restorecon -Rv /webdata found"
    SCORE=$((SCORE + 15))
else
    echo "FAIL [0/15] restorecon -Rv /webdata not found"
    FAILED=1
fi


# ------------------------------------------------------------
# TEST 7 – Final verification
# 15 Marks
# ------------------------------------------------------------

if grep -Eq 'ls[[:space:]]+-Zd[[:space:]]+/webdata' "$SCRIPT" \
   && grep -Eq 'ls[[:space:]]+-Z[[:space:]]+/webdata/files/index\.html' "$SCRIPT"; then

    echo "PASS [15/15] Final SELinux context verification found"
    SCORE=$((SCORE + 15))
else
    echo "FAIL [0/15] Final context verification not found"
    FAILED=1
fi


# ------------------------------------------------------------
# FINAL RESULT
# ------------------------------------------------------------

echo
echo "=========================================="
echo " FINAL RESULT"
echo "=========================================="

echo "Score: $SCORE / $TOTAL"

if [ "$SCORE" -eq "$TOTAL" ]; then
    echo "STATUS: PASS"
    echo "Excellent! All required commands were found."
    exit 0
else
    echo "STATUS: NEEDS IMPROVEMENT"
    echo "Please check the failed test cases."
    exit 1
fi
```
