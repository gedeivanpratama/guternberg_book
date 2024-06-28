import 'package:flutter/material.dart';

class BookLikeScreen extends StatefulWidget {
  const BookLikeScreen({super.key});

  @override
  State<BookLikeScreen> createState() => _BookLikeScreenState();
}

class _BookLikeScreenState extends State<BookLikeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
            floating: true,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('SliverAppBar'),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child:
                        Text('$index', textScaler: const TextScaler.linear(5)),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
