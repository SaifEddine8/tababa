import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tababa/constant/constant_colors.dart';
import 'package:tababa/constant/constant_style.dart';
import 'package:tababa/models/clinic_model.dart';

class AddClinicScreen extends StatefulWidget {
  const AddClinicScreen({super.key});

  @override
  State<AddClinicScreen> createState() => _AddClinicScreenState();
}
List<String>categories=[
      
      'اسنان',
      'سكري',
      'عظام',
      'جلدية وتجميل'
    ];
class _AddClinicScreenState extends State<AddClinicScreen> {
  //Controllers الحقول النصية
  final TextEditingController _clinicNameController = TextEditingController();
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool isLoading=false;
  File? _selectedImage;
final ImagePicker _picker = ImagePicker();

  // متغير الاختصاص
  String? _selectedSpecialty=categories[0];
  

  // أيام الدوام
  final Map<String, bool> _workDays = {
    'الأحد': false,
    'الإثنين': false,
    'الثلاثاء': false,
    'الأربعاء': false,
    'الخميس': false,
    'الجمعة': false,
    'السبت': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('إضافة عيادة جديدة',style: ConstantStyle.title.copyWith(color: Colors.white),),
        centerTitle: true,
        backgroundColor: ConstantColors.primary // Primary Color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _clinicNameController,
              decoration: const InputDecoration(
                labelText: 'اسم العيادة',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _doctorNameController,
              decoration: const InputDecoration(
                labelText: 'اسم الطبيب',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: _selectedSpecialty,
              hint: const Text('اختر الاختصاص الطبي'),
              items: categories.map((String specialty) {
                return DropdownMenuItem<String>(
                  value: specialty,
                  child: Text(specialty),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSpecialty = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _bioController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'نبذة عن العيادة والخدمات المقدمة',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'عنوان العيادة (المدينة، الشارع)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'أيام الدوام:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ..._workDays.keys.map((String day) {
              return CheckboxListTile(
                title: Text(day),
                value: _workDays[day],
                onChanged: (bool? value) {
                  setState(() {
                    _workDays[day] = value ?? false;
                  });
                },
              );
            }).toList(),
            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: () async{
                final XFile? image=await _picker.pickImage(source: ImageSource.gallery);
                if(image!=null)
                {
                  setState(() {
                    _selectedImage=File(image.path);
                  });
                }
              },
              icon: const Icon(Icons.image),
              label: const Text('إضافة صور العيادة'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ConstantColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async{
                List<String> activeWorkDays = _workDays.entries
                  .where((entry) => entry.value)
                  .map((entry) => entry.key)
                  .toList();
                ClinicModel clinic=ClinicModel(id: FirebaseFirestore.instance.collection('clinic').id, 
                ownerId: FirebaseAuth.instance.currentUser!.uid, 
                clinicName: _clinicNameController.text, 
                doctorName: _doctorNameController.text, 
                specialty: _selectedSpecialty!, 
                bio: _bioController.text, 
                address: _addressController.text, 
                workDays: activeWorkDays, 
                imageUrls: _selectedImage!.path);
                setState(() {
                        isLoading=!isLoading;
                        });
                await addClinic(clinic);
                setState(() {
                        isLoading=!isLoading;
                        });
              },
              child:isLoading?CircularProgressIndicator(): Text('حفظ',style: ConstantStyle.subtitle.copyWith(color: Colors.white),), 
            ),
          ],
        ),
      ),
    );

    
  }
Future<void>addClinic(ClinicModel clinic)async{
  final docRef=FirebaseFirestore.instance.collection('clinic').doc();
  clinic=clinic.copyWith(id:docRef.id );
  await docRef.set(clinic.toMap());
}





  
}