import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, dynamic> _userProfile = {
    'name': 'John Doe',
    'username': '@johndoe',
    'bio': 'Digital creator | Photography enthusiast | Coffee lover ☕',
    'avatar': 'https://example.com/avatar.jpg',
    'isVerified': true,
    'isFollowing': false,
    'followers': 12500,
    'following': 890,
    'posts': 156,
    'isPrivate': false,
  };

  final List<Map<String, dynamic>> _posts = [
    {
      'id': '1',
      'image': 'https://example.com/post1.jpg',
      'likes': 234,
      'comments': 12,
    },
    {
      'id': '2',
      'image': 'https://example.com/post2.jpg',
      'likes': 189,
      'comments': 8,
    },
    {
      'id': '3',
      'image': 'https://example.com/post3.jpg',
      'likes': 456,
      'comments': 23,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 400,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildProfileHeader(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: _showProfileOptions,
                ),
              ],
            ),
          ];
        },
        body: Column(
          children: [
            // Profile Stats
            _buildProfileStats(),
            
            // Action Buttons
            _buildActionButtons(),
            
            // Tab Bar
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.video_library)),
                Tab(icon: Icon(Icons.bookmark_border)),
              ],
            ),
            
            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPostsGrid(),
                  _buildVideosGrid(),
                  _buildSavedGrid(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6366F1),
            Color(0xFF8B5CF6),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.grey[300],
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // User Info
            Text(
              _userProfile['name'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _userProfile['username'],
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                if (_userProfile['isVerified']) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 20,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            
            // Bio
            Text(
              _userProfile['bio'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Posts', _userProfile['posts'].toString()),
          _buildStatItem('Followers', _formatNumber(_userProfile['followers'])),
          _buildStatItem('Following', _formatNumber(_userProfile['following'])),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: _userProfile['isFollowing'] ? _unfollow : _follow,
              style: ElevatedButton.styleFrom(
                backgroundColor: _userProfile['isFollowing'] 
                    ? Colors.grey[300] 
                    : Theme.of(context).primaryColor,
                foregroundColor: _userProfile['isFollowing'] 
                    ? Colors.black 
                    : Colors.white,
              ),
              child: Text(
                _userProfile['isFollowing'] ? 'Following' : 'Follow',
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton(
              onPressed: _sendMessage,
              child: const Text('Message'),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: _shareProfile,
            icon: const Icon(Icons.person_add),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return _buildPostItem(post);
      },
    );
  }

  Widget _buildVideosGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return _buildVideoItem(post);
      },
    );
  }

  Widget _buildSavedGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return _buildSavedItem(post);
      },
    );
  }

  Widget _buildPostItem(Map<String, dynamic> post) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.image,
        size: 50,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildVideoItem(Map<String, dynamic> post) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Stack(
        children: [
          Center(
            child: Icon(
              Icons.play_circle_outline,
              size: 50,
              color: Colors.grey,
            ),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: Icon(
              Icons.play_arrow,
              size: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedItem(Map<String, dynamic> post) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Stack(
        children: [
          Center(
            child: Icon(
              Icons.bookmark,
              size: 50,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  void _follow() {
    setState(() {
      _userProfile['isFollowing'] = true;
      _userProfile['followers']++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Following user')),
    );
  }

  void _unfollow() {
    setState(() {
      _userProfile['isFollowing'] = false;
      _userProfile['followers']--;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unfollowed user')),
    );
  }

  void _sendMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening chat...')),
    );
  }

  void _shareProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile shared!')),
    );
  }

  void _showProfileOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Profile'),
              onTap: _shareProfile,
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copy Link'),
              onTap: _copyProfileLink,
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Report User'),
              onTap: _reportUser,
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

  void _copyProfileLink() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile link copied!')),
    );
  }

  void _reportUser() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User reported!')),
    );
  }

  void _blockUser() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User blocked!')),
    );
  }
}
