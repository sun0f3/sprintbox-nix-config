{
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "varlamoved@gmail.com";

  services.nginx = {
    enable = true;
    upstreams.buhduh.servers."unix:///tmp/puma.sock" = {};
    virtualHosts."buhduh.ru" = {
      #   addSSL = true;
      #   enableACME = true;
      root = "/home/buhduh/app/current/public";
      locations."/" = {
        recommendedProxySettings = true;
        extraConfig  = ''
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
      extraConfig = ''
        index index.html;
        try_files $uri $uri/ =404;
      '';
    };
  };
}
