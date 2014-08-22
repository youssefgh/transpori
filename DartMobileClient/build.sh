#cd ~/NetBeansProjects/Transportation/Transportation-mobile/www
cd ~/NetBeansProjects/Transportation/Station-saver/www
rm * -r
cd ~/NetBeansProjects/Transportation/DartMobileClient
pub build
cd build/web
#cp -r * ~/NetBeansProjects/Transportation/Transportation-mobile/www
cp -r * ~/NetBeansProjects/Transportation/Station-saver/www
cd ~/NetBeansProjects/Transportation/Station-saver
#pwd
#cordova build 
cordova emulate
