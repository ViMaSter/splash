# Running Bar Plymouth Theme

This adds a Plymouth boot splash theme (shown before the login manager).

## Build RPM (Immutable-safe)

Build in a mutable environment, not on the Bazzite host root.

Option A: Toolbox (recommended on Bazzite)

1. Create and enter a toolbox:

   toolbox create --image fedora-toolbox:latest
   toolbox enter

2. In toolbox, install build deps:

   sudo dnf install -y rpm-build rpmdevtools

3. From the host, put this repo under your home directory (for example in ~/src/splash).

4. In toolbox, go to the same path and build:

   cd ~/src/splash
   ./build-plymouth-rpm.sh

5. Exit toolbox:

   exit

Notes:

- Toolbox shares your home directory, so files built in toolbox appear on the host too.
- If your repo is not in your home directory, copy it there first or bind-mount it into a containerized build environment.

Quick copy-paste sequence:

   toolbox create --image fedora-toolbox:latest
   toolbox enter
   sudo dnf install -y rpm-build rpmdevtools
   cd ~/src/splash
   ./build-plymouth-rpm.sh
   exit

Option B: Any Fedora container/VM

1. Install rpm build tooling in that environment.
2. Run:

   ./build-plymouth-rpm.sh

The resulting RPM will be in:

dist/rpms/noarch/runningbar-plymouth-1.0.0-1*.rpm

## Layer On Bazzite

From your Bazzite host:

1. Layer the local RPM:

   sudo rpm-ostree install ./dist/rpms/noarch/runningbar-plymouth-1.0.0-1*.rpm

2. Set it as default Plymouth theme:

   sudo plymouth-set-default-theme runningbar

3. Regenerate initramfs and reboot:

   sudo rpm-ostree initramfs --enable --reboot

After reboot, the pre-login boot splash should use Running Bar.