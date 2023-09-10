import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _postController = TextEditingController();
  bool _isLoading = false;

  final List<Map<String, dynamic>> _posts = [
    {
      'id': '1',
      'user': {
        'name': 'John Doe',
        'username': '@johndoe',
        'avatar': 'https://example.com/avatar1.jpg',
        'isVerified': true,
      },
      'content': 'Just finished an amazing hike! The view from the top was incredible. #hiking #nature #adventure',
      'image': 'https://example.com/hike.jpg',
      'likes': 42,
      'comments': 8,
      'shares': 3,
      'timeAgo': '2h',
      'isLiked': false,
    },
    {
      'id': '2',
      'user': {
        'name': 'Sarah Wilson',
        'username': '@sarahw',
        'avatar': 'https://example.com/avatar2.jpg',
        'isVerified': false,
      },
      'content': 'Working on a new project. Can\'t wait to share it with you all! 🚀',
      'image': null,
      'likes': 28,
      'comments': 5,
      'shares': 1,
      'timeAgo': '4h',
      'isLiked': true,
    },
    {
      'id': '3',
      'user': {
        'name': 'Mike Johnson',
        'username': '@mikej',
        'avatar': 'https://example.com/avatar3.jpg',
        'isVerified': true,
      },
      'content': 'Delicious homemade pasta for dinner tonight! 🍝',
      'image': 'https://example.com/pasta.jpg',
      'likes': 67,
      'comments': 12,
      'shares': 7,
      'timeAgo': '6h',
      'isLiked': false,
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _openSearch,
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: _openNotifications,
          ),
        ],
      ),
      body: Column(
        children: [
          // Create Post Section
          _buildCreatePostSection(),
          
          // Posts List
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshFeed,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return _buildPostCard(post);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createPost,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCreatePostSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: InkWell(
              onTap: _createPost,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'What\'s on your mind?',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: _addPhoto,
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: _addVideo,
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                            post['user']['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (post['user']['isVerified']) ...[
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
                        '${post['user']['username']} • ${post['timeAgo']}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'save',
                      child: Text('Save Post'),
                    ),
                    const PopupMenuItem(
                      value: 'report',
                      child: Text('Report'),
                    ),
                    const PopupMenuItem(
                      value: 'hide',
                      child: Text('Hide'),
                    ),
                  ],
                  onSelected: _handlePostAction,
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Post Content
            Text(
              post['content'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            
            // Post Image
            if (post['image'] != null)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.image,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(height: 12),
            
            // Post Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  icon: post['isLiked'] ? Icons.favorite : Icons.favorite_border,
                  label: '${post['likes']}',
                  color: post['isLiked'] ? Colors.red : Colors.grey[600],
                  onTap: () => _toggleLike(post['id']),
                ),
                _buildActionButton(
                  icon: Icons.comment_outlined,
                  label: '${post['comments']}',
                  color: Colors.grey[600],
                  onTap: () => _openComments(post['id']),
                ),
                _buildActionButton(
                  icon: Icons.share_outlined,
                  label: '${post['shares']}',
                  color: Colors.grey[600],
                  onTap: () => _sharePost(post['id']),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshFeed() async {
    setState(() {
      _isLoading = true;
    });
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isLoading = false;
    });
  }

  void _createPost() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _buildCreatePostModal(),
    );
  }

  Widget _buildCreatePostModal() {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              Text(
                'Create Post',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: _publishPost,
                child: const Text('Post'),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 16),
          TextField(
            controller: _postController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'What\'s on your mind?',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.photo_camera),
                onPressed: _addPhoto,
              ),
              IconButton(
                icon: const Icon(Icons.videocam),
                onPressed: _addVideo,
              ),
              IconButton(
                icon: const Icon(Icons.location_on),
                onPressed: _addLocation,
              ),
              IconButton(
                icon: const Icon(Icons.mood),
                onPressed: _addEmoji,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openSearch() {
    // Implement search functionality
  }

  void _openNotifications() {
    // Implement notifications
  }

  void _addPhoto() {
    // Implement photo selection
  }

  void _addVideo() {
    // Implement video selection
  }

  void _addLocation() {
    // Implement location selection
  }

  void _addEmoji() {
    // Implement emoji picker
  }

  void _publishPost() {
    if (_postController.text.isNotEmpty) {
      // Implement post publishing
      Navigator.pop(context);
      _postController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post published!')),
      );
    }
  }

  void _toggleLike(String postId) {
    setState(() {
      final postIndex = _posts.indexWhere((post) => post['id'] == postId);
      if (postIndex != -1) {
        final post = _posts[postIndex];
        post['isLiked'] = !post['isLiked'];
        post['likes'] += post['isLiked'] ? 1 : -1;
      }
    });
  }

  void _openComments(String postId) {
    // Implement comments functionality
  }

  void _sharePost(String postId) {
    // Implement sharing functionality
  }

  void _handlePostAction(String action) {
    // Implement post actions
  }
}
