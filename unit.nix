{ lib, pkgs, ... }: {
  services.unit = {
    enable = true;
    package = pkgs.unit.override {withRuby_2_7 = false; withRuby_3_1 = true; ruby_3_1 = pkgs.ruby_3_2;};
    config = ''
    {
    "listeners": {
        "*:80": {
            "pass": "routes"
        }
    },

    "routes": [
        {
            "action": {
                "share": "/var/www/buhduh/current/public$uri",
                "fallback": {
                    "pass": "applications/rails"
                }
            }
        }
    ],

    "applications": {
        "rails": {
            "type": "ruby",
            "user": "buhduh",
            "group": "buhduh",
            "script": "config.ru",
            "working_directory": "/var/www/buhduh/current/"
        }
    }
    }
    '';
  };

  systemd.services.unit.path = with pkgs; [ ruby_3_2  ];
  systemd.services.unit.environment."RAILS_ENV" = "production";
  #systemd.services.unit.environment."GEM_PATH" = "/root/.local/share/gem/ruby/3.2.0";
}
