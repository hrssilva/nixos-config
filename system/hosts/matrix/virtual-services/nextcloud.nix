{ ... }:
{
  #### AIO needs Docker to spawn sibling containers
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";

  #### Open the ports AIO uses
  networking.firewall.allowedTCPPorts = [ 80 443 8443 ];

  #### Persistent dirs (config + data). Reuse your existing host paths.
  # We'll keep AIO's config under /var/lib/nextcloud-aio and
  # reuse your /mnt/data/nextcloud-server as the Nextcloud data dir.
  #systemd.tmpfiles.rules = [
  #  "d /var/lib/nextcloud-aio 0750 root root -"
  #  "d /var/lib/nextcloud-aio/mastercontainer 0750 root root -"
  #  "d /mnt/data/nextcloud-server 0750 root root -"
  #];

  #### Run the AIO master container; it manages the rest through the Docker socket.
  virtualisation.oci-containers.containers.nextcloud-aio-master = {
    image = "nextcloud/all-in-one:latest";
    # Do NOT bind 443 here; the AIO reverse proxy container will take 443.
    ports = [
      "8980:80"        # HTTP (incl. ACME HTTP-01)
      "8443:8443"    # AIO admin UI
    ];
    volumes = [
      # Persist AIO master config
      "nextcloud_aio_mastercontainer:/mnt/docker-aio-config"

      # Allow AIO master to control sibling containers
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    environment = {
      # Tell AIO where your data lives inside the container namespace
      NEXTCLOUD_DATADIR = "/mnt/data/nextcloud-aio";
      # (Optional) Pre-fill your domain:
      # NEXTCLOUD_MAINDOMAIN = "cloud.example.com";
      # (Optional) If running behind an external reverse proxy, you can later
      # set AIO variables such as APACHE_PORT, APACHE_IP_BINDING, etc., in UI.
    };
    extraOptions = [
      "--pull=always"
      "--name=nextcloud-aio-mastercontainer"
    ];
  };

  #### Removed items from your original config:
  # - services.postgresql (AIO brings its own PostgreSQL)
  # - containers.\"vNextcloud\" (replaced by Dockerized AIO)
}

