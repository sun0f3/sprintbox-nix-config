{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [
      "141.8.194.254"
      "141.8.197.254"
    ];
    defaultGateway = "141.8.199.1";
    defaultGateway6 = "fe80::1";
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce true;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="141.8.199.116"; prefixLength=24; }
        ];
        ipv6.addresses = [
          { address="2a0a:2b41:6:1f98::"; prefixLength=64; }
{ address="fe80::5054:ff:fe63:7036"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "141.8.199.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = "fe80::1"; prefixLength = 32; } ];
      };
      
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="52:54:00:63:70:36", NAME="eth0"
    
  '';
}
