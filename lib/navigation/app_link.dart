//NOTE //* Esta clase es  para implementar los Deep Links.
//REVIEW //* investigar mas dobre esto ,antes de aplicarlo en una aplicacion real.

class AppLink {
  // 1
  static const String kHomePath = '/home';
  static const String kOnboardingPath = '/onboarding';
  static const String kLoginPath = '/login';
  static const String kProfilePath = '/profile';
  static const String kItemPath = '/item';
  // 2
  static const String kTabParam = 'tab';
  static const String kIdParam = 'id';
  // 3
  String? location;
  // 4
  int? currentTab;
  // 5
  String? itemId;
  // 6
  AppLink({this.location, this.currentTab, this.itemId});

  static AppLink fromLocation(String location) {
    location = Uri.decodeFull(location);

    final uri = Uri.parse(location);

    final params = uri.queryParameters;

    void trySet(String key, void Function(String?) setter) {
      if (params.containsKey(key)) {
        setter?.call(params[key]);
      }
    }

    final link = AppLink()..location = uri.path;

    trySet(AppLink.kTabParam, (s) => link.currentTab = int.tryParse(s!));

    trySet(AppLink.kIdParam, (s) => link.itemId = s);

    return link;
  }

  String toLocation() {
    // 1
    String addKeyValPair({String? key, String? value}) =>
        value == null ? '' : '${key}=$value&';
    // 2
    switch (location) {
      // 3
      case kLoginPath:
        return kLoginPath;
      // 4
      case kOnboardingPath:
        return kOnboardingPath;
      // 5
      case kProfilePath:
        return kProfilePath;
      // 6
      case kItemPath:
        var loc = '$kItemPath?';
        loc += addKeyValPair(key: kIdParam, value: itemId);
        return Uri.encodeFull(loc);
      // 7
      default:
        var loc = '$kHomePath?';
        loc += addKeyValPair(key: kTabParam, value: currentTab.toString());
        return Uri.encodeFull(loc);
    }
  }
}
