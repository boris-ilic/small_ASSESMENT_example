find . -name "*.g.dart" -type f -delete
# fvm flutter clean
# fvm flutter pub get
fvm flutter packages pub run build_runner build --delete-conflicting-outputs
