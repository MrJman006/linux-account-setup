# OS Partitions And Mount Points

I like to have maximum flexiblilty on my OS drive both in terms of sizing
partitions and hardening the system with STIG recommendations. While I may
customize each of my installs slightly, the layout and sizing below is what
I use a typical baseline.

**Disk Partitions**

```
/dev/disk
|-- part1               /boot/efi
|-- part2               /boot
`-- part3
    |-- vg_os-lv_root   /
    |-- vg_os-lv_swap   swap
    |-- vg_os-lv_tmp    /tmp
    |-- vg_os-lv_var    /var
    `-- vg_os-lv_home   /home
```

The first partitions I leave as standard partitons. I set them to mount
`/boot/efi` and `/boot` respectivley. There is not much flexability with these
two partitions because all boot files have to be accessible by the motherboard
during power on and can't be encrypted or behind a LVM partition. The third
standard partition I set to take up the remainder of the disk space and set it
to be a LVM partition. This lets it be used as is or split into two or more
logical partitions. Using LVM logical partitions makes it easier to manage and
resize the non-bootable OS mount points. So I typically create several logical
partitions and mount the remainder of the OS mount points to each. The specific
layout I use is 'root' (a.k.a '/'), 'swap', '/home', '/tmp', and '/var'. I choose
these to allow for system hardening should I decide I want it at some point.

Below are approximate partition sizes I use. The values below are by no means
minimum or maximum values. They are just rough sizings that I have found don't
need to be adjusted very much given a 500 GiB - 1000 GiB drive.

|Mount Point |Size            |
|:-----------|:---------------|
|/boot       |1   GiB         |
|/boot/efi   |1   GiB         |
|/           |100-200 GiB     |
|/tmp        |10 GiB          |
|/var        |10 GiB          |
|/home       |Remaining Space |
