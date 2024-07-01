import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:guternberg_book/features/home/presentations/screens/home_screen.dart';
import 'package:guternberg_book/features/liked_book/presentations/screens/book_like_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final _controller = ScrollController();
  ValueNotifier<bool> _isVisible = ValueNotifier<bool>(true);

  late List<Widget> _screens;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void listen() {
    final direction = _controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (_isVisible.value) return;
    _isVisible.value = true;
  }

  void hide() {
    if (!_isVisible.value) return;
    _isVisible.value = false;
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(listen);
    _screens = <Widget>[
      HomeScreen(scrollController: _controller),
      BookLikeScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: _isVisible,
        builder: (context, visible, _) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: visible ? kBottomNavigationBarHeight : 0,
            child: Wrap(
              children: [
                BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.house_rounded),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.thumb_up_rounded),
                      label: 'Like',
                    ),
                    //TODO : dark mode/ change Language
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.settings_applications_sharp),
                    //   label: 'Setting',
                    // ),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: (int index) {
                    _onItemTapped(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // TODO : not ready yet
  void _showSettingDialog(int index) {
    switch (index) {
      case 0:
      case 1:
        _onItemTapped(index);
        break;
      default:
        showModalBottomSheet(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Icon(Icons.light_mode),
                        Icon(Icons.dark_mode),
                        // Text("Dark Mode")
                        Text("Light Mode")
                      ],
                    ),
                  ),
                  Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Icon(Icons.light_mode),
                        Icon(Icons.language),
                        // Text("Dark Mode")
                        Text("Language")
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
    }
  }
}
