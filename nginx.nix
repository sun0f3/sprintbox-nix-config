{
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "varlamoved@gmail.com";
  services.nginx.enable = true;
  services.nginx.virtualHosts."buhduh.ru" = {
    addSSL = true;
    enableACME = true;
    root = "/var/www/buhduh.ru";
  };
}
