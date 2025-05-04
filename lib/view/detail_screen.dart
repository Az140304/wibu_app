import 'package:flutter/material.dart';
import 'package:wibu_app/network/base_network.dart';

class AnimeDetailCharacter extends StatefulWidget {
  final int id;
  final String endpoint;
  const AnimeDetailCharacter({super.key, required this.id, required this.endpoint});

  @override
  State<AnimeDetailCharacter> createState() => _AnimeDetailCharacterState();
}

class _AnimeDetailCharacterState extends State<AnimeDetailCharacter> {
  bool _customTileExpanded = false;
  bool _isLoading = true;
  Map<String, dynamic>? _detailData;
  String? errorMessage;
  @override
  void initState(){
    super.initState();
    _fetchDetailData();
  }

  Future<void> _fetchDetailData() async {
    try {
      final data = await BaseNetwork.getDetailData(widget.endpoint, widget.id);
      setState(() {
        _detailData = data;
        _isLoading = false;
      });
    } catch (e) {
      errorMessage = e.toString();
      _isLoading = false;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Character")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text("Error Message"))
          : _detailData != null
          ? Column(
        children: <Widget>[
          Image.network(_detailData!['images'][0] ?? 'https://placehold.co/600x400'),
          Text(_detailData!['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
          const ExpansionTile(
            title: Text('ExpansionTile 1'),
            children: <Widget>[ListTile(title: Text('This is tile number 1'))],
          ),

        ],
      )

      /*Column(
            children: [
              Image.network(_detailData!['images'][0] ?? 'https://placehold.co/600x400'),
              Text("Name : ${_detailData!['name']}"),
              Text("Kekkei Genkei : ${_detailData!['personal']['kekkeiGenkai'] ?? 'Empty'}"),
              Text("Titles : ${_detailData!['personal']['titles']}")
            ],
          ) */: Text("No Data Available")
    );
  }
}
