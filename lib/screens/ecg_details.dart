import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ECGDetails extends StatefulWidget {
  const ECGDetails({Key? key, required this.deviceId}) : super(key: key);
  final String deviceId;

  @override
  State<ECGDetails> createState() => _ECGDetailsState();
}

class _ECGDetailsState extends State<ECGDetails> {
  late double screenWidth;
  String bpm = "0";

  @override
  Widget build(BuildContext context) {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('${widget.deviceId}/bpm');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        bpm = data.toString();
      });
    });
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
            // header container
            Container(
              height: 130,
              width: screenWidth,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                ],
              ),
            ),
            // value container
            SizedBox(
              width: screenWidth,
              height: MediaQuery.of(context).size.height - 240,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$bpm BPM",
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 50,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
