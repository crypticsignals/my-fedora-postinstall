# my-fedora-postinstall

Gets various data ready from existing fedora install to quickly get things back up and running if needed.

**This was developed, tested, and ran with a Fedora 42 KDE system. I cannot guarantee it works perfectly for other Fedora spins/editions, but this should come pretty close.** Code is pretty DE-agnostic, anyhow.

## 📄 `.gitignore`

Choosing not to sync output files just to ensure repo is clean.

## 📄 `generatePackageLists.sh`

- Ensures free and nonfree repos are added to the list.
- Runs `dnf repoquery --userinstalled --qf "%{name}\n "` to make a list of every installed package on the system. Does involve the default utils that comes with your desktop environment, KDE in my case.
- Runs `flatpak list --columns=application` to generate a list of installed flatpaks to another text file. 
- Export the generated files off of your current system, whether that's on a NAS, Cloud Storage, Syncthing Array, or even a flash drive to have an easy reinstall experience on other computers!
- ⚠️ **Does not work with manually installed .rpm files**. For this I'd recommend putting your RPM files in the `data` directory, and then copying your entire local copy of this repo as a .zip file to your target system.


## 📄 `generatePackageLists.sh`

- Installs packages and flatpaks.
- Walks you through just about every step.
- Completely automates installs, with the option of having a confirmation/review before actual installs happen.