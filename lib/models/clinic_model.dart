class ClinicModel {
  final String id;               
  final String ownerId;           
  final String clinicName;        
  final String doctorName;        
  final String specialty;        
  final String bio;               
  final String address;           
  final List<String> workDays;    
  final String imageUrls;   
  final bool isFav;

  ClinicModel({
    required this.id,
    required this.ownerId,
    required this.clinicName,
    required this.doctorName,
    required this.specialty,
    required this.bio,
    required this.address,
    required this.workDays,
    required this.imageUrls,
    this.isFav=false
  });

  ClinicModel copyWith({
    String? id,
    String? ownerId,
    String? clinicName,
    String? doctorName,
    String? specialty,
    String? bio,
    String? address,
    List<String>? workDays,
    String? imageUrls,
    bool?isFav
  }) {
    return ClinicModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      clinicName: clinicName ?? this.clinicName,
      doctorName: doctorName ?? this.doctorName,
      specialty: specialty ?? this.specialty,
      bio: bio ?? this.bio,
      address: address ?? this.address,
      workDays: workDays ?? this.workDays,
      imageUrls: imageUrls ?? this.imageUrls,
      isFav: isFav??this.isFav
    );
  }

  factory ClinicModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ClinicModel(
      id: documentId,
      ownerId: map['ownerId'],
      clinicName: map['clinicName'],
      doctorName: map['doctorName'],
      specialty: map['specialty'],
      bio: map['bio'],
      address: map['address'],
      workDays: List<String>.from(map['workDays']),
      imageUrls: map['imageUrls'],
      isFav: map['isFav']
      );
      
  }
    
  

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'clinicName': clinicName,
      'doctorName': doctorName,
      'specialty': specialty,
      'bio': bio,
      'address': address,
      'workDays': workDays,
      'imageUrls': imageUrls,
      'isFav':isFav
    };
  }
}