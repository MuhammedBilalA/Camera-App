import 'dart:io';
import 'package:camera_app/photos_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

Future getimage() async {
  final imagedb = await Hive.openBox('imgstore');
  imagelist.value.clear();
  imagelist.value.addAll(imagedb.values);
  imagelist.notifyListeners();
}

Future<bool> requestPermission() async {
  final permission = await Permission.storage.request();

  final status = permission.isGranted;

  if (status) {
    return true;
  } else {
    var result = await Permission.storage.request();
    if (result == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

Future<Directory?> getDirectory() async {
  Directory? directory = await path_provider.getExternalStorageDirectory();

  if (Platform.isAndroid) {
    if (await requestPermission()) {
      String newPath = '';
      List<String> floders = directory!.path.split("/");

      for (int x = 1; x < floders.length; x++) {
        String folder = floders[x];

        if (folder != "Android") {
          newPath += "/" + folder;
          print(
              '$newPath');
        } else {
          break;
        }
      }
      newPath = newPath + "/CameraApp";

      directory = Directory(newPath);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        return directory;
      }
    }
  }

  return directory;
}

Future<void> saveImage(File imageFile, String imageName) async {
  final appDocumentDirectory = await getDirectory();

  final savedDir = Directory('${appDocumentDirectory?.path}/images');

  final dirPath = savedDir.path.toString();

  if (!Directory(dirPath).existsSync()) {
    Directory(dirPath).createSync(recursive: true);
  }

  final newPath = path.join(savedDir.path, imageName);
  await imageFile.copy(newPath);
}
