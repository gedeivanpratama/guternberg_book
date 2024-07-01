import 'package:flutter/material.dart';
import 'package:guternberg_book/core/global/presentations/screens/detail_book_screen.dart';

import '../../../../features/home/data/models/book_response.dart';

class BookItemWidget extends StatelessWidget {
  final Book book;
  final void Function()? onLikedPressed;
  final void Function()? onDisLikedPressed;

  const BookItemWidget({
    super.key,
    required this.book,
    required this.onLikedPressed,
    required this.onDisLikedPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Color(0xFF2D9596)),
            ),
            child: Material(
              borderRadius: BorderRadius.circular(30),
              color: Color.fromARGB(255, 245, 245, 243),
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailBookScreen(book: book),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              book.title,
                              style: Theme.of(context).textTheme.headlineLarge,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Divider(thickness: 1),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        alignment: WrapAlignment.start,
                        children: [
                          if (book.authors.isNotEmpty)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.person),
                                Flexible(
                                  child: Text(
                                    "${book.authors.first.name} ",
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.download),
                              Text(
                                "${book.downloadCount} ",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          if (book.authors.isNotEmpty)
                            //TODO : handle if the date is 0 or less than 0
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.calendar_month_outlined),
                                Text(
                                  "${book.authors.first.birthYear} - ${book.authors.first.deathYear} ",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                ),
                              ],
                            ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        runSpacing: 0,
                        children: book.bookshelves.take(3).map((bookshelve) {
                          return Chip(label: Text(bookshelve));
                        }).toList()
                          ..addAll([
                            if (book.bookshelves.length > 3)
                              Chip(label: Text("..."))
                          ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            right: -10,
            child: Row(
              children: [
                IconButton(
                  key: key,
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: onLikedPressed,
                  icon: Icon(Icons.thumb_up),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: onDisLikedPressed,
                  icon: Icon(Icons.thumb_down),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
