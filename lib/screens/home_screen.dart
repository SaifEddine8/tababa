import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tababa/constant/constant_colors.dart';
import 'package:tababa/models/clinic_model.dart';
import 'package:tababa/widgets/category_widget.dart';
import 'package:tababa/widgets/clinic_card.dart';
import 'package:tababa/widgets/custom_form_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
List<String>categories=[
      'الكل',
      'اسنان',
      'سكري',
      'عظام',
      'جلدية وتجميل'
    ];
class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  String selectedItem=categories[0];
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    
    
    TextEditingController searchController=TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child:SizedBox(
            width: .infinity,
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  child: TextField(
                    // textDirection: .rtl,
                    textAlign: .end,
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'بحث',
                      suffixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    itemCount: categories.length,
                    itemExtent: 150,
                    
                    itemBuilder:(context,index)=>CategoryWidget(
                      category: categories[index],
                      textColor: selectedItem==categories[index]?
                      ConstantColors.tertiary
                      :
                      ConstantColors.primary,
                      backgroundColor: selectedItem==categories[index]?
                      ConstantColors.primary
                      :
                      ConstantColors.tertiary,
                      onTap: () => setState(() {
                        selectedItem=categories[index];
                      }),
                      )
                    ),
                ),
                SizedBox(height: size.height*0.02,),
               Expanded(
                child:StreamBuilder(stream: FirebaseFirestore.instance.collection('clinic').snapshots(), 
                builder: (context,clinicSnapshot){
                  if(!clinicSnapshot.hasData)
                  {
                    return Center(child: Text('Nothing'),);
                  }
                  final clinics=clinicSnapshot.data!.docs.map((doc)=>ClinicModel.fromMap(doc.data(), doc.id))
                  .where((doc)=>doc.specialty==selectedItem||selectedItem=='الكل').where((doc)=>doc.clinicName.toLowerCase().contains(searchController.text)).toList();
                  return StreamBuilder(
                    stream:FirebaseFirestore.instance.collection('users').doc(firebaseAuth.currentUser!.uid).collection('favorite').snapshots() , 
                    builder: (context,favsnnapshot){
                      if(!favsnnapshot.hasData)
                      {
                        return Center(child: Text('Nothing'),);
                      }
                      final favId=favsnnapshot.data!.docs.map((f)=>f.id).toSet();
                      final clinicsWithFav=clinics.map((p)=>p.copyWith(isFav: favId.contains(p.id))).toList();
                      return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
                      itemCount: clinicsWithFav.length,
                      
                      itemBuilder: (context,index)=>ClinicCard(clinic: clinicsWithFav[index],
                      onFavoriteTap: () async{
                        if(clinicsWithFav[index].isFav)
                        {
                          FirebaseFirestore.instance.collection('users').doc(firebaseAuth.currentUser!.uid)
                          .collection('favorite').doc(clinicsWithFav[index].id).delete();
                        }
                        else{
                          await addFav(clinicsWithFav[index]);
                        }
            
                      } ,));
                    });
                }
                ) ),
              ],
            ),
          )
           ),
      ),

      
    );
  }
  Future<void>addFav(ClinicModel clinic)async{
    String uid=FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).collection('favorite').doc(clinic.id).set(clinic.toMap());

  }
}