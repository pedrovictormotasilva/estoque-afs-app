import 'package:flutter/material.dart';

class ContainerHomePage extends StatelessWidget {
  final String text;
  final IconData icon;
  final int quantity;
  final VoidCallback onTap;

  const ContainerHomePage({
    Key? key,
    required this.text,
    required this.icon,
    required this.quantity,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 2,
              color: Color(0xFF086632),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quantity.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  text,
                  style: TextStyle(color: Color(0xFF2F7B2B), fontSize: 14),
                ),
              ],
            ),
            Spacer(),
            CircleAvatar(
              backgroundColor: Color(0xFF086632),
              child: Icon(icon, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
