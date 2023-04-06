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
      WorkingDirectory = "/home/buhduh/app/current";
      ExecStart = "/home/buhduh/bin/bundle exec puma -C /home/buhduh/app/current/config/puma.rb";
      Restart = "always";
      User = "buhduh";
    };

    wantedBy = [ "multi-user.target" ];

  };

}
