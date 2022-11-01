import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProfilePage extends StatelessWidget {
  final String id;
  const ProfilePage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('userDetails');
    final data = box.get(id);
    final name = data['name'];
    final gender = data['gender'];
    final age = data['age'];
    final type = data['atype'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text(
                    name[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                dataRow('Name', name),
                dataRow('Age', age),
                dataRow('Gender', gender),
                dataRow('Account Type', type),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dataRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        const SizedBox(width: 10),
        Text(value),
      ],
    );
  }
}
