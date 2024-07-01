import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/global/domain/repositories/book_local_repository.dart';
import '../../../../core/global/presentations/widgets/book_item_widget.dart';
import '../../../home/presentations/screens/home_screen.dart';
import '../../../home/presentations/state/local_book_bloc/local_book_bloc.dart';

class BookLikeScreen extends StatefulWidget {
  const BookLikeScreen({super.key});

  @override
  State<BookLikeScreen> createState() => _BookLikeScreenState();
}

class _BookLikeScreenState extends State<BookLikeScreen> {
  late LocalBookBloc _localBookBloc;

  @override
  void initState() {
    super.initState();
    _localBookBloc = LocalBookBloc(
      repository: context.read<BookLocalRepository>(),
    );
    _localBookBloc.add(LocalBookFetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contex) => _localBookBloc,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.sort),
              ),
              floating: true,
              flexibleSpace: const FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(12),
                title: Text(
                  'Liked Book',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            BlocBuilder<LocalBookBloc, LocalBookState>(
              builder: (context, state) {
                return switch (state) {
                  LocalBookUpdated() => SliverToBoxAdapter(child: Text("")),
                  LocalBookInitial() => SliverLoadingWidget(),
                  LocalBookLoading() => SliverLoadingWidget(),
                  LocalBookFailure() => SliverToBoxAdapter(
                      child: Center(child: Text(state.message))),
                  LocalBookLoaded() => SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (state.books.isEmpty) {
                            return Center(child: Text("Book Not Found"));
                          }

                          return BookItemWidget(
                            book: state.books[index],
                            onLikedPressed: () {
                              // final params = state.books[index];
                              // _localBookBloc
                              //     .add(LocalBookLikePressed(params));
                            },
                            onDisLikedPressed: () {
                              // final params = state.books[index];
                              // _localBookBloc.add(
                              //   LocalBookDisLikePressed(params),
                              // );
                            },
                          );
                        },
                        childCount: state.books.length,
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
