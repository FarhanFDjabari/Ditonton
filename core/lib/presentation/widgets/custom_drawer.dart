import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;

  CustomDrawer({required this.content});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _drawerController;

  Widget _buildDrawer() {
    return Column(
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://d17ivq9b7rppb3.cloudfront.net/original/jobs/turut_berkontribusi_memajungan_dunia_it_di_indonesia_270619074639.jpeg'),
          ),
          accountName: Text('Ditonton'),
          accountEmail: Text('ditonton@dicoding.com'),
        ),
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text('Movies'),
          onTap: () {
            Navigator.pushReplacementNamed(context, HOME_ROUTE_NAME);
            _drawerController.reverse();
          },
        ),
        ListTile(
          leading: const Icon(Icons.tv),
          title: const Text('Tv Series'),
          onTap: () {
            Navigator.pushReplacementNamed(context, HOME_TV_ROUTE_NAME);
            _drawerController.reverse();
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Watchlist'),
          onTap: () {
            Navigator.pushNamed(context, WATCHLIST_ROUTE);
            _drawerController.reverse();
          },
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, ABOUT_ROUTE);
            _drawerController.reverse();
          },
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _drawerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _drawerController.dispose();
  }

  void onDrawerTap() => _drawerController.isDismissed
      ? _drawerController.forward()
      : _drawerController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDrawerTap,
      child: AnimatedBuilder(
        animation: _drawerController,
        builder: (context, child) {
          double slide = 255.0 * _drawerController.value;
          double scale = 1 - (_drawerController.value * 0.3);
          return Stack(
            children: [
              _buildDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: widget.content,
              ),
            ],
          );
        },
      ),
    );
  }
}
