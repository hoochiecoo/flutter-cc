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
  String _status = "Initializing...";

  @override
  void initState() {
    super.initState();
    _initFFI();
  }

  void _initFFI() {
    try {
      // На Android библиотека упаковывается в APK как libnative_add.so
      final DynamicLibrary nativeLib = Platform.isAndroid
          ? DynamicLibrary.open('libnative_add.so')
          : DynamicLibrary.process();

      final NativeAdd nativeAdd = nativeLib
          .lookup<NativeFunction<NativeAddFunc>>('native_add')
          .asFunction();
      
      // Вызываем C функцию
      final calcResult = nativeAdd(10, 50);

      setState(() {
        _result = calcResult;
        _status = "FFI Connected ✅";
      });
    } catch (e) {
      setState(() {
        _status = "FFI Error ❌: $e";
      });
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('FFI CI Test')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_status, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text('10 + 50 (from C) =', style: TextStyle(color: Colors.grey)),
              Text('$_result', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w300)),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Если вы видите число 60, значит C-код успешно скомпилирован и связан через JNI/FFI.",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
