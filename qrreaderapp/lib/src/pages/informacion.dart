import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/slide_item.dart';
import '../models/slide.dart';
import '../widgets/slide_dots.dart';

class CerrarSesion extends StatefulWidget {
  const CerrarSesion({super.key});

  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<CerrarSesion> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: slideList.length,
                      itemBuilder: (ctx, i) => SlideItem(i),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 35),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int i = 0; i < slideList.length; i++)
                                if (i == _currentPage)
                                  SlideDots(true)
                                else
                                  SlideDots(false)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'SCANNER QR',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue[400],
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        '            ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      // FlatButton(
                      //   child: Text(
                      //     'Getting Started',
                      //     style: TextStyle(
                      //       fontSize: 18,
                      //     ),
                      //   ),
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(5),
                      //   ),
                      //   padding: const EdgeInsets.all(15),
                      //   color: Theme.of(context).primaryColor,
                      //   textColor: Colors.white,
                      //   onPressed: () {},
                      // ),

                      // FlatButton(
                      //   child: Text(
                      //     'Login',
                      //     style: TextStyle(fontSize: 18),
                      //   ),
                      //   onPressed: () {},
                      // ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}