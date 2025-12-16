import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';

// Сигнатуры
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
  String _status = "Waiting for FFI...";

  @override
  void initState() {
    super.initState();
    _initFFI();
  }

  void _initFFI() {
    try {
      final DynamicLibrary nativeLib = Platform.isAndroid
          ? DynamicLibrary.open('libnative_add.so')
          : DynamicLibrary.process();

      final NativeAdd nativeAdd = nativeLib
          .lookup<NativeFunction<NativeAddFunc>>('native_add')
          .asFunction();
      
      setState(() {
        _result = nativeAdd(10, 20);
        _status = "FFI Success!";
      });
    } catch (e) {
      setState(() {
        _status = "Error: $e";
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Dart FFI CI Test')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_status, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text('10 + 20 (C Code) ='),
              Text('$_result', style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ),
      ),
    );
  }
}
