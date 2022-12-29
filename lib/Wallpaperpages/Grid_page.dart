// ignore: file_names
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:like_button/like_button.dart';
import 'package:path_provider/path_provider.dart';

import 'gridview.dart';

// ignore: camel_case_types
class page extends StatefulWidget {
  final Item item;
  const page({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<page> createState() => _pageState();
}

// ignore: camel_case_types
class _pageState extends State<page> {
  bool loading = false;
  final postController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('like');
  bool isLiked = false;
  int likeCount = 10;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => grid(),
                )),
          ),
          actions: const [
            Icon(Icons.more_vert),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Hero(
                tag: widget.item,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InteractiveViewer(child: buildimg()),
                ),
              ),
            ),
            const SizedBox(height: 100),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      String url = widget.item.urlImage;
                      final tempDir = await getTemporaryDirectory();
                      final path = '${tempDir.path}/myfile.jpg';
                      // ignore: use_build_context_synchronously
                      const snackBar = SnackBar(
                          content: Text(
                        'Download succsesfully...',
                        style: TextStyle(color: Colors.greenAccent),
                      ));
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      await Dio().download(url, path);
                      await GallerySaver.saveImage(path);
                    },
                    child: const Text("downloading"),
                  ),




                  LikeButton(
                    size: 40,
                    isLiked: isLiked,
                    likeCount: likeCount,
                    likeBuilder: (isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked
                            ? const Color.fromARGB(255, 234, 25, 35)
                            : Colors.grey,
                        size: 40,
                      );
                    },
                    countBuilder: (count, isLiked, text) {
                      var color =
                          isLiked ? Colors.deepPurpleAccent : Colors.grey;

                      return Text(
                        text,
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      );
                    },
                    onTap: (isLiked) async {
                      setState(() {
                        likeCount++;

                       
                        ref.child('1').update({
                          'title': likeCount,
                        });
                      });
                      // this.isLiked = !isLiked;
                      // likeCount += this.isLiked ? 1 : -1;

                      return !isLiked;
                    },
                  ),

                


                ],
              ),
            ),
          ],
        ),
      );

  Widget buildimg() {
    return Image.network(
      widget.item.urlImage,
    );
  }
}
