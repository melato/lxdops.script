This repository is obsolete.  It is superceded by [lxdops.demo](https://github.com/melato/lxdops).

A set of example and working configuration files for lxdops (https://github.com/melato/lxdops).

**Initial setup:**
- lxdops property set zfsroot <zfs-filesystem>  # sets a global property that specifies a root zfs filesystem to use.

**Create a Test project (optional):**
```
lxdops project create -profiles test
lxc project switch test
```
which is equivalent to:
```
lxc project create -c features.images=false test
lxdops project copy-profiles -source-project default -target-project test default
lxc project switch test
```

Use any project name you like.  The project should have its own profiles.  lxdops does not create images, so the project does not need separate images.

**Create a template container and a working container (alpine):**
```
cd templates
lxdops launch alp.yaml
cd containers
lxdops launch dev.yaml
```

This creates:
- A stopped container called "alp", with a "copy" snapshot
- A running container called "dev" that is cloned from alp/copy
- Two zfs filesystems, "host", and "log", for each of the above containers
- A .lxdops profile for each of these containers, with several disk devices:  /var/opt, /etc/opt, /opt, /home, /var/log, /usr/local/bin.
/var/log is in the "log" filesystem.  All other devices are in the "host" filesystem.


**Rebuild a container:**
If you want to upgrade the os of container dev, then first upgrade or rebuild its template (not described here)
```
lxdops rebuild dev.yaml
```


**Managing Configuration files:**

For production  use, I structure my numerous lxdops configuration files in 3 levels:
- base lxdops: this repository
- generic lxdops:  mostly templates, and configuration specific to me, such as my user
- host-specific lxdops:  containes a .yaml file for each container in a single host LXD system
Each level includes files from the previous levels
