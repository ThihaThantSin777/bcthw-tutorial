import 'dart:convert';
import 'package:crypto/crypto.dart';

void main() {
  List<String> inputs = ["Hello", "Hello World", "Hello World1", "Hello World!", "Hello World Now"];

  print("MD5 Hashes:");
  for (String input in inputs) {
    print('$input : ${_getMD5Hash(input)}');
  }
}

String _getMD5Hash(String input) {
  var bytes = utf8.encode(input);
  var digest = md5.convert(bytes);
  return digest.toString();
}
