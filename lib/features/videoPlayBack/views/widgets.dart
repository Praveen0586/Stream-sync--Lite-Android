import 'package:flutter/material.dart';

class VideoPlayerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(color: Colors.black), // Video Preview
          Icon(Icons.play_arrow, size: 64, color: Colors.white),
          Positioned(left: 16, child: Icon(Icons.rotate_left, color: Colors.white)),
          Positioned(right: 16, child: Icon(Icons.rotate_right, color: Colors.white)),
        ],
      ),
    );
  }
}

// course_header.dart
class CourseHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Introduction to Quantum Physics', style: Theme.of(context).textTheme.titleLarge),
        Text('By Dr. Evelyn Reed', style: Theme.of(context).textTheme.titleSmall),
        Row(
          children: [
            Icon(Icons.thumb_up), Text('1.2k'),
            SizedBox(width: 16),
            Icon(Icons.comment), Text('87'),
            SizedBox(width: 16),
            Icon(Icons.share),
          ],
        ),
      ],
    );
  }
}