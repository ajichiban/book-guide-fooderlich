import 'package:flutter/material.dart';
import 'app_link.dart';


//NOTE //* Esta clase es  para implementar los Deep Links.
//REVIEW //* investigar mas dobre esto ,antes de aplicarlo en una aplicacion real.
// 1
class AppRouteParser extends RouteInformationParser<AppLink> {
  // 2
  @override
  Future<AppLink> parseRouteInformation(RouteInformation routeInformation) async {
    // 3
    final link = AppLink.fromLocation(routeInformation.location!);
    return link;
  }

  // 4
  @override
  RouteInformation restoreRouteInformation(AppLink appLink) {
    // 5
    final location = appLink.toLocation();
    // 6
    return RouteInformation(location: location);
  }
}
