
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:io';
import 'package:ffi/ffi.dart';

void main() {
  final DynamicLibrary lib = Platform.isAndroid
      ? DynamicLibrary.open('libexample.so')
      : throw UnsupportedError('Only Android');

  final invertArray = lib.lookupFunction<
      Void Function(Pointer<Uint8>, Int32),
      void Function(Pointer<Uint8>, int)>('invert_array');

  Uint8List frame = Uint8List.fromList([0, 128, 255]);
  final ptr = malloc<Uint8>(frame.length);
  ptr.asTypedList(frame.length).setAll(0, frame);

  invertArray(ptr, frame.length);

  print(ptr.asTypedList(frame.length));

  malloc.free(ptr);
}
