import 'dart:io';

import 'package:camera_app/functions.dart';
import 'package:camera_app/photos_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    getimage();
    return Scaffold(
        appBar: AppBar(
          title: const Text('CAMERA APP'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 150, left: 100, right: 100, bottom: 20),
              child: InkWell(
                onTap: () {
                  _addimage();
                },
                child: Card(
                  elevation: 10,
                  color: const Color.fromARGB(255, 8, 249, 177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(150)),
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, right: 54),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.camera,
                                size: 90,
                              )),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 65, right: 2),
                          child: Text(
                            'CAMERA',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.deepPurpleAccent),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 100,
                right: 100,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => PhotosScreen()));
                },
                child: Card(
                  elevation: 10,
                  color: Color.fromARGB(255, 7, 229, 250),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60)),
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, right: 54),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.image,
                                size: 90,
                              )),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 65, right: 2),
                          child: Text(
                            'PHOTOS',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.deepPurpleAccent),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future _addimage() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }

    final imagedb = await Hive.openBox('imgstore');
    imagedb.add(image.path);
    await getimage();
    await saveImage(File(image.path), basename(image.path));
  }
}
