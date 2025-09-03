#!/bin/bash
set -euxo pipefail

# Script de instalación nativa para Wine con Box86/Box64 en ARM64
# Instala Wine, Box, wrappers, y prepara para The Forest

echo "Instalando dependencias del sistema para Box y Wine..."
sudo apt update
sudo apt install -y git wget curl cmake python3 build-essential gcc-arm-linux-gnueabihf libc6-dev-armhf-cross libc6:armhf libstdc++6:armhf ca-certificates unzip cabextract xvfb

echo "Compilando e instalando Box86..."
git clone https://github.com/ptitSeb/box86
mkdir box86/build
cd box86/build
cmake .. -DRPI4ARM64=1 -DARM_DYNAREC=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
sudo make install DESTDIR=/usr/local
cd ../..

echo "Compilando e instalando Box64..."
git clone https://github.com/ptitSeb/box64
mkdir box64/build
cd box64/build
cmake .. -DRPI4ARM64=1 -DARM_DYNAREC=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
sudo make install DESTDIR=/usr/local
cd ../..

echo "Instalando Wine..."
bash scripts/install-wine.sh

echo "Configurando wrappers para Wine con Box..."
bash scripts/wrap-wine.sh

echo "Instalando dependencias adicionales..."
sudo apt install -y winetricks

echo "Inicializando Wine..."
wine64 wineboot

echo "Instalando VCRun2019..."
xvfb-run winetricks -q vcrun2019

echo "Instalación de Wine con Box completada. Ahora puedes usar wine o wine64 para ejecutar aplicaciones Windows."
