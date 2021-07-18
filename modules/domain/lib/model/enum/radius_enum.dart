enum RadiusEnum {
  short,
  medium,
  long,
}

extension RadiusEnumExtension on RadiusEnum {
  double toDistance() {
    switch (this) {
      case RadiusEnum.short:
        return 200;
      case RadiusEnum.medium:
        return 1000;
      case RadiusEnum.long:
        return 4000;
    }
  }
}
