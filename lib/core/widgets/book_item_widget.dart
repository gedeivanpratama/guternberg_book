import 'package:flutter/material.dart';

class BookItemWidget extends StatelessWidget {
  const BookItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 245, 245, 243),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Color(0xFF2D9596)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      "Romeo and Juliet, Romeo",
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person),
                      Text(
                        "Melville, Herman ",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.download),
                      Text(
                        "172172 ",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calendar_month_outlined),
                      Text(
                        "1775 - 1817 ",
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
                children: [
                  Chip(label: Text("Gothic Fiction")),
                  Chip(label: Text("Movie Books")),
                  Chip(label: Text("Precursors of Science Fiction")),
                  Chip(label: Text("...")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
