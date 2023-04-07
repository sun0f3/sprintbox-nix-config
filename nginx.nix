{
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "varlamoved@gmail.com";

  services.nginx = {
    enable = true;
    #upstreams.buhduh.servers."unix:///tmp/puma.sock" = {};
    upstreams.buhduh.servers."127.0.0.1:3000" = {};
    virtualHosts."buhduh.ru" = {
      #   addSSL = true;
      #   enableACME = true;
      root = "/home/buhduh/app/current/public";
      locations."/" = {
        #recommendedProxySettings = true;
        extraConfig  = ''
        try_files $uri/index.html $uri @app;

        location @app {
            proxy_pass http://buhduh;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $host;
            proxy_redirect off;
        }
        '';
      };
    };
  };
}
