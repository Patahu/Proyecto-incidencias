// imports
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../util/authUser.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firebaseFirestore;
  // constructor
  UserRepository(
      {FirebaseAuth? firebaseAuth,
      GoogleSignIn? googleSignIn,
      FirebaseFirestore? firebaseFirestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  // Sing In With Google
  Future<void> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser;

      googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);

      final auis = _firebaseAuth.currentUser;

      DocumentSnapshot doc =
          await _firebaseFirestore.collection("users").doc(auis!.uid).get();
      if (!doc.exists) {
        crearUsuarioDb(auis.email, auis.displayName, '','');
      }


  }
  Future<void> actualizarUsuario({required String idUsuario,required Map<String, Object?> ejecucion}) async {
    await _firebaseFirestore.collection('users').doc(idUsuario).update(ejecucion);
  }

  // Sing In With Credentials
  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  // SingUp - Registro
  Future<UserCredential> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // SingOut
  Future<Future<List<void>>> signOut() async {
    return Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  // Esta logueado?
  Future<bool> isSignedIn() async {
    final user = _firebaseAuth.currentUser;
    return user != null;
  }

  Future<AuthUser?> getUsuario() async {
    final userr = _firebaseAuth.currentUser;
    DocumentSnapshot doc =
        await _firebaseFirestore.collection("users").doc(userr?.uid).get();
    if (doc.exists) {
      final userss = AuthUser(
          userr!.uid, doc['nombre'], doc['correo'], '${doc['numero']}',doc['DNI']);
      return userss;
    }
    return null;
  }

  Future<void> crearUsuarioDb(
      String? correo, String? nombre, String? numero,String? DNI) async {
    _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser?.uid)
        .set({
      'idUsuario': _firebaseAuth.currentUser?.uid,
      'nombre': nombre,
      'correo': correo,
      'numero': numero,
      'DNI': DNI
    });
  }

  Future<void> resetPassDB(String correo) async {
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: correo.trim());
    }on FirebaseAuthException catch(e){
      print(e);

    }

  }
}
