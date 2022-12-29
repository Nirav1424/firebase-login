import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_f2/watsup_utility.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import '../FirebasePages/home_page.dart';

// ignore: camel_case_types
class imgDown extends StatefulWidget {
  const imgDown({super.key});

  @override
  State<imgDown> createState() => _imgDownState();
}

// ignore: camel_case_types
class _imgDownState extends State<imgDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Hero(
            tag: "car",
            child: Image.network(
                "https://tse3.mm.bing.net/th?id=OIP.roZQuPk4mzOaqe-4qJJ8wQHaEo&pid=Api&P=0"),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            String url =
                "https://images.pexels.com/photos/244206/pexels-photo-244206.jpeg?cs=srgb&dl=lights-car-vehicle-244206.jpg&fm=jpg";

            final tempDir = await getTemporaryDirectory();
            final path = '${tempDir.path}/myfile.jpg';
            // ignore: use_build_context_synchronously

            await Dio().download(url, path);
            await GallerySaver.saveImage(path);
          },
          child: const Text("downloading...."),
        ),
        ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => Home(),
              //     ));
            },
            child: const Text("watsup utility..")),
             ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            },
            child: const Text("Api calling..")),
      ],
    );
  }
}
