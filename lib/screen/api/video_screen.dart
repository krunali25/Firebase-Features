import 'package:firebase_features/helper/dimens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../provider/video_provider.dart';
import '../../model/video_model.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<VideoProvider>(context, listen: false).postAllVideo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video List", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Consumer<VideoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.videos.isEmpty) {
            return Center(child: Text("No videos available.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)));
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            itemCount: provider.videos.length,
            itemBuilder: (context, index) {
              final Video video = provider.videos[index];
              return VideoCard(video: video);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Provider.of<VideoProvider>(context, listen: false).postAllVideo();
        },
        child: Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final Video video;
  VideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Reduced elevation
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6), // Smaller margins
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(8), // Reduced padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Player
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: VideoPlayerWidget(videoUrl: video.url ?? ""),
            ),
            SizedBox(height: 6),

            // Video Details
            Text(
              "Quality: ${video.quality ?? "Unknown"}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 4),
            Text(
              "Size: ${video.formattedSize ?? "Unavailable"}",
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            Text(
              "Extension: ${video.extension ?? "Unknown"}",
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      }).catchError((error) {
        print("Error initializing video: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized
        ? Container(
      height: Dimens.height_300, // Fixed smaller height for the video
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.black,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(_controller),
          IconButton(
            iconSize: 40, // Smaller button
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _controller.value.isPlaying ? _controller.pause() : _controller.play();
              });
            },
          ),
        ],
      ),
    )
        : Center(child: CircularProgressIndicator());
  }
}
