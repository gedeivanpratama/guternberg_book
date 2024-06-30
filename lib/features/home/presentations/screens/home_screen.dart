import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';
import 'package:guternberg_book/features/home/presentations/state/book_bloc/book_bloc.dart';

import '../../../../core/presentations/widgets/book_item_widget.dart';

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
  late BookBloc _bookBloc;
  BookParams params = BookParams(page: "1");
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bookBloc = context.read<BookBloc>()..add(BookFetch(params));
    _bookBloc.add(BookFetch(params));
    widget.scrollController.addListener(_loadMore);
  }

  void _loadMore() {
    if (_isBottom) _bookBloc.add(BookLoadMore(params));
  }

  bool get _isBottom {
    final direction = widget.scrollController.position.userScrollDirection;
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;
    if (!widget.scrollController.hasClients) return false;
    if (direction == ScrollDirection.forward) return false;
    return currentScroll >= (maxScroll * 0.99);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return Future.sync(() {
            _bookBloc.add(BookFetch(BookParams(page: "1"), isReload: true));
            _searchController.clear();
          });
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search Author ...",
                    prefixIcon: IconButton(
                      icon: Icon(Icons.sort_rounded),
                      onPressed: () async {
                        final result = await FilterDialog(
                          context,
                          bookParams: params,
                        ).show();

                        if (result == null) return;

                        final filter = result as BookParams;
                        if (filter.clear) {
                          params = BookParams(search: _searchController.text);
                        } else {
                          params = params.copyWith(
                            languages: filter.languages,
                            topic: filter.topic,
                          );
                        }
                        _bookBloc.add(BookFetch(params, isReload: true));
                      },
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        if (_searchController.text.trim().isEmpty) return;
                        params = params.copyWith(
                          search: _searchController.text,
                        );
                        _bookBloc.add(BookFetch(params, isReload: true));
                      },
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
            BlocBuilder<BookBloc, BookState>(
              builder: (context, state) {
                return switch (state) {
                  BookInitial() => SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator())),
                  BookFailure() => SliverToBoxAdapter(
                      child: Center(child: Text(state.message))),
                  BookLoading() => SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator())),
                  BookLoaded() => SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (state.data.books.isEmpty) {
                            return Center(child: Text("Book Not Found"));
                          }
                          if (index >= state.data.books.length) {
                            return SizedBox(
                              height: 80,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          return BookItemWidget(book: state.data.books[index]);
                        },
                        childCount: state.data.books.length + 1,
                      ),
                    ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
                  DropdownMenu(
                    initialSelection: bookParams.languages,
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
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        log(_language.toString());
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
