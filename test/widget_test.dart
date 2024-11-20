import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(onThemeChanged: (ThemeMode mode) {
        setState(() {
          _themeMode = mode;
        });
      }),
    );
  }
}

class LoginPage extends StatelessWidget {
  final Function(ThemeMode) onThemeChanged;

  const LoginPage({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Select Theme'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        try {
                          Navigator.of(context).pop();
                          onThemeChanged(
                              ThemeMode.light); // Switch to light mode
                        } catch (e) {
                          // Handle error gracefully
                          debugPrint("Error switching to light mode: $e");
                        }
                      },
                      child: const Text('Light Mode'),
                    ),
                    TextButton(
                      onPressed: () {
                        try {
                          Navigator.of(context).pop();
                          onThemeChanged(ThemeMode.dark); // Switch to dark mode
                        } catch (e) {
                          // Handle error gracefully
                          debugPrint("Error switching to dark mode: $e");
                        }
                      },
                      child: const Text('Dark Mode'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add logo here
            Image.asset(
              'asset/logo.jpeg', // Path to the logo image in your assets
              height: 100, // Adjust the size of the logo as needed
            ),
            const SizedBox(
                height: 20), // Space between the logo and the text fields
            const TextField(
              decoration: InputDecoration(labelText: 'Username'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    try {
                      // Add login logic here
                    } catch (e) {
                      debugPrint("Error during login: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    try {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupPage()),
                      );
                    } catch (e) {
                      debugPrint("Error navigating to signup: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Signup'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Username'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Cell Number'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                try {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GroupDiscussionPage()),
                  );
                } catch (e) {
                  debugPrint("Error navigating to Group Discussion Page: $e");
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupDiscussionPage extends StatefulWidget {
  const GroupDiscussionPage({super.key});

  @override
  _GroupDiscussionPageState createState() => _GroupDiscussionPageState();
}

class _GroupDiscussionPageState extends State<GroupDiscussionPage> {
  List<Map<String, String>> messages = [];
  final TextEditingController messageController = TextEditingController();
  final String userName = "User";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Discussion'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onDoubleTap: () {
                            try {
                              _showDeleteDialog(
                                  index); // Show delete dialog on double tap
                            } catch (e) {
                              debugPrint("Error showing delete dialog: $e");
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  messages[index]['user']!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  messages[index]['message']!,
                                ),
                                Text(
                                  messages[index]['time']!,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    try {
                      if (messageController.text.isNotEmpty) {
                        setState(() {
                          String time =
                              '${DateTime.now().hour}:${DateTime.now().minute}';
                          messages.add({
                            'user': userName,
                            'message': messageController.text,
                            'time': time,
                          });
                          messageController.clear();
                        });
                      }
                    } catch (e) {
                      debugPrint("Error sending message: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Message'),
          content: const Text('Are you sure you want to delete this message?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                try {
                  setState(() {
                    messages.removeAt(index); // Remove the message
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  debugPrint("Error deleting message: $e");
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
