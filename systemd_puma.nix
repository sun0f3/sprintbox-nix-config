{ pkgs, ... }: {
  systemd.services.puma = {
    enable = false;
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
      ExecStart = "/var/www/buhduh/current/bin/puma -C /var/www/buhduh/current/config/puma.rb";
      Restart = "always";
      User = "buhduh";
    };

    wantedBy = [ "multi-user.target" ];

  };
}
