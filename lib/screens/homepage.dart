import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:outshade/screens/profile.dart';

import '../models/user_list.dart';
import '../services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _ageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  var detailsBox = Hive.box('userDetails');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getUsers(),
        builder: (context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 1,
                );
              },
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var otherData = detailsBox.get(snapshot.data![index].id);
                return ListTile(
                  leading: CircleAvatar(
                    // random color
                    backgroundColor: Colors.primaries[index % Colors.primaries.length],
                    child: Text(
                      snapshot.data![index].name[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(snapshot.data![index].atype),
                  onTap: () {
                    if (otherData == null) {
                      detailsDialog(context, snapshot, index);
                    } else {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => ProfilePage(id: snapshot.data![index].id)));
                    }
                  },
                  trailing: ElevatedButton(
                    style: otherData != null
                        ? ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.purple,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              side: BorderSide(
                                color: Colors.purple,
                              ),
                            ))
                        : ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple[600],
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                    onPressed: () {
                      if (otherData == null) {
                        detailsDialog(context, snapshot, index);
                      } else {
                        detailsBox.delete(snapshot.data![index].id);
                      }
                    },
                    child: Text(otherData == null ? 'Sign In' : 'Sign Out'),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<dynamic> detailsDialog(BuildContext context, AsyncSnapshot<List<User>> snapshot, int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Details"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    hintText: "Enter Age",
                  ),
                ),
                TextField(
                  controller: _genderController,
                  decoration: InputDecoration(
                    hintText: "Enter Gender",
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  detailsBox.put(snapshot.data![index].id, {
                    "age": _ageController.text,
                    "gender": _genderController.text,
                    "name": snapshot.data![index].name,
                    "atype": snapshot.data![index].atype
                  });
                  setState(() {});
                  _ageController.clear();
                  _genderController.clear();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => ProfilePage(id: snapshot.data![index].id)));
                },
                child: Text("Sign In"),
              ),
            ],
          );
        });
  }
}
