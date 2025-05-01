import 'package:flutter/material.dart';
import 'package:wibu_app/controller/anime_presenter.dart';
import 'package:wibu_app/model/anime_model.dart';
import 'package:wibu_app/view/detail_screen.dart';

class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({super.key});

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> implements AnimeView {
  late AnimePresenter _presenter;
  bool _isLoading = false;
  List<Anime> _animeList = [];
  String? _errorMessage;
  String _currentEndpoint = "akatsuki";

  @override
  void initState(){
    super.initState();
    _presenter = AnimePresenter(this);
    _presenter.loadAnimeData(_currentEndpoint);
  }

  void _fetchData(String endpoint){
    _currentEndpoint = endpoint;
    _presenter.loadAnimeData(_currentEndpoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Anime List"),),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () => _fetchData("akatsuki"), child: Text("Akatsuki")),
              SizedBox(width: 10,),
              ElevatedButton(onPressed: () => _fetchData("kara") , child: Text("Kara")),
              
            ],
          ),
          Expanded(child: _isLoading ?
          Center(child: CircularProgressIndicator())
              : _errorMessage != null
              ? Center(child: Text("Error Message"))
              : ListView.builder(
              itemCount: _animeList.length,
              itemBuilder: (context,index){
                final anime = _animeList[index];
                return ListTile(
                  leading: anime.imageUrl.isNotEmpty ? Image.network(anime.imageUrl) : Image.network('https://placehold.co/600x400'),
                  title: Text(anime.name),
                  subtitle: Text("Family ${anime.familyCreator}"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AnimeDetailCharacter(id: anime.id, endpoint: _currentEndpoint)));
                  },
                );
              })
          )
        ],
      ),
    );
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showAnimeList(List<Anime> animeList) {
    // TODO: implement showAnimeList
    setState(() {
      _animeList = animeList;
    });
  }

  @override
  void showError(String message) {
    // TODO: implement showError
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
    _isLoading = true;
  }
}
