import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import 'package:toko_football/screens/menu.dart';
import 'package:toko_football/screens/productlist_form.dart';
import 'package:toko_football/screens/product_entry_list.dart';
// If you navigate directly to a LoginPage widget, import it:
// import 'package:toko_football/screens/login.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Text(
                  'Toko Football',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Seluruh berita sepak bola terkini di sini!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Create Product'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProductFormPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.add_reaction_rounded),
            title: const Text('News List'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductEntryListPage()),
              );
            },
          ),

          const Divider(),

          // LOGOUT BUTTON
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              // Close the drawer immediately for nicer UX
              Navigator.pop(context);

              try {
                // Call the logout endpoint that clears session on server
                // Adjust the URL if your logout endpoint is different
                final resp = await request.logout("http://localhost:8000/auth/logout/");

                // The logout helper may return different shapes:
                // - pbp_django_auth's logout often returns {"status": true} or similar
                // - If your backend returns {"status": "success"}, adapt condition below
                final bool loggedOut = (resp is Map && (resp['status'] == true || resp['status'] == 'success'));

                if (loggedOut) {
                  // Show confirmation
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Logged out successfully.")),
                    );
                  }

                  // Option A: navigate to named route '/login' and clear history
                  // (Preferred if you registered routes in MaterialApp)
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  }

                  // Option B: OR navigate directly to LoginPage widget and clear history
                  // Uncomment if you don't use named routes and have LoginPage class.
                  /*
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                      (route) => false,
                    );
                  }
                  */
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Logout failed. Please try again.")),
                    );
                  }
                }
              } catch (e) {
                // network / unexpected error
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error during logout: $e")),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
