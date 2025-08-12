# Noxcoin GUI Wallet

A fast, privacy, cross-platform desktop wallet for Noxcoin.  
Built with Qt/QML. Simple Mode for one-click start, Advanced Mode for full control.

- **Website:** https://noxcoin.org
- **Explorer:** https://explorer.noxcoin.org/
- **Repo:** https://github.com/noxcoin-project/noxcoin-gui

---

## Highlights
- **Privacy by default** (Ring Signatures, Stealth Addresses, RingCT, Bulletproofs+)
- **Two modes**: Simple (auto node) and Advanced (local/remote node, full controls)
- **Cross-platform**: Linux, macOS, Windows; experimental Android build
- **Seed backup**: 25-word mnemonic + encrypted wallet files

---

## Build from Source

**Minimum Qt**: 5.9.7 (Qt 5.12+ recommended)  
**Official releases** bundle `noxcoin-wallet-gui` with CLI binaries from deterministic builds.

### Reproducible Windows static build (Docker, any OS)
1) Install Docker: https://docs.docker.com/engine/install/  
2) Clone:
~~~bash
git clone --branch master --recursive https://github.com/noxcoin-project/noxcoin-gui.git
~~~
*(use a tag like `v0.18.4.1` for a specific release)*

3) Build image:
~~~bash
cd noxcoin-gui
docker build --tag noxcoin:build-env-windows --build-arg THREADS=4 --file Dockerfile.windows .
~~~
4) Build binaries:
~~~bash
docker run --rm -it -v <NOXCOIN_GUI_DIR_ABS_PATH>:/noxcoin-gui -w /noxcoin-gui \
  noxcoin:build-env-windows sh -c 'make depends root=/depends target=x86_64-w64-mingw32 tag=win-x64 -j4'
~~~
Artifacts: `noxcoin-gui/build/x86_64-w64-mingw32/release/bin`

### Reproducible Linux static build (Docker, any OS)
1) Install Docker  
2) Clone (see above)  
3) Build image:
~~~bash
cd noxcoin-gui
docker build --tag noxcoin:build-env-linux --build-arg THREADS=4 --file Dockerfile.linux .
~~~
4) Build:
~~~bash
docker run --rm -it -v <NOXCOIN_GUI_DIR_ABS_PATH>:/noxcoin-gui -w /noxcoin-gui \
  noxcoin:build-env-linux sh -c 'make release-static -j4'
~~~
Artifacts: `noxcoin-gui/build/release/bin`

5) (*Note*) This builds **GUI** only; build `noxcoind`/CLI in the core repo.  
6) (*Optional*) Verify SHA-256:
~~~bash
docker run --rm -it -v <NOXCOIN_GUI_DIR_ABS_PATH>:/noxcoin-gui -w /noxcoin-gui \
  noxcoin:build-env-linux sh -c 'shasum -a 256 build/release/bin/noxcoin-wallet-gui'
~~~

### Android APK (Docker, experimental)
- Min Android 9 (API 28), ARMv8-A (64-bit)
~~~bash
git clone --recursive https://github.com/noxcoin-project/noxcoin-gui.git
cd noxcoin-gui
docker build --tag noxcoin:build-env-android --build-arg THREADS=4 --file Dockerfile.android .
docker run --rm -it -v <NOXCOIN_GUI_DIR_ABS_PATH>:/noxcoin-gui -e THREADS=4 noxcoin:build-env-android
~~~
APK: `build/Android/release/android-build/noxcoin-gui.apk`  
Install via ADB:
~~~bash
adb install build/Android/release/android-build/noxcoin-gui.apk
~~~

