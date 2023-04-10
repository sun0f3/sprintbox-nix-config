{ lib, ... }: {
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "varlamoved@gmail.com";

  services.nginx = {
    enable = true;
    #upstreams.buhduh.servers."unix:///tmp/puma.sock" = {};
    upstreams.buhduh.servers."127.0.0.1:3000" = {};
    virtualHosts."buhduh.ru" = {
      #addSSL = true;
      forceSSL = true;
      enableACME = true;
      root = "/var/www/buhduh/current/public";
      locations."@app".extraConfig = ''
        proxy_pass http://buhduh;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_redirect off;
      '';
      extraConfig = ''
        try_files $uri/index.html $uri @app;
        error_page 500 502 503 504 /500.html;
        client_max_body_size 4G;
        keepalive_timeout 10;
      '';
    };
  };

  #systemd.services.nginx.serviceConfig.ProtectHome = "read-only";
  systemd.services.nginx.serviceConfig.ProtectHome = lib.mkForce false;
  systemd.services.nginx.serviceConfig.ProtectSystem = lib.mkForce false;
}
