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
      ExecStart = "/home/buhduh/bin/bundle exec puma -C /home/buhduh/app/current/config/puma.rb";
      Restart = "always";
    };

    wantedBy = [ "multi-user.target" ];

  };

}