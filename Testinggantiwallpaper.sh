#!/bin/bash

# URL wallpaper di repo GitHub lo
WALLPAPER_URL="https://raw.githubusercontent.com/MePetter/wallpaper/main/wallpaper.jpeg"

# Path untuk menyimpan wallpaper
WALLPAPER_PATH="/usr/share/backgrounds/wallpaper.jpg"

# Download wallpaper terbaru
echo "Downloading new wallpaper..."
curl -L -o "$WALLPAPER_PATH" "$WALLPAPER_URL"

# Cek Desktop Environment
DESKTOP_ENV=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')

if [[ "$DESKTOP_ENV" == *"gnome"* ]]; then
    echo "Setting wallpaper for GNOME..."
    gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_PATH"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER_PATH"
elif [[ "$DESKTOP_ENV" == *"kde"* ]]; then
    echo "Setting wallpaper for KDE..."
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript \
    "var allDesktops = desktops(); for (i in allDesktops) { d = allDesktops[i]; d.wallpaperPlugin = 'org.kde.image'; d.currentConfigGroup = ['Wallpaper', 'org.kde.image', 'General']; d.writeConfig('Image', 'file://$WALLPAPER_PATH'); }"
else
    echo "Unsupported Desktop Environment: $DESKTOP_ENV"
    exit 1
fi

echo "Wallpaper updated!"
