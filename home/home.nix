{ pkgs, lib, ... }:
let
  apply_home = pkgs.writeShellScriptBin
    "apply-home"
    (builtins.readFile ../apply-home.sh);

  apply_system = pkgs.writeShellScriptBin
    "apply-system"
    (builtins.readFile ../apply-system.sh);
in
{
  imports = [
    ./i3.nix
  ];

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  home.packages = with pkgs; [ nil xclip apply_home apply_system];

  programs.git = {
    enable = true;
    userName = "Ivan";
    userEmail = "ivan.asdf0@gmail.com";
    extraConfig.init.defaultBranch = "master";
  };

  programs.bash = {
    enable = true;
    bashrcExtra = builtins.readFile ./bashrc;
  };

  programs.starship = {
    enable = true;
  };
  xdg.configFile."starship.toml" = {
    source = ./starship.toml;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = ":luafile ~/.config/nvim/init.lua";
    plugins = with pkgs.vimPlugins; [
      lualine-nvim
    ];
  };

  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };

  programs.tmux = {
    enable = true;
    mouse = true;
  };
}

