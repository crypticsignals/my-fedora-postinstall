# my-fedora-postinstall
Gets various data ready from existing fedora install to quickly get things back up and running if needed.

## 📄 `.gitignore`

Choosing not to sync output files just to ensure repo is clean.

## 📄 `generatePackageLists.sh`

- Ensures free and nonfree repos are added to the list
- Runs `dnf repoquery --userinstalled --qf "%{name}\n "` to make a list of every installed package on the system. Does involve the default utils that comes with your desktop environment, KDE in my case.
- Runs `flatpak list --columns=application` to generate a list of installed flatpaks to another text file. 

In the future, I will create a shell script to install everything from that file.