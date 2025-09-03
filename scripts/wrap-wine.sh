#!/bin/sh
set -euxo pipefail

# Install wrapper script for box86 & box64
sudo cat << EOF > /usr/local/bin/wine
#!/bin/sh
WINEPREFIX=~/.wine WINEARCH=win32 box86 /usr/local/wine/bin/wine \$@
EOF
sudo cat << EOF > /usr/local/bin/wine64
#!/bin/sh
WINEPREFIX=~/.wine64 WINEARCH=win64 box64 /usr/local/wine/bin/wine64 \$@
EOF
sudo cat << EOF > /usr/local/bin/wineserver
#!/bin/sh
WINEPREFIX=~/.wine64 WINEARCH=win64 box64 /usr/local/wine/bin/wineserver \$@
EOF
sudo ln -sf /usr/local/wine/bin/wineboot /usr/local/bin/wineboot
sudo ln -sf /usr/local/wine/bin/winecfg /usr/local/bin/winecfg
sudo chmod +x /usr/local/bin/wine /usr/local/bin/wine64 /usr/local/bin/wineboot /usr/local/bin/winecfg /usr/local/bin/wineserver
