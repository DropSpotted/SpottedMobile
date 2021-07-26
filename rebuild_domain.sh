echo 'Rebuilding in domain'
cd modules/domain/ && flutter packages pub run build_runner build --delete-conflicting-outputs && cd ../../