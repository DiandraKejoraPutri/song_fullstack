import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ukl_25/widgets/bottom_nav.dart';
import 'package:ukl_25/views/addsong.dart';

class Playlist extends StatefulWidget {
  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  List<dynamic> playlists = [];
  int _currentIndex = 0;
  String role = "user";
  bool isLoading = true;

  Future<void> fetchPlaylists() async {
    final response = await http.get(Uri.parse('https://learn.smktelkom-mlg.sch.id/ukl2/playlists'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        playlists = data['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    fetchPlaylists();
  }
  void _onNavTap(int index) {
  setState(() {
    _currentIndex = index;
  });

  if (role == "user") {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/playlist');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/addsong');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  final playlist = playlists[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/songlist',
                        arguments: {'playlistId': playlist['uuid']},
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                playlist['playlist_name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '🎵 ${playlist['song_count']} songs',
                                style: const TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                         Icon(Icons.arrow_forward_ios, size: 16, color: Colors.green[300]),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
        role: role,
      ),
    );
  }
}
