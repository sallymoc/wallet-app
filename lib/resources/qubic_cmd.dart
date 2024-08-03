import 'dart:convert';
import 'dart:typed_data';

import 'package:qubic_wallet/models/qubic_import_vault_seed.dart';
import 'package:qubic_wallet/models/qubic_vault_export_seed.dart';
import 'package:qubic_wallet/resources/qubic_cmd_utils.dart';
import 'package:qubic_wallet/resources/qubic_js.dart';
import 'package:universal_platform/universal_platform.dart';

class QubicCmd {
  late QubicJs qubicJs;
  late QubicCmdUtils qubicCmdUtils;

  Future<void> _initQubicJS() async {
    qubicJs = QubicJs();
    await qubicJs.initialize();
  }

  void _disploseQubicJS() {
    qubicJs.disposeController();
  }

  void _initQubicCMD() {
    qubicCmdUtils = QubicCmdUtils();
  }

  void _disposeQubicCMD() {}

  void dispose() {
    if ((UniversalPlatform.isAndroid) || (UniversalPlatform.isIOS)) {
      _disploseQubicJS();
    }
    if ((UniversalPlatform.isLinux) ||
        (UniversalPlatform.isWindows) ||
        (UniversalPlatform.isMacOS)) {
      _disposeQubicCMD();
    }
  }

  Future<void> initialize() async {
    if ((UniversalPlatform.isAndroid) || (UniversalPlatform.isIOS)) {
      await _initQubicJS();
    }
    if ((UniversalPlatform.isLinux) ||
        (UniversalPlatform.isWindows) ||
        (UniversalPlatform.isMacOS)) {
      _initQubicCMD();
    }
  }

  Future<String> getPublicIdFromSeed(String seed) async {
    if ((UniversalPlatform.isAndroid) || (UniversalPlatform.isIOS)) {
      return await qubicJs.getPublicIdFromSeed(seed);
    }
    if ((UniversalPlatform.isLinux) ||
        (UniversalPlatform.isWindows) ||
        (UniversalPlatform.isMacOS)) {
      _initQubicCMD();
      return await qubicCmdUtils.getPublicIdFromSeed(seed);
    }
    throw "OS Not supported";
  }

  Future<String> createTransaction(
      String seed, String destinationId, int value, int tick) async {
    if ((UniversalPlatform.isAndroid) || (UniversalPlatform.isIOS)) {
      return await qubicJs.createTransaction(seed, destinationId, value, tick);
    }
    if ((UniversalPlatform.isLinux) ||
        (UniversalPlatform.isWindows) ||
        (UniversalPlatform.isMacOS)) {
      return await qubicCmdUtils.createTransaction(
          seed, destinationId, value, tick);
    }
    throw "OS Not supported";
  }

  Future<String> createAssetTransferTransaction(
      String seed,
      String destinationId,
      String assetName,
      String assetIssuer,
      int numberOfAssets,
      int tick) async {
    if ((UniversalPlatform.isAndroid) || (UniversalPlatform.isIOS)) {
      return await qubicJs.createAssetTransferTransaction(
          seed, destinationId, assetName, assetIssuer, numberOfAssets, tick);
    }
    if ((UniversalPlatform.isLinux) ||
        (UniversalPlatform.isWindows) ||
        (UniversalPlatform.isMacOS)) {
      return await qubicCmdUtils.createAssetTransferTransaction(
          seed, destinationId, assetName, assetIssuer, numberOfAssets, tick);
    }
    throw "OS Not supported";
  }

  Future<Uint8List> createVaultFile(
      String password, List<QubicVaultExportSeed> seeds) async {
    if ((UniversalPlatform.isAndroid) || (UniversalPlatform.isIOS)) {
      return await qubicJs.createVaultFile(password, seeds);
    }
    if ((UniversalPlatform.isLinux) ||
        (UniversalPlatform.isWindows) ||
        (UniversalPlatform.isMacOS)) {
      return await qubicCmdUtils.createVaultFile(password, seeds);
    }
    throw "OS Not supported";
  }

  Future<List<QubicImportVaultSeed>> importVaultFile(
      String password, String? filePath, Uint8List? fileContents) async {
    if ((UniversalPlatform.isAndroid) || (UniversalPlatform.isIOS)) {
      if (fileContents == null) {
        throw "File contents base64 is required";
      }
      var base64String = base64Encode(fileContents);
      return await qubicJs.importVault(password, base64String);
    }
    if ((UniversalPlatform.isLinux) ||
        (UniversalPlatform.isWindows) ||
        (UniversalPlatform.isMacOS)) {
      if (filePath == null) {
        throw "File path is required";
      }
      return await qubicCmdUtils.importVaultFile(password, filePath!);
    }
    throw "OS Not supported";
  }
}
