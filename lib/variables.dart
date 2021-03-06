import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle myTextStyle(double size, [Color color, FontWeight fw = FontWeight.w700,]){
  return  GoogleFonts.roboto(
    fontSize: size,
    color: color,
    fontWeight: fw,
  );
}

CollectionReference userCollection = FirebaseFirestore.instance.collection('users');