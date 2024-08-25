import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/api.dart' as crypto;
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'dart:typed_data';

void main() {
  final keyPair = _generateRSAKeyPair();
  final publicKey = keyPair.publicKey as RSAPublicKey;
  final privateKey = keyPair.privateKey as RSAPrivateKey;

  final message = 'Hello World!';
  final encryptedMessage = _encryptMessage(message, publicKey);
  print('Encrypted Message: $encryptedMessage');

  final decryptedMessage = _decryptMessage(encryptedMessage, privateKey);
  print('Decrypted Message: $decryptedMessage');
}

AsymmetricKeyPair<PublicKey, PrivateKey> _generateRSAKeyPair() {
  final keyGen = RSAKeyGenerator()
    ..init(ParametersWithRandom(
      RSAKeyGeneratorParameters(BigInt.from(65537), 512, 64),
      _getSecureRandom(),
    ));

  return keyGen.generateKeyPair();
}

crypto.SecureRandom _getSecureRandom() {
  final secureRandom = FortunaRandom();

  final seedSource = DateTime.now().millisecondsSinceEpoch;
  final seedBytes = Uint8List(32)..buffer.asByteData().setInt64(0, seedSource);
  secureRandom.seed(KeyParameter(seedBytes));

  return secureRandom;
}

String _encryptMessage(String message, RSAPublicKey publicKey) {
  final encrypt = Encrypter(RSA(publicKey: publicKey));
  final encrypted = encrypt.encrypt(message);
  return encrypted.base64;
}

String _decryptMessage(String encryptedMessage, RSAPrivateKey privateKey) {
  final encrypt = Encrypter(RSA(privateKey: privateKey));
  final decrypted = encrypt.decrypt64(encryptedMessage);
  return decrypted;
}
