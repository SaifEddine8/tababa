import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tababa/constant/constant_colors.dart';
import 'package:tababa/models/clinic_model.dart'; 

class FavoriteClinicCard extends StatelessWidget {
  final ClinicModel clinic;
  final VoidCallback onTap;
  final VoidCallback? onFavoritePressed; 

  const FavoriteClinicCard({
    Key? key,
    required this.clinic,
    required this.onTap,
    this.onFavoritePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image(
                    image: clinic.imageUrls.startsWith('http')
                        ? NetworkImage(clinic.imageUrls) as ImageProvider
                        : FileImage(File(clinic.imageUrls)),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[100],
                      child: Icon(Icons.local_hospital_outlined, color: ConstantColors.primary),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clinic.clinicName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 13, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'د. ${clinic.doctorName}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // العنوان
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 13, color: ConstantColors.primary),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              clinic.address,
                              style: TextStyle(
                                fontSize: 12,
                                color: ConstantColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.pink,
                  ),
                  onPressed: onFavoritePressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}