{ ... }:

{
  disko.devices = {
    # HDDs for RAID1
    disk = {
      hdd1 = {
        type = "disk";
        device = "/dev/sdb";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02";
            };
            mdadm = {
              size = "100%";
              content = {
                type = "mdraid";
                name = "raid-data";
              };
            };
          };
        };
      };
      hdd2 = {
        type = "disk";
        device = "/dev/sdc";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02";
            };
            mdadm = {
              size = "100%";
              content = {
                type = "mdraid";
                name = "raid-data";
              };
            };
          };
        };
      };

      # SSD SATA
      ssd = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            cache = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/mnt/cache";
              };
            };
          };
        };
      };

      # NVMe: boot + swap + root + db
      nvme = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            swap = {
              size = "4G";
              content = {
                type = "swap";
                randomEncryption = true;
              };
            };
            root = {
              size = "200G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
            db = {
              size = "remaining";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/postgresql";
              };
            };
          };
        };
      };
    };

    # Array RAID1 in /mnt/data
    mdadm = {
      "raid-data" = {
        type = "mdadm";
        level = 1;
        content = {
          type = "gpt";
          partitions = {
            data = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/mnt/data";
              };
            };
          };
        };
      };
    };
  };
}

