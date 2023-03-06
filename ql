[1mdiff --git a/home/home.nix b/home/home.nix[m
[1mindex 8345b1a..75a97c6 100644[m
[1m--- a/home/home.nix[m
[1m+++ b/home/home.nix[m
[36m@@ -52,9 +52,11 @@[m [min[m
     cloc[m
     unzip[m
     tree[m
[32m+[m[32m    feh[m
     zathura[m
[31m-    # bash improvements[m
[31m-    exa[m
[32m+[m[32m    # default utils improvements[m
[32m+[m[32m    exa # ls[m
[32m+[m[32m    bat # cat[m
     # dev[m
     nodejs[m
     nodePackages.pyright[m
[36m@@ -151,5 +153,9 @@[m [min[m
     #shadowOpacity = 1;[m
     #shadow-offset-x = 10;[m
   };[m
[32m+[m
[32m+[m[32m  programs.rofi = {[m
[32m+[m[32m    enable = true;[m
[32m+[m[32m  };[m
 }[m
 [m
[1mdiff --git a/home/i3/i3.nix b/home/i3/i3.nix[m
[1mindex e572ded..3995930 100644[m
[1m--- a/home/i3/i3.nix[m
[1m+++ b/home/i3/i3.nix[m
[36m@@ -111,6 +111,11 @@[m [min[m
         #{ command = "pkill polybar; polybar --log=info 2>> /home/ivan/.cache/polybar1.log"; always = true; notification = false; }[m
         { command = "pkill polybar; polybar"; always = true; notification = false; }[m
         { command = "pkill picom; picom"; always = true; notification = false; }[m
[32m+[m[32m        {[m
[32m+[m[32m          command = "feh --bg-fill --randomize ~/.config/feh/wallpapers/*";[m
[32m+[m[32m          always = true;[m
[32m+[m[32m          notification = false;[m
[32m+[m[32m        }[m
       ];[m
       defaultWorkspace = "workspace number 1";[m
 [m
[36m@@ -150,5 +155,10 @@[m [min[m
   xdg.configFile."alacritty/alacritty.yml" = {[m
     source = ../alacritty/alacritty.yml;[m
   };[m
[32m+[m
[32m+[m[32m  xdg.configFile."feh/wallpapers" = {[m
[32m+[m[32m    source = ./wallpapers;[m
[32m+[m[32m    recursive = true;[m
[32m+[m[32m  };[m
 }[m
 [m
[1mdiff --git a/home/polybar/default.nix b/home/polybar/default.nix[m
[1mindex 833d55f..8a23482 100644[m
[1m--- a/home/polybar/default.nix[m
[1m+++ b/home/polybar/default.nix[m
[36m@@ -22,8 +22,8 @@[m
         override-redirect = true;[m
         # to hide it when fullscreen[m
         wm-restack = "i3";[m
[31m-        width = "98%";[m
[31m-        offset-x = "1%";[m
[32m+[m[32m        width = "100%";[m
[32m+[m[32m        #offset-x = "1%";[m
         height = 29;[m
         padding-right = 1;[m
 [m
[36m@@ -32,7 +32,7 @@[m
 [m
         #border-size = 5;[m
         #border-color = "\${colors.crust}";[m
[31m-        radius = 10;[m
[32m+[m[32m        #radius = 10;[m
 [m
         seperator = "|";[m
         module-margin = 2;[m
