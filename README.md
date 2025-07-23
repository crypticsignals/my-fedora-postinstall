# my-fedora-postinstall

Gets various data ready from existing fedora install to quickly get things back up and running if needed.

**This was developed, tested, and ran with a Fedora 42 KDE system and VM. I cannot guarantee it works perfectly for other Fedora spins/editions, but this should come pretty close.** Code is pretty DE-agnostic, anyhow.

## 📄 `.gitignore`

- This is here simply because I'm choosing not to sync output files just to ensure repo is clean.

## 📄 `generatePackageLists.sh`

- Ensures rpmfusiom free and nonfree repos are added to the list, if user chooses to do so.
- Runs `dnf repoquery --userinstalled --qf "%{name}\n"` to make a list of every installed package on the system. Does involve the default utils that comes with your desktop environment, KDE in my case.
- Runs `flatpak list --columns=application,origin` to generate a list of installed flatpaks with their origin remotes to another text file. 
- ⚠️ **Does not work with manually installed .rpm files**. For this I'd recommend putting your RPM files in the `data` directory, and then copying your entire local copy of this repo as a .zip file to your target system.
- ⚠️ **Also does not work with third party repos, as of yet.**. In the future, I'll add steps for third party repos.

### Usage

1. Run the script. There is only one choice, and it walks you through the rest of the details.
2. Export/back up the generated files off of your current system, whether that's on a NAS, Cloud Storage, Syncthing Array, or even a flash drive to have an easy reinstall experience on other computers!


## 📄 `installPackages.sh`

- ⚠️ **Requires the hostname of the initial and target machines to be the same OR for the hostname of the initial machine to be hard coded into the code.**
  - Also requires the install files to be located in a directory in the root of this named `data`.
- Installs packages and flatpaks.
- Walks you through just about every step.
- Completely automates installs, with the option of having a confirmation/review before actual installs happen.

### Usage

There are two ways to start:

- Ensure that the target machine has the same hostname as what was generated in data/`<hostname>`-installedPackages<or>Flatpaks.txt
- Edit the line at the start of the script to match that hostname

Then:

1. Ensure that flathub is enabled as a remote. There's a few ways to do this.
2. Run the script. There are options to run it with confirmation to see what's installed (useful for potential tampering situations) or just to run it straight through.

## 📄 `setFirewall.sh`

- Sets firewall configurations to work past not-secure-as-I-like defaults, with options to either set custom ports, just disable the defaults (good for laptops where you likely don't want any open ports), or to leave them alone
- Optional SSH server configuration/enabling

### Usage

1. Run the script

It's pretty straightforward and walks you through everything.

## Future plans

- [ ] **Add specialty install instructions** (optional, will be in a seperate file) to install third party stuff like Tailscale.
  - [x] Firewall
  - [ ] Tailscale
- [ ] **Add specific configurations script** for things like firewall settings.
- [ ] **Add steps to see what third-party repos are enabled** and then install them.
- [ ] **Step away from hostname-based package list files.** I currently do this as I have multiple machines synced to this directory locally through syncthing. Though I will say it also would prevent accidental overwriting with similar setups. There's cases to be made for either.