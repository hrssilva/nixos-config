# NixOS Configuration
This is a personal NixOS configuration using [flakes](https://wiki.nixos.org/wiki/Flakes) and [home-manager](https://github.com/nix-community/home-manager). Special thanks to [Ryan Yin](https://github.com/ryan4yin) for the amazing resource [his book](https://nixos-and-flakes.thiscute.world/) proved to be.

## System
The system folder contains several system configuration Nix modules for modularly building different hosts.
- *hosts* contains the particular host module, importing several modules and its specific hardware configuration.
- *modules* has several utility modules for reusability.
- *hardware* has the specific hardware configurations, normally created when first installing NixOS.

## Home
The home folder contains all the home-manager configuration, as well as user specific configurations, packages and their configurations.

## Future possibilities
This setup can be further modularized to separate [system](#System) and [home](#Home) in their own flakes, although this makes no sense with its current size. 

Additionaly, the setup is multi-host but single-user at the moment. This could be expanded by segregating [home](#Home) in several users and refactoring how the user variables are setup in flake.nix.
