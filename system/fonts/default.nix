{pkgs, ...} : {
  fonts = {
    packages = with pkgs; [
      # Monospace
      #fira-code
      #fira-code-symbols
      #jetbrains-mono
      #source-code-pro
      hack-font
      #(nerdfonts.override { fonts = [ "Hack" ]; })

      # Icons & Emoji
      (pkgs.callPackage ./nerd {})
      weather-icons
      noto-fonts-emoji
      # Serif
      times-newer-roman
      # Sans
      helvetica-neue-lt-std
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
