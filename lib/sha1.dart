import 'dart:convert';
import 'package:crypto/crypto.dart';

void main() {
  List<String> inputs = ["Hello", "Hello World", "Hello World1", "Hello World!", "Hello World Now"];

  print("SHA1 Hashes:");
  for (String input in inputs) {
    print('$input : ${_getSHA1Hash(input)}');
  }
}

String _getSHA1Hash(String input) {
  var bytes = utf8.encode(input);
  var digest = sha1.convert(bytes);
  return digest.toString();
}
