import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';

typedef NativeAddFunc = Int32 Function(Int32 a, Int32 b);
typedef NativeAdd = int Function(int a, int b);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _result = 0;
  String _status = "Wait...";

  @override
  void initState() {
    super.initState();
    try {
      final DynamicLibrary nativeLib = Platform.isAndroid
          ? DynamicLibrary.open('libnative_add.so')
          : DynamicLibrary.process();
      final NativeAdd nativeAdd = nativeLib
          .lookup<NativeFunction<NativeAddFunc>>('native_add')
          .asFunction();
      _result = nativeAdd(100, 200);
      _status = "FFI OK";
    } catch (e) {
      _status = "Error: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Status: $_status", style: const TextStyle(fontSize: 20)),
              Text("100 + 200 = $_result", style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
