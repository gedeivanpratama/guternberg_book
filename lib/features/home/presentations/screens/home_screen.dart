import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';
import 'package:guternberg_book/core/global/presentations/widgets/error_widget.dart';
import 'package:guternberg_book/core/global/presentations/widgets/loading_widget.dart';
import 'package:guternberg_book/features/home/presentations/state/book_bloc/book_bloc.dart';
import 'package:guternberg_book/features/liked_book/presentations/state/local_book_bloc/local_book_bloc.dart';

import '../../../../core/global/domain/repositories/book_local_repository.dart';
import '../../../../core/global/presentations/widgets/book_item_widget.dart';
import 'widgets/filter_dialog_widget.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;
  const HomeScreen({super.key, required this.scrollController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BookBloc _bookBloc;
  late LocalBookBloc _localBookBloc;

  BookParams params = BookParams(page: "1");
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bookBloc = context.read<BookBloc>()..add(BookFetch(params));
    _localBookBloc = LocalBookBloc(
      repository: context.read<BookLocalRepository>(),
    );
    _bookBloc.add(BookFetch(params));
    widget.scrollController.addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _localBookBloc,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _onReloadTriggered,
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
                          await _onfilterPressed(context);
                        },
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: _onSearchPressed,
                      ),
                    ),
                    onTapOutside: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    onSubmitted: (_) {
                      _onSearchPressed();
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
              BlocListener<LocalBookBloc, LocalBookState>(
                listener: _likedBookListener,
                child: BlocBuilder<BookBloc, BookState>(
                  builder: (context, state) {
                    return switch (state) {
                      BookInitial() => SliverLoadingWidget(),
                      BookLoading() => SliverLoadingWidget(),
                      BookFailure() => SliverErrorWidget(error: state),
                      BookLoaded() => SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              if (state.data.books.isEmpty) {
                                return Center(child: Text("Book Not Found"));
                              }
                              if (index >= state.data.books.length) {
                                return SizedBox(
                                  height: 80,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                              return BookItemWidget(
                                book: state.data.books[index],
                                onLikedPressed: () {
                                  final params = state.data.books[index];
                                  _localBookBloc
                                      .add(LocalBookLikePressed(params));
                                },
                                onDisLikedPressed: () {
                                  final params = state.data.books[index];
                                  _localBookBloc.add(
                                    LocalBookDisLikePressed(params),
                                  );
                                },
                              );
                            },
                            childCount: state.data.books.length + 1,
                          ),
                        ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onReloadTriggered() {
    return Future.sync(() {
      _bookBloc.add(BookFetch(BookParams(page: "1"), isReload: true));
      _searchController.clear();
    });
  }

  _onfilterPressed(BuildContext context) async {
    final result = await FilterDialog(context, bookParams: params).show();
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
  }

  void _onSearchPressed() {
    if (_searchController.text.trim().isEmpty) return;
    params = params.copyWith(
      search: _searchController.text,
    );
    _bookBloc.add(BookFetch(params, isReload: true));
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

  String _getUpdatedMessage(LocalBookUpdated state) {
    if (state.isLiked) return "${state.bookName} has been liked";
    return "${state.bookName} has been disLiked";
  }

  void _likedBookListener(context, state) {
    if (state is LocalBookUpdated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_getUpdatedMessage(state))),
      );
    }

    if (state is LocalBookFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }
}
