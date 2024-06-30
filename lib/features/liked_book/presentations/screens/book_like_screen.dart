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
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.sort),
            ),
            floating: true,
            flexibleSpace: const FlexibleSpaceBar(
              titlePadding: EdgeInsets.all(12),
              title: Text(
                'Liked Book',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // return BookItemWidget();
                SizedBox();
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
