import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/status_controller.dart';
import '../widgets/custom_appbar.dart';
import '../screens/image_tab.dart';
import '../screens/video_tab.dart';
import '../screens/saved_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<StatusController>(context);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Status Saver'),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [Tab(text: 'Images'), Tab(text: 'Videos'), Tab(text: 'Saved')],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [ImageTab(), VideoTab(), SavedScreen()],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final found = await controller.scan();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Found ${found.length} status files')));
        },
        child: const Icon(Icons.refresh),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (i) {
          if (i == 1) Navigator.pushNamed(context, '/');
          if (i == 2) Navigator.pushNamed(context, '/settings');
        },
      ),
    );
  }
}
