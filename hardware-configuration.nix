{ nixpkgs, ... }:
{
  imports = [ (nixpkgs + "/nixos/modules/profiles/qemu-guest.nix") ];
  boot.loader.grub.device = "/dev/vda";
  fileSystems."/" = { device = "/dev/vda3"; fsType = "ext4"; };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 1024;
  }];
}
