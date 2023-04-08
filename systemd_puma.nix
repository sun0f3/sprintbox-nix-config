{ pkgs, ... }: {
  systemd.services.puma = {
    enable = true;
    description = "Puma HTTP Server";
    after = [ "network.target" ];
    path = with pkgs; [
      ruby_3_2
    ];

    environment= {
      RAILS_ENV="production";
    };

    serviceConfig =  {
      Type = "notify";
      WatchdogSec = 10;
      WorkingDirectory = "/var/www/buhduh/current";
      ExecStart = "/home/buhduh/bin/puma -C /var/www/buhduh/current/config/puma.rb";
      Restart = "always";
      User = "buhduh";
    };

    wantedBy = [ "multi-user.target" ];

  };

}
