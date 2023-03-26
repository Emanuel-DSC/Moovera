import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

cancelChanges(email, image) {
    final user = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance.collection('Users').doc(user).set({
      'Email': email,
      'ProfilePicture': image,
    });
  }