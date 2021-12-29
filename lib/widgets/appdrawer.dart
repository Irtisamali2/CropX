import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final url =
      "https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/165430968/original/4e18e27e0ec5257a4a3d4fb06583ae443e0f2278/create-wordpress-website-with-responsive-wordpress-design.jpg";
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: Colors.purple),
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.all(0),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.purple),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(url),
                  ),
                  accountName: Text("Irtisam Ali"),
                  accountEmail: Text("irtisam.ali2@icloud.com"),
                )),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                "HomePage",
                textScaleFactor: 1.1,
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.forward,
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.shop,
                color: Colors.white,
              ),
              title: Text(
                "CartPage",
                textScaleFactor: 1.1,
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.forward,
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text(
                "Profile",
                textScaleFactor: 1.1,
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.forward,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
