import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tababa/models/clinic_model.dart';
import 'package:tababa/widgets/favorite_clinic_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder(stream: FirebaseFirestore.instance.collection('users').doc(firebaseAuth.currentUser!.uid).collection('favorite').snapshots(), 
    builder: (context,snapshot)
    {
      if(snapshot.connectionState==ConnectionState.waiting)
      {
        return Center(child: CircularProgressIndicator(),);

      }
      else if(snapshot.data!.docs.isEmpty)
      {
        return Center(child: Text('favorite screen is empty'),);
      }
      final favorites=snapshot.data!.docs.map((fav)=>ClinicModel.fromMap(fav.data(), fav.id)).toList();
      return ListView.builder(
        itemCount:favorites.length ,
        itemBuilder:(context,index)=>FavoriteClinicCard(clinic: favorites[index], onTap: (){},onFavoritePressed: () {
           FirebaseFirestore.instance.collection('users').doc(firebaseAuth.currentUser!.uid).collection('favorite').doc(favorites[index].id).delete();
        },)
         );
    })
    ;
  }
}