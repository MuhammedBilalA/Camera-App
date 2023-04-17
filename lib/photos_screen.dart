import 'dart:io';

import 'package:camera_app/view_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

ValueNotifier<List> imagelist = ValueNotifier([]);

class PhotosScreen extends StatelessWidget {
  const PhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PHOTOS'),
      ),
      body: ValueListenableBuilder(
        valueListenable: imagelist,
        builder: (context, value, child) {
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                 
                  child: GridTile(
                    child: Image.file(
                      File(value[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                   onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ViewImage(index: index)));
                   }
                ),
              );
            },
            itemCount: value.length,
          );
        },
      ),
    );
  }
}
