// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskPage extends StatelessWidget {
  // const TaskPage({super.key});

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void update(String id, bool finished) {
    firestore.collection('Tasks').doc(id).update({'finished': finished});
  }

  void delete(String id) {
    firestore.collection('Tasks').doc(id).delete();
  }

  void logout(BuildContext context) async {
    try {
      await auth.signOut();

      Navigator.of(context).pushNamed('/a');
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Task Page'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                heroTag: 'btnX',
                onPressed: () => logout(context),
                backgroundColor: Colors.black26,
                elevation: 0,
                child: Icon(Icons.logout),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: firestore
                    .collection('Tasks')
                    .where('uid', isEqualTo: auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var tasks = snapshot.data!.docs;

                  return ListView(
                    children: tasks
                        .map((task) => Dismissible(
                              key: Key(task.id),
                              onDismissed: (_) => delete(task.id),
                              background: Container(color: Colors.red),
                              child: CheckboxListTile(
                                title: Text(task['name']),
                                onChanged: (value) => update(task.id, value!),
                                value: task['finished'],
                              ),
                            ))
                        .toList(),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add Task',
          onPressed: () {
            Navigator.of(context).pushNamed('/c');
          },
          child: Icon(Icons.add),
        ));
  }
}
