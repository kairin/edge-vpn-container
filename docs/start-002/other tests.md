# Check if DISPLAY variable is set
echo $DISPLAY
###output below
  
root@ef6b784a9db0:/# echo $DISPLAY

root@ef6b784a9db0:/# 

# Try launching Edge
  microsoft-edge
###output below

root@ef6b784a9db0:/# microsoft-edge
[3366:3366:1105/071231.445161:ERROR:content/browser/zygote_host/zygote_host_impl_linux.cc:101] Running as root without --no-sandbox is not supported. See https://crbug.com/638180.
root@ef6b784a9db0:/# 

# If that fails, try with no-sandbox flag
  microsoft-edge --no-sandbox
###output below

root@ef6b784a9db0:/# microsoft-edge --no-sandbox
[3395:3430:1105/071253.366046:ERROR:dbus/bus.cc:408] Failed to connect to the bus: Failed to connect to socket /run/dbus/system_bus_socket: No such file or directory
[3395:3395:1105/071253.367366:ERROR:ui/ozone/platform/x11/ozone_platform_x11.cc:249] Missing X server or $DISPLAY
[3395:3395:1105/071253.367373:ERROR:ui/aura/env.cc:257] The platform failed to initialize.  Exiting.
root@ef6b784a9db0:/# 

# If you get display errors, try this version
  microsoft-edge --no-sandbox --disable-gpu
###output below

root@ef6b784a9db0:/#   microsoft-edge --no-sandbox --disable-gpu
[3437:3472:1105/071325.013741:ERROR:dbus/bus.cc:408] Failed to connect to the bus: Failed to connect to socket /run/dbus/system_bus_socket: No such file or directory
[3437:3437:1105/071325.015398:ERROR:ui/ozone/platform/x11/ozone_platform_x11.cc:249] Missing X server or $DISPLAY
[3437:3437:1105/071325.015405:ERROR:ui/aura/env.cc:257] The platform failed to initialize.  Exiting.
root@ef6b784a9db0:/# 

