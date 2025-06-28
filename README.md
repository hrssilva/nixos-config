# NixOS Configuration
This is a personal NixOS configuration using [flakes](https://wiki.nixos.org/wiki/Flakes) and [home-manager](https://github.com/nix-community/home-manager). Special thanks to [Ryan Yin](https://github.com/ryan4yin) and all his contributors for the excellent resource [their book](https://nixos-and-flakes.thiscute.world/) proved to be.

## System
The system folder contains several system configuration Nix modules for modularly building different hosts.
- *hosts* contains the particular host module, which imports several modules and has its specific hardware configuration.
- *modules* has several utility modules for reusability.
- *hardware* has the specific hardware configurations, typically created when NixOS is first installed.

## Home
The home folder contains all the home-manager configuration, as well as user-specific configurations, packages, and their configurations.

## Future possibilities
This setup can be further modularized to separate the [system](#System) and [home](#Home) in their flakes, although this may not be practical given its current size. 

