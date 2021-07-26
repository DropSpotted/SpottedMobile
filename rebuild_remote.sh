echo 'Rebuilding in remote'
cd modules/remote/ && flutter packages pub run build_runner build --delete-conflicting-outputs && cd ../