import 'package:flutter/material.dart';
import 'package:wifi_configuration/wifi_configuration.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              RaisedButton(
                child: Text('scan'),
                onPressed: updateWifiList,
              ),
              Divider(),
              TextField(
                decoration: InputDecoration(
                  labelText: "SSID",
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              RaisedButton(
                child: Text("connect"),
                onPressed: connect,
              ),
              Divider(),
              RaisedButton(
                child: Text('disconnect'),
                onPressed: () async {
                  print(
                    "disconnected: ${await WifiConfiguration.disconnect()}",
                  );
                },
              ),
              Divider(),
              Text("Connection status: ${connectionStatus}"),
              Divider(),
              if (available == null)
                Row(
                  children: <Widget>[
                    Text('Scanning...'),
                    CircularProgressIndicator(),
                  ],
                )
              else
                for (var item in available) Text(item?.toString() ?? "")
            ],
          ),
        ),
      ),
    );
  }

  WifiConnectionStatus connectionStatus;
  var available = [];
  var ssidControl = TextEditingController();
  var passControl = TextEditingController();

  void updateWifiList() async {
    setState(() {
      available = null;
    });
    var value = [];
    try {
      value = await WifiConfiguration.getWifiList();
      print("get wifi list : " + available.toString());
    } finally {
      setState(() {
        available = value;
      });
    }
  }

  void connect() async {
    var value = await WifiConfiguration.connectToWifi(
      ssidControl.text,
      passControl.text,
      "com.example.wifi_configuration_example",
    );
    setState(() {
      connectionStatus = value;
    });
  }
}
