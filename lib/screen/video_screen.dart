import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/video_provider.dart';


class VideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video List')),
      body: Consumer<VideoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.videoList.isEmpty) {
            return Center(child: Text('No videos available'));
          }
          return ListView.builder(
            itemCount: provider.videoList.length,
            itemBuilder: (context, index) {
              var video = provider.videoList[index];
              return ListTile(
                title: Text("Quality: ${video.quality}"),
                subtitle: Text("Size: ${video.formattedSize}"),
                trailing: Icon(Icons.play_circle_fill, color: Colors.blue),
                onTap: () {
                  // Open video player (implement logic)
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<VideoProvider>(context, listen: false).getAllVideo(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
