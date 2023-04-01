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
        return Stack(
          children: [
            AlertDialog(
              contentPadding: EdgeInsets.all(0),
              insetPadding: EdgeInsets.all(0),
              content: Container(
                width: MediaQuery.of(dialogContext).size.width,
                height: MediaQuery.of(dialogContext).size.height,
                child: flutterWebView.WebView(
                  javascriptMode: flutterWebView.JavascriptMode.unrestricted,
                  initialUrl: authorizationUrl,
                  onPageFinished: (url) {
                    if (url.startsWith(redirectUrl)) {
                      Navigator.pop(dialogContext, url);
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );





    if (result == null) throw AuthenticationException(ERROR_USER_CLOSED);

    return result;
  }
}
