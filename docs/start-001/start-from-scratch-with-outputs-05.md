root@ef6b784a9db0:/# ls -la /opt/microsoft/msedge/
total 449452
drwxr-xr-x 7 root root      4096 Nov  5 06:54 .
drwxr-xr-x 3 root root      4096 Nov  5 06:54 ..
drwxr-xr-x 2 root root      4096 Nov  5 06:54 AdSelectionAttestationsPreloaded
drwxr-xr-x 2 root root      4096 Nov  5 06:54 MEIPreload
drwxr-xr-x 3 root root      4096 Nov  5 06:54 WidevineCdm
drwxr-xr-x 2 root root      4096 Nov  5 06:54 cron
-rw-r--r-- 1 root root       500 Oct 30 13:18 default-app-block
-rw-r--r-- 1 root root  12005632 Oct 30 13:18 icudtl.dat
-rw-r--r-- 1 root root    297736 Oct 30 13:18 libEGL.so
-rw-r--r-- 1 root root   7873112 Oct 30 13:18 libGLESv2.so
-rw-r--r-- 1 root root   1036472 Oct 30 13:18 liblearning_tools.so
-rw-r--r-- 1 root root  12168592 Oct 30 13:18 libmip_core.so
-rw-r--r-- 1 root root   3475216 Oct 30 13:18 libmip_protection_sdk.so
-rw-r--r-- 1 root root   5542384 Oct 30 13:18 liboneauth.so
-rw-r--r-- 1 root root   3382088 Oct 30 13:18 liboneds.so
-rw-r--r-- 1 root root     26880 Oct 30 13:18 libqt5_shim.so
-rw-r--r-- 1 root root     29440 Oct 30 13:18 libqt6_shim.so
-rw-r--r-- 1 root root   2739304 Oct 30 13:18 libtelclient.so
-rw-r--r-- 1 root root   4518424 Oct 30 13:18 libvk_swiftshader.so
-rw-r--r-- 1 root root    657904 Oct 30 13:18 libvulkan.so.1
-rw-r--r-- 1 root root    533576 Oct 30 13:18 libwns_push_client.so
drwxr-xr-x 2 root root     20480 Nov  5 06:54 locales
-rwxr-xr-x 1 root root      1585 Oct 30 13:18 microsoft-edge
-rwxr-xr-x 1 root root 362056936 Oct 30 13:18 msedge
-rwxr-xr-x 1 root root   3931416 Oct 30 13:18 msedge-management-service
-rwsr-xr-x 1 root root     15512 Oct 30 13:18 msedge-sandbox
-rw-r--r-- 1 root root   1249271 Oct 30 13:18 msedge_100_percent.pak
-rw-r--r-- 1 root root   1946804 Oct 30 13:18 msedge_200_percent.pak
-rwxr-xr-x 1 root root   2238864 Oct 30 13:18 msedge_crashpad_handler
-rw-r--r-- 1 root root     10579 Oct 30 13:18 product_logo_128.png
-rw-r--r-- 1 root root       729 Oct 30 13:18 product_logo_16.png
-rw-r--r-- 1 root root      1210 Oct 30 13:18 product_logo_24.png
-rw-r--r-- 1 root root     24850 Oct 30 13:18 product_logo_256.png
-rw-r--r-- 1 root root      1803 Oct 30 13:18 product_logo_32.png
-rw-r--r-- 1 root root      3713 Oct 30 13:18 product_logo_48.png
-rw-r--r-- 1 root root      5656 Oct 30 13:18 product_logo_64.png
-rw-r--r-- 1 root root  33472171 Oct 30 13:18 resources.pak
-rw-r--r-- 1 root root    792041 Oct 30 13:18 v8_context_snapshot.bin
-rw-r--r-- 1 root root       107 Oct 30 13:18 vk_swiftshader_icd.json
-rwxr-xr-x 1 root root     37394 Oct 30 13:18 xdg-mime
-rwxr-xr-x 1 root root     33273 Oct 30 13:18 xdg-settings
root@ef6b784a9db0:/# 


root@ef6b784a9db0:/# dpkg -s microsoft-edge-stable
Package: microsoft-edge-stable
Status: install ok installed
Priority: optional
Section: web
Installed-Size: 618247
Maintainer: Microsoft Edge for Linux Team <EdgeLinuxDev@microsoft.com>
Architecture: amd64
Version: 142.0.3595.53-1
Provides: www-browser
Depends: ca-certificates, fonts-liberation, libasound2 (>= 1.0.17), libatk-bridge2.0-0 (>= 2.5.3), libatk1.0-0 (>= 2.11.90), libatspi2.0-0 (>= 2.9.90), libc6 (>= 2.17), libcairo2 (>= 1.6.0), libcups2 (>= 1.6.0), libcurl3-gnutls | libcurl3-nss | libcurl4 | libcurl3, libdbus-1-3 (>= 1.9.14), libexpat1 (>= 2.1~beta3), libgbm1 (>= 17.1.0~rc2), libglib2.0-0 (>= 2.39.4), libgtk-3-0 (>= 3.9.10) | libgtk-4-1, libnspr4 (>= 2:4.9-2~), libnss3 (>= 2:3.35), libpango-1.0-0 (>= 1.14.0), libudev1 (>= 183), libuuid1 (>= 2.16), libvulkan1, libx11-6 (>= 2:1.4.99.1), libxcb1 (>= 1.9.2), libxcomposite1 (>= 1:0.4.4-1), libxdamage1 (>= 1:1.1), libxext6, libxfixes3, libxkbcommon0 (>= 0.5.0), libxrandr2, wget, xdg-utils (>= 1.0.2)
Pre-Depends: dpkg (>= 1.14.0)
Description: The web browser from Microsoft
 Microsoft Edge is a browser that combines a minimal design with sophisticated technology to make the web faster, safer, and easier.
root@ef6b784a9db0:/#
