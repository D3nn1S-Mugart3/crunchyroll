import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MangasPDF extends StatelessWidget {
  final List<Anime> animeList = [
    Anime(
      title: "One Piece", 
      imageAsset: "assets/images/one-piece.jpg", 
      pdfAsset: "assets/pdf/OP 1099-1199.pdf"
    ),
    Anime(
      title: "One Piece", 
      imageAsset: "assets/images/one-piece.jpg", 
      pdfAsset: "assets/pdf/OP 1110-1116.pdf"
    ),
    Anime(
      title: "One Piece", 
      imageAsset: "assets/images/one-piece.jpg", 
      pdfAsset: "assets/pdf/OP 1117.pdf"
    ),
    Anime(
      title: "One Piece", 
      imageAsset: "assets/images/one-piece.jpg", 
      pdfAsset: "assets/pdf/OP 1117.pdf"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mangas"),
      ),
      body: ListView.builder(
        itemCount: (animeList.length / 2).ceil(),
        itemBuilder: (context, index) {
          final leftAnime = animeList[index * 2];
          final rightAnime = index * 2 < animeList.length
              ? animeList[index *2 + 1]
              : null;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimeTile(anime: leftAnime),
              if (rightAnime != null) AnimeTile(anime: rightAnime)
            ],
          );
        },
      ),
    );
  }
}

class Anime {
  final String title;
  final String imageAsset;
  final String pdfAsset;

  Anime({
    required this.title,
    required this.imageAsset,
    required this.pdfAsset,
  });
}

class AnimeTile extends StatelessWidget {
  final Anime anime;

  AnimeTile({required this.anime});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () => _openPdf(context, anime.pdfAsset),
            child: Image.asset(anime.imageAsset, width: 150),
          ),
        ),
        Text(anime.title),
      ],
    );
  }

  void _openPdf(BuildContext context, String pdfAsset) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/${pdfAsset.split('/').last}");
    final data = await rootBundle.load(pdfAsset);
    await file.writeAsBytes(data.buffer.asUint8List(), flush: true);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(pdfPath: file.path),
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  PdfViewerScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}