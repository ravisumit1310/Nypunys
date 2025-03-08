class StudentDetailsModel {
  String name;
  String email;
  int classId;
  String gender;
  DateTime dateOfBirth;
  String placeOfBirth;
  int age;
  String nationality;
  String motherTongue;
  String languagesKnown;
  String contactAddress;
  String permanentAddress;
  String contactNo;
  String whatsappNo;
  String adharCardNo;
  String caste;
  String subCaste;
  String socialCategory;
  DateTime dateOfJoining;
  String classOfJoining;
  String admissionNo;
  String penNo;
  String satasNo;
  String affiliationNo;
  String previousSchoolName;
  String languageStudiedFirst;
  String languageStudiedSecond;
  String languageStudiedThird;
  String reasonForChange;
  String fathersName;
  String fathersQualification;
  String fathersOccupation;
  String fathersMobile;
  String fathersEmail;
  String fathersAdharNo;
  double fathersAnnualIncome;
  String mothersName;
  String mothersQualification;
  String mothersOccupation;
  String mothersMobile;
  String mothersEmail;
  String mothersAdharNo;
  double mothersAnnualIncome;
  String guardiansName;
  String guardiansQualification;
  String guardiansOccupation;
  String guardiansMobile;
  String guardiansEmail;
  String guardiansAdharNo;
  double guardiansAnnualIncome;
  List<String> guardiansSiblingDetails;
  String bloodGroup;
  double height;
  double weight;
  String allergyAilment;
  String doctorAdvice;
  String specificDiet;
  String pediatricianName;
  String pediatricianContact;
  String password;
  String className; // ✅ Fixed casing
  String section;
  int adminId;
  int teacherId;

  StudentDetailsModel({
    required this.name,
    required this.email,
    required this.classId,
    required this.gender,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.age,
    required this.nationality,
    required this.motherTongue,
    required this.languagesKnown,
    required this.contactAddress,
    required this.permanentAddress,
    required this.contactNo,
    required this.whatsappNo,
    required this.adharCardNo,
    required this.caste,
    required this.subCaste,
    required this.socialCategory,
    required this.dateOfJoining,
    required this.classOfJoining,
    required this.admissionNo,
    required this.penNo,
    required this.satasNo,
    required this.affiliationNo,
    required this.previousSchoolName,
    required this.languageStudiedFirst,
    required this.languageStudiedSecond,
    required this.languageStudiedThird,
    required this.reasonForChange,
    required this.fathersName,
    required this.fathersQualification,
    required this.fathersOccupation,
    required this.fathersMobile,
    required this.fathersEmail,
    required this.fathersAdharNo,
    required this.fathersAnnualIncome,
    required this.mothersName,
    required this.mothersQualification,
    required this.mothersOccupation,
    required this.mothersMobile,
    required this.mothersEmail,
    required this.mothersAdharNo,
    required this.mothersAnnualIncome,
    required this.guardiansName,
    required this.guardiansQualification,
    required this.guardiansOccupation,
    required this.guardiansMobile,
    required this.guardiansEmail,
    required this.guardiansAdharNo,
    required this.guardiansAnnualIncome,
    required this.guardiansSiblingDetails,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.allergyAilment,
    required this.doctorAdvice,
    required this.specificDiet,
    required this.pediatricianName,
    required this.pediatricianContact,
    required this.password,
    required this.className, // ✅ Added class_name
    required this.section, // ✅ Added section
    required this.adminId,
    required this.teacherId,
  });

  factory StudentDetailsModel.fromJson(Map<String, dynamic> json) {
    return StudentDetailsModel(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      classId: json["class_id"] ?? 0,
      gender: json["gender"] ?? "",
      dateOfBirth: json["date_of_birth"] != null
          ? DateTime.parse(json["date_of_birth"])
          : DateTime(2000, 1, 1),
      placeOfBirth: json["place_of_birth"] ?? "",
      age: json["age"] ?? 0,
      nationality: json["nationality"] ?? "",
      motherTongue: json["mother_tongue"] ?? "",
      languagesKnown: json["languages_known"] ?? "",
      contactAddress: json["contact_address"] ?? "",
      permanentAddress: json["permanent_address"] ?? "",
      contactNo: json["contact_no"] ?? "",
      whatsappNo: json["whatsapp_no"] ?? "",
      adharCardNo: json["adhar_card_no"] ?? "",
      caste: json["caste"] ?? "",
      subCaste: json["sub_caste"] ?? "",
      socialCategory: json["social_category"] ?? "",
      dateOfJoining: json["date_of_joining"] != null
          ? DateTime.parse(json["date_of_joining"])
          : DateTime(2000, 1, 1),
      classOfJoining: json["class_of_joining"] ?? "",
      admissionNo: json["admission_no"] ?? "",
      penNo: json["pen_no"] ?? "",
      satasNo: json["satas_no"] ?? "",
      affiliationNo: json["affiliation_no"] ?? "",
      previousSchoolName: json["previous_school_name"] ?? "",
      languageStudiedFirst: json["language_studied_first"] ?? "",
      languageStudiedSecond: json["language_studied_second"] ?? "",
      languageStudiedThird: json["language_studied_third"] ?? "",
      reasonForChange: json["reason_for_change"] ?? "",
      fathersName: json["fathers_name"] ?? "",
      fathersQualification: json["fathers_qualification"] ?? "",
      fathersOccupation: json["fathers_occupation"] ?? "",
      fathersMobile: json["fathers_mobile"] ?? "",
      fathersEmail: json["fathers_email"] ?? "",
      fathersAdharNo: json["fathers_adhar_no"] ?? "",
      fathersAnnualIncome: json["fathers_annual_income"]?.toDouble() ?? 0.0,
      mothersName: json["mothers_name"] ?? "",
      mothersQualification: json["mothers_qualification"] ?? "",
      mothersOccupation: json["mothers_occupation"] ?? "",
      mothersMobile: json["mothers_mobile"] ?? "",
      mothersEmail: json["mothers_email"] ?? "",
      mothersAdharNo: json["mothers_adhar_no"] ?? "",
      mothersAnnualIncome: json["mothers_annual_income"]?.toDouble() ?? 0.0,
      guardiansName: json["guardians_name"] ?? "",
      guardiansQualification: json["guardians_qualification"] ?? "",
      guardiansOccupation: json["guardians_occupation"] ?? "",
      guardiansMobile: json["guardians_mobile"] ?? "",
      guardiansEmail: json["guardians_email"] ?? "",
      guardiansAdharNo: json["guardians_adhar_no"] ?? "",
      guardiansAnnualIncome: json["guardians_annual_income"]?.toDouble() ?? 0.0,
      guardiansSiblingDetails: json["guardians_sibling_details"] != null
          ? List<String>.from(
              (json["guardians_sibling_details"] as List)
                  .map((x) => x?.toString() ?? ""),
            )
          : [],
      bloodGroup: json["blood_group"] ?? "",
      height: json["height"]?.toDouble() ?? 0.0,
      weight: json["weight"]?.toDouble() ?? 0.0,
      allergyAilment: json["allergy_ailment"] ?? "",
      doctorAdvice: json["doctor_advice"] ?? "",
      specificDiet: json["specific_diet"] ?? "",
      pediatricianName: json["pediatrician_name"] ?? "",
      pediatricianContact: json["pediatrician_contact"] ?? "",
      password: json["password"] ?? "",
      className: json["class_name"] ?? "", // ✅ Now included
      section: json["section"] ?? "", // ✅ Now included
      adminId: json["admin_id"] ?? 0,
      teacherId: json["teacher_id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "class_id": classId,
        "gender": gender,
        "date_of_birth": dateOfBirth.toIso8601String(),
        "place_of_birth": placeOfBirth,
        "age": age,
        "nationality": nationality,
        "mother_tongue": motherTongue,
        "languages_known": languagesKnown,
        "contact_address": contactAddress,
        "permanent_address": permanentAddress,
        "contact_no": contactNo,
        "whatsapp_no": whatsappNo,
        "adhar_card_no": adharCardNo,
        "caste": caste,
        "sub_caste": subCaste,
        "social_category": socialCategory,
        "date_of_joining": dateOfJoining.toIso8601String(),
        "class_of_joining": classOfJoining,
        "admission_no": admissionNo,
        "pen_no": penNo,
        "satas_no": satasNo,
        "affiliation_no": affiliationNo,
        "previous_school_name": previousSchoolName,
        "language_studied_first": languageStudiedFirst,
        "language_studied_second": languageStudiedSecond,
        "language_studied_third": languageStudiedThird,
        "reason_for_change": reasonForChange,
        "fathers_name": fathersName,
        "fathers_qualification": fathersQualification,
        "fathers_occupation": fathersOccupation,
        "fathers_mobile": fathersMobile,
        "fathers_email": fathersEmail,
        "fathers_adhar_no": fathersAdharNo,
        "fathers_annual_income": fathersAnnualIncome,
        "mothers_name": mothersName,
        "mothers_qualification": mothersQualification,
        "mothers_occupation": mothersOccupation,
        "mothers_mobile": mothersMobile,
        "mothers_email": mothersEmail,
        "mothers_adhar_no": mothersAdharNo,
        "mothers_annual_income": mothersAnnualIncome,
        "guardians_name": guardiansName,
        "guardians_qualification": guardiansQualification,
        "guardians_occupation": guardiansOccupation,
        "guardians_mobile": guardiansMobile,
        "guardians_email": guardiansEmail,
        "guardians_adhar_no": guardiansAdharNo,
        "guardians_annual_income": guardiansAnnualIncome,
        "guardians_sibling_details":
            List<dynamic>.from(guardiansSiblingDetails.map((x) => x)),
        "blood_group": bloodGroup,
        "height": height,
        "weight": weight,
        "allergy_ailment": allergyAilment,
        "doctor_advice": doctorAdvice,
        "specific_diet": specificDiet,
        "pediatrician_name": pediatricianName,
        "pediatrician_contact": pediatricianContact,
        "password": password,
        "admin_id": adminId,
        "teacher_id": teacherId,
      };
}

// class StudentDetailsModel {
//   String name;
//   String email;
//   int classId;
//   String gender;
//   DateTime dateOfBirth;
//   String placeOfBirth;
//   int age;
//   String nationality;
//   String motherTongue;
//   String languagesKnown;
//   String contactAddress;
//   String permanentAddress;
//   String contactNo;
//   String whatsappNo;
//   String adharCardNo;
//   String caste;
//   String subCaste;
//   String socialCategory;
//   DateTime dateOfJoining;
//   String classOfJoining;
//   String admissionNo;
//   String penNo;
//   String satasNo;
//   String affiliationNo;
//   String previousSchoolName;
//   String languageStudiedFirst;
//   String languageStudiedSecond;
//   String languageStudiedThird;
//   String reasonForChange;
//   String fathersName;
//   String fathersQualification;
//   String fathersOccupation;
//   String fathersMobile;
//   String fathersEmail;
//   String fathersAdharNo;
//   double fathersAnnualIncome;
//   String mothersName;
//   String mothersQualification;
//   String mothersOccupation;
//   String mothersMobile;
//   String mothersEmail;
//   String mothersAdharNo;
//   double mothersAnnualIncome;
//   String guardiansName;
//   String guardiansQualification;
//   String guardiansOccupation;
//   String guardiansMobile;
//   String guardiansEmail;
//   String guardiansAdharNo;
//   double guardiansAnnualIncome;
//   List<String> guardiansSiblingDetails;
//   String bloodGroup;
//   double height;
//   double weight;
//   String allergyAilment;
//   String doctorAdvice;
//   String specificDiet;
//   String pediatricianName;
//   String pediatricianContact;
//   String password;
//   int adminId;
//   int teacherId;
//
//   StudentDetailsModel({
//     required this.name,
//     required this.email,
//     required this.classId,
//     required this.gender,
//     required this.dateOfBirth,
//     required this.placeOfBirth,
//     required this.age,
//     required this.nationality,
//     required this.motherTongue,
//     required this.languagesKnown,
//     required this.contactAddress,
//     required this.permanentAddress,
//     required this.contactNo,
//     required this.whatsappNo,
//     required this.adharCardNo,
//     required this.caste,
//     required this.subCaste,
//     required this.socialCategory,
//     required this.dateOfJoining,
//     required this.classOfJoining,
//     required this.admissionNo,
//     required this.penNo,
//     required this.satasNo,
//     required this.affiliationNo,
//     required this.previousSchoolName,
//     required this.languageStudiedFirst,
//     required this.languageStudiedSecond,
//     required this.languageStudiedThird,
//     required this.reasonForChange,
//     required this.fathersName,
//     required this.fathersQualification,
//     required this.fathersOccupation,
//     required this.fathersMobile,
//     required this.fathersEmail,
//     required this.fathersAdharNo,
//     required this.fathersAnnualIncome,
//     required this.mothersName,
//     required this.mothersQualification,
//     required this.mothersOccupation,
//     required this.mothersMobile,
//     required this.mothersEmail,
//     required this.mothersAdharNo,
//     required this.mothersAnnualIncome,
//     required this.guardiansName,
//     required this.guardiansQualification,
//     required this.guardiansOccupation,
//     required this.guardiansMobile,
//     required this.guardiansEmail,
//     required this.guardiansAdharNo,
//     required this.guardiansAnnualIncome,
//     required this.guardiansSiblingDetails,
//     required this.bloodGroup,
//     required this.height,
//     required this.weight,
//     required this.allergyAilment,
//     required this.doctorAdvice,
//     required this.specificDiet,
//     required this.pediatricianName,
//     required this.pediatricianContact,
//     required this.password,
//     required this.adminId,
//     required this.teacherId,
//   });
//
//   factory StudentDetailsModel.fromJson(Map<String, dynamic> json) =>
//       StudentDetailsModel(
//         name: json["name"] ?? "", // Use empty string if null
//         email: json["email"] ?? "",
//         classId: json["class_id"] ?? 0, // Default integer to 0
//         gender: json["gender"] ?? "",
//         dateOfBirth: json["date_of_birth"] != null
//             ? DateTime.parse(json["date_of_birth"])
//             : DateTime(2000, 1, 1), // Provide a default date
//         placeOfBirth: json["place_of_birth"] ?? "",
//         age: json["age"] ?? 0,
//         nationality: json["nationality"] ?? "",
//         motherTongue: json["mother_tongue"] ?? "",
//         languagesKnown: json["languages_known"] ?? "",
//         contactAddress: json["contact_address"] ?? "",
//         permanentAddress: json["permanent_address"] ?? "",
//         contactNo: json["contact_no"] ?? "",
//         whatsappNo: json["whatsapp_no"] ?? "",
//         adharCardNo: json["adhar_card_no"] ?? "",
//         caste: json["caste"] ?? "",
//         subCaste: json["sub_caste"] ?? "",
//         socialCategory: json["social_category"] ?? "",
//         dateOfJoining: json["date_of_joining"] != null
//             ? DateTime.parse(json["date_of_joining"])
//             : DateTime(2000, 1, 1),
//         classOfJoining: json["class_of_joining"] ?? "",
//         admissionNo: json["admission_no"] ?? "",
//         penNo: json["pen_no"] ?? "",
//         satasNo: json["satas_no"] ?? "",
//         affiliationNo: json["affiliation_no"] ?? "",
//         previousSchoolName: json["previous_school_name"] ?? "",
//         languageStudiedFirst: json["language_studied_first"] ?? "",
//         languageStudiedSecond: json["language_studied_second"] ?? "",
//         languageStudiedThird: json["language_studied_third"] ?? "",
//         reasonForChange: json["reason_for_change"] ?? "",
//         fathersName: json["fathers_name"] ?? "",
//         fathersQualification: json["fathers_qualification"] ?? "",
//         fathersOccupation: json["fathers_occupation"] ?? "",
//         fathersMobile: json["fathers_mobile"] ?? "",
//         fathersEmail: json["fathers_email"] ?? "",
//         fathersAdharNo: json["fathers_adhar_no"] ?? "",
//         fathersAnnualIncome: json["fathers_annual_income"]?.toDouble() ?? 0.0,
//         mothersName: json["mothers_name"] ?? "",
//         mothersQualification: json["mothers_qualification"] ?? "",
//         mothersOccupation: json["mothers_occupation"] ?? "",
//         mothersMobile: json["mothers_mobile"] ?? "",
//         mothersEmail: json["mothers_email"] ?? "",
//         mothersAdharNo: json["mothers_adhar_no"] ?? "",
//         mothersAnnualIncome: json["mothers_annual_income"]?.toDouble() ?? 0.0,
//         guardiansName: json["guardians_name"] ?? "",
//         guardiansQualification: json["guardians_qualification"] ?? "",
//         guardiansOccupation: json["guardians_occupation"] ?? "",
//         guardiansMobile: json["guardians_mobile"] ?? "",
//         guardiansEmail: json["guardians_email"] ?? "",
//         guardiansAdharNo: json["guardians_adhar_no"] ?? "",
//         guardiansAnnualIncome:
//             json["guardians_annual_income"]?.toDouble() ?? 0.0,
//
//         // ✅ Fix for `guardiansSiblingDetails`
//         guardiansSiblingDetails: json["guardians_sibling_details"] != null
//             ? List<String>.from(
//                 (json["guardians_sibling_details"] as List)
//                     .map((x) => x?.toString() ?? ""),
//               )
//             : [], // Default to an empty list if null
//
//         bloodGroup: json["blood_group"] ?? "",
//         height: json["height"]?.toDouble() ?? 0.0,
//         weight: json["weight"]?.toDouble() ?? 0.0,
//         allergyAilment: json["allergy_ailment"] ?? "",
//         doctorAdvice: json["doctor_advice"] ?? "",
//         specificDiet: json["specific_diet"] ?? "",
//         pediatricianName: json["pediatrician_name"] ?? "",
//         pediatricianContact: json["pediatrician_contact"] ?? "",
//         password: json["password"] ?? "",
//         adminId: json["admin_id"] ?? 0,
//         teacherId: json["teacher_id"] ?? 0,
//       );
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "email": email,
//         "class_id": classId,
//         "gender": gender,
//         "date_of_birth": dateOfBirth.toIso8601String(),
//         "place_of_birth": placeOfBirth,
//         "age": age,
//         "nationality": nationality,
//         "mother_tongue": motherTongue,
//         "languages_known": languagesKnown,
//         "contact_address": contactAddress,
//         "permanent_address": permanentAddress,
//         "contact_no": contactNo,
//         "whatsapp_no": whatsappNo,
//         "adhar_card_no": adharCardNo,
//         "caste": caste,
//         "sub_caste": subCaste,
//         "social_category": socialCategory,
//         "date_of_joining": dateOfJoining.toIso8601String(),
//         "class_of_joining": classOfJoining,
//         "admission_no": admissionNo,
//         "pen_no": penNo,
//         "satas_no": satasNo,
//         "affiliation_no": affiliationNo,
//         "previous_school_name": previousSchoolName,
//         "language_studied_first": languageStudiedFirst,
//         "language_studied_second": languageStudiedSecond,
//         "language_studied_third": languageStudiedThird,
//         "reason_for_change": reasonForChange,
//         "fathers_name": fathersName,
//         "fathers_qualification": fathersQualification,
//         "fathers_occupation": fathersOccupation,
//         "fathers_mobile": fathersMobile,
//         "fathers_email": fathersEmail,
//         "fathers_adhar_no": fathersAdharNo,
//         "fathers_annual_income": fathersAnnualIncome,
//         "mothers_name": mothersName,
//         "mothers_qualification": mothersQualification,
//         "mothers_occupation": mothersOccupation,
//         "mothers_mobile": mothersMobile,
//         "mothers_email": mothersEmail,
//         "mothers_adhar_no": mothersAdharNo,
//         "mothers_annual_income": mothersAnnualIncome,
//         "guardians_name": guardiansName,
//         "guardians_qualification": guardiansQualification,
//         "guardians_occupation": guardiansOccupation,
//         "guardians_mobile": guardiansMobile,
//         "guardians_email": guardiansEmail,
//         "guardians_adhar_no": guardiansAdharNo,
//         "guardians_annual_income": guardiansAnnualIncome,
//         "guardians_sibling_details":
//             List<dynamic>.from(guardiansSiblingDetails.map((x) => x)),
//         "blood_group": bloodGroup,
//         "height": height,
//         "weight": weight,
//         "allergy_ailment": allergyAilment,
//         "doctor_advice": doctorAdvice,
//         "specific_diet": specificDiet,
//         "pediatrician_name": pediatricianName,
//         "pediatrician_contact": pediatricianContact,
//         "password": password,
//         "admin_id": adminId,
//         "teacher_id": teacherId,
//       };
// }
