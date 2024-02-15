import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoriesPage extends ConsumerStatefulWidget {
  const StoriesPage({super.key});

  @override
  ConsumerState<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends ConsumerState<StoriesPage> {
  final PageController _pageController = PageController();
  int _currentStoryIndex = 0;
  int _currentMediaIndex = 0;

  final List<Map<String, dynamic>> _stories = [
    {
      'id': '1',
      'user': {
        'name': 'John Doe',
        'username': '@johndoe',
        'avatar': 'https://example.com/avatar1.jpg',
        'isVerified': true,
      },
      'media': [
        {
          'type': 'image',
          'url': 'https://example.com/story1.jpg',
          'duration': 5,
        },
        {
          'type': 'video',
          'url': 'https://example.com/story1.mp4',
          'duration': 10,
        },
      ],
      'timestamp': '2h ago',
      'isViewed': false,
    },
    {
      'id': '2',
      'user': {
        'name': 'Sarah Wilson',
        'username': '@sarahw',
        'avatar': 'https://example.com/avatar2.jpg',
        'isVerified': false,
      },
      'media': [
        {
          'type': 'image',
          'url': 'https://example.com/story2.jpg',
          'duration': 5,
        },
      ],
      'timestamp': '4h ago',
      'isViewed': true,
    },
    {
      'id': '3',
      'user': {
        'name': 'Mike Johnson',
        'username': '@mikej',
        'avatar': 'https://example.com/avatar3.jpg',
        'isVerified': true,
      },
      'media': [
        {
          'type': 'image',
          'url': 'https://example.com/story3.jpg',
          'duration': 5,
        },
        {
          'type': 'image',
          'url': 'https://example.com/story4.jpg',
          'duration': 5,
        },
        {
          'type': 'video',
          'url': 'https://example.com/story2.mp4',
          'duration': 15,
        },
      ],
      'timestamp': '6h ago',
      'isViewed': false,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Story Content
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentStoryIndex = index;
                _currentMediaIndex = 0;
              });
            },
            itemCount: _stories.length,
            itemBuilder: (context, index) {
              final story = _stories[index];
              return _buildStoryView(story);
            },
          ),
          
          // Top Bar
          _buildTopBar(),
          
          // Bottom Bar
          _buildBottomBar(),
          
          // Progress Indicators
          _buildProgressIndicators(),
        ],
      ),
    );
  }

  Widget _buildStoryView(Map<String, dynamic> story) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Media Content
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[900],
            child: const Center(
              child: Icon(
                Icons.image,
                size: 100,
                color: Colors.white,
              ),
            ),
          ),
          
          // Story Info
          Positioned(
            top: 100,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.person),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                story['user']['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              if (story['user']['isVerified']) ...[
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.verified,
                                  color: Colors.blue,
                                  size: 16,
                                ),
                              ],
                            ],
                          ),
                          Text(
                                '${story['user']['username']} • ${story['timestamp']}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onPressed: _showStoryOptions,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Gesture Detector for Navigation
          GestureDetector(
            onTap: _nextMedia,
            onPanEnd: (details) {
              if (details.velocity.pixelsPerSecond.dx > 0) {
                _previousMedia();
              } else if (details.velocity.pixelsPerSecond.dx < 0) {
                _nextMedia();
              }
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 50,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: _showStoryOptions,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Positioned(
      bottom: 50,
      left: 16,
      right: 16,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Send message',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: _likeStory,
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicators() {
    if (_stories.isEmpty) return const SizedBox.shrink();
    
    final currentStory = _stories[_currentStoryIndex];
    final mediaCount = currentStory['media'].length;
    
    return Positioned(
      top: 60,
      left: 16,
      right: 16,
      child: Row(
        children: List.generate(mediaCount, (index) {
          return Expanded(
            child: Container(
              height: 3,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: index <= _currentMediaIndex
                    ? Colors.white
                    : Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _nextMedia() {
    final currentStory = _stories[_currentStoryIndex];
    final mediaCount = currentStory['media'].length;
    
    if (_currentMediaIndex < mediaCount - 1) {
      setState(() {
        _currentMediaIndex++;
      });
    } else if (_currentStoryIndex < _stories.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _previousMedia() {
    if (_currentMediaIndex > 0) {
      setState(() {
        _currentMediaIndex--;
      });
    } else if (_currentStoryIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showStoryOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Story'),
              onTap: _shareStory,
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copy Link'),
              onTap: _copyLink,
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Report'),
              onTap: _reportStory,
            ),
            ListTile(
              leading: const Icon(Icons.block),
              title: const Text('Block User'),
              onTap: _blockUser,
            ),
          ],
        ),
      ),
    );
  }

  void _likeStory() {
    // Implement story liking
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Story liked!')),
    );
  }

  void _sendMessage() {
    // Implement message sending
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Message sent!')),
    );
  }

  void _shareStory() {
    // Implement story sharing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Story shared!')),
    );
  }

  void _copyLink() {
    // Implement link copying
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Link copied!')),
    );
  }

  void _reportStory() {
    // Implement story reporting
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Story reported!')),
    );
  }

  void _blockUser() {
    // Implement user blocking
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User blocked!')),
    );
  }
}
