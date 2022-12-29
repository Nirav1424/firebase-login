import 'package:flutter/material.dart';
import 'Grid_page.dart';

// ignore: camel_case_types
class grid extends StatefulWidget {
  const grid({super.key});

  @override
  State<grid> createState() => _gridState();
}

class _gridState extends State<grid> {
  final list = List.generate(50, (index) => 'item $index');
  final items = <Item>[
    const Item(
      title: 'item 1',
      urlImage:
          'https://tse3.mm.bing.net/th?id=OIP.roZQuPk4mzOaqe-4qJJ8wQHaEo&pid=Api&P=0',
    ),
    const Item(
      title: 'item 2',
      urlImage:
          'https://tse1.mm.bing.net/th?id=OIP.YtCIycyteEsaHZyuXKDVuAHaEK&pid=Api&P=0',
    ),
    const Item(
      title: 'item 3',
      urlImage:
          'https://tse2.mm.bing.net/th?id=OIP.7UR1eXJy8Kk9umKhRWI_UQHaEK&pid=Api&P=0',
    ),
    const Item(
      title: 'item 4',
      urlImage:
          'https://tse1.mm.bing.net/th?id=OIP.2N0A0tTHju2fs-bDhiFWqwHaEv&pid=Api&P=0',
    ),
    const Item(
      title: 'item 5',
      urlImage:
          'https://tse3.mm.bing.net/th?id=OIP.uU_R5hH3KXL0jDgUF4kjCQHaEK&pid=Api&P=0',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10),
          itemCount: items.length,
          itemBuilder: (BuildContext ctx, index) {
            final item = items[index];
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => page(item: item),
              )),
              child: Center(
                  child: Hero(
                      tag: item,
                      child: Image.network(
                        item.urlImage,
                        fit: BoxFit.cover,
                      ))),
            );
          }),
    );
  }
}

class Item {
  final String urlImage;
  final String title;

  const Item({
    required this.urlImage,
    required this.title,
  });
}
