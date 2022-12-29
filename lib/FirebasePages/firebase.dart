import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Fire extends StatelessWidget {
  const Fire({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Firebase Authentication'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<FirebaseApp> _firebaseApp;
  bool isLoggedIn = false;
  String? name;

  @override
  void initState() {
    super.initState();
    _firebaseApp = Firebase.initializeApp();
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      isLoggedIn = false;
      name = " ";
    });
  }

  void googleSignIn() async {
    final googleSignIn = GoogleSignIn();
    final signInAccount = await googleSignIn.signIn();

    final googleAccountAuthentication = await signInAccount?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAccountAuthentication?.accessToken,
        idToken: googleAccountAuthentication?.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    if (FirebaseAuth.instance.currentUser != null) {
      // print('Google Authentication Successful');
      // print('${FirebaseAuth.instance.currentUser?.displayName} signed in.');
      setState(() {
        isLoggedIn = true;
        // name = FirebaseAuth.instance.currentUser?.displayName;
      });
    } else {
      // print('Unable to sign in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: _firebaseApp,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                  child: ElevatedButton(
                onPressed: () {
                  googleSignIn();
                },
                child: const Text('Tap..'),
              ));
            }
          }),
    );
  }
}
