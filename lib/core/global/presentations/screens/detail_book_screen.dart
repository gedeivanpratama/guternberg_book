import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guternberg_book/core/global/presentations/screens/reading_screen.dart';

import '../../../../features/home/data/models/book_response.dart';

class DetailBookScreen extends StatefulWidget {
  const DetailBookScreen({super.key, required this.book});
  final Book book;

  @override
  State<DetailBookScreen> createState() => _DetailBookScreenState();
}

class _DetailBookScreenState extends State<DetailBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              style: IconButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            floating: true,
            pinned: true,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              title: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.9),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        widget.book.title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    if (widget.book.authors.isNotEmpty)
                      //TODO : handle if the date is 0 or less than 0
                      Wrap(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.person,
                                size: 10,
                                color: Colors.white,
                              ),
                              Flexible(
                                child: Text(
                                  "${widget.book.authors.first.name} ",
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 10,
                                color: Colors.white,
                              ),
                              Text(
                                "${widget.book.authors.first.birthYear} - ${widget.book.authors.first.deathYear} ",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              background: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: widget.book.formats?.image ?? "",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    spacing: 10,
                    runSpacing: 0,
                    children: widget.book.bookshelves
                        .map((bookshelve) => Chip(label: Text(bookshelve)))
                        .toList(),
                  ),
                ),
                Divider(thickness: 1),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.book.subjects.map((subject) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.adjust),
                            SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                subject,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Divider(thickness: 1),
                if (widget.book.formats?.webviewUrl.isNotEmpty ??
                    "".isNotEmpty) ...[
                  SizedBox(height: 100),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReadingScreen(
                              bookUrl: widget.book.formats!.webviewUrl,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.book),
                      label: Text("read the book"),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
