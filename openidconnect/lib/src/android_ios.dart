part of openidconnect;

class OpenIdConnectAndroidiOS {
  static Future<String> authorizeInteractive({
    required BuildContext context,
    required String title,
    required String authorizationUrl,
    required String redirectUrl,
    required int popupWidth,
    required int popupHeight,
  }) async {
    //Create the url

    final result = await showDialog<String?>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: flutterWebView.WebView(
              userAgent: 'random',
              javascriptMode: flutterWebView.JavascriptMode.unrestricted,
              initialUrl: authorizationUrl,
              onPageFinished: (url) {
                if (url.startsWith(redirectUrl)) {
                  Navigator.pop(dialogContext, url);
                }
              },
            ),
          ),
        );
      },
    );






    if (result == null) throw AuthenticationException(ERROR_USER_CLOSED);

    return result;
  }
}
