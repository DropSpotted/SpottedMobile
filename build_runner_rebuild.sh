flutter pub get

cd modules/remote/ && flutter pub get && cd ../
cd domain/ && flutter pub get && cd ../
cd foundation && flutter pub get && cd ../

echo 'Rebuilding in remote'
cd remote/ && flutter packages pub run build_runner build --delete-conflicting-outputs && cd ../

echo 'Rebuilding in domain'
cd domain/ && flutter packages pub run build_runner build --delete-conflicting-outputs && cd ../../

echo 'Rebuilding in lib'
flutter packages pub run build_runner build --delete-conflicting-outputs
