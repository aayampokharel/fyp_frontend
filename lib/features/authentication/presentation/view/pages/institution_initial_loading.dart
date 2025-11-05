// import 'package:flutter/material.dart';
// import 'package:flutter_dashboard/core/constants/color_constants.dart';
// import 'package:flutter_dashboard/core/constants/string_constants.dart';
// import 'package:flutter_dashboard/features/authentication/presentation/view/pages/institution_csv_upload_page.dart';
// import 'package:flutter_dashboard/features/authentication/presentation/view/widgets/nav_bar_widget.dart';
// import 'package:material_color_utilities/material_color_utilities.dart';

// class InstitutionInitialLoading extends StatelessWidget {
//   const InstitutionInitialLoading({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: NavBarWidget(
//           icon1: const Icon(Icons.person, color: Colors.white),
//           icon2: const Icon(Icons.logout, color: Colors.white),
//           onPressedIcon1: () {},
//           onPressedIcon2: () {},
//           companyName: StringConstants.companyName,
//         ),
//       ),
//       body: Center(
//         child: FutureBuilder(
//           future: null,
//           // initialData: InitialData,
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator(
//                 color: ColorConstants.primaryPurple,
//               );
//             }
//             if (snapshot.connectionState == ConnectionState.done) {
//              if (snapshot.hasError){
//               return Text(snapshot.error.toString());
//               }else{
//                 snapshot.data
//                 HandleInstitutionReceivedData(context,snapshot.data);
//               }
//              }
//             }
//           },
//         ),
//       ),
//     );
//   }
// }


// void HandleInstitutionReceivedData( BuildContext context ,dynamic data) {
// Navigator.pop(context);
// Navigator.push(context, MaterialPageRoute(builder:(context) => InstitutionCsvUploadPage()));
// }