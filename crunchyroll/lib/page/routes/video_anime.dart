import 'package:crunchyroll/page/routes/proximo_episodio.dart';
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
    _controller = VideoPlayerController.asset("assets/kimetsu.mp4");
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
                        Text("Demon Slayer: Kimetsu no Yaiba", style: TextStyle(fontSize: 13, color: Colors.orange)),
                        SizedBox(height: 7),
                        Text("S57 E1 - Para vencer a Muzan Kibutsuji", style: TextStyle(fontSize: 18, color: Colors.white)),
                        SizedBox(height: 7),
                        Text("Subtitulado", style: TextStyle(fontSize: 14, color: Colors.grey)),
                        SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.thumb_up_alt_outlined, color: Colors.white),
                                SizedBox(width: 4),
                                Text("123", style: TextStyle(color: Colors.white)),
                                SizedBox(width: 16),
                                Icon(Icons.thumb_down_alt_outlined, color: Colors.white),
                                SizedBox(width: 4),
                                Text("4", style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.thumb_up_alt_outlined, color: Colors.white),
                                SizedBox(width: 16),
                                Icon(Icons.more_vert, color: Colors.white)
                              ], 
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text("Tanjiro por fin tiene permiso para unirse al entrenamiento de los Pilares. Con renovadas energías se dirige a reforzar su cuerpo con Uzui.", style: TextStyle(fontSize: 14, color: Colors.white)),
                        SizedBox(height: 10),
                        Divider(color: Colors.grey),
                        SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            
                          },
                          child: Row(
                            children: [
                              Icon(Icons.comment_outlined, color: Colors.white),
                              SizedBox(width: 8),
                              Text("Comentarios", style: TextStyle(color: Colors.white, fontSize: 17),)
                            ],
                          ),
                        ),
                        SizedBox(height: 4),
                        Divider(color: Colors.grey),
                        SizedBox(height: 12),
                        Text("Próximo episodio", style: TextStyle(fontSize: 18, color: Colors.white)),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NextEpisodePage()),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 130,
                                height: 78,
                                color: Colors.white
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("2. El dolor de Giyu To...", style: TextStyle(fontSize: 16, color: Colors.white)),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Icon(Icons.comment_outlined, color: Colors.grey),
                                        SizedBox(width: 8),
                                        Text("1.4K", style: TextStyle(color: Colors.white)),
                                        Spacer(),
                                        Icon(Icons.file_download_outlined, color: Colors.white),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: const Text("TODOS LOS EPISODIOS", style: TextStyle(fontSize: 16, color: Colors.orange)),
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