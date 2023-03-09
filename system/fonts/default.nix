{pkgs, ...} : {
  fonts = {
    fonts = with pkgs; [
      #fira-code
      #fira-code-symbols
      #jetbrains-mono
      #source-code-pro
      hack-font
      noto-fonts-emoji
      #(nerdfonts.override { fonts = [ "Hack" ]; })
    ];
    enableDefaultFonts = false;
    fontconfig = {
      defaultFonts = {
        monospace = [ "Material Design Icons" "Symbols Nerd Font" ];
        sansSerif = [ ];
        serif = [ ];
        #emoji = ["Noto Color Emoji"];
      };
      /*localConf = ''
        <alias>
          <family>Hack</family>
          <prefer>
            <family>Symbols Nerd Font</family>
          </prefer>
        </alias>
      '';*/
    };
  };
}
