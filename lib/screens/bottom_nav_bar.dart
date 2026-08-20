import 'package:flutter/material.dart';

import '../routes/routes_name.dart';
import 'dailystreak_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
       color: Color(0xff142B56),
      elevation: 12,

      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            _NavItem(
              icon: Icons.home_rounded,
              title: "Home",
              isSelected: true,
              onTap: (){
                Navigator.pushNamed(context, RouteName.homeScreen);
              },
            ),

            _NavItem(
              icon: Icons.menu_book_rounded,
              title: "Chapters",
              onTap: (){
                Navigator.pushNamed(context, RouteName.audio);
              },


            ),

            const SizedBox(width: 45),

            _NavItem(
              icon: Icons.local_fire_department_outlined,
              title: "Streak",
                onTap: () {
                  Navigator.pushNamed(context, RouteName.dailystreakscreen);
                }
            ),

            _NavItem(
              icon: Icons.person_outline_rounded,
              title: "Profile",
                onTap: () {
                  Navigator.pushNamed(context, RouteName.profileScreen);
                }
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.title,
    this.isSelected = false, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            color: isSelected
                ? const Color(0xffD4A64A)
                : Colors.grey,
            size: 28,
          ),

          const SizedBox(height: 5),

          Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xffD4A64A)
                  : Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}