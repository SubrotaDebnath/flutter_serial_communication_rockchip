import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:flutter_serial_communication_rockchip/constants/navigation/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var availablePorts = [];
  @override
  void initState() {
    super.initState();
    SerialPortConfig().baudRate = 9600;
    SerialPortConfig().bits = 8;
    // openSerialPort(serialPort: serialPort);
    initPorts();
  }

  // openSerialPort({required SerialPort serialPort})  {
  // serialPort.open(  mode: SerialPortMode.readWrite);
  // }

  Future<void> initPorts() async {
    setState(() => availablePorts = SerialPort.availablePorts);
     // availablePorts = SerialPort.availablePorts;
    if (kDebugMode) {
      print('availablePorts: ${availablePorts.toString()}');
    }
    if(availablePorts.isNotEmpty){
      SerialPort serialPort1 = SerialPort('/dev/ttyS1');

      // SerialPort serialPort1 = SerialPort(availablePorts.first);
      serialPort1.openReadWrite();

      if(kDebugMode){
        print('Is Serial Port Open: ${serialPort1.openReadWrite()}');
      }
      try{
        serialPort1.write(Uint8List.fromList("Hello World!".codeUnits));
        if (kDebugMode) {
          print(serialPort1.write(Uint8List.fromList("Hello World!".codeUnits)));
        }
        SerialPortReader reader = SerialPortReader(serialPort1);
        reader.stream.map((data) {
          print(String.fromCharCodes(data));
        });

      }on SerialPortError catch(err,_){
        if(kDebugMode){
          print('Serial Port Exception: $err');
          print('Serial Port Error: ${SerialPort.lastError}');
        }
         serialPort1.close();
      }
      // bool isOpened = serialPort1.open( mode: SerialPortMode.readWrite);
      // if(kDebugMode){
      //   print('Is Serial Port Open: $isOpened');
      // }
    }else{
      if (kDebugMode) {
        print('No Ports Available');
      }
    }

  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.red,
      // body: Container(),
      body: ListView.builder(
          itemCount: availablePorts.length,
          itemBuilder: (context,index){
            final port = SerialPort(availablePorts[index]??'');
      return Container(width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(8),
        // padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(8)
        ),
        child: ElevatedButton(
          onPressed: (){
            Navigator.pushNamed(context, Routes.kPortConnectScreen);
          },
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(12)),
          child: Text(
              'Name: ${port.name}\n'
              'IsOpen: ${port.isOpen}\n'
              'Address: ${port.address}\n'
              'Transport: ${port.transport}\n'
              'Product Name: ${port.productName}\n',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
      
  }
      ,),);
  }
}
