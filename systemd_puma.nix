{ pkgs, ... }: {
  systemd.services.puma = {
    enable = true;
    description = "Puma HTTP Server";
    after = [ "network.target" ];
    path = ["/home/buhduh/app"];

    serviceConfig =  {
      Type = "notify";
      WatchdogSec = 10;
      WorkingDirectory = "/home/buhduh/app";
      ExecStart = "${pkgs.rubyPackages_3_2.puma}/bin/puma -C /home/buhduh/app/current/config/puma.rb";
      Restart = "always";
    };

    wantedBy = [ "multi-user.target" ];

  };

}
