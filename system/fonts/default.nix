{pkgs, ...} : {
  fonts = {
    packages = with pkgs; [
      # Monospace
      fira-code
      cascadia-code
      # fira-code-symbols
      # jetbrains-mono
      # source-code-pro
      hack-font
      # (nerdfonts.override { fonts = [ "Hack" ]; })

      # Icons & Emoji
      (pkgs.callPackage ./nerd {})
      (pkgs.callPackage ./operator-mono {})
      weather-icons
      noto-fonts-emoji
      # Serif
      times-newer-roman
      # Sans
      helvetica-neue-lt-std
      # Other
      noto-fonts-cjk-sans
    ];
    enableDefaultPackages = false;
    fontconfig = {
      defaultFonts = {
        monospace = [ "Hack" ];
        sansSerif = [ "Helvetica Neue LT Std" ];
        serif = [ "Times Newer Roman" ];
        emoji = [ "Noto Color Emoji" ];
      };
      localConf = ''
        <alias>
          <family>Hack</family>
          <prefer>
            <family>Symbols Nerd Font</family>
          </prefer>
        </alias>
      '';
    };
  };
}
