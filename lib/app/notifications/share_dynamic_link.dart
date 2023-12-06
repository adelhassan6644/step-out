part of 'notification_helper.dart';

FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

Future<void> initDynamicLinks() async {
  dynamicLinks.onLink.listen((dynamicLinkData) {
    final String deepLink = dynamicLinkData.link.toString(); // Get DEEP LINK

    final String path = dynamicLinkData.link.path;

    if (deepLink.isEmpty) return;
    handleDeepLink(path);
  }).onError((error) {
    log('onLink error');
  });
  initUniLinks();
}

Future<void> initUniLinks() async {
  try {
    final initialLink = await dynamicLinks.getInitialLink();
    if (initialLink == null) return;
    handleDeepLink(initialLink.link.path);
  } catch (e) {
    // Error
  }
}

void handleDeepLink(String path) {
  CustomNavigator.push(Routes.ITEM_DETAILS,
      arguments: int.parse(path.replaceAll('/', '')));
  // navigate to detailed product screen
}
