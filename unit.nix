{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.unit;
in {

  services.unit = {
    enable = false;
    package = pkgs.unit.override {withRuby_2_7 = false; withRuby_3_1 = true; ruby_3_1 = pkgs.ruby_3_2;};
    config = ''
    {
    "listeners": {
        "*:3001": {
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

  config = mkIf config.services.unit.enable {
    systemd.services.unit.path = with pkgs; [ ruby_3_2  ];
    systemd.services.unit.environment."RAILS_ENV" = "production";
  };
}
