import 'dart:io';
import 'package:camera_app/functions.dart';
import 'package:camera_app/home_screen.dart';

import 'package:camera_app/photos_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ViewImage extends StatelessWidget {
  late int index;
  ViewImage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.file(File(imagelist.value[index])),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Are you sure you want to delete?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          delete(index, context);
                          Navigator.pop(context);
                        },
                        child: Text('Yes')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No'))
                  ],
                );
              });
        },
        child: Icon(Icons.delete),
      ),
    );
  }

  Future delete(int index, ctx) async {
    final imagedb = await Hive.openBox('imgstore');
    imagedb.deleteAt(index);
    getimage();
    Navigator.pop(ctx);
  }
}
