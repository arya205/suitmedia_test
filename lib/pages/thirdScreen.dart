import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart' show Provider;
import 'dart:convert';

import 'package:suitmedia_test/pages/nameProvider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  void setName(String name) {
    Provider.of<NameProvider>(context, listen: false).setName(name);
    Get.snackbar('Name Changed', 'Name set to $name');
  }

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=1&per_page=10'),
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Third Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<List<dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final user = data[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user['avatar']),
                    ),
                    title: Text('${user['first_name']} ${user['last_name']}'),
                    subtitle: Text(user['email']),
                    onTap: () =>
                        setName('${user['first_name']} ${user['last_name']}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
