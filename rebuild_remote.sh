echo 'Rebuilding in remote'
cd remote/ && flutter packages pub run build_runner build --delete-conflicting-outputs && cd ../