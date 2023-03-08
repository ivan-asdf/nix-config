{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    profiles.ivan-nix = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        privacy-badger
        betterttv
      ];
#      extraConfig = builtins.readFile ./user.js;
      userChrome = builtins.readFile ./userChrome.css; 
    };
  };
}
