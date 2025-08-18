{ pkgs, ... } :
{
    services.displayManager.sddm.enable = true;
    security.pam.services.sddm.kwallet = {
        enable = true;
    };
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm.wayland.enable = true;

    # Add some wayland stuff
    xdg.portal = { enable = true; extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; }; 
}
