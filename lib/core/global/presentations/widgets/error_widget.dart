import 'package:flutter/material.dart';

import '../../../../features/home/presentations/state/book_bloc/book_bloc.dart';

class SliverErrorWidget extends StatelessWidget {
  final BookFailure error;
  const SliverErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(15)),
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(
                  Icons.warning_amber,
                ),
              ),
              SizedBox(width: 15),
              Flexible(
                child: Text(
                  error.message,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
