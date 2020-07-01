import 'package:app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> with TickerProviderStateMixin {
  String name;
  String imageUrl;
  String uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Animation<int> _characterCount;

  int _stringIndex;
  static const List<String> _kStrings = const <String>[
    'Let your thoughts run free ...',
  ];
  String get _currentString => _kStrings[_stringIndex % _kStrings.length];

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);
    uid = user.uid;
    name = user.displayName;
    imageUrl = user.photoUrl;
    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    AnimationController controller = new AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );
    setState(() {
      _stringIndex = _stringIndex == null ? 0 : _stringIndex + 1;
      _characterCount = new StepTween(begin: 0, end: _currentString.length)
          .animate(
              new CurvedAnimation(parent: controller, curve: Curves.easeIn));
    });
    await controller.forward();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF7F8F3),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/drabble_icon.png"),
                height: 75.0,
              ),
              SizedBox(height: 25),
              Image(
                image: AssetImage("assets/images/drabble.png"),
                height: 100.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
                child: _characterCount == null
                    ? null
                    : AnimatedBuilder(
                        animation: _characterCount,
                        builder: (BuildContext context, Widget child) {
                          String text = _currentString.substring(
                              0, _characterCount.value);
                          return Text(
                            text,
                            style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),
                          );
                        },
                      ),
              ),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return HomePage(
                    title: "Drabbles",
                    uid: uid,
                    name: name,
                    imageUrl: imageUrl);
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Color(0xFF2C3D63)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
