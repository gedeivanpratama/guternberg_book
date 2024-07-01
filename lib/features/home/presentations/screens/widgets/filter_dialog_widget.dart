import 'package:flutter/material.dart';

import '../../../domain/params/params_book.dart';

class FilterDialog<T> {
  final BuildContext context;
  final BookParams bookParams;
  BookLanguage? _language;

  final _topicController = TextEditingController();

  FilterDialog(this.context, {required this.bookParams}) {
    this._topicController.text = bookParams.topic ?? "";
  }

  Future<T?> show() {
    return showModalBottomSheet(
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )),
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.sizeOf(context).height * 0.5,
          padding: EdgeInsets.all(24),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 236, 236, 211),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                      hintText: "Topic",
                      fillColor: Colors.white,
                    ),
                    controller: _topicController,
                  ),
                  SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: DropdownMenu(
                      initialSelection: bookParams.languages,
                      menuStyle: MenuStyle(
                        surfaceTintColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                      ),
                      onSelected: (value) {
                        _language = value;
                      },
                      label: Text("Language"),
                      width: MediaQuery.sizeOf(context).width * 0.88,
                      dropdownMenuEntries: BookLanguage.values.map(
                        (lang) {
                          return DropdownMenuEntry(
                            value: lang,
                            label: lang.name,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final params = BookParams(
                          topic: _topicController.text,
                          languages: _language,
                        );
                        Navigator.pop(context, params);
                      },
                      icon: Icon(Icons.sort_rounded),
                      label: Text("Apply Filter"),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context, BookParams(clear: true));
                    },
                    icon: Icon(Icons.replay_outlined),
                    label: Text("clear"),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
