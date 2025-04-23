# Scripts for building KStars in several environments
## Install Pre-requisites

```
sudo apt install git
```

## Install scripts

```
mkdir -p $HOME/astro/git
cd $HOME/astro/git
git clone https://github.com/sterne-jaeger/kstars-scripts.git
cd kstars-scripts
```

## Configure scripts
The file `scripts/config.sh` contains all variables to configure your installation. If unsure, leave it as is.

## Execute scripts to install INDI, INDI 3rd-Party, StellarSolver and KStars

```
~/astro/git/kstars-scripts/scripts/install-indi.sh
~/astro/git/kstars-scripts/scripts/install-indi-3rdparty.sh
~/astro/git/kstars-scripts/scripts/install-phd2.sh
~/astro/git/kstars-scripts/scripts/install-stellarsolver.sh
~/astro/git/kstars-scripts/scripts/install-kstars.sh
```

