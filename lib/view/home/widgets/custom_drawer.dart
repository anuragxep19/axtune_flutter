import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(132, 38, 208, 205),
              Color.fromARGB(122, 26, 41, 128),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(top: 50, bottom: 20),
              height: 150,
              child: Center(
                child: Icon(Icons.music_note, size: 80, color: Colors.white),
              ),
            ),
            _IconText(
              title: 'Home',
              icon: Icons.home_outlined,
              onTap: () => Navigator.of(context).pop(),
            ),
            _IconText(
              onTap: () {},
              icon: Icons.settings_outlined,
              title: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _IconText({
    required this.title,
    required this.icon,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 30),
            SizedBox(width: 30),
            Text(title, style: TextStyle(color: Colors.black, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
