import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoDemo extends StatefulWidget {
  const VideoDemo({super.key});
  final String title = "VideoDemo";

  @override
  State<VideoDemo> createState() => _VideoDemoState();
}

class _VideoDemoState extends State<VideoDemo> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/Kimetsu.mp4");
    _initializeVideoPlayerFuture = _controller.initialize().then((_){
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          aspectRatio: _controller.value.aspectRatio,
          autoPlay: true,
          looping: true,
        );
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Video"),
        ),
        body: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Chewie(
                      controller: _chewieController
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Demon Slayer: Kimetsu no Yaiba", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange)),
                        Text("S57 E1 - Para vencer a Muzan Kibutsuji", style: TextStyle(fontSize: 18)),
                        Text("Subtitulado", style: TextStyle(fontSize: 14, color: Colors.grey)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.thumb_up_alt_outlined),
                                SizedBox(width: 4),
                                Text("123"),
                                SizedBox(width: 16),
                                Icon(Icons.thumb_down_alt_outlined),
                                SizedBox(width: 4),
                                Text("4"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.thumb_up_alt_outlined),
                                SizedBox(width: 16),
                                Icon(Icons.more_vert)
                              ], 
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text("Tanjiro por fin tiene permiso para unirse al entrenamiento de los Pilares. Con renovadas energías se dirige a reforzar su cuerpo con Uzui.", style: TextStyle(fontSize: 14)),
                        SizedBox(height: 8),
                        Divider(color: Colors.grey),
                        GestureDetector(
                          onTap: () {
                            
                          },
                          child: Row(
                            children: [
                              Icon(Icons.comment_outlined),
                              SizedBox(width: 8),
                              Text("Comentarios")
                            ],
                          ),
                        ),
                        Divider(color: Colors.grey),
                        SizedBox(height: 12),
                        Text("Proximo episodio", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 56,
                              color: Colors.black26
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Kimetsu no Yaiba - Episodio 2", style: TextStyle(fontSize: 16)),
                                  Row(
                                    children: [
                                      Icon(Icons.comment),
                                      SizedBox(width: 8),
                                      Text("Comentarios"),
                                      Spacer(),
                                      Icon(Icons.download),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: const Text("Todos los episodios", style: TextStyle(fontSize: 16, color: Colors.orange)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            } else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
    );
  }
}