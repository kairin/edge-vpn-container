================================================
executed the following commands:

apt-get update
apt-get install -y curl gnupg ca-certificates
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/microsoft.gpg
echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list
apt-get update
apt-get install -y microsoft-edge-stable

================================================

executed the following commands, to verify what is installed:

root@ef6b784a9db0:/# apt list --installed
Listing... Done
adduser/noble,now 3.137ubuntu1 all [installed]
adwaita-icon-theme/noble,now 46.0-1 all [installed,automatic]
alsa-topology-conf/noble,now 1.2.5.1-2 all [installed,automatic]
alsa-ucm-conf/noble-updates,now 1.2.10-1ubuntu5.7 all [installed,automatic]
apt-utils/noble-updates,now 2.8.3 amd64 [installed]
apt/noble-updates,now 2.8.3 amd64 [installed]
at-spi2-common/noble,now 2.52.0-1build1 all [installed,automatic]
at-spi2-core/noble,now 2.52.0-1build1 amd64 [installed,automatic]
base-files/noble-updates,now 13ubuntu10.3 amd64 [installed]
base-passwd/noble,now 3.6.3build1 amd64 [installed]
bash/noble,now 5.2.21-2ubuntu4 amd64 [installed]
binutils-common/now 2.42-4ubuntu2.5 amd64 [installed,upgradable to: 2.42-4ubuntu2.6]
binutils-x86-64-linux-gnu/now 2.42-4ubuntu2.5 amd64 [installed,upgradable to: 2.42-4ubuntu2.6]
binutils/now 2.42-4ubuntu2.5 amd64 [installed,upgradable to: 2.42-4ubuntu2.6]
bsdutils/noble-updates,now 1:2.39.3-9ubuntu6.3 amd64 [installed]
build-essential/noble,now 12.10ubuntu1 amd64 [installed]
bzip2/noble-updates,now 1.0.8-5.1build0.1 amd64 [installed,automatic]
ca-certificates/noble,now 20240203 all [installed]
coreutils/noble-updates,now 9.4-3ubuntu6.1 amd64 [installed]
cpp-13-x86-64-linux-gnu/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
cpp-13/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
cpp-x86-64-linux-gnu/noble,now 4:13.2.0-7ubuntu1 amd64 [installed,automatic]
cpp/noble,now 4:13.2.0-7ubuntu1 amd64 [installed,automatic]
cuda-cccl-13-0/now 13.0.85-1 amd64 [installed,local]
cuda-compat-13-0/now 580.95.05-0ubuntu1 amd64 [installed,local]
cuda-crt-13-0/now 13.0.88-1 amd64 [installed,local]
cuda-cudart-13-0/now 13.0.96-1 amd64 [installed,local]
cuda-cudart-dev-13-0/now 13.0.96-1 amd64 [installed,local]
cuda-culibos-13-0/now 13.0.85-1 amd64 [installed,local]
cuda-culibos-dev-13-0/now 13.0.85-1 amd64 [installed,local]
cuda-cupti-13-0/now 13.0.85-1 amd64 [installed,local]
cuda-driver-dev-13-0/now 13.0.96-1 amd64 [installed,local]
cuda-nvcc-13-0/now 13.0.88-1 amd64 [installed,local]
cuda-nvrtc-13-0/now 13.0.88-1 amd64 [installed,local]
cuda-nvtx-13-0/now 13.0.85-1 amd64 [installed,local]
cuda-profiler-api-13-0/now 13.0.85-1 amd64 [installed,local]
cuda-toolkit-13-0-config-common/now 13.0.96-1 all [installed,local]
cuda-toolkit-13-config-common/now 13.0.96-1 all [installed,local]
cuda-toolkit-config-common/now 13.0.96-1 all [installed,local]
curl/noble-updates,noble-security,now 8.5.0-2ubuntu10.6 amd64 [installed]
dash/noble,now 0.5.12-6ubuntu5 amd64 [installed]
dbus-bin/noble-updates,now 1.14.10-4ubuntu4.1 amd64 [installed,automatic]
dbus-daemon/noble-updates,now 1.14.10-4ubuntu4.1 amd64 [installed,automatic]
dbus-session-bus-common/noble-updates,now 1.14.10-4ubuntu4.1 all [installed,automatic]
dbus-system-bus-common/noble-updates,now 1.14.10-4ubuntu4.1 all [installed,automatic]
dbus-user-session/noble-updates,now 1.14.10-4ubuntu4.1 amd64 [installed,automatic]
dbus/noble-updates,now 1.14.10-4ubuntu4.1 amd64 [installed,automatic]
dconf-gsettings-backend/noble-updates,now 0.40.0-4ubuntu0.1 amd64 [installed,automatic]
dconf-service/noble-updates,now 0.40.0-4ubuntu0.1 amd64 [installed,automatic]
debconf/noble,now 1.5.86ubuntu1 all [installed]
debianutils/noble,now 5.17build1 amd64 [installed]
diffutils/noble,now 1:3.10-1build1 amd64 [installed]
dirmngr/noble-updates,noble-security,now 2.4.4-2ubuntu17.3 amd64 [installed,automatic]
dmsetup/noble-updates,now 2:1.02.185-3ubuntu3.2 amd64 [installed,automatic]
doca-sdk-common/now 3.1.0105-1 amd64 [installed,local]
doca-sdk-dpdk-bridge/now 3.1.0105-1 amd64 [installed,local]
doca-sdk-eth/now 3.1.0105-1 amd64 [installed,local]
doca-sdk-gpunetio/now 3.1.0105-1 amd64 [installed,local]
doca-sdk-rdma/now 3.1.0105-1 amd64 [installed,local]
doca-sdk-verbs/now 3.1.0105-1 amd64 [installed,local]
dpkg-dev/noble-updates,noble-security,now 1.22.6ubuntu6.5 all [installed,automatic]
dpkg/noble-updates,noble-security,now 1.22.6ubuntu6.5 amd64 [installed]
e2fsprogs/noble-updates,now 1.47.0-2.4~exp1ubuntu4.1 amd64 [installed]
findutils/noble,now 4.9.0-5build1 amd64 [installed]
fontconfig-config/noble,now 2.15.0-1.1ubuntu2 amd64 [installed,automatic]
fontconfig/noble,now 2.15.0-1.1ubuntu2 amd64 [installed,automatic]
fonts-liberation-sans-narrow/noble,now 1:1.07.6-4 all [installed,automatic]
fonts-liberation/noble,now 1:2.1.5-3 all [installed,automatic]
g++-13-x86-64-linux-gnu/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
g++-13/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
g++-x86-64-linux-gnu/noble,now 4:13.2.0-7ubuntu1 amd64 [installed,automatic]
g++/noble,now 4:13.2.0-7ubuntu1 amd64 [installed,automatic]
gcc-13-base/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
gcc-13-x86-64-linux-gnu/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
gcc-13/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
gcc-14-base/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed]
gcc-x86-64-linux-gnu/noble,now 4:13.2.0-7ubuntu1 amd64 [installed,automatic]
gcc/noble,now 4:13.2.0-7ubuntu1 amd64 [installed,automatic]
gir1.2-girepository-2.0/noble,now 1.80.1-1 amd64 [installed,automatic]
gir1.2-glib-2.0/noble-updates,noble-security,now 2.80.0-6ubuntu3.4 amd64 [installed,automatic]
gnupg-utils/noble-updates,noble-security,now 2.4.4-2ubuntu17.3 amd64 [installed,automatic]
gnupg/noble-updates,noble-security,now 2.4.4-2ubuntu17.3 all [installed]
gpg-agent/noble-updates,noble-security,now 2.4.4-2ubuntu17.3 amd64 [installed,automatic]
gpg/noble-updates,noble-security,now 2.4.4-2ubuntu17.3 amd64 [installed,automatic]
gpgconf/noble-updates,noble-security,now 2.4.4-2ubuntu17.3 amd64 [installed,automatic]
gpgsm/noble-updates,noble-security,now 2.4.4-2ubuntu17.3 amd64 [installed,automatic]
gpgv/noble-updates,noble-security,now 2.4.4-2ubuntu17.3 amd64 [installed]
grep/noble,now 3.11-4build1 amd64 [installed]
gsettings-desktop-schemas/noble-updates,now 46.1-0ubuntu1 all [installed,automatic]
gtk-update-icon-cache/noble-updates,now 3.24.41-4ubuntu1.3 amd64 [installed,automatic]
gzip/noble-updates,now 1.12-1ubuntu3.1 amd64 [installed]
hicolor-icon-theme/noble,now 0.17-2 all [installed,automatic]
hostname/noble,now 3.23+nmu2ubuntu2 amd64 [installed]
humanity-icon-theme/noble,now 0.6.16 all [installed,automatic]
hwdata/noble,now 0.379-1 all [installed,automatic]
ibverbs-providers/now 56.0-1 amd64 [installed,local]
ibverbs-utils/now 56.0-1 amd64 [installed,local]
init-system-helpers/noble,now 1.66ubuntu1 all [installed]
jq/noble-updates,noble-security,now 1.7.1-3ubuntu0.24.04.1 amd64 [installed]
keyboxd/noble-updates,noble-security,now 2.4.4-2ubuntu17.3 amd64 [installed,automatic]
libacl1/noble-updates,now 2.3.2-1build1.1 amd64 [installed]
libapparmor1/noble-updates,now 4.0.1really4.0.1-0ubuntu0.24.04.4 amd64 [installed,automatic]
libapt-pkg6.0t64/noble-updates,now 2.8.3 amd64 [installed]
libargon2-1/noble,now 0~20190702+dfsg-4build1 amd64 [installed,automatic]
libasan8/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libasound2-data/noble-updates,now 1.2.11-1ubuntu0.1 all [installed,automatic]
libasound2t64/noble-updates,now 1.2.11-1ubuntu0.1 amd64 [installed,automatic]
libassuan0/noble,now 2.5.6-1build1 amd64 [installed]
libatk-bridge2.0-0t64/noble,now 2.52.0-1build1 amd64 [installed,automatic]
libatk1.0-0t64/noble,now 2.52.0-1build1 amd64 [installed,automatic]
libatomic1/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libatspi2.0-0t64/noble,now 2.52.0-1build1 amd64 [installed,automatic]
libattr1/noble-updates,now 1:2.5.2-1build1.1 amd64 [installed]
libaudit-common/noble-updates,now 1:3.1.2-2.1build1.1 all [installed]
libaudit1/noble-updates,now 1:3.1.2-2.1build1.1 amd64 [installed]
libauthen-sasl-perl/noble,now 2.1700-1 all [installed,automatic]
libavahi-client3/noble,now 0.8-13ubuntu6 amd64 [installed,automatic]
libavahi-common-data/noble,now 0.8-13ubuntu6 amd64 [installed,automatic]
libavahi-common3/noble,now 0.8-13ubuntu6 amd64 [installed,automatic]
libbinutils/now 2.42-4ubuntu2.5 amd64 [installed,upgradable to: 2.42-4ubuntu2.6]
libblkid1/noble-updates,now 2.39.3-9ubuntu6.3 amd64 [installed]
libbrotli1/noble,now 1.1.0-2build2 amd64 [installed,automatic]
libbsd0/noble-updates,now 0.12.1-1build1.1 amd64 [installed,automatic]
libbz2-1.0/noble-updates,now 1.0.8-5.1build0.1 amd64 [installed]
libc-bin/noble-updates,noble-security,now 2.39-0ubuntu8.6 amd64 [installed]
libc-dev-bin/noble-updates,noble-security,now 2.39-0ubuntu8.6 amd64 [installed,automatic]
libc6-dev/noble-updates,noble-security,now 2.39-0ubuntu8.6 amd64 [installed,automatic]
libc6/noble-updates,noble-security,now 2.39-0ubuntu8.6 amd64 [installed]
libcairo-gobject2/noble,now 1.18.0-3build1 amd64 [installed,automatic]
libcairo2/noble,now 1.18.0-3build1 amd64 [installed,automatic]
libcap-ng0/noble,now 0.8.4-2build2 amd64 [installed]
libcap2/noble-updates,noble-security,now 1:2.66-5ubuntu2.2 amd64 [installed]
libcc1-0/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libclone-perl/noble,now 0.46-1build3 amd64 [installed,automatic]
libcolord2/noble,now 1.4.7-1build2 amd64 [installed,automatic]
libcom-err2/noble-updates,now 1.47.0-2.4~exp1ubuntu4.1 amd64 [installed]
libcrypt-dev/noble,now 1:4.4.36-4build1 amd64 [installed,automatic]
libcrypt1/noble,now 1:4.4.36-4build1 amd64 [installed]
libcryptsetup12/noble-updates,now 2:2.7.0-1ubuntu4.2 amd64 [installed,automatic]
libctf-nobfd0/now 2.42-4ubuntu2.5 amd64 [installed,upgradable to: 2.42-4ubuntu2.6]
libctf0/now 2.42-4ubuntu2.5 amd64 [installed,upgradable to: 2.42-4ubuntu2.6]
libcublas-13-0/now 13.1.0.3-1 amd64 [installed,local]
libcudnn9-cuda-13/now 9.14.0.64-1 amd64 [installed,local]
libcufft-13-0/now 12.0.0.61-1 amd64 [installed,local]
libcufile-13-0/now 1.15.1.6-1 amd64 [installed,local]
libcups2t64/noble-updates,noble-security,now 2.4.7-1.2ubuntu7.4 amd64 [installed,automatic]
libcurand-13-0/now 10.4.0.35-1 amd64 [installed,local]
libcurl4t64/noble-updates,noble-security,now 8.5.0-2ubuntu10.6 amd64 [installed,automatic]
libcusolver-13-0/now 12.0.4.66-1 amd64 [installed,local]
libcusparse-13-0/now 12.6.3.3-1 amd64 [installed,local]
libcusparselt0-cuda-13/now 0.8.1.1-1 amd64 [installed,local]
libdata-dump-perl/noble,now 1.25-1 all [installed,automatic]
libdatrie1/noble,now 0.2.13-3build1 amd64 [installed,automatic]
libdb5.3t64/noble,now 5.3.28+dfsg2-7 amd64 [installed,automatic]
libdbus-1-3/noble-updates,now 1.14.10-4ubuntu4.1 amd64 [installed,automatic]
libdbus-1-dev/noble-updates,now 1.14.10-4ubuntu4.1 amd64 [installed,automatic]
libdconf1/noble-updates,now 0.40.0-4ubuntu0.1 amd64 [installed,automatic]
libdebconfclient0/noble,now 0.271ubuntu3 amd64 [installed]
libdeflate0/noble-updates,now 1.19-1build1.1 amd64 [installed,automatic]
libdevmapper1.02.1/noble-updates,now 2:1.02.185-3ubuntu3.2 amd64 [installed,automatic]
libdpkg-perl/noble-updates,noble-security,now 1.22.6ubuntu6.5 all [installed,automatic]
libdrm-amdgpu1/noble-updates,now 2.4.122-1~ubuntu0.24.04.1 amd64 [installed,automatic]
libdrm-common/noble-updates,now 2.4.122-1~ubuntu0.24.04.1 all [installed,automatic]
libdrm-intel1/noble-updates,now 2.4.122-1~ubuntu0.24.04.1 amd64 [installed,automatic]
libdrm2/noble-updates,now 2.4.122-1~ubuntu0.24.04.1 amd64 [installed,automatic]
libedit2/noble,now 3.1-20230828-1build1 amd64 [installed,automatic]
libegl-mesa0/noble-updates,now 25.0.7-0ubuntu0.24.04.2 amd64 [installed,automatic]
libegl1/noble,now 1.7.0-1build1 amd64 [installed,automatic]
libelf1t64/noble-updates,noble-security,now 0.190-1.1ubuntu0.1 amd64 [installed,automatic]
libencode-locale-perl/noble,now 1.05-3 all [installed,automatic]
libepoxy0/noble,now 1.5.10-1build1 amd64 [installed,automatic]
libexpat1/noble-updates,noble-security,now 2.6.1-2ubuntu0.3 amd64 [installed,automatic]
libext2fs2t64/noble-updates,now 1.47.0-2.4~exp1ubuntu4.1 amd64 [installed]
libfabric-aws-bin/now 1.22.0amzn5.0 amd64 [installed,local]
libfabric-aws-dev/now 1.22.0amzn5.0 amd64 [installed,local]
libfabric1-aws/now 1.22.0amzn5.0 amd64 [installed,local]
libfdisk1/noble-updates,now 2.39.3-9ubuntu6.3 amd64 [installed,automatic]
libffi8/noble,now 3.4.6-1build1 amd64 [installed]
libfile-basedir-perl/noble,now 0.09-2 all [installed,automatic]
libfile-desktopentry-perl/noble,now 0.22-3 all [installed,automatic]
libfile-listing-perl/noble,now 6.16-1 all [installed,automatic]
libfile-mimeinfo-perl/noble,now 0.34-1 all [installed,automatic]
libfont-afm-perl/noble,now 1.20-4 all [installed,automatic]
libfontconfig1/noble,now 2.15.0-1.1ubuntu2 amd64 [installed,automatic]
libfreetype6/noble,now 2.13.2+dfsg-1build3 amd64 [installed,automatic]
libfribidi0/noble,now 1.0.13-3build1 amd64 [installed,automatic]
libgbm1/noble-updates,now 25.0.7-0ubuntu0.24.04.2 amd64 [installed,automatic]
libgcc-13-dev/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
libgcc-s1/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed]
libgcrypt20/noble,now 1.10.3-2build1 amd64 [installed]
libgdbm-compat4t64/noble,now 1.23-5.1build1 amd64 [installed,automatic]
libgdbm6t64/noble,now 1.23-5.1build1 amd64 [installed,automatic]
libgdk-pixbuf-2.0-0/noble-updates,noble-security,now 2.42.10+dfsg-3ubuntu3.2 amd64 [installed,automatic]
libgdk-pixbuf2.0-bin/noble-updates,noble-security,now 2.42.10+dfsg-3ubuntu3.2 amd64 [installed,automatic]
libgdk-pixbuf2.0-common/noble-updates,noble-security,now 2.42.10+dfsg-3ubuntu3.2 all [installed,automatic]
libgdrapi/now 2.5.1 amd64 [installed,local]
libgirepository-1.0-1/noble,now 1.80.1-1 amd64 [installed,automatic]
libgl1-mesa-dri/noble-updates,now 25.0.7-0ubuntu0.24.04.2 amd64 [installed,automatic]
libgl1/noble,now 1.7.0-1build1 amd64 [installed,automatic]
libgles2/noble,now 1.7.0-1build1 amd64 [installed,automatic]
libglib2.0-0t64/noble-updates,noble-security,now 2.80.0-6ubuntu3.4 amd64 [installed,automatic]
libglib2.0-data/noble-updates,noble-security,now 2.80.0-6ubuntu3.4 all [installed,automatic]
libglvnd0/noble,now 1.7.0-1build1 amd64 [installed,automatic]
libglx-mesa0/noble-updates,now 25.0.7-0ubuntu0.24.04.2 amd64 [installed,automatic]
libglx0/noble,now 1.7.0-1build1 amd64 [installed,automatic]
libgmp10/noble-updates,now 2:6.3.0+dfsg-2ubuntu6.1 amd64 [installed]
libgnutls30t64/noble-updates,noble-security,now 3.8.3-1.1ubuntu3.4 amd64 [installed]
libgomp1/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libgpg-error0/noble-updates,now 1.47-3build2.1 amd64 [installed]
libgprofng0/now 2.42-4ubuntu2.5 amd64 [installed,upgradable to: 2.42-4ubuntu2.6]
libgraphite2-3/noble,now 1.3.14-2build1 amd64 [installed,automatic]
libgssapi-krb5-2/noble-updates,noble-security,now 1.20.1-6ubuntu2.6 amd64 [installed,automatic]
libgtk-3-0t64/noble-updates,now 3.24.41-4ubuntu1.3 amd64 [installed,automatic]
libgtk-3-bin/noble-updates,now 3.24.41-4ubuntu1.3 amd64 [installed,automatic]
libgtk-3-common/noble-updates,now 3.24.41-4ubuntu1.3 all [installed,automatic]
libharfbuzz0b/noble,now 8.3.0-2build2 amd64 [installed,automatic]
libhogweed6t64/noble-updates,now 3.9.1-2.2build1.1 amd64 [installed]
libhtml-form-perl/noble,now 6.11-1 all [installed,automatic]
libhtml-format-perl/noble,now 2.16-2 all [installed,automatic]
libhtml-parser-perl/noble,now 3.81-1build3 amd64 [installed,automatic]
libhtml-tagset-perl/noble,now 3.20-6 all [installed,automatic]
libhtml-tree-perl/noble,now 5.07-3 all [installed,automatic]
libhttp-cookies-perl/noble,now 6.11-1 all [installed,automatic]
libhttp-daemon-perl/noble,now 6.16-1 all [installed,automatic]
libhttp-date-perl/noble,now 6.06-1 all [installed,automatic]
libhttp-message-perl/noble,now 6.45-1ubuntu1 all [installed,automatic]
libhttp-negotiate-perl/noble,now 6.01-2 all [installed,automatic]
libhwasan0/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libibumad-dev/now 56.0-1 amd64 [installed,local]
libibumad3/now 56.0-1 amd64 [installed,local]
libibverbs-dev/now 56.0-1 amd64 [installed,local]
libibverbs1/now 56.0-1 amd64 [installed,local]
libice6/noble,now 2:1.0.10-1build3 amd64 [installed,automatic]
libicu74/noble-updates,now 74.2-1ubuntu3.1 amd64 [installed,automatic]
libidn2-0/noble-updates,now 2.3.7-2build1.1 amd64 [installed]
libio-html-perl/noble,now 1.004-3 all [installed,automatic]
libio-socket-ssl-perl/noble,now 2.085-1 all [installed,automatic]
libio-stringy-perl/noble,now 2.111-3 all [installed,automatic]
libipc-system-simple-perl/noble,now 1.30-2 all [installed,automatic]
libisl23/noble-updates,now 0.26-3build1.1 amd64 [installed,automatic]
libitm1/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libjansson4/noble,now 2.14-2build2 amd64 [installed,automatic]
libjbig0/noble,now 2.1-6.1ubuntu2 amd64 [installed,automatic]
libjpeg-turbo8/noble,now 2.1.5-2ubuntu2 amd64 [installed,automatic]
libjpeg8/noble,now 8c-2ubuntu11 amd64 [installed,automatic]
libjq1/noble-updates,noble-security,now 1.7.1-3ubuntu0.24.04.1 amd64 [installed,automatic]
libjson-c5/noble,now 0.17-1build1 amd64 [installed,automatic]
libk5crypto3/noble-updates,noble-security,now 1.20.1-6ubuntu2.6 amd64 [installed,automatic]
libkeyutils1/noble,now 1.6.3-3build1 amd64 [installed,automatic]
libkmod2/noble-updates,now 31+20240202-2ubuntu7.1 amd64 [installed,automatic]
libkrb5-3/noble-updates,noble-security,now 1.20.1-6ubuntu2.6 amd64 [installed,automatic]
libkrb5support0/noble-updates,noble-security,now 1.20.1-6ubuntu2.6 amd64 [installed,automatic]
libksba8/noble,now 1.6.6-1build1 amd64 [installed,automatic]
liblcms2-2/noble,now 2.14-2build1 amd64 [installed,automatic]
libldap2/noble-updates,now 2.6.7+dfsg-1~exp1ubuntu8.2 amd64 [installed,automatic]
liblerc4/noble,now 4.0.0+ds-4ubuntu2 amd64 [installed,automatic]
libllvm20/noble-updates,now 1:20.1.2-0ubuntu1~24.04.2 amd64 [installed,automatic]
liblsan0/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
liblwp-mediatypes-perl/noble,now 6.04-2 all [installed,automatic]
liblwp-protocol-https-perl/noble,now 6.13-1 all [installed,automatic]
liblz4-1/noble-updates,now 1.9.4-1build1.1 amd64 [installed]
liblzma5/noble-updates,noble-security,now 5.6.1+really5.4.5-1ubuntu0.2 amd64 [installed]
libmailtools-perl/noble,now 2.21-2 all [installed,automatic]
libmd0/noble-updates,now 1.1.0-2build1.1 amd64 [installed]
libmount1/noble-updates,now 2.39.3-9ubuntu6.3 amd64 [installed]
libmpc3/noble-updates,now 1.3.1-1build1.1 amd64 [installed,automatic]
libmpfr6/noble-updates,now 4.2.1-1build1.1 amd64 [installed,automatic]
libnccl2/now 2.27.7-1+cuda13.0 amd64 [installed,local]
libncurses6/noble,now 6.4+20240113-1ubuntu2 amd64 [installed]
libncursesw6/noble,now 6.4+20240113-1ubuntu2 amd64 [installed]
libnet-dbus-perl/noble,now 1.2.0-2build3 amd64 [installed,automatic]
libnet-http-perl/noble,now 6.23-1 all [installed,automatic]
libnet-smtp-ssl-perl/noble,now 1.04-2 all [installed,automatic]
libnet-ssleay-perl/noble,now 1.94-1build4 amd64 [installed,automatic]
libnettle8t64/noble-updates,now 3.9.1-2.2build1.1 amd64 [installed]
libnghttp2-14/noble-updates,now 1.59.0-1ubuntu0.2 amd64 [installed,automatic]
libnl-3-200/noble-updates,now 3.7.0-0.3build1.1 amd64 [installed]
libnl-3-dev/noble-updates,now 3.7.0-0.3build1.1 amd64 [installed]
libnl-route-3-200/noble-updates,now 3.7.0-0.3build1.1 amd64 [installed]
libnl-route-3-dev/noble-updates,now 3.7.0-0.3build1.1 amd64 [installed]
libnpp-13-0/now 13.0.1.2-1 amd64 [installed,local]
libnpth0t64/noble,now 1.6-3.1build1 amd64 [installed]
libnspr4/noble,now 2:4.35-1.1build1 amd64 [installed,automatic]
libnss-systemd/noble-updates,now 255.4-1ubuntu8.11 amd64 [installed,automatic]
libnss3/noble,now 2:3.98-1build1 amd64 [installed,automatic]
libnuma1/noble,now 2.0.18-1build1 amd64 [installed,automatic]
libnvfatbin-13-0/now 13.0.85-1 amd64 [installed,local]
libnvinfer-dispatch10/now 10.13.3.9-1+cuda13.0 amd64 [installed,local]
libnvinfer-lean10/now 10.13.3.9-1+cuda13.0 amd64 [installed,local]
libnvinfer-plugin10/now 10.13.3.9-1+cuda13.0 amd64 [installed,local]
libnvinfer-vc-plugin10/now 10.13.3.9-1+cuda13.0 amd64 [installed,local]
libnvinfer-win-builder-resource10/now 10.13.3.9-1+cuda13.0 amd64 [installed,local]
libnvinfer10/now 10.13.3.9-1+cuda13.0 amd64 [installed,local]
libnvjitlink-13-0/now 13.0.88-1 amd64 [installed,local]
libnvjpeg-13-0/now 13.0.1.86-1 amd64 [installed,local]
libnvonnxparsers10/now 10.13.3.9-1+cuda13.0 amd64 [installed,local]
libnvptxcompiler-13-0/now 13.0.88-1 amd64 [installed,local]
libnvvm-13-0/now 13.0.88-1 amd64 [installed,local]
libonig5/noble,now 6.9.9-1build1 amd64 [installed,automatic]
libp11-kit0/noble-updates,now 0.25.3-4ubuntu2.1 amd64 [installed]
libpam-modules-bin/noble-updates,noble-security,now 1.5.3-5ubuntu5.5 amd64 [installed]
libpam-modules/noble-updates,noble-security,now 1.5.3-5ubuntu5.5 amd64 [installed]
libpam-runtime/noble-updates,noble-security,now 1.5.3-5ubuntu5.5 all [installed]
libpam-systemd/noble-updates,now 255.4-1ubuntu8.11 amd64 [installed,automatic]
libpam0g/noble-updates,noble-security,now 1.5.3-5ubuntu5.5 amd64 [installed]
libpango-1.0-0/noble,now 1.52.1+ds-1build1 amd64 [installed,automatic]
libpangocairo-1.0-0/noble,now 1.52.1+ds-1build1 amd64 [installed,automatic]
libpangoft2-1.0-0/noble,now 1.52.1+ds-1build1 amd64 [installed,automatic]
libpcap0.8-dev/noble,now 1.10.4-4.1ubuntu3 amd64 [installed,automatic]
libpcap0.8t64/noble,now 1.10.4-4.1ubuntu3 amd64 [installed,automatic]
libpci3/noble,now 1:3.10.0-2build1 amd64 [installed,automatic]
libpciaccess0/noble-updates,now 0.17-3ubuntu0.24.04.2 amd64 [installed,automatic]
libpcre2-8-0/noble-updates,now 10.42-4ubuntu2.1 amd64 [installed]
libperl5.38t64/noble-updates,noble-security,now 5.38.2-3.2ubuntu0.2 amd64 [installed,automatic]
libpixman-1-0/noble,now 0.42.2-1build1 amd64 [installed,automatic]
libpkgconf3/noble,now 1.8.1-2build1 amd64 [installed,automatic]
libpng16-16t64/noble,now 1.6.43-5build1 amd64 [installed,automatic]
libproc2-0/noble-updates,now 2:4.0.4-4ubuntu3.2 amd64 [installed]
libpsl5t64/noble,now 0.21.2-1.1build1 amd64 [installed,automatic]
libpython3-stdlib/noble-updates,now 3.12.3-0ubuntu2 amd64 [installed,automatic]
libpython3.12-minimal/noble-updates,noble-security,now 3.12.3-1ubuntu0.8 amd64 [installed,automatic]
libpython3.12-stdlib/noble-updates,noble-security,now 3.12.3-1ubuntu0.8 amd64 [installed,automatic]
libquadmath0/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
librdmacm-dev/now 56.0-1 amd64 [installed,local]
librdmacm1/now 56.0-1 amd64 [installed,local]
libreadline8t64/noble,now 8.2-4build1 amd64 [installed,automatic]
librsvg2-2/noble,now 2.58.0+dfsg-1build1 amd64 [installed,automatic]
librsvg2-common/noble,now 2.58.0+dfsg-1build1 amd64 [installed,automatic]
librtmp1/noble,now 2.4+20151223.gitfa8646d.1-2build7 amd64 [installed,automatic]
libsasl2-2/noble-updates,now 2.1.28+dfsg1-5ubuntu3.1 amd64 [installed,automatic]
libsasl2-modules-db/noble-updates,now 2.1.28+dfsg1-5ubuntu3.1 amd64 [installed,automatic]
libseccomp2/noble-updates,now 2.5.5-1ubuntu3.1 amd64 [installed]
libselinux1/noble-updates,now 3.5-2ubuntu2.1 amd64 [installed]
libsemanage-common/noble,now 3.5-1build5 all [installed]
libsemanage2/noble,now 3.5-1build5 amd64 [installed]
libsensors-config/noble,now 1:3.6.0-9build1 all [installed,automatic]
libsensors5/noble,now 1:3.6.0-9build1 amd64 [installed,automatic]
libsepol2/noble,now 3.5-2build1 amd64 [installed]
libsframe1/now 2.42-4ubuntu2.5 amd64 [installed,upgradable to: 2.42-4ubuntu2.6]
libsharpyuv0/noble,now 1.3.2-0.4build3 amd64 [installed,automatic]
libsm6/noble,now 2:1.2.3-1build3 amd64 [installed,automatic]
libsmartcols1/noble-updates,now 2.39.3-9ubuntu6.3 amd64 [installed]
libsqlite3-0/noble-updates,noble-security,now 3.45.1-1ubuntu2.5 amd64 [installed,automatic]
libss2/noble-updates,now 1.47.0-2.4~exp1ubuntu4.1 amd64 [installed]
libssh-4/now 0.10.6-2ubuntu0.1 amd64 [installed,upgradable to: 0.10.6-2ubuntu0.2]
libssl3t64/noble-updates,noble-security,now 3.0.13-0ubuntu3.6 amd64 [installed]
libstdc++-13-dev/noble-updates,noble-security,now 13.3.0-6ubuntu2~24.04 amd64 [installed,automatic]
libstdc++6/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed]
libsystemd-shared/noble-updates,now 255.4-1ubuntu8.11 amd64 [installed,automatic]
libsystemd0/noble-updates,now 255.4-1ubuntu8.11 amd64 [installed]
libtasn1-6/noble-updates,noble-security,now 4.19.0-3ubuntu0.24.04.1 amd64 [installed]
libtcmalloc-minimal4t64/noble,now 2.15-3build1 amd64 [installed]
libtext-iconv-perl/noble,now 1.7-8build3 amd64 [installed,automatic]
libthai-data/noble,now 0.1.29-2build1 all [installed,automatic]
libthai0/noble,now 0.1.29-2build1 amd64 [installed,automatic]
libtie-ixhash-perl/noble,now 1.23-4 all [installed,automatic]
libtiff6/noble-updates,noble-security,now 4.5.1+git230720-4ubuntu2.4 amd64 [installed,automatic]
libtimedate-perl/noble,now 2.3300-2 all [installed,automatic]
libtinfo6/noble,now 6.4+20240113-1ubuntu2 amd64 [installed]
libtry-tiny-perl/noble,now 0.31-2 all [installed,automatic]
libtsan2/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libubsan1/noble-updates,noble-security,now 14.2.0-4ubuntu2~24.04 amd64 [installed,automatic]
libudev1/noble-updates,now 255.4-1ubuntu8.11 amd64 [installed]
libunistring5/noble-updates,now 1.1-2build1.1 amd64 [installed]
liburi-perl/noble,now 5.27-1 all [installed,automatic]
libuuid1/noble-updates,now 2.39.3-9ubuntu6.3 amd64 [installed]
libvulkan1/noble,now 1.3.275.0-1build1 amd64 [installed,automatic]
libwayland-client0/noble,now 1.22.0-2.1build1 amd64 [installed,automatic]
libwayland-cursor0/noble,now 1.22.0-2.1build1 amd64 [installed,automatic]
libwayland-egl1/noble,now 1.22.0-2.1build1 amd64 [installed,automatic]
libwayland-server0/noble,now 1.22.0-2.1build1 amd64 [installed,automatic]
libwebp7/noble,now 1.3.2-0.4build3 amd64 [installed,automatic]
libwww-perl/noble,now 6.76-1 all [installed,automatic]
libwww-robotrules-perl/noble,now 6.02-1 all [installed,automatic]
libx11-6/noble,now 2:1.8.7-1build1 amd64 [installed,automatic]
libx11-data/noble,now 2:1.8.7-1build1 all [installed,automatic]
libx11-protocol-perl/noble,now 0.56-9 all [installed,automatic]
libx11-xcb1/noble,now 2:1.8.7-1build1 amd64 [installed,automatic]
libxau6/noble,now 1:1.0.9-1build6 amd64 [installed,automatic]
libxaw7/noble,now 2:1.0.14-1build2 amd64 [installed,automatic]
libxcb-dri3-0/noble,now 1.15-1ubuntu2 amd64 [installed,automatic]
libxcb-glx0/noble,now 1.15-1ubuntu2 amd64 [installed,automatic]
libxcb-present0/noble,now 1.15-1ubuntu2 amd64 [installed,automatic]
libxcb-randr0/noble,now 1.15-1ubuntu2 amd64 [installed,automatic]
libxcb-render0/noble,now 1.15-1ubuntu2 amd64 [installed,automatic]
libxcb-shape0/noble,now 1.15-1ubuntu2 amd64 [installed,automatic]
libxcb-shm0/noble,now 1.15-1ubuntu2 amd64 [installed,automatic]
libxcb-sync1/noble,now 1.15-1ubuntu2 amd64 [installed,automatic]
libxcb-xfixes0/noble,now 1.15-1ubuntu2 amd64 [installed,automatic]
libxcb1/noble,now 1.15-1ubuntu2 amd64 [installed,automatic]
libxcomposite1/noble,now 1:0.4.5-1build3 amd64 [installed,automatic]
libxcursor1/noble,now 1:1.2.1-1build1 amd64 [installed,automatic]
libxdamage1/noble,now 1:1.1.6-1build1 amd64 [installed,automatic]
libxdmcp6/noble,now 1:1.1.3-0ubuntu6 amd64 [installed,automatic]
libxext6/noble,now 2:1.3.4-1build2 amd64 [installed,automatic]
libxfixes3/noble,now 1:6.0.0-2build1 amd64 [installed,automatic]
libxft2/noble,now 2.3.6-1build1 amd64 [installed,automatic]
libxi6/noble,now 2:1.8.1-1build1 amd64 [installed,automatic]
libxinerama1/noble,now 2:1.1.4-3build1 amd64 [installed,automatic]
libxkbcommon0/noble,now 1.6.0-1build1 amd64 [installed,automatic]
libxkbfile1/noble,now 1:1.1.0-1build4 amd64 [installed,automatic]
libxml-parser-perl/noble,now 2.47-1build3 amd64 [installed,automatic]
libxml-twig-perl/noble,now 1:3.52-2 all [installed,automatic]
libxml-xpathengine-perl/noble,now 0.14-2 all [installed,automatic]
libxml2/noble-updates,noble-security,now 2.9.14+dfsg-1.3ubuntu3.6 amd64 [installed,automatic]
libxmu6/noble,now 2:1.1.3-3build2 amd64 [installed,automatic]
libxmuu1/noble,now 2:1.1.3-3build2 amd64 [installed,automatic]
libxpm4/noble,now 1:3.5.17-1build2 amd64 [installed,automatic]
libxrandr2/noble,now 2:1.5.2-2build1 amd64 [installed,automatic]
libxrender1/noble,now 1:0.9.10-1.1build1 amd64 [installed,automatic]
libxshmfence1/noble,now 1.3-1build5 amd64 [installed,automatic]
libxt6t64/noble,now 1:1.2.1-1.2build1 amd64 [installed,automatic]
libxtst6/noble,now 2:1.2.3-1.1build1 amd64 [installed,automatic]
libxv1/noble,now 2:1.0.11-1.1build1 amd64 [installed,automatic]
libxxf86dga1/noble,now 2:1.1.5-1build1 amd64 [installed,automatic]
libxxf86vm1/noble,now 1:1.1.4-1build4 amd64 [installed,automatic]
libxxhash0/noble,now 0.8.2-2build1 amd64 [installed]
libzstd1/noble-updates,now 1.5.5+dfsg2-2build1.1 amd64 [installed]
linux-libc-dev/now 6.8.0-85.85 amd64 [installed,upgradable to: 6.8.0-87.88]
login/noble-updates,now 1:4.13+dfsg1-4ubuntu3.2 amd64 [installed]
logsave/noble-updates,now 1.47.0-2.4~exp1ubuntu4.1 amd64 [installed]
lto-disabled-list/noble,now 47 all [installed,automatic]
make/noble,now 4.3-4.1build2 amd64 [installed,automatic]
mawk/noble,now 1.3.4.20240123-1build1 amd64 [installed]
media-types/noble,now 10.1.0 all [installed,automatic]
mesa-libgallium/noble-updates,now 25.0.7-0ubuntu0.24.04.2 amd64 [installed,automatic]
mesa-vulkan-drivers/noble-updates,now 25.0.7-0ubuntu0.24.04.2 amd64 [installed,automatic]
microsoft-edge-stable/stable,now 142.0.3595.53-1 amd64 [installed]
mlnx-dpdk/now 22.11.0-2507.1.0.2507097 amd64 [installed,local]
mount/noble-updates,now 2.39.3-9ubuntu6.3 amd64 [installed]
ncurses-base/noble,now 6.4+20240113-1ubuntu2 all [installed]
ncurses-bin/noble,now 6.4+20240113-1ubuntu2 amd64 [installed]
netbase/noble,now 6.4 all [installed,automatic]
networkd-dispatcher/noble,now 2.2.4-1 all [installed,automatic]
openssl/noble-updates,noble-security,now 3.0.13-0ubuntu3.6 amd64 [installed,automatic]
passwd/noble-updates,now 1:4.13+dfsg1-4ubuntu3.2 amd64 [installed]
patch/noble,now 2.7.6-7build3 amd64 [installed]
pci.ids/noble-updates,now 0.0~2024.03.31-1ubuntu0.1 all [installed,automatic]
pciutils/noble,now 1:3.10.0-2build1 amd64 [installed,automatic]
perl-base/noble-updates,noble-security,now 5.38.2-3.2ubuntu0.2 amd64 [installed]
perl-modules-5.38/noble-updates,noble-security,now 5.38.2-3.2ubuntu0.2 all [installed,automatic]
perl-openssl-defaults/noble,now 7build3 amd64 [installed,automatic]
perl/noble-updates,noble-security,now 5.38.2-3.2ubuntu0.2 amd64 [installed,automatic]
pinentry-curses/noble,now 1.2.1-3ubuntu5 amd64 [installed,automatic]
pkgconf-bin/noble,now 1.8.1-2build1 amd64 [installed,automatic]
pkgconf/noble,now 1.8.1-2build1 amd64 [installed,automatic]
procps/noble-updates,now 2:4.0.4-4ubuntu3.2 amd64 [installed]
python3-dbus/noble,now 1.3.2-5build3 amd64 [installed,automatic]
python3-gi/noble,now 3.48.2-1 amd64 [installed,automatic]
python3-minimal/noble-updates,now 3.12.3-0ubuntu2 amd64 [installed,automatic]
python3.12-minimal/noble-updates,noble-security,now 3.12.3-1ubuntu0.8 amd64 [installed,automatic]
python3.12/noble-updates,noble-security,now 3.12.3-1ubuntu0.8 amd64 [installed,automatic]
python3/noble-updates,now 3.12.3-0ubuntu2 amd64 [installed,automatic]
readline-common/noble,now 8.2-4build1 all [installed,automatic]
rpcsvc-proto/noble,now 1.4.2-0ubuntu7 amd64 [installed,automatic]
sed/noble,now 4.9-2build1 amd64 [installed]
sensible-utils/noble,now 0.0.22 all [installed]
session-migration/noble,now 0.3.9build1 amd64 [installed,automatic]
sgml-base/noble,now 1.31 all [installed,automatic]
shared-mime-info/noble,now 2.4-4 amd64 [installed,automatic]
systemd-dev/noble-updates,now 255.4-1ubuntu8.11 all [installed,automatic]
systemd-resolved/noble-updates,now 255.4-1ubuntu8.11 amd64 [installed,automatic]
systemd-sysv/noble-updates,now 255.4-1ubuntu8.11 amd64 [installed,automatic]
systemd-timesyncd/noble-updates,now 255.4-1ubuntu8.11 amd64 [installed,automatic]
systemd/noble-updates,now 255.4-1ubuntu8.11 amd64 [installed,automatic]
sysvinit-utils/noble,now 3.08-6ubuntu3 amd64 [installed]
tar/noble,now 1.35+dfsg-3build1 amd64 [installed]
tzdata/noble-updates,noble-security,now 2025b-0ubuntu0.24.04.1 all [installed,automatic]
ubuntu-keyring/noble,now 2023.11.28.1 all [installed]
ubuntu-mono/noble,now 24.04-0ubuntu1 all [installed,automatic]
unminimize/noble-updates,now 0.2.1 amd64 [installed]
unzip/noble-updates,noble-security,now 6.0-28ubuntu4.1 amd64 [installed]
usb.ids/noble,now 2024.03.18-1 all [installed,automatic]
util-linux/noble-updates,now 2.39.3-9ubuntu6.3 amd64 [installed]
wget/noble-updates,noble-security,now 1.21.4-1ubuntu4.1 amd64 [installed]
x11-common/noble,now 1:7.7+23ubuntu3 all [installed,automatic]
x11-utils/noble,now 7.7+6build2 amd64 [installed,automatic]
x11-xserver-utils/noble,now 7.7+10build2 amd64 [installed,automatic]
xdg-user-dirs/noble,now 0.18-1build1 amd64 [installed,automatic]
xdg-utils/noble,now 1.1.3-4.1ubuntu3 all [installed,automatic]
xkb-data/noble-updates,now 2.41-2ubuntu1.1 all [installed,automatic]
xml-core/noble,now 0.19 all [installed,automatic]
xz-utils/noble-updates,noble-security,now 5.6.1+really5.4.5-1ubuntu0.2 amd64 [installed,automatic]
zlib1g/noble-updates,now 1:1.3.dfsg-3.1ubuntu2.1 amd64 [installed]
zutty/noble,now 0.14.8.20231210+dfsg1-1 amd64 [installed,automatic]
root@ef6b784a9db0:/# 


