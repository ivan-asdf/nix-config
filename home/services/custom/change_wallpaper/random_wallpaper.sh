wallpapers=~/.config/wallpapers
pushd $wallpapers
wallpaper=$(ls . | sort -R | tail -1)
ln -s -f $wallpaper .wallpaper
#feh --bg-fill .wallpaper; rm ~/.fehbg
betterlockscreen -u .wallpaper --fx blur
betterlockscreen -w
