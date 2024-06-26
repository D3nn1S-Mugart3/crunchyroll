import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class NextEpisodePage extends StatefulWidget {
  const NextEpisodePage({super.key});
  final String title = "VideoDemo";

  @override
  _NextEpisodePageState createState() => _NextEpisodePageState();
}

class _NextEpisodePageState extends State<NextEpisodePage> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/video/One_Piece.mp4");
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
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
    _chewieController.dispose(); // Dispose only if it's not null
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Episode"),
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
                    controller: _chewieController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("One Piece - Episodio 1", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Temporada 1, Episodio 1", style: TextStyle(fontSize: 16)),
                      Text("Doblaje: Español", style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.thumb_up_alt_outlined),
                              SizedBox(width: 4),
                              Text("456"),
                              SizedBox(width: 16),
                              Icon(Icons.thumb_down_alt_outlined),
                              SizedBox(width: 4),
                              Text("12"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.download),
                              SizedBox(width: 16),
                              Icon(Icons.more_vert),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text("Luffy comienza su aventura para encontrar el One Piece y convertirse en el Rey de los Piratas.", style: TextStyle(fontSize: 14)),
                      SizedBox(height: 8),
                      Divider(color: Colors.grey),
                      GestureDetector(
                        onTap: () {
                          // Navegar a la ventana de comentarios
                        },
                        child: Row(
                          children: [
                            Icon(Icons.comment),
                            SizedBox(width: 8),
                            Text("Comentarios"),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey),
                      SizedBox(height: 16),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            // Navegar a la ventana de todos los episodios
                          },
                          child: Text("Todos los episodios", style: TextStyle(fontSize: 16, color: Colors.blue)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
                    } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}