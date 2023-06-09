# /bin/bash

echo [exe] rm -rf /usr/src/app/UnrealEngine
rm -rf /usr/src/app/UnrealEngine
cd /usr/src/app/
git clone --depth 1 -b carla git@github.com:CarlaUnreal/UnrealEngine.git

cd /usr/src/app/UnrealEngine
echo [exe] Setup.sh
./Setup.sh
echo [exe] GenerateProjectFiles.sh
./GenerateProjectFiles.sh
echo [exe] make -j 4
make -j 4
echo [exe] bash Engine/Build/BatchFiles/Linux/Build.sh ShaderCompileWorker Linux Development
bash Engine/Build/BatchFiles/Linux/Build.sh ShaderCompileWorker Linux Development

rm -rfv /usr/src/app/carla
cd /usr/src/app/
git clone https://github.com/carla-simulator/carla

export UE4_ROOT=/usr/src/app/UnrealEngine

cd /usr/src/app/carla
git checkout 0.9.13
sed -i 's~XERCESC_REPO=https://ftp.cixug.es/apache//xerces/c/3/sources/xerces-c-${XERCESC_VERSION}.tar.gz~XERCESC_REPO=https://archive.apache.org/dist/xerces/c/3/sources/xerces-c-${XERCESC_VERSION}.tar.gz~g' Util/BuildTools/Setup.sh
echo [exe] Update.sh
./Update.sh
echo [exe] make -j 4 PythonAPI
make -j 4 PythonAPI
echo [exe] make -j 4 launch
make -j 4 launch
