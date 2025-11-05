 ~/Apps/edge-vpn-container  002-gpu-hardware-acceleration !42 ?3                                                                      
❯ xhost -      
access control enabled, only authorized clients can connect

 ~/Apps/edge-vpn-container  002-gpu-hardware-acceleration !42 ?3                                                                      
❯ xhost +local:docker
non-network local connections being added to access control list

 ~/Apps/edge-vpn-container  002-gpu-hardware-acceleration !42 ?3                                                                      
❯ xhost
access control enabled, only authorized clients can connect
LOCAL:

 ~/Apps/edge-vpn-container  002-gpu-hardware-acceleration !42 ?3                                                                      
❯ ./verify-host.sh   
========================================
Host Display Configuration Verification
========================================

1. Checking DISPLAY variable...
✓ DISPLAY is set: :0
  Meaning: Display server is available on :0

2. Checking X11 socket files...
✓ Found 2 X11 socket(s):
  srwxrwxr-x 1 kkk kkk 0 Nov  5 07:32 X0
  srwxrwxr-x 1 kkk kkk 0 Nov  5 07:32 X1
  Meaning: X server is running and accessible via these sockets

3. Checking xhost access control...
✓ Access control is enabled
  Actual status: Local connections are allowed
  Explanation: This is secure and will work with Docker.

  Raw xhost output:
    access control enabled, only authorized clients can connect
    LOCAL:

4. Checking Docker...
✓ Docker is installed
  Version: Docker version 28.5.1, build e180ab8
✓ Docker is accessible (no sudo required)

5. Checking NVIDIA GPU...
✓ nvidia-smi is available

  GPU Information:
    Model: NVIDIA GeForce RTX 4080 SUPER
    Driver: 580.95.05
    CUDA: 13.0
    Compute Capability: 8.9
    Utilization: 8%
    Memory: 426MB / 16376MB
    Temperature: 40°C

  NVIDIA Capabilities:
    ✓ NVENC (Hardware video encoding) - Available
    ? NVDEC status - Unable to query
    ✓ CUDA Compute - Capability 8.9
    ✓ Display Output - Active (GPU connected to monitor)
    ○ Persistence Mode - Disabled

6. Checking NVIDIA Docker runtime...
✓ NVIDIA runtime is available

  Available runtimes:
     Runtimes: runc io.containerd.runc.v2 nvidia
     Default Runtime: runc
     Init Binary: docker-init
     containerd version: 05044ec0a9a75232cad458027ca83437aae3f4da
     runc version: 
     init version: de40ad0

========================================
Verification Summary
========================================
✓ All checks passed!

Your system is ready to run the container.
Execute: ./run.sh

========================================
Quick Reference
========================================

Enable X11 access for Docker:
  xhost +local:docker

Re-enable access control (if disabled):
  xhost -
  xhost +local:docker

Launch container:
  ./run.sh


 ~/Apps/edge-vpn-container  002-gpu-hardware-acceleration !42 ?3                                                                      
❯ 


