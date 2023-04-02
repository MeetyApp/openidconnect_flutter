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
        SystemChrome.setEnabledSystemUIOverlays([]); // Hide the status bar
        return WillPopScope(
          onWillPop: () async => false, // Prevent the back button from closing the dialog
          child: Stack(
            children: [
              AlertDialog(
                contentPadding: EdgeInsets.all(0),
                insetPadding: EdgeInsets.all(0),
                content: Container(
                  width: MediaQuery.of(dialogContext).size.width,
                  height: MediaQuery.of(dialogContext).size.height,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(dialogContext).padding.top, // Height of the status bar
                        color: Colors.white, // Set the color you want for the status bar area
                      ),
                      Expanded(
                        child: flutterWebView.WebView(
                          userAgent: 'random',
                          javascriptMode: flutterWebView.JavascriptMode.unrestricted,
                          initialUrl: authorizationUrl,
                          onPageFinished: (url) {
                            if (url.startsWith(redirectUrl)) {
                              SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values); // Show the status bar again
                              Navigator.pop(dialogContext, url);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );






    if (result == null) throw AuthenticationException(ERROR_USER_CLOSED);

    return result;
  }
}
