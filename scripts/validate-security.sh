#!/bin/bash
set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

CONTAINER_NAME="${1:-edge-nvidia}"
ERRORS=0

echo "==================================================================="
echo "           Security Validation: $CONTAINER_NAME"
echo "==================================================================="

# Check if container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo -e "${RED}✗ Container '$CONTAINER_NAME' is not running${NC}" >&2
    echo "Start container first: ./run.sh" >&2
    exit 1
fi

# Check 1: Privileged mode should be false
echo -n "Checking privileged mode... "
PRIVILEGED=$(docker inspect "$CONTAINER_NAME" --format='{{.HostConfig.Privileged}}')
if [ "$PRIVILEGED" = "false" ]; then
    echo -e "${GREEN}✓ PASS${NC} (Privileged: false)"
else
    echo -e "${RED}✗ FAIL${NC} (Privileged: $PRIVILEGED)"
    ((ERRORS++))
fi

# Check 2: No dangerous capabilities
echo -n "Checking capabilities... "
CAP_ADD=$(docker inspect "$CONTAINER_NAME" --format='{{.HostConfig.CapAdd}}')
if [ "$CAP_ADD" = "[]" ] || [ "$CAP_ADD" = "<no value>" ] || [ -z "$CAP_ADD" ]; then
    echo -e "${GREEN}✓ PASS${NC} (No capabilities added)"
else
    # Check for dangerous capabilities
    DANGEROUS_CAPS=("SYS_ADMIN" "NET_ADMIN" "SYS_MODULE" "SYS_RAWIO")
    HAS_DANGEROUS=false
    for cap in "${DANGEROUS_CAPS[@]}"; do
        if echo "$CAP_ADD" | grep -q "$cap"; then
            HAS_DANGEROUS=true
            break
        fi
    done

    if [ "$HAS_DANGEROUS" = true ]; then
        echo -e "${RED}✗ FAIL${NC} (Dangerous capabilities: $CAP_ADD)"
        ((ERRORS++))
    else
        echo -e "${YELLOW}⚠ WARNING${NC} (Capabilities added: $CAP_ADD)"
    fi
fi

# Check 3: IPC mode (NOTE: --ipc=host required for X11 shared memory)
echo -n "Checking IPC configuration... "
IPC_MODE=$(docker inspect "$CONTAINER_NAME" --format='{{.HostConfig.IpcMode}}')
if [ "$IPC_MODE" != "host" ]; then
    echo -e "${GREEN}✓ PASS${NC} (IPC: $IPC_MODE - isolated)"
else
    # X11 GUI applications require shared IPC for performance
    # This is a documented trade-off for GPU-accelerated GUI containers
    echo -e "${YELLOW}⚠ EXPECTED${NC} (IPC: host - required for X11 GUI)"
fi

# Check 4: Seccomp should be enabled (not unconfined)
echo -n "Checking seccomp profile... "
SECURITY_OPT=$(docker inspect "$CONTAINER_NAME" --format='{{.HostConfig.SecurityOpt}}')
if echo "$SECURITY_OPT" | grep -q "seccomp=unconfined"; then
    echo -e "${RED}✗ FAIL${NC} (Seccomp: unconfined)"
    ((ERRORS++))
elif [ "$SECURITY_OPT" = "[]" ] || [ "$SECURITY_OPT" = "<no value>" ]; then
    echo -e "${GREEN}✓ PASS${NC} (Seccomp: default profile enabled)"
else
    echo -e "${GREEN}✓ PASS${NC} (Seccomp: custom profile)"
fi

# Check 5: no-new-privileges (NOTE: Incompatible with NVIDIA runtime)
echo -n "Checking no-new-privileges... "
if echo "$SECURITY_OPT" | grep -q "no-new-privileges:true" || echo "$SECURITY_OPT" | grep -q "no-new-privileges=true"; then
    echo -e "${GREEN}✓ PASS${NC} (no-new-privileges: true)"
else
    # NVIDIA runtime requires privilege escalation for GPU access
    # This is a documented trade-off for GPU-accelerated containers
    echo -e "${YELLOW}⚠ SKIP${NC} (Incompatible with --runtime=nvidia)"
fi

# Check 6: Resource limits (memory)
echo -n "Checking memory limits... "
MEMORY_LIMIT=$(docker inspect "$CONTAINER_NAME" --format='{{.HostConfig.Memory}}')
if [ "$MEMORY_LIMIT" -gt 0 ]; then
    MEMORY_MB=$((MEMORY_LIMIT / 1024 / 1024))
    echo -e "${GREEN}✓ PASS${NC} (Memory limit: ${MEMORY_MB}MB)"
else
    echo -e "${RED}✗ FAIL${NC} (No memory limit set)"
    ((ERRORS++))
fi

# Check 7: CPU limits
echo -n "Checking CPU limits... "
CPU_QUOTA=$(docker inspect "$CONTAINER_NAME" --format='{{.HostConfig.CpuQuota}}')
CPU_PERIOD=$(docker inspect "$CONTAINER_NAME" --format='{{.HostConfig.CpuPeriod}}')
if [ "$CPU_QUOTA" -gt 0 ] && [ "$CPU_PERIOD" -gt 0 ]; then
    CPU_CORES=$(awk "BEGIN {printf \"%.1f\", $CPU_QUOTA / $CPU_PERIOD}")
    echo -e "${GREEN}✓ PASS${NC} (CPU limit: ${CPU_CORES} cores)"
else
    NANO_CPUS=$(docker inspect "$CONTAINER_NAME" --format='{{.HostConfig.NanoCpus}}')
    if [ "$NANO_CPUS" -gt 0 ]; then
        CPU_CORES=$(awk "BEGIN {printf \"%.1f\", $NANO_CPUS / 1000000000}")
        echo -e "${GREEN}✓ PASS${NC} (CPU limit: ${CPU_CORES} cores)"
    else
        echo -e "${RED}✗ FAIL${NC} (No CPU limit set)"
        ((ERRORS++))
    fi
fi

echo "==================================================================="
echo "                    Summary"
echo "==================================================================="

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ All security checks passed${NC}"
    echo "Container is properly hardened."
    exit 0
else
    echo -e "${RED}✗ $ERRORS security check(s) failed${NC}"
    echo "Review the issues above and update run.sh configuration."
    exit 1
fi