### Linux (native)
Tested on recent Ubuntu/Debian/Gentoo/Fedora.
1) Install core deps (examples):
- **Debian/Ubuntu/Mint**:
~~~bash
sudo apt install build-essential cmake miniupnpc libunbound-dev graphviz doxygen libunwind8-dev \
pkg-config libssl-dev libzmq3-dev libsodium-dev libhidapi-dev libnorm-dev libusb-1.0-0-dev \
libpgm-dev libprotobuf-dev protobuf-compiler libgcrypt20-dev \
libboost-chrono-dev libboost-date-time-dev libboost-filesystem-dev libboost-locale-dev \
libboost-program-options-dev libboost-regex-dev libboost-serialization-dev libboost-system-dev \
libboost-thread-dev
~~~
- **Gentoo**:
~~~bash
sudo emerge app-arch/xz-utils app-doc/doxygen dev-cpp/gtest dev-libs/boost dev-libs/expat \
dev-libs/openssl dev-util/cmake media-gfx/graphviz net-dns/unbound net-libs/miniupnpc \
net-libs/zeromq sys-libs/libunwind dev-libs/libsodium dev-libs/hidapi dev-libs/libgcrypt
~~~
- **Fedora**:
~~~bash
sudo dnf install make automake cmake gcc-c++ boost-devel miniupnpc-devel graphviz doxygen \
unbound-devel libunwind-devel pkgconfig openssl-devel libcurl-devel hidapi-devel libusb-devel \
zeromq-devel libgcrypt-devel
~~~

2) Install Qt (5.9.7+). From distro repos or official installer: https://www.qt.io/download-qt-installer  
3) Build:
~~~bash
git clone --recursive https://github.com/noxcoin-project/noxcoin-gui.git
cd noxcoin-gui
make release -j4
~~~
If Qt is custom-installed:
~~~bash
CMAKE_PREFIX_PATH=$HOME/Qt/5.12.12/gcc_64 make release -j4
~~~
Binary: `build/release/bin/noxcoin-wallet-gui`

### macOS
1) Xcode (App Store)  
2) Homebrew: https://brew.sh/  
3) Core deps:
~~~bash
brew install cmake pkg-config openssl boost unbound hidapi zmq libpgm libsodium miniupnpc expat \
libunwind-headers protobuf libgcrypt
~~~
4) Qt 5.9.7+:
~~~bash
brew install qt@5
# or use Qt online installer
~~~
5) Build:
~~~bash
git clone --recursive https://github.com/noxcoin-project/noxcoin-gui.git
cd noxcoin-gui
make release -j4
# If Qt is custom:
CMAKE_PREFIX_PATH=$HOME/Qt/5.12.12/clang_64 make release -j4
~~~
App bundle notes: see `DEPLOY.md`.  
Binary: `build/release/bin/noxcoin-wallet-gui`

### Windows (MSYS2 / MINGW64, 64-bit)
1) Install MSYS2: https://www.msys2.org/  
2) Open **MSYS2 MinGW 64-bit** shell  
3) Deps:
~~~bash
pacman -Syu
pacman -S mingw-w64-x86_64-toolchain make mingw-w64-x86_64-cmake \
  mingw-w64-x86_64-boost mingw-w64-x86_64-openssl mingw-w64-x86_64-zeromq \
  mingw-w64-x86_64-libsodium mingw-w64-x86_64-hidapi mingw-w64-x86_64-protobuf-c \
  mingw-w64-x86_64-libusb mingw-w64-x86_64-libgcrypt mingw-w64-x86_64-unbound \
  mingw-w64-x86_64-pcre mingw-w64-x86_64-angleproject mingw-w64-x86_64-qt5 git
~~~
4) Build:
~~~bash
git clone --recursive https://github.com/noxcoin-project/noxcoin-gui.git
cd noxcoin-gui
make release-win64 -j4
cd build/release && make deploy
~~~
Artifacts: `build/release/bin`

---

## Run
- **Simple Mode**: auto-connects and starts syncing. Best for new users.
- **Advanced Mode**: Settings → Node → choose **Local** (runs `noxcoind`) or **Remote** (enter `host:port`, default RPC often `19009`).
- Create a new wallet or restore with your **25-word seed**. Keep your password/seed offline.

*macOS tip*: if CLI tools crash during sync on very low-RAM systems, try `--max-concurrency 1`.
