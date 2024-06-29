import 'package:flutter/material.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';

import '../../../../core/widgets/book_item_widget.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;
  const HomeScreen({
    super.key,
    required this.scrollController,
  });
  static const String routeName = '/Homescreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: widget.scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.all(10),
              centerTitle: true,
              title: TextField(
                decoration: InputDecoration(
                  hintText: "Search Book ...",
                  prefixIcon: IconButton(
                    icon: Icon(Icons.sort_rounded),
                    onPressed: () async {
                      final result = await FilterDialog(context).show();
                      if (result == null) return;
                      print(result);
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
                onTapOutside: (_) {
                  FocusScope.of(context).unfocus();
                },
              ),
              background: Center(
                child: Text(
                  'Gutendex Book',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return BookItemWidget();
              },
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class FilterDialog<T> {
  final BuildContext context;
  FilterDialog(this.context);

  final _topicController = TextEditingController();
  final _languageController = TextEditingController();
  final _isCopyright = ValueNotifier(true);

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
                  DropdownMenu(
                    label: Text("Language"),
                    controller: _languageController,
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
                ],
              ),
              SizedBox(height: 12),
              ValueListenableBuilder(
                valueListenable: _isCopyright,
                builder: (context, value, _) {
                  return ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      final params = BookParams(
                        topic: _topicController.text,
                        copyright: _isCopyright.value,
                      );
                      Navigator.pop(context, params);
                    },
                    icon: Icon(Icons.sort_rounded),
                    label: Text("Apply Filter"),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
