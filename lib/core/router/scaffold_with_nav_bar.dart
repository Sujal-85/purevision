import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  bool _onScroll(UserScrollNotification notification) {
    if (notification.direction == ScrollDirection.reverse && _isVisible) {
      _controller.forward();
      setState(() => _isVisible = false);
    } else if (notification.direction == ScrollDirection.forward &&
        !_isVisible) {
      _controller.reverse();
      setState(() => _isVisible = true);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final isPlayScreen = widget.navigationShell.currentIndex == 1;

    return NotificationListener<UserScrollNotification>(
      onNotification: _onScroll,
      child: Scaffold(
        extendBody: true,
        body: widget.navigationShell,
        bottomNavigationBar: SlideTransition(
          position: _offsetAnimation,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: isPlayScreen
                      ? Colors.black.withOpacity(0.3)
                      : Colors.black12,
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: NavigationBar(
                selectedIndex: widget.navigationShell.currentIndex,
                onDestinationSelected: (index) => _onTap(context, index),
                backgroundColor: isPlayScreen ? Colors.black : Colors.white,
                elevation: 0,
                indicatorColor: isPlayScreen
                    ? AppColors.primaryBlue.withOpacity(0.2)
                    : AppColors.primaryBlue.withOpacity(0.1),
                destinations: [
                  _buildNavDestination(
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home,
                    label: 'Home',
                    isDark: isPlayScreen,
                  ),
                  _buildNavDestination(
                    icon: Icons.play_circle_outline,
                    selectedIcon: Icons.play_circle_filled,
                    label: 'Play',
                    isDark: isPlayScreen,
                  ),
                  _buildNavDestination(
                    icon: Icons.grid_view_outlined,
                    selectedIcon: Icons.grid_view,
                    label: 'Categories',
                    isDark: isPlayScreen,
                  ),
                  _buildNavDestination(
                    icon: Icons.shopping_cart_outlined,
                    selectedIcon: Icons.shopping_cart,
                    label: 'Cart',
                    isDark: isPlayScreen,
                  ),
                  _buildNavDestination(
                    icon: Icons.person_outline,
                    selectedIcon: Icons.person,
                    label: 'Account',
                    isDark: isPlayScreen,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  NavigationDestination _buildNavDestination({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required bool isDark,
  }) {
    final color = isDark ? Colors.white : AppColors.primaryBlue;
    final unselectedColor = isDark ? Colors.grey : Colors.black54;

    return NavigationDestination(
      icon: Icon(icon, color: unselectedColor),
      selectedIcon: Icon(selectedIcon, color: color),
      label: label,
    );
  }
}
