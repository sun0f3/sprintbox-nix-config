{ lib, ... }: {
  services.unit = {
    enable = true;
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

}
