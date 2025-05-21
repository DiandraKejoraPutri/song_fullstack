import 'package:flutter/material.dart';
import 'package:ukl_25/views/song_detail.dart';
import 'package:ukl_25/views/songlist.dart';
import 'views/login_page.dart';
import 'views/playlist.dart';
import 'views/addsong.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context)=>LoginPage(),
      '/playlist':(context)=>Playlist(),
      '/songlist':(context)=>Songlist(),
      '/songdetail':(context)=>const SongDetailPage(song: {}, songId: '', title: '', artist: '', thumbnail: '',),
      '/addsong':(context)=>const AddSong(playlistId: '',),
    },
  ));
}
