import 'package:crunchyroll/page/view/profile/content.dart';
import 'package:crunchyroll/page/view/profile/edit_profile.dart';
import 'package:flutter/material.dart';

class GradientScrollView extends StatefulWidget {
  @override
  _GradientScrollViewState createState() => _GradientScrollViewState();
}

class _GradientScrollViewState extends State<GradientScrollView> {
  double _scrollOffset = 0;
  String userName = 'Dennis';

  void _updateUserName(String newName) {
    setState(() {
      userName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: _scrollOffset > 200 ? Colors.black : Colors.transparent,
        elevation: 0,
        title: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: _scrollOffset > 200 ? 1.0 : 0.0,
          child: Text('Mi cuenta', style: TextStyle(color: Colors.grey, fontSize: 24, fontWeight: FontWeight.bold),),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  setState(() {
                    _scrollOffset = scrollNotification.metrics.pixels;
                  });
                }
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Opacity(
                          opacity: 1,
                          child: Image_profile(),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 70),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => EditProfile(onSave: _updateUserName)),
                                        );
                                      },
                                      child: Container(
                                        width: 110.0,
                                        height: 110.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.white, width: 1.3),
                                          image: DecorationImage(
                                            image: AssetImage('assets/images/luffy.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.edit_outlined,
                                          size: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              userName,
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                      child: ContentProfile(userName: userName),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Image_profile extends StatelessWidget {
  const Image_profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 254,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fondo/colores.avif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
