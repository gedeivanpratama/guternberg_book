import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 180, 207, 150),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.info),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Text(
                "Book Not Found",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
