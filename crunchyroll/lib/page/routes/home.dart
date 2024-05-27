import 'package:crunchyroll/page/routes/video_anime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAddedToList = false;

  void navigateToDetails(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoDemo(),
      
      ),
    );
  }

  void toggleListStatus() {
    setState(() {
      isAddedToList = !isAddedToList;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isAddedToList ? 'Se ha añadido a la lista' : 'Se ha eliminado de la lista')
      ),
    );
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Marcar como visto'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Compartir'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/icons/crunchyroll.svg',
            color: Colors.orange,
            width: 35,
            height: 35,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cast_outlined),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          GestureDetector(
            onTap: navigateToDetails,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: SizedBox(
                        // height: constraints.maxHeight * 0.5,
                        child: Image.asset(
                          'assets/images/Kimetsu_no_Yaiba-cover.jpg',
                          height: MediaQuery.of(context).size.height / 2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                );
              }
            )
          ),
          GestureDetector(
            onTap: navigateToDetails,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Estamos en la era de Taisho de Japón. Tanjiro, un joven que se gana la vida vendiendo carbón, descubre un día que su familia ha sido asesinada por un demonio...',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ), 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: (){}, 
                icon: Icon(Icons.play_arrow_outlined),
                label: Text('VER AHORA'),
              ),
              IconButton(
                onPressed: toggleListStatus,
                icon: Icon(isAddedToList ? Icons.bookmark : Icons.bookmark_border)
              ),
            ],
          ), 
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Nuestras recomendaciones',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          SizedBox(height: 8), // Reduced spacing
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            height: 280, // Adjusted height for the recommendations
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  width: 160, // Adjusted width for the recommendations
                  margin: EdgeInsets.symmetric(horizontal: 4.0), // Reduced horizontal margin
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/Kimetsu_no_Yaiba-cover.jpg', // Replace with a valid image URL
                        height: 200, // Adjusted height for the image
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 4), // Reduced vertical spacing
                      Text(
                        'Anime Title ${index + 1}',
                        style: TextStyle(fontSize: 16 , color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dob | Sub',style: TextStyle(fontSize: 14 , color: Colors.grey),
                          ),
                          IconButton(
                            icon: Icon(Icons.more_vert, color: Colors.grey),
                            onPressed: () {
                              // More options
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: navigateToDetails,
            child: Container(
              margin: EdgeInsets.all(16.0),
              height: 190, // Increased height for the video section
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Kimetsu_no_Yaiba-cover.jpg'), // Replace with a valid image URL
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: Row(
                      children: [
                        Icon(Icons.play_circle_fill, color: Colors.white, size: 40,),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Anime Title',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Temporada 1, Episodio 1',
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Text(
                      '15 min restantes',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: IconButton(
                      icon: Icon(Icons.more_vert, color: Colors.white),
                      onPressed: () => showModal(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
      ),
      body: Center(
        child: Text('Detalles del Anime'),
      ),
    );
  }
}