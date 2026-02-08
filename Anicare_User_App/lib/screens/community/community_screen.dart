import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../../utils/constants.dart';

class CommunityPost {
  final String id;
  final String communityName;
  final String content;
  final DateTime timestamp;
  int likes;
  bool isLiked;

  CommunityPost({
    required this.id,
    required this.communityName,
    required this.content,
    required this.timestamp,
    this.likes = 0,
    this.isLiked = false,
  });
}

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  Timer? _timer;
  final Random _random = Random();
  
  final List<String> _communityNames = [
    'Mumbai Pet Lovers',
    'Navi Mumbai Animal Welfare',
    'Stray Care Mumbai',
    'Pet Rescue India',
    'Animal Friends Community',
    'Paws & Claws Mumbai',
    'Street Dogs Care',
    'Mumbai Cat Lovers',
  ];

  final List<String> _postContents = [
    'Spotted a healthy stray dog near Kharghar station. Fed them today.',
    'Successfully rescued an injured cat from the street. Thanks for support!',
    'Organizing a pet adoption drive this weekend at Vashi. Join us!',
    'Found a lost puppy near Nerul. Contact me if you know the owner.',
    'Vaccination camp for stray animals happening next week. Free for all!',
    'Need volunteers for animal feeding drive in Panvel area.',
    'Rescued a bird with broken wing. Looking for vet recommendations.',
    'Community cleanup drive for animal shelters this Sunday.',
  ];

  List<CommunityPost> _posts = [];

  @override
  void initState() {
    super.initState();
    _generatePosts();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        setState(() {
          _generatePosts();
        });
      }
    });
  }

  void _generatePosts() {
    _posts = List.generate(5, (index) {
      return CommunityPost(
        id: DateTime.now().millisecondsSinceEpoch.toString() + index.toString(),
        communityName: _communityNames[_random.nextInt(_communityNames.length)],
        content: _postContents[_random.nextInt(_postContents.length)],
        timestamp: DateTime.now().subtract(Duration(hours: _random.nextInt(24))),
        likes: _random.nextInt(50),
      );
    });
  }

  void _toggleLike(int index) {
    setState(() {
      if (_posts[index].isLiked) {
        _posts[index].likes--;
        _posts[index].isLiked = false;
      } else {
        _posts[index].likes++;
        _posts[index].isLiked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Community Feed")),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: Icon(Icons.group, color: AppColors.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.communityName, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              _formatTime(post.timestamp),
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(post.content, style: const TextStyle(fontSize: 15, height: 1.4)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          post.isLiked ? Icons.favorite : Icons.favorite_border,
                          color: post.isLiked ? Colors.red : Colors.grey,
                        ),
                        onPressed: () => _toggleLike(index),
                      ),
                      Text('${post.likes}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.comment_outlined, color: Colors.grey),
                        onPressed: () {},
                      ),
                      const Text('0'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
