import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';

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
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
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
                              Chip(
                                  label: Text("Precursors of Science Fiction")),
                              Chip(label: Text("...")),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
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