root@ef6b784a9db0:/# apt list --installed | grep edge

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

microsoft-edge-stable/stable,now 142.0.3595.53-1 amd64 [installed]
root@ef6b784a9db0:/# 

root@ef6b784a9db0:/# dpkg -l | grep microsoft-edge
ii  microsoft-edge-stable             142.0.3595.53-1                   amd64        The web browser from Microsoft
root@ef6b784a9db0:/# 

root@ef6b784a9db0:/# which microsoft-edge
/usr/bin/microsoft-edge
root@ef6b784a9db0:/# 


root@ef6b784a9db0:/# apt-cache policy microsoft-edge-stable
microsoft-edge-stable:
  Installed: 142.0.3595.53-1
  Candidate: 142.0.3595.53-1
  Version table:
 *** 142.0.3595.53-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
        100 /var/lib/dpkg/status
     141.0.3537.99-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     141.0.3537.92-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     141.0.3537.85-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     141.0.3537.71-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     141.0.3537.57-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     140.0.3485.94-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     140.0.3485.81-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     140.0.3485.66-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     140.0.3485.54-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     139.0.3405.125-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     139.0.3405.119-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     139.0.3405.111-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     139.0.3405.102-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     139.0.3405.86-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     138.0.3351.121-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     138.0.3351.109-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     138.0.3351.95-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     138.0.3351.83-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     138.0.3351.77-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     138.0.3351.65-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     138.0.3351.55-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     137.0.3296.93-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     137.0.3296.83-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     137.0.3296.68-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     137.0.3296.62-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     137.0.3296.58-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     137.0.3296.52-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     136.0.3240.92-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     136.0.3240.76-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     136.0.3240.64-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     136.0.3240.50-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     135.0.3179.98-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     135.0.3179.85-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     135.0.3179.73-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     135.0.3179.54-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     134.0.3124.95-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     134.0.3124.85-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     134.0.3124.83-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     134.0.3124.68-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     134.0.3124.51-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     133.0.3065.92-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     133.0.3065.82-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     133.0.3065.69-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     133.0.3065.59-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     132.0.2957.140-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     132.0.2957.127-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     132.0.2957.115-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     131.0.2903.147-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     131.0.2903.112-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     131.0.2903.99-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     131.0.2903.86-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     131.0.2903.70-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     131.0.2903.63-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     131.0.2903.51-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     131.0.2903.48-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     130.0.2849.80-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     130.0.2849.68-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     130.0.2849.56-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     130.0.2849.52-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     130.0.2849.46-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     129.0.2792.89-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     129.0.2792.79-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     129.0.2792.65-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     129.0.2792.52-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     128.0.2739.79-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     128.0.2739.67-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     128.0.2739.63-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     128.0.2739.54-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     128.0.2739.42-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     127.0.2651.105-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     127.0.2651.98-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     127.0.2651.86-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     127.0.2651.74-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     126.0.2592.113-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     126.0.2592.102-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     126.0.2592.87-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     126.0.2592.81-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     126.0.2592.68-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     126.0.2592.61-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     126.0.2592.56-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     125.0.2535.92-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     125.0.2535.85-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     125.0.2535.79-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     125.0.2535.67-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     125.0.2535.51-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     124.0.2478.109-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     124.0.2478.105-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     124.0.2478.97-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     124.0.2478.80-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     124.0.2478.67-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     124.0.2478.51-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     123.0.2420.97-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     123.0.2420.81-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     123.0.2420.65-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     123.0.2420.53-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     122.0.2365.92-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     122.0.2365.80-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     122.0.2365.63-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     122.0.2365.59-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     122.0.2365.52-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     121.0.2277.128-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     121.0.2277.113-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     121.0.2277.106-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     121.0.2277.98-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     121.0.2277.83-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     120.0.2210.144-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     120.0.2210.133-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     120.0.2210.121-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     120.0.2210.91-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     120.0.2210.89-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     120.0.2210.77-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     120.0.2210.61-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     119.0.2151.97-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     119.0.2151.72-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     119.0.2151.58-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     119.0.2151.44-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     118.0.2088.76-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     118.0.2088.69-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     118.0.2088.61-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     118.0.2088.57-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     118.0.2088.46-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     117.0.2045.55-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     117.0.2045.47-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     117.0.2045.40-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     117.0.2045.35-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     117.0.2045.31-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     116.0.1938.81-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     116.0.1938.76-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     116.0.1938.69-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     116.0.1938.62-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     116.0.1938.54-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     115.0.1901.203-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     115.0.1901.200-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     115.0.1901.188-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     114.0.1823.82-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     95.0.1020.40-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
     95.0.1020.38-1 500
        500 https://packages.microsoft.com/repos/edge stable/main amd64 Packages
