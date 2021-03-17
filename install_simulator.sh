clear
set -e

make

THEOS_OBJ_DIR=./.theos/obj/iphone_simulator/debug

#install tweak into simject folder

rm -rf /opt/simject/14PiP.plist ||:
cp -rfv ./14PiP.plist /opt/simject
rm -rf /opt/simject/14PiP.dylib ||:
cp -rfv $THEOS_OBJ_DIR/14PiP.dylib /opt/simject

resim
