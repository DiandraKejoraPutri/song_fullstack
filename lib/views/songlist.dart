import 'package:flutter/material.dart';
import 'package:ukl_25/views/song_detail.dart';

class Songlist extends StatefulWidget {
  const Songlist({super.key});

  @override
  State<Songlist> createState() => _SonglistPageState();
}

class _SonglistPageState extends State<Songlist> {
  final List<Map<String, String>> songs = [
    {
      'title': 'Cinta Luar Biasa',
      'artist': 'ANDMESH',
      'thumbnail': 'https://via.placeholder.com/300x180.png?text=No+Image',
    },
    {
      'title': 'Jiwa Yang Bersedih',
      'artist': 'Ghea Indrawati',
      'thumbnail': 'https://via.placeholder.com/300x180.png?text=No+Image',
    },
    {
      'title': 'Pura-pura lupa',
      'artist': 'Mahen',
      'thumbnail': 'https://via.placeholder.com/300x180.png?text=No+Image',
    },
    {
      'title': 'Untuk Apa',
      'artist': 'Maudy Ayunda',
      'thumbnail': 'https://via.placeholder.com/300x180.png?text=No+Image',
    },
  ];

  String searchQuery = '';
  Set<int> likedIndexes = {};

  @override
  Widget build(BuildContext context) {
    final filteredSongs = songs.where((song) {
      final query = searchQuery.toLowerCase();
      return song['title']!.toLowerCase().contains(query) ||
          song['artist']!.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pop Hits'),
        backgroundColor: Colors.green[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari berdasarkan judul atau artis...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSongs.length,
              itemBuilder: (context, index) {
                final song = filteredSongs[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongDetailPage(
                          title: song['title']!,
                          artist: song['artist']!,
                          thumbnail: song['thumbnail']!,
                          song: {}, 
                          songId: '', 
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            song['thumbnail'] ?? 'https://via.placeholder.com/150',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                'https://via.placeholder.com/150',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song['title']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(song['artist']!),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.play_circle_fill,
                              color: Colors.blue, size: 30),
                          onPressed: () {
                            // TODO: Implement play action
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            likedIndexes.contains(index)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: likedIndexes.contains(index)
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              if (likedIndexes.contains(index)) {
                                likedIndexes.remove(index);
                              } else {
                                likedIndexes.add(index);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
