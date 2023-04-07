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
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header Host $host;

          if (-f $request_filename) {
            break;
          }

          if (-f $request_filename/index.html) {
            rewrite (.*) $1/index.html break;
          }

          if (-f $request_filename.html) {
            rewrite (.*) $1.html break;
          }

          if (!-f $request_filename) {
            proxy_pass http://buhduh;
            break;
          }
        '';
      };
      locations."*~ \.(ico|css|gif|jpe?g|png|js)(\?[0-9]+)?$".extraConfig  = ''
          expires max;
          break;
        '';
      extraConfig = ''
        index index.html;
        try_files $uri $uri/ =404;
      '';
    };
  };
}