root@ef6b784a9db0:/# 


root@ef6b784a9db0:/# grep " install " /var/log/dpkg.log
2025-10-01 02:03:25 install base-passwd:amd64 <none> 3.6.3build1
2025-10-01 02:03:25 install base-files:amd64 <none> 13ubuntu10
2025-10-01 02:03:26 install libc6:amd64 <none> 2.39-0ubuntu8
2025-10-01 02:03:26 install perl-base:amd64 <none> 5.38.2-3.2build2
2025-10-01 02:03:27 install mawk:amd64 <none> 1.3.4.20240123-1build1
2025-10-01 02:03:27 install bash:amd64 <none> 5.2.21-2ubuntu4
2025-10-01 02:03:27 install bsdutils:amd64 <none> 1:2.39.3-9ubuntu6
2025-10-01 02:03:27 install coreutils:amd64 <none> 9.4-3ubuntu6
2025-10-01 02:03:27 install dash:amd64 <none> 0.5.12-6ubuntu5
2025-10-01 02:03:27 install debconf:all <none> 1.5.86ubuntu1
2025-10-01 02:03:27 install debianutils:amd64 <none> 5.17build1
2025-10-01 02:03:27 install diffutils:amd64 <none> 1:3.10-1build1
2025-10-01 02:03:27 install e2fsprogs:amd64 <none> 1.47.0-2.4~exp1ubuntu4
2025-10-01 02:03:27 install findutils:amd64 <none> 4.9.0-5build1
2025-10-01 02:03:27 install gcc-14-base:amd64 <none> 14-20240412-0ubuntu1
2025-10-01 02:03:27 install grep:amd64 <none> 3.11-4build1
2025-10-01 02:03:27 install gzip:amd64 <none> 1.12-1ubuntu3
2025-10-01 02:03:27 install hostname:amd64 <none> 3.23+nmu2ubuntu2
2025-10-01 02:03:27 install init-system-helpers:all <none> 1.66ubuntu1
2025-10-01 02:03:27 install libacl1:amd64 <none> 2.3.2-1build1
2025-10-01 02:03:28 install libattr1:amd64 <none> 1:2.5.2-1build1
2025-10-01 02:03:28 install libaudit-common:all <none> 1:3.1.2-2.1build1
2025-10-01 02:03:28 install libaudit1:amd64 <none> 1:3.1.2-2.1build1
2025-10-01 02:03:28 install libblkid1:amd64 <none> 2.39.3-9ubuntu6
2025-10-01 02:03:28 install libbz2-1.0:amd64 <none> 1.0.8-5.1
2025-10-01 02:03:28 install libc-bin:amd64 <none> 2.39-0ubuntu8
2025-10-01 02:03:28 install libcap-ng0:amd64 <none> 0.8.4-2build2
2025-10-01 02:03:28 install libcap2:amd64 <none> 1:2.66-5ubuntu2
2025-10-01 02:03:28 install libcom-err2:amd64 <none> 1.47.0-2.4~exp1ubuntu4
2025-10-01 02:03:28 install libcrypt1:amd64 <none> 1:4.4.36-4build1
2025-10-01 02:03:28 install libdebconfclient0:amd64 <none> 0.271ubuntu3
2025-10-01 02:03:28 install libext2fs2t64:amd64 <none> 1.47.0-2.4~exp1ubuntu4
2025-10-01 02:03:28 install libgcc-s1:amd64 <none> 14-20240412-0ubuntu1
2025-10-01 02:03:28 install libgcrypt20:amd64 <none> 1.10.3-2build1
2025-10-01 02:03:28 install libgmp10:amd64 <none> 2:6.3.0+dfsg-2ubuntu6
2025-10-01 02:03:28 install libgpg-error0:amd64 <none> 1.47-3build2
2025-10-01 02:03:28 install liblz4-1:amd64 <none> 1.9.4-1build1
2025-10-01 02:03:28 install liblzma5:amd64 <none> 5.6.1+really5.4.5-1
2025-10-01 02:03:28 install libmd0:amd64 <none> 1.1.0-2build1
2025-10-01 02:03:28 install libmount1:amd64 <none> 2.39.3-9ubuntu6
2025-10-01 02:03:28 install libncursesw6:amd64 <none> 6.4+20240113-1ubuntu2
2025-10-01 02:03:28 install libpam-modules:amd64 <none> 1.5.3-5ubuntu5
2025-10-01 02:03:29 install libpam-modules-bin:amd64 <none> 1.5.3-5ubuntu5
2025-10-01 02:03:29 install libpam-runtime:all <none> 1.5.3-5ubuntu5
2025-10-01 02:03:29 install libpam0g:amd64 <none> 1.5.3-5ubuntu5
2025-10-01 02:03:29 install libpcre2-8-0:amd64 <none> 10.42-4ubuntu2
2025-10-01 02:03:29 install libproc2-0:amd64 <none> 2:4.0.4-4ubuntu3
2025-10-01 02:03:29 install libselinux1:amd64 <none> 3.5-2ubuntu2
2025-10-01 02:03:29 install libsemanage-common:all <none> 3.5-1build5
2025-10-01 02:03:29 install libsemanage2:amd64 <none> 3.5-1build5
2025-10-01 02:03:29 install libsepol2:amd64 <none> 3.5-2build1
2025-10-01 02:03:29 install libsmartcols1:amd64 <none> 2.39.3-9ubuntu6
2025-10-01 02:03:29 install libss2:amd64 <none> 1.47.0-2.4~exp1ubuntu4
2025-10-01 02:03:29 install libssl3t64:amd64 <none> 3.0.13-0ubuntu3
2025-10-01 02:03:29 install libsystemd0:amd64 <none> 255.4-1ubuntu8
2025-10-01 02:03:29 install libtinfo6:amd64 <none> 6.4+20240113-1ubuntu2
2025-10-01 02:03:29 install libudev1:amd64 <none> 255.4-1ubuntu8
2025-10-01 02:03:29 install libuuid1:amd64 <none> 2.39.3-9ubuntu6
2025-10-01 02:03:29 install libzstd1:amd64 <none> 1.5.5+dfsg2-2build1
2025-10-01 02:03:29 install login:amd64 <none> 1:4.13+dfsg1-4ubuntu3
2025-10-01 02:03:29 install logsave:amd64 <none> 1.47.0-2.4~exp1ubuntu4
2025-10-01 02:03:29 install mount:amd64 <none> 2.39.3-9ubuntu6
2025-10-01 02:03:29 install ncurses-base:all <none> 6.4+20240113-1ubuntu2
2025-10-01 02:03:29 install ncurses-bin:amd64 <none> 6.4+20240113-1ubuntu2
2025-10-01 02:03:29 install passwd:amd64 <none> 1:4.13+dfsg1-4ubuntu3
2025-10-01 02:03:30 install procps:amd64 <none> 2:4.0.4-4ubuntu3
2025-10-01 02:03:30 install sed:amd64 <none> 4.9-2build1
2025-10-01 02:03:30 install sensible-utils:all <none> 0.0.22
2025-10-01 02:03:30 install sysvinit-utils:amd64 <none> 3.08-6ubuntu3
2025-10-01 02:03:30 install tar:amd64 <none> 1.35+dfsg-3build1
2025-10-01 02:03:30 install util-linux:amd64 <none> 2.39.3-9ubuntu6
2025-10-01 02:03:30 install zlib1g:amd64 <none> 1:1.3.dfsg-3.1ubuntu2
2025-10-01 02:03:32 install apt:amd64 <none> 2.7.14build2
2025-10-01 02:03:32 install gpgv:amd64 <none> 2.4.4-2ubuntu17
2025-10-01 02:03:32 install libapt-pkg6.0t64:amd64 <none> 2.7.14build2
2025-10-01 02:03:32 install libassuan0:amd64 <none> 2.5.6-1build1
2025-10-01 02:03:32 install libffi8:amd64 <none> 3.4.6-1build1
2025-10-01 02:03:32 install libgnutls30t64:amd64 <none> 3.8.3-1.1ubuntu3
2025-10-01 02:03:32 install libhogweed6t64:amd64 <none> 3.9.1-2.2build1
2025-10-01 02:03:32 install libidn2-0:amd64 <none> 2.3.7-2build1
2025-10-01 02:03:32 install libnettle8t64:amd64 <none> 3.9.1-2.2build1
2025-10-01 02:03:32 install libnpth0t64:amd64 <none> 1.6-3.1build1
2025-10-01 02:03:33 install libp11-kit0:amd64 <none> 0.25.3-4ubuntu2
2025-10-01 02:03:33 install libseccomp2:amd64 <none> 2.5.5-1ubuntu3
2025-10-01 02:03:33 install libstdc++6:amd64 <none> 14-20240412-0ubuntu1
2025-10-01 02:03:33 install libtasn1-6:amd64 <none> 4.19.0-3build1
2025-10-01 02:03:33 install libunistring5:amd64 <none> 1.1-2build1
2025-10-01 02:03:33 install libxxhash0:amd64 <none> 0.8.2-2build1
2025-10-01 02:03:33 install ubuntu-keyring:all <none> 2023.11.28.1
2025-10-01 02:09:55 install libdb5.3t64:amd64 <none> 5.3.28+dfsg2-7
2025-10-01 02:09:56 install unminimize:amd64 <none> 0.2.1
2025-10-14 16:58:12 install openssl:amd64 <none> 3.0.13-0ubuntu3.6
2025-10-14 16:58:12 install ca-certificates:all <none> 20240203
2025-10-14 16:58:18 install adduser:all <none> 3.137ubuntu1
2025-10-14 16:58:18 install libkrb5support0:amd64 <none> 1.20.1-6ubuntu2.6
2025-10-14 16:58:18 install libk5crypto3:amd64 <none> 1.20.1-6ubuntu2.6
2025-10-14 16:58:18 install libkeyutils1:amd64 <none> 1.6.3-3build1
2025-10-14 16:58:18 install libkrb5-3:amd64 <none> 1.20.1-6ubuntu2.6
2025-10-14 16:58:18 install libgssapi-krb5-2:amd64 <none> 1.20.1-6ubuntu2.6
2025-10-14 16:58:18 install libnghttp2-14:amd64 <none> 1.59.0-1ubuntu0.2
2025-10-14 16:58:18 install libnl-3-200:amd64 <none> 3.7.0-0.3build1.1
2025-10-14 16:58:18 install libnl-route-3-200:amd64 <none> 3.7.0-0.3build1.1
2025-10-14 16:58:18 install libpsl5t64:amd64 <none> 0.21.2-1.1build1
2025-10-14 16:58:18 install wget:amd64 <none> 1.21.4-1ubuntu4.1
2025-10-14 16:58:18 install libbrotli1:amd64 <none> 1.1.0-2build2
2025-10-14 16:58:18 install libsasl2-modules-db:amd64 <none> 2.1.28+dfsg1-5ubuntu3.1
2025-10-14 16:58:18 install libsasl2-2:amd64 <none> 2.1.28+dfsg1-5ubuntu3.1
2025-10-14 16:58:18 install libldap2:amd64 <none> 2.6.7+dfsg-1~exp1ubuntu8.2
2025-10-14 16:58:18 install librtmp1:amd64 <none> 2.4+20151223.gitfa8646d.1-2build7
2025-10-14 16:58:18 install libssh-4:amd64 <none> 0.10.6-2ubuntu0.1
2025-10-14 16:58:18 install libcurl4t64:amd64 <none> 8.5.0-2ubuntu10.6
2025-10-14 16:58:18 install curl:amd64 <none> 8.5.0-2ubuntu10.6
2025-10-14 16:58:18 install libnl-3-dev:amd64 <none> 3.7.0-0.3build1.1
2025-10-14 16:58:18 install libnl-route-3-dev:amd64 <none> 3.7.0-0.3build1.1
2025-10-14 16:58:18 install patch:amd64 <none> 2.7.6-7build3
2025-10-14 16:58:18 install libibverbs1:amd64 <none> 56.0-1
2025-10-14 16:58:18 install libibverbs-dev:amd64 <none> 56.0-1
2025-10-14 16:58:18 install librdmacm1:amd64 <none> 56.0-1
2025-10-14 16:58:18 install librdmacm-dev:amd64 <none> 56.0-1
2025-10-14 16:58:18 install libibumad3:amd64 <none> 56.0-1
2025-10-14 16:58:18 install libibumad-dev:amd64 <none> 56.0-1
2025-10-14 16:58:18 install ibverbs-utils:amd64 <none> 56.0-1
2025-10-14 16:58:18 install ibverbs-providers:amd64 <none> 56.0-1
2025-10-14 16:58:18 install libgdrapi:amd64 <none> 2.5.1
2025-10-14 16:58:18 install libfabric-aws-bin:amd64 <none> 1.22.0amzn5.0
2025-10-14 16:58:18 install libfabric-aws-dev:amd64 <none> 1.22.0amzn5.0
2025-10-14 16:58:18 install libfabric1-aws:amd64 <none> 1.22.0amzn5.0
2025-10-16 23:56:41 install cuda-compat-13-0:amd64 <none> 580.95.05-0ubuntu1
2025-10-16 23:56:42 install cuda-cudart-13-0:amd64 <none> 13.0.96-1
2025-10-16 23:56:42 install cuda-culibos-13-0:amd64 <none> 13.0.85-1
2025-10-16 23:56:42 install cuda-cupti-13-0:amd64 <none> 13.0.85-1
2025-10-16 23:56:43 install cuda-toolkit-13-0-config-common:all <none> 13.0.96-1
2025-10-16 23:56:43 install cuda-toolkit-13-config-common:all <none> 13.0.96-1
2025-10-16 23:56:43 install cuda-toolkit-config-common:all <none> 13.0.96-1
2025-10-16 23:56:56 install sgml-base:all <none> 1.31
2025-10-16 23:56:56 install libbsd0:amd64 <none> 0.12.1-1build1.1
2025-10-16 23:56:56 install libdbus-1-3:amd64 <none> 1.14.10-4ubuntu4.1
2025-10-16 23:56:56 install libelf1t64:amd64 <none> 0.190-1.1ubuntu0.1
2025-10-16 23:56:56 install libkmod2:amd64 <none> 31+20240202-2ubuntu7.1
2025-10-16 23:56:56 install libjansson4:amd64 <none> 2.14-2build2
2025-10-16 23:56:56 install libnuma1:amd64 <none> 2.0.18-1build1
2025-10-16 23:56:56 install libpcap0.8t64:amd64 <none> 1.10.4-4.1ubuntu3
2025-10-16 23:56:56 install pci.ids:all <none> 0.0~2024.03.31-1ubuntu0.1
2025-10-16 23:56:56 install libpci3:amd64 <none> 1:3.10.0-2build1
2025-10-16 23:56:56 install pciutils:amd64 <none> 1:3.10.0-2build1
2025-10-16 23:56:56 install usb.ids:all <none> 2024.03.18-1
2025-10-16 23:56:56 install doca-sdk-common:amd64 <none> 3.1.0105-1
2025-10-16 23:56:56 install hwdata:all <none> 0.379-1
2025-10-16 23:56:56 install libc-dev-bin:amd64 <none> 2.39-0ubuntu8.6
2025-10-16 23:56:56 install linux-libc-dev:amd64 <none> 6.8.0-85.85
2025-10-16 23:56:57 install libcrypt-dev:amd64 <none> 1:4.4.36-4build1
2025-10-16 23:56:57 install rpcsvc-proto:amd64 <none> 1.4.2-0ubuntu7
2025-10-16 23:56:57 install libc6-dev:amd64 <none> 2.39-0ubuntu8.6
2025-10-16 23:56:57 install libpkgconf3:amd64 <none> 1.8.1-2build1
2025-10-16 23:56:57 install pkgconf-bin:amd64 <none> 1.8.1-2build1
2025-10-16 23:56:57 install pkgconf:amd64 <none> 1.8.1-2build1
2025-10-16 23:56:57 install xml-core:all <none> 0.19
2025-10-16 23:56:57 install libdbus-1-dev:amd64 <none> 1.14.10-4ubuntu4.1
2025-10-16 23:56:57 install libpcap0.8-dev:amd64 <none> 1.10.4-4.1ubuntu3
2025-10-16 23:56:57 install mlnx-dpdk:amd64 <none> 22.11.0-2507.1.0.2507097
2025-10-16 23:56:57 install doca-sdk-dpdk-bridge:amd64 <none> 3.1.0105-1
2025-10-16 23:56:57 install doca-sdk-eth:amd64 <none> 3.1.0105-1
2025-10-16 23:56:57 install doca-sdk-rdma:amd64 <none> 3.1.0105-1
2025-10-16 23:56:57 install doca-sdk-gpunetio:amd64 <none> 3.1.0105-1
2025-10-16 23:56:57 install doca-sdk-verbs:amd64 <none> 3.1.0105-1
2025-10-17 00:04:35 install perl-modules-5.38:all <none> 5.38.2-3.2ubuntu0.2
2025-10-17 00:04:35 install libgdbm6t64:amd64 <none> 1.23-5.1build1
2025-10-17 00:04:35 install libgdbm-compat4t64:amd64 <none> 1.23-5.1build1
2025-10-17 00:04:35 install libperl5.38t64:amd64 <none> 5.38.2-3.2ubuntu0.2
2025-10-17 00:04:35 install perl:amd64 <none> 5.38.2-3.2ubuntu0.2
2025-10-17 00:04:36 install apt-utils:amd64 <none> 2.8.3
2025-10-17 00:04:36 install readline-common:all <none> 8.2-4build1
2025-10-17 00:04:36 install libreadline8t64:amd64 <none> 8.2-4build1
2025-10-17 00:04:36 install libsqlite3-0:amd64 <none> 3.45.1-1ubuntu2.5
2025-10-17 00:04:36 install libncurses6:amd64 <none> 6.4+20240113-1ubuntu2
2025-10-17 00:04:36 install xz-utils:amd64 <none> 5.6.1+really5.4.5-1ubuntu0.2
2025-10-17 00:04:36 install binutils-common:amd64 <none> 2.42-4ubuntu2.5
2025-10-17 00:04:36 install libsframe1:amd64 <none> 2.42-4ubuntu2.5
2025-10-17 00:04:36 install libbinutils:amd64 <none> 2.42-4ubuntu2.5
2025-10-17 00:04:36 install libctf-nobfd0:amd64 <none> 2.42-4ubuntu2.5
2025-10-17 00:04:36 install libctf0:amd64 <none> 2.42-4ubuntu2.5
2025-10-17 00:04:36 install libgprofng0:amd64 <none> 2.42-4ubuntu2.5
2025-10-17 00:04:36 install binutils-x86-64-linux-gnu:amd64 <none> 2.42-4ubuntu2.5
2025-10-17 00:04:36 install binutils:amd64 <none> 2.42-4ubuntu2.5
2025-10-17 00:04:36 install gcc-13-base:amd64 <none> 13.3.0-6ubuntu2~24.04
2025-10-17 00:04:36 install libisl23:amd64 <none> 0.26-3build1.1
2025-10-17 00:04:36 install libmpfr6:amd64 <none> 4.2.1-1build1.1
2025-10-17 00:04:36 install libmpc3:amd64 <none> 1.3.1-1build1.1
2025-10-17 00:04:36 install cpp-13-x86-64-linux-gnu:amd64 <none> 13.3.0-6ubuntu2~24.04
2025-10-17 00:04:36 install cpp-13:amd64 <none> 13.3.0-6ubuntu2~24.04
2025-10-17 00:04:36 install cpp-x86-64-linux-gnu:amd64 <none> 4:13.2.0-7ubuntu1
2025-10-17 00:04:36 install cpp:amd64 <none> 4:13.2.0-7ubuntu1
2025-10-17 00:04:36 install libcc1-0:amd64 <none> 14.2.0-4ubuntu2~24.04
2025-10-17 00:04:36 install libgomp1:amd64 <none> 14.2.0-4ubuntu2~24.04
2025-10-17 00:04:36 install libitm1:amd64 <none> 14.2.0-4ubuntu2~24.04
2025-10-17 00:04:36 install libatomic1:amd64 <none> 14.2.0-4ubuntu2~24.04
2025-10-17 00:04:36 install libasan8:amd64 <none> 14.2.0-4ubuntu2~24.04
2025-10-17 00:04:36 install liblsan0:amd64 <none> 14.2.0-4ubuntu2~24.04
2025-10-17 00:04:36 install libtsan2:amd64 <none> 14.2.0-4ubuntu2~24.04
2025-10-17 00:04:36 install libubsan1:amd64 <none> 14.2.0-4ubuntu2~24.04
2025-10-17 00:04:36 install libhwasan0:amd64 <none> 14.2.0-4ubuntu2~24.04
2025-10-17 00:04:36 install libquadmath0:amd64 <none> 14.2.0-4ubuntu2~24.04
2025-10-17 00:04:36 install libgcc-13-dev:amd64 <none> 13.3.0-6ubuntu2~24.04
2025-10-17 00:04:36 install gcc-13-x86-64-linux-gnu:amd64 <none> 13.3.0-6ubuntu2~24.04
2025-10-17 00:04:36 install gcc-13:amd64 <none> 13.3.0-6ubuntu2~24.04
2025-10-17 00:04:37 install gcc-x86-64-linux-gnu:amd64 <none> 4:13.2.0-7ubuntu1
2025-10-17 00:04:37 install gcc:amd64 <none> 4:13.2.0-7ubuntu1
2025-10-17 00:04:37 install libstdc++-13-dev:amd64 <none> 13.3.0-6ubuntu2~24.04
2025-10-17 00:04:37 install g++-13-x86-64-linux-gnu:amd64 <none> 13.3.0-6ubuntu2~24.04
2025-10-17 00:04:37 install g++-13:amd64 <none> 13.3.0-6ubuntu2~24.04
2025-10-17 00:04:37 install g++-x86-64-linux-gnu:amd64 <none> 4:13.2.0-7ubuntu1
2025-10-17 00:04:37 install g++:amd64 <none> 4:13.2.0-7ubuntu1
2025-10-17 00:04:37 install make:amd64 <none> 4.3-4.1build2
2025-10-17 00:04:37 install libdpkg-perl:all <none> 1.22.6ubuntu6.5
2025-10-17 00:04:37 install bzip2:amd64 <none> 1.0.8-5.1build0.1
2025-10-17 00:04:37 install lto-disabled-list:all <none> 47
2025-10-17 00:04:37 install dpkg-dev:all <none> 1.22.6ubuntu6.5
2025-10-17 00:04:37 install build-essential:amd64 <none> 12.10ubuntu1
2025-10-17 00:04:37 install gpgconf:amd64 <none> 2.4.4-2ubuntu17.3
2025-10-17 00:04:37 install libksba8:amd64 <none> 1.6.6-1build1
2025-10-17 00:04:37 install dirmngr:amd64 <none> 2.4.4-2ubuntu17.3
2025-10-17 00:04:37 install gnupg-utils:amd64 <none> 2.4.4-2ubuntu17.3
2025-10-17 00:04:37 install gpg:amd64 <none> 2.4.4-2ubuntu17.3
2025-10-17 00:04:37 install pinentry-curses:amd64 <none> 1.2.1-3ubuntu5
2025-10-17 00:04:37 install gpg-agent:amd64 <none> 2.4.4-2ubuntu17.3
2025-10-17 00:04:37 install gpgsm:amd64 <none> 2.4.4-2ubuntu17.3
2025-10-17 00:04:37 install keyboxd:amd64 <none> 2.4.4-2ubuntu17.3
2025-10-17 00:04:37 install gnupg:all <none> 2.4.4-2ubuntu17.3
2025-10-17 00:04:37 install libonig5:amd64 <none> 6.9.9-1build1
2025-10-17 00:04:37 install libjq1:amd64 <none> 1.7.1-3ubuntu0.24.04.1
2025-10-17 00:04:37 install jq:amd64 <none> 1.7.1-3ubuntu0.24.04.1
2025-10-17 00:04:37 install libtcmalloc-minimal4t64:amd64 <none> 2.15-3build1
2025-10-17 00:04:37 install unzip:amd64 <none> 6.0-28ubuntu4.1
2025-10-17 00:05:09 install libnvvm-13-0:amd64 <none> 13.0.88-1
2025-10-17 00:05:10 install libnvptxcompiler-13-0:amd64 <none> 13.0.88-1
2025-10-17 00:05:10 install cuda-cccl-13-0:amd64 <none> 13.0.85-1
2025-10-17 00:05:10 install cuda-crt-13-0:amd64 <none> 13.0.88-1
2025-10-17 00:05:10 install cuda-cudart-dev-13-0:amd64 <none> 13.0.96-1
2025-10-17 00:05:11 install cuda-culibos-dev-13-0:amd64 <none> 13.0.85-1
2025-10-17 00:05:11 install cuda-driver-dev-13-0:amd64 <none> 13.0.96-1
2025-10-17 00:05:11 install cuda-nvcc-13-0:amd64 <none> 13.0.88-1
2025-10-17 00:05:11 install cuda-nvrtc-13-0:amd64 <none> 13.0.88-1
2025-10-17 00:05:12 install cuda-nvtx-13-0:amd64 <none> 13.0.85-1
2025-10-17 00:05:12 install cuda-profiler-api-13-0:amd64 <none> 13.0.85-1
2025-10-17 00:05:16 install libcublas-13-0:amd64 <none> 13.1.0.3-1
2025-10-17 00:05:20 install libcufft-13-0:amd64 <none> 12.0.0.61-1
2025-10-17 00:05:23 install libcurand-13-0:amd64 <none> 10.4.0.35-1
2025-10-17 00:05:24 install libcusparse-13-0:amd64 <none> 12.6.3.3-1
2025-10-17 00:05:26 install libcusolver-13-0:amd64 <none> 12.0.4.66-1
2025-10-17 00:05:28 install libnpp-13-0:amd64 <none> 13.0.1.2-1
2025-10-17 00:05:30 install libnvjpeg-13-0:amd64 <none> 13.0.1.86-1
2025-10-17 00:05:30 install libcufile-13-0:amd64 <none> 1.15.1.6-1
2025-10-17 00:05:31 install libnvjitlink-13-0:amd64 <none> 13.0.88-1
2025-10-17 00:05:34 install libnvfatbin-13-0:amd64 <none> 13.0.85-1
2025-10-17 00:05:42 install libcudnn9-cuda-13:amd64 <none> 9.14.0.64-1
2025-10-17 00:05:52 install libnvinfer-dispatch10:amd64 <none> 10.13.3.9-1+cuda13.0
2025-10-17 00:05:52 install libnvinfer-lean10:amd64 <none> 10.13.3.9-1+cuda13.0
2025-10-17 00:05:53 install libnvinfer-plugin10:amd64 <none> 10.13.3.9-1+cuda13.0
2025-10-17 00:05:53 install libnvinfer-vc-plugin10:amd64 <none> 10.13.3.9-1+cuda13.0
2025-10-17 00:05:53 install libnvinfer-win-builder-resource10:amd64 <none> 10.13.3.9-1+cuda13.0
2025-10-17 00:05:57 install libnvinfer10:amd64 <none> 10.13.3.9-1+cuda13.0
2025-10-17 00:06:02 install libnvonnxparsers10:amd64 <none> 10.13.3.9-1+cuda13.0
2025-10-17 00:06:07 install libcusparselt0-cuda-13:amd64 <none> 0.8.1.1-1
2025-10-17 00:06:09 install libnccl2:amd64 <none> 2.27.7-1+cuda13.0
2025-11-05 06:54:13 install libpython3.12-minimal:amd64 <none> 3.12.3-1ubuntu0.8
2025-11-05 06:54:13 install libexpat1:amd64 <none> 2.6.1-2ubuntu0.3
2025-11-05 06:54:13 install python3.12-minimal:amd64 <none> 3.12.3-1ubuntu0.8
2025-11-05 06:54:14 install python3-minimal:amd64 <none> 3.12.3-0ubuntu2
2025-11-05 06:54:14 install media-types:all <none> 10.1.0
2025-11-05 06:54:14 install netbase:all <none> 6.4
2025-11-05 06:54:14 install tzdata:all <none> 2025b-0ubuntu0.24.04.1
2025-11-05 06:54:14 install libpython3.12-stdlib:amd64 <none> 3.12.3-1ubuntu0.8
2025-11-05 06:54:14 install python3.12:amd64 <none> 3.12.3-1ubuntu0.8
2025-11-05 06:54:14 install libpython3-stdlib:amd64 <none> 3.12.3-0ubuntu2
2025-11-05 06:54:14 install python3:amd64 <none> 3.12.3-0ubuntu2
2025-11-05 06:54:14 install libapparmor1:amd64 <none> 4.0.1really4.0.1-0ubuntu0.24.04.4
2025-11-05 06:54:14 install libargon2-1:amd64 <none> 0~20190702+dfsg-4build1
2025-11-05 06:54:14 install libdevmapper1.02.1:amd64 <none> 2:1.02.185-3ubuntu3.2
2025-11-05 06:54:14 install libjson-c5:amd64 <none> 0.17-1build1
2025-11-05 06:54:14 install libcryptsetup12:amd64 <none> 2:2.7.0-1ubuntu4.2
2025-11-05 06:54:14 install libfdisk1:amd64 <none> 2.39.3-9ubuntu6.3
2025-11-05 06:54:14 install libsystemd-shared:amd64 <none> 255.4-1ubuntu8.11
2025-11-05 06:54:14 install systemd-dev:all <none> 255.4-1ubuntu8.11
2025-11-05 06:54:15 install systemd:amd64 <none> 255.4-1ubuntu8.11
2025-11-05 06:54:15 install systemd-sysv:amd64 <none> 255.4-1ubuntu8.11
2025-11-05 06:54:15 install fonts-liberation:all <none> 1:2.1.5-3
2025-11-05 06:54:15 install libasound2-data:all <none> 1.2.11-1ubuntu0.1
2025-11-05 06:54:15 install libasound2t64:amd64 <none> 1.2.11-1ubuntu0.1
2025-11-05 06:54:15 install libglib2.0-0t64:amd64 <none> 2.80.0-6ubuntu3.4
2025-11-05 06:54:15 install at-spi2-common:all <none> 2.52.0-1build1
2025-11-05 06:54:15 install libatk1.0-0t64:amd64 <none> 2.52.0-1build1
2025-11-05 06:54:15 install libxau6:amd64 <none> 1:1.0.9-1build6
2025-11-05 06:54:15 install libxdmcp6:amd64 <none> 1:1.1.3-0ubuntu6
2025-11-05 06:54:15 install libxcb1:amd64 <none> 1.15-1ubuntu2
2025-11-05 06:54:15 install libx11-data:all <none> 2:1.8.7-1build1
2025-11-05 06:54:15 install libx11-6:amd64 <none> 2:1.8.7-1build1
2025-11-05 06:54:15 install libxext6:amd64 <none> 2:1.3.4-1build2
2025-11-05 06:54:15 install libxi6:amd64 <none> 2:1.8.1-1build1
2025-11-05 06:54:15 install libatspi2.0-0t64:amd64 <none> 2.52.0-1build1
2025-11-05 06:54:15 install libatk-bridge2.0-0t64:amd64 <none> 2.52.0-1build1
2025-11-05 06:54:15 install libpng16-16t64:amd64 <none> 1.6.43-5build1
2025-11-05 06:54:15 install libfreetype6:amd64 <none> 2.13.2+dfsg-1build3
2025-11-05 06:54:15 install fontconfig-config:amd64 <none> 2.15.0-1.1ubuntu2
2025-11-05 06:54:15 install libfontconfig1:amd64 <none> 2.15.0-1.1ubuntu2
2025-11-05 06:54:15 install libpixman-1-0:amd64 <none> 0.42.2-1build1
2025-11-05 06:54:15 install libxcb-render0:amd64 <none> 1.15-1ubuntu2
2025-11-05 06:54:15 install libxcb-shm0:amd64 <none> 1.15-1ubuntu2
2025-11-05 06:54:15 install libxrender1:amd64 <none> 1:0.9.10-1.1build1
2025-11-05 06:54:15 install libcairo2:amd64 <none> 1.18.0-3build1
2025-11-05 06:54:15 install libavahi-common-data:amd64 <none> 0.8-13ubuntu6
2025-11-05 06:54:15 install libavahi-common3:amd64 <none> 0.8-13ubuntu6
2025-11-05 06:54:15 install libavahi-client3:amd64 <none> 0.8-13ubuntu6
2025-11-05 06:54:16 install libcups2t64:amd64 <none> 2.4.7-1.2ubuntu7.4
2025-11-05 06:54:16 install libdrm-common:all <none> 2.4.122-1~ubuntu0.24.04.1
2025-11-05 06:54:16 install libdrm2:amd64 <none> 2.4.122-1~ubuntu0.24.04.1
2025-11-05 06:54:16 install libwayland-server0:amd64 <none> 1.22.0-2.1build1
2025-11-05 06:54:16 install libdrm-amdgpu1:amd64 <none> 2.4.122-1~ubuntu0.24.04.1
2025-11-05 06:54:16 install libpciaccess0:amd64 <none> 0.17-3ubuntu0.24.04.2
2025-11-05 06:54:16 install libdrm-intel1:amd64 <none> 2.4.122-1~ubuntu0.24.04.1
2025-11-05 06:54:16 install libedit2:amd64 <none> 3.1-20230828-1build1
2025-11-05 06:54:16 install libicu74:amd64 <none> 74.2-1ubuntu3.1
2025-11-05 06:54:16 install libxml2:amd64 <none> 2.9.14+dfsg-1.3ubuntu3.6
2025-11-05 06:54:16 install libllvm20:amd64 <none> 1:20.1.2-0ubuntu1~24.04.2
2025-11-05 06:54:16 install libsensors-config:all <none> 1:3.6.0-9build1
2025-11-05 06:54:16 install libsensors5:amd64 <none> 1:3.6.0-9build1
2025-11-05 06:54:16 install libx11-xcb1:amd64 <none> 2:1.8.7-1build1
2025-11-05 06:54:16 install libxcb-dri3-0:amd64 <none> 1.15-1ubuntu2
2025-11-05 06:54:16 install libxcb-present0:amd64 <none> 1.15-1ubuntu2
2025-11-05 06:54:16 install libxcb-randr0:amd64 <none> 1.15-1ubuntu2
2025-11-05 06:54:16 install libxcb-sync1:amd64 <none> 1.15-1ubuntu2
2025-11-05 06:54:16 install libxcb-xfixes0:amd64 <none> 1.15-1ubuntu2
2025-11-05 06:54:16 install libxshmfence1:amd64 <none> 1.3-1build5
2025-11-05 06:54:16 install mesa-libgallium:amd64 <none> 25.0.7-0ubuntu0.24.04.2
2025-11-05 06:54:16 install libgbm1:amd64 <none> 25.0.7-0ubuntu0.24.04.2
2025-11-05 06:54:16 install libgdk-pixbuf2.0-common:all <none> 2.42.10+dfsg-3ubuntu3.2
2025-11-05 06:54:16 install shared-mime-info:amd64 <none> 2.4-4
2025-11-05 06:54:16 install libjpeg-turbo8:amd64 <none> 2.1.5-2ubuntu2
2025-11-05 06:54:16 install libjpeg8:amd64 <none> 8c-2ubuntu11
2025-11-05 06:54:16 install libdeflate0:amd64 <none> 1.19-1build1.1
2025-11-05 06:54:16 install libjbig0:amd64 <none> 2.1-6.1ubuntu2
2025-11-05 06:54:16 install liblerc4:amd64 <none> 4.0.0+ds-4ubuntu2
2025-11-05 06:54:17 install libsharpyuv0:amd64 <none> 1.3.2-0.4build3
2025-11-05 06:54:17 install libwebp7:amd64 <none> 1.3.2-0.4build3
2025-11-05 06:54:17 install libtiff6:amd64 <none> 4.5.1+git230720-4ubuntu2.4
2025-11-05 06:54:17 install libgdk-pixbuf-2.0-0:amd64 <none> 2.42.10+dfsg-3ubuntu3.2
2025-11-05 06:54:17 install gtk-update-icon-cache:amd64 <none> 3.24.41-4ubuntu1.3
2025-11-05 06:54:17 install hicolor-icon-theme:all <none> 0.17-2
2025-11-05 06:54:17 install humanity-icon-theme:all <none> 0.6.16
2025-11-05 06:54:18 install ubuntu-mono:all <none> 24.04-0ubuntu1
2025-11-05 06:54:18 install adwaita-icon-theme:all <none> 46.0-1
2025-11-05 06:54:18 install libcairo-gobject2:amd64 <none> 1.18.0-3build1
2025-11-05 06:54:18 install liblcms2-2:amd64 <none> 2.14-2build1
2025-11-05 06:54:18 install libcolord2:amd64 <none> 1.4.7-1build2
2025-11-05 06:54:18 install libepoxy0:amd64 <none> 1.5.10-1build1
2025-11-05 06:54:18 install libfribidi0:amd64 <none> 1.0.13-3build1
2025-11-05 06:54:18 install libgraphite2-3:amd64 <none> 1.3.14-2build1
2025-11-05 06:54:18 install libharfbuzz0b:amd64 <none> 8.3.0-2build2
2025-11-05 06:54:18 install fontconfig:amd64 <none> 2.15.0-1.1ubuntu2
2025-11-05 06:54:18 install libthai-data:all <none> 0.1.29-2build1
2025-11-05 06:54:18 install libdatrie1:amd64 <none> 0.2.13-3build1
2025-11-05 06:54:18 install libthai0:amd64 <none> 0.1.29-2build1
2025-11-05 06:54:18 install libpango-1.0-0:amd64 <none> 1.52.1+ds-1build1
2025-11-05 06:54:18 install libpangoft2-1.0-0:amd64 <none> 1.52.1+ds-1build1
2025-11-05 06:54:18 install libpangocairo-1.0-0:amd64 <none> 1.52.1+ds-1build1
2025-11-05 06:54:18 install libwayland-client0:amd64 <none> 1.22.0-2.1build1
2025-11-05 06:54:18 install libwayland-cursor0:amd64 <none> 1.22.0-2.1build1
2025-11-05 06:54:18 install libwayland-egl1:amd64 <none> 1.22.0-2.1build1
2025-11-05 06:54:19 install libxcomposite1:amd64 <none> 1:0.4.5-1build3
2025-11-05 06:54:19 install libxfixes3:amd64 <none> 1:6.0.0-2build1
2025-11-05 06:54:19 install libxcursor1:amd64 <none> 1:1.2.1-1build1
2025-11-05 06:54:19 install libxdamage1:amd64 <none> 1:1.1.6-1build1
2025-11-05 06:54:19 install libxinerama1:amd64 <none> 2:1.1.4-3build1
2025-11-05 06:54:19 install xkb-data:all <none> 2.41-2ubuntu1.1
2025-11-05 06:54:19 install libxkbcommon0:amd64 <none> 1.6.0-1build1
2025-11-05 06:54:19 install libxrandr2:amd64 <none> 2:1.5.2-2build1
2025-11-05 06:54:19 install dbus-bin:amd64 <none> 1.14.10-4ubuntu4.1
2025-11-05 06:54:19 install dbus-session-bus-common:all <none> 1.14.10-4ubuntu4.1
2025-11-05 06:54:19 install dbus-daemon:amd64 <none> 1.14.10-4ubuntu4.1
2025-11-05 06:54:19 install dbus-system-bus-common:all <none> 1.14.10-4ubuntu4.1
2025-11-05 06:54:19 install dbus:amd64 <none> 1.14.10-4ubuntu4.1
2025-11-05 06:54:19 install libpam-systemd:amd64 <none> 255.4-1ubuntu8.11
2025-11-05 06:54:19 install dbus-user-session:amd64 <none> 1.14.10-4ubuntu4.1
2025-11-05 06:54:19 install libdconf1:amd64 <none> 0.40.0-4ubuntu0.1
2025-11-05 06:54:19 install dconf-service:amd64 <none> 0.40.0-4ubuntu0.1
2025-11-05 06:54:19 install dconf-gsettings-backend:amd64 <none> 0.40.0-4ubuntu0.1
2025-11-05 06:54:19 install libgtk-3-common:all <none> 3.24.41-4ubuntu1.3
2025-11-05 06:54:19 install libgtk-3-0t64:amd64 <none> 3.24.41-4ubuntu1.3
2025-11-05 06:54:19 install libnspr4:amd64 <none> 2:4.35-1.1build1
2025-11-05 06:54:19 install libnss3:amd64 <none> 2:3.98-1build1
2025-11-05 06:54:19 install libvulkan1:amd64 <none> 1.3.275.0-1build1
2025-11-05 06:54:19 install xdg-utils:all <none> 1.1.3-4.1ubuntu3
2025-11-05 06:54:19 install microsoft-edge-stable:amd64 <none> 142.0.3595.53-1
2025-11-05 06:54:27 install dmsetup:amd64 <none> 2:1.02.185-3ubuntu3.2
2025-11-05 06:54:27 install gir1.2-glib-2.0:amd64 <none> 2.80.0-6ubuntu3.4
2025-11-05 06:54:27 install libgirepository-1.0-1:amd64 <none> 1.80.1-1
2025-11-05 06:54:27 install gir1.2-girepository-2.0:amd64 <none> 1.80.1-1
2025-11-05 06:54:27 install libglib2.0-data:all <none> 2.80.0-6ubuntu3.4
2025-11-05 06:54:27 install libnss-systemd:amd64 <none> 255.4-1ubuntu8.11
2025-11-05 06:54:27 install libtext-iconv-perl:amd64 <none> 1.7-8build3
2025-11-05 06:54:27 install python3-dbus:amd64 <none> 1.3.2-5build3
2025-11-05 06:54:27 install python3-gi:amd64 <none> 3.48.2-1
2025-11-05 06:54:27 install networkd-dispatcher:all <none> 2.2.4-1
2025-11-05 06:54:27 install systemd-resolved:amd64 <none> 255.4-1ubuntu8.11
2025-11-05 06:54:27 install systemd-timesyncd:amd64 <none> 255.4-1ubuntu8.11
2025-11-05 06:54:27 install xdg-user-dirs:amd64 <none> 0.18-1build1
2025-11-05 06:54:27 install libxmuu1:amd64 <none> 2:1.1.3-3build2
2025-11-05 06:54:27 install alsa-topology-conf:all <none> 1.2.5.1-2
2025-11-05 06:54:27 install alsa-ucm-conf:all <none> 1.2.10-1ubuntu5.7
2025-11-05 06:54:27 install x11-common:all <none> 1:7.7+23ubuntu3
2025-11-05 06:54:27 install libxtst6:amd64 <none> 2:1.2.3-1.1build1
2025-11-05 06:54:27 install session-migration:amd64 <none> 0.3.9build1
2025-11-05 06:54:27 install gsettings-desktop-schemas:all <none> 46.1-0ubuntu1
2025-11-05 06:54:27 install at-spi2-core:amd64 <none> 2.52.0-1build1
2025-11-05 06:54:27 install fonts-liberation-sans-narrow:all <none> 1:1.07.6-4
2025-11-05 06:54:27 install libclone-perl:amd64 <none> 0.46-1build3
2025-11-05 06:54:27 install libdata-dump-perl:all <none> 1.25-1
2025-11-05 06:54:27 install libegl-mesa0:amd64 <none> 25.0.7-0ubuntu0.24.04.2
2025-11-05 06:54:27 install libencode-locale-perl:all <none> 1.05-3
2025-11-05 06:54:27 install libipc-system-simple-perl:all <none> 1.30-2
2025-11-05 06:54:27 install libfile-basedir-perl:all <none> 0.09-2
2025-11-05 06:54:27 install liburi-perl:all <none> 5.27-1
2025-11-05 06:54:27 install libfile-desktopentry-perl:all <none> 0.22-3
2025-11-05 06:54:27 install libtimedate-perl:all <none> 2.3300-2
2025-11-05 06:54:27 install libhttp-date-perl:all <none> 6.06-1
2025-11-05 06:54:27 install libfile-listing-perl:all <none> 6.16-1
2025-11-05 06:54:27 install libfile-mimeinfo-perl:all <none> 0.34-1
2025-11-05 06:54:27 install libfont-afm-perl:all <none> 1.20-4
2025-11-05 06:54:27 install libgdk-pixbuf2.0-bin:amd64 <none> 2.42.10+dfsg-3ubuntu3.2
2025-11-05 06:54:27 install libgl1-mesa-dri:amd64 <none> 25.0.7-0ubuntu0.24.04.2
2025-11-05 06:54:27 install libxcb-glx0:amd64 <none> 1.15-1ubuntu2
2025-11-05 06:54:27 install libxxf86vm1:amd64 <none> 1:1.1.4-1build4
2025-11-05 06:54:28 install libglx-mesa0:amd64 <none> 25.0.7-0ubuntu0.24.04.2
2025-11-05 06:54:28 install libgtk-3-bin:amd64 <none> 3.24.41-4ubuntu1.3
2025-11-05 06:54:28 install libhtml-tagset-perl:all <none> 3.20-6
2025-11-05 06:54:28 install libhtml-parser-perl:amd64 <none> 3.81-1build3
2025-11-05 06:54:28 install libio-html-perl:all <none> 1.004-3
2025-11-05 06:54:28 install liblwp-mediatypes-perl:all <none> 6.04-2
2025-11-05 06:54:28 install libhttp-message-perl:all <none> 6.45-1ubuntu1
2025-11-05 06:54:28 install libhtml-form-perl:all <none> 6.11-1
2025-11-05 06:54:28 install libhtml-tree-perl:all <none> 5.07-3
2025-11-05 06:54:28 install libhtml-format-perl:all <none> 2.16-2
2025-11-05 06:54:28 install libhttp-cookies-perl:all <none> 6.11-1
2025-11-05 06:54:28 install libhttp-daemon-perl:all <none> 6.16-1
2025-11-05 06:54:28 install libhttp-negotiate-perl:all <none> 6.01-2
2025-11-05 06:54:28 install libice6:amd64 <none> 2:1.0.10-1build3
2025-11-05 06:54:28 install perl-openssl-defaults:amd64 <none> 7build3
2025-11-05 06:54:28 install libnet-ssleay-perl:amd64 <none> 1.94-1build4
2025-11-05 06:54:28 install libio-socket-ssl-perl:all <none> 2.085-1
2025-11-05 06:54:28 install libio-stringy-perl:all <none> 2.111-3
2025-11-05 06:54:28 install libnet-http-perl:all <none> 6.23-1
2025-11-05 06:54:28 install libtry-tiny-perl:all <none> 0.31-2
2025-11-05 06:54:28 install libwww-robotrules-perl:all <none> 6.02-1
2025-11-05 06:54:28 install libwww-perl:all <none> 6.76-1
2025-11-05 06:54:28 install liblwp-protocol-https-perl:all <none> 6.13-1
2025-11-05 06:54:28 install libnet-smtp-ssl-perl:all <none> 1.04-2
2025-11-05 06:54:28 install libmailtools-perl:all <none> 2.21-2
2025-11-05 06:54:28 install libxml-parser-perl:amd64 <none> 2.47-1build3
2025-11-05 06:54:28 install libxml-twig-perl:all <none> 1:3.52-2
2025-11-05 06:54:28 install libnet-dbus-perl:amd64 <none> 1.2.0-2build3
2025-11-05 06:54:28 install librsvg2-2:amd64 <none> 2.58.0+dfsg-1build1
2025-11-05 06:54:28 install librsvg2-common:amd64 <none> 2.58.0+dfsg-1build1
2025-11-05 06:54:28 install libsm6:amd64 <none> 2:1.2.3-1build3
2025-11-05 06:54:28 install libtie-ixhash-perl:all <none> 1.23-4
2025-11-05 06:54:28 install libx11-protocol-perl:all <none> 0.56-9
2025-11-05 06:54:28 install libxt6t64:amd64 <none> 1:1.2.1-1.2build1
2025-11-05 06:54:28 install libxmu6:amd64 <none> 2:1.1.3-3build2
2025-11-05 06:54:28 install libxpm4:amd64 <none> 1:3.5.17-1build2
2025-11-05 06:54:28 install libxaw7:amd64 <none> 2:1.0.14-1build2
2025-11-05 06:54:28 install libxcb-shape0:amd64 <none> 1.15-1ubuntu2
2025-11-05 06:54:28 install libxft2:amd64 <none> 2.3.6-1build1
2025-11-05 06:54:28 install libxkbfile1:amd64 <none> 1:1.1.0-1build4
2025-11-05 06:54:28 install libxml-xpathengine-perl:all <none> 0.14-2
2025-11-05 06:54:28 install libxv1:amd64 <none> 2:1.0.11-1.1build1
2025-11-05 06:54:28 install libxxf86dga1:amd64 <none> 2:1.1.5-1build1
2025-11-05 06:54:28 install mesa-vulkan-drivers:amd64 <none> 25.0.7-0ubuntu0.24.04.2
2025-11-05 06:54:29 install libglvnd0:amd64 <none> 1.7.0-1build1
2025-11-05 06:54:29 install libglx0:amd64 <none> 1.7.0-1build1
2025-11-05 06:54:29 install libgl1:amd64 <none> 1.7.0-1build1
2025-11-05 06:54:29 install x11-utils:amd64 <none> 7.7+6build2
2025-11-05 06:54:29 install x11-xserver-utils:amd64 <none> 7.7+10build2
2025-11-05 06:54:29 install libegl1:amd64 <none> 1.7.0-1build1
2025-11-05 06:54:29 install libgles2:amd64 <none> 1.7.0-1build1
2025-11-05 06:54:29 install zutty:amd64 <none> 0.14.8.20231210+dfsg1-1
2025-11-05 06:54:29 install libauthen-sasl-perl:all <none> 2.1700-1
root@ef6b784a9db0:/# 


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









