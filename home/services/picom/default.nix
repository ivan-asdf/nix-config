{ ... }: {
  services.picom = {
    enable = true;
    backend = "glx";
    opacityRules = [
      # use: xprop | grep "CLASS"  to get window name
      "96:class_g = 'Alacritty' && focused"
      "90:class_g = 'Alacritty' && !focused"
      "96:class_g = 'kitty' && focused"
      "90:class_g = 'kitty' && !focused"
    ];
    settings = {
      blur = {
        method = "dual_kawase";
        strength = 3;
        #size = 10;
        #deviation = 5.0;
      };
    };
    fade = true;
    fadeDelta = 5;
    shadow = true;
    #shadowOpacity = 1;
    #shadow-offset-x = 10;
  };
}

