import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'nameProvider.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _palindromeController = TextEditingController();

  void setName(String name) {
    if (name.isEmpty) {
      Get.snackbar('Invalid', 'Please enter a name');
      return;
    }

    Provider.of<NameProvider>(context, listen: false).setName(name);
    Get.toNamed('/second');
  }

  void isPalindrome(String text) {
    if (text.isEmpty) {
      Get.snackbar('Invalid', 'Please enter a text to check');
      return;
    }
    String cleanedText = text.replaceAll(RegExp(r'[\W_]+'), '').toLowerCase();
    String reversedText = cleanedText.split('').reversed.join('');
    if (cleanedText == reversedText) {
      Get.snackbar('Result', 'The text is a palindrome');
    } else {
      Get.snackbar('Result', 'The text is not a palindrome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 70,
                backgroundColor: Color.fromRGBO(255, 255, 255, 0.4),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.person, size: 50, color: Colors.white),
                    Positioned(
                      right: 0,
                      child: Icon(Icons.add, size: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: _palindromeController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Palindrome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),

                    ElevatedButton(
                      onPressed: () {
                        isPalindrome(_palindromeController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Color(0xFF2B637B),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'CHECK',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        setName(_nameController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Color(0xFF2B637B),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'NEXT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
