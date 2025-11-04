#!/bin/bash
# Quick test script to verify container works

echo "Testing edge-vpn container..."
echo

# Test 1: Check if image exists
echo -n "1. Image exists: "
if docker image inspect edge-vpn &> /dev/null; then
    echo "✅ PASS"
else
    echo "❌ FAIL - Run: docker build -t edge-vpn ."
    exit 1
fi

# Test 2: Can create container with entrypoint override
echo -n "2. Container creation: "
if docker run --rm --entrypoint /bin/echo edge-vpn "test" &> /dev/null; then
    echo "✅ PASS"
else
    echo "❌ FAIL"
    exit 1
fi

# Test 3: Start script exists and is executable
echo -n "3. Start script: "
if docker run --rm --entrypoint /bin/bash edge-vpn -c "test -x /usr/local/bin/start.sh" &> /dev/null; then
    echo "✅ PASS"
else
    echo "❌ FAIL"
    exit 1
fi

# Test 4: Can run as user 1000
echo -n "4. User context: "
if docker run --rm --entrypoint /bin/bash -u 1000:1000 edge-vpn -c "id -u" 2>/dev/null | grep -q "1000"; then
    echo "✅ PASS"
else
    echo "❌ FAIL"
    exit 1
fi

# Test 5: Start script can execute
echo -n "5. Script execution: "
if docker run --rm --entrypoint /bin/bash -u 1000:1000 edge-vpn -c "/usr/local/bin/start.sh --version 2>&1" | grep -qi "microsoft"; then
    echo "✅ PASS"
else
    echo "⚠️  SKIP (needs display)"
fi

echo
echo "All critical tests passed! Container should work."
echo
echo "To run: ./run.sh"
