import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SetupWifi extends StatefulWidget {
  const SetupWifi({super.key});

  @override
  State<SetupWifi> createState() => _SetupWifiState();
}

class _SetupWifiState extends State<SetupWifi> {
  bool _isError = false;

  @override
  Widget build(BuildContext context) {
    return !_isError
        ? WebView(
            initialUrl: 'http://192.168.4.1',
            javascriptMode: JavascriptMode.unrestricted,
            onWebResourceError: (error) => {
              setState(() {
                _isError = true;
              })
            },
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.wifi_off,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 16, left: 20, right: 20),
                    child: Text(
                      'You are not connected to the Heart rate device.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    )),
              ],
            ),
          );
  }
}
