import 'package:flutter/material.dart';

class ECGDetails extends StatefulWidget {
  const ECGDetails({Key? key, required this.deviceId}) : super(key: key);

  final String deviceId;

  @override
  State<ECGDetails> createState() => _ECGDetailsState();
}

class _ECGDetailsState extends State<ECGDetails> {
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return _mainLayout();
  }

  Widget _mainLayout() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("ECG Monitor"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 130,
              width: screenWidth,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.deviceId,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Current Device",
                    style: TextStyle(
                        color: Colors.white.withAlpha(220),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30.0, left: 10, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "Last update : 24/01/24 - 13.05.14 (IST)",
                          style: TextStyle(
                              color: Colors.white.withAlpha(250),
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
