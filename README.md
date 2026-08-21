# SELinux Permanent File Context Rule Using semanage fcontext

## Aim

To assign a permanent SELinux file context rule for a custom directory using `semanage fcontext` and apply the rule using `restorecon`.

## Requirements

* CentOS / RHEL-compatible Linux system
* SELinux enabled
* `policycoreutils-python-utils` or equivalent package installed
* Root or sudo access
* `semanage` command available
* `restorecon` command available

## Theory

SELinux controls access to files and directories using security contexts.

The `chcon` command can change the SELinux context temporarily. However, the change may not survive a file relabeling operation.

To create a **permanent SELinux context rule**, use:

```bash
semanage fcontext
```

The pattern:

```text
/webdata(/.*)?
```

means that the rule applies to:

* `/webdata`
* Files inside `/webdata`
* Subdirectories inside `/webdata`
* Files inside those subdirectories

The SELinux type required for this assignment is:

```text
httpd_sys_content_t
```

The permanent rule is:

```bash
semanage fcontext -a -t httpd_sys_content_t "/webdata(/.*)?"
```

After adding the rule, use:

```bash
restorecon -Rv /webdata
```

to apply the SELinux context to the directory and its contents.

## Student Task

Complete the file:

```text
student_solution.sh
```

Your program must perform the following operations.

### Step 1 – Create the directory

Create:

```text
/webdata/files
```

using:

```bash
mkdir -p /webdata/files
```

### Step 2 – Create the HTML file

Create:

```text
/webdata/files/index.html
```

### Step 3 – Check the current SELinux context

Display the context of:

```text
/webdata
```

and:

```text
/webdata/files/index.html
```

Use:

```bash
ls -Zd /webdata
ls -Z /webdata/files/index.html
```

### Step 4 – Create the permanent SELinux rule

Use `semanage fcontext` with:

* Directory: `/webdata`
* Pattern: `/webdata(/.*)?`
* SELinux type: `httpd_sys_content_t`

Required command:

```bash
semanage fcontext -a -t httpd_sys_content_t "/webdata(/.*)?"
```

### Step 5 – Apply the SELinux rule

Use:

```bash
restorecon -Rv /webdata
```

### Step 6 – Verify the context

Display the final SELinux contexts:

```bash
ls -Zd /webdata
ls -Z /webdata/files/index.html
```

The expected SELinux type is:

```text
httpd_sys_content_t
```

## Expected Result

The following should show `httpd_sys_content_t` as the SELinux type:

```bash
ls -Zd /webdata
```

and:

```bash
ls -Z /webdata/files/index.html
```

The permanent rule should also be visible using:

```bash
semanage fcontext -l | grep /webdata
```

## Submission Instructions

1. Open your assigned GitHub Classroom repository.
2. Open `student_solution.sh`.
3. Complete all TODO sections.
4. Commit your changes.
5. Push the changes to GitHub.
6. GitHub Actions will automatically execute the test cases.
7. Check the **Actions** tab to see your test result.

## Restrictions

Do not modify:

```text
tests/test.sh
```

Do not modify:

```text
.github/workflows/
```

Only modify:

```text
student_solution.sh
```

## Grading Scheme

| Test                          |   Marks |
| ----------------------------- | ------: |
| Create `/webdata/files`       |      10 |
| Create `index.html`           |      10 |
| Check SELinux context         |      10 |
| Use `semanage fcontext`       |      25 |
| Use `/webdata(/.*)?` pattern  |      15 |
| Use `restorecon -Rv /webdata` |      15 |
| Verify final context          |      15 |
| **Total**                     | **100** |

## Important

Run this assignment only on a laboratory CentOS/RHEL-compatible system or VM.

The assignment modifies:

```text
/webdata
```

and SELinux file-context rules.

Root/sudo privileges may be required.

## Commands to Remember

```bash
mkdir -p /webdata/files

touch /webdata/files/index.html

ls -Zd /webdata

ls -Z /webdata/files/index.html

semanage fcontext -a -t httpd_sys_content_t "/webdata(/.*)?"

restorecon -Rv /webdata

ls -Zd /webdata

ls -Z /webdata/files/index.html
```
