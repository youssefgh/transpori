cd ~/NetBeansProjects/Transportation/Transportation-mobile/www
rm * -r
cd ~/NetBeansProjects/Transportation/DartMobileClient
pub build
cd build/web
cp -r * ~/NetBeansProjects/Transportation/Transportation-mobile/www
cd ~/NetBeansProjects/Transportation/Transportation-mobile
pwd
cordova build 
cordova emulate
