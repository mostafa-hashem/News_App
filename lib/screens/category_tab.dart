// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../shared/components/constans.dart';
// import '../shared/network/remot/api_manager.dart';
// import 'widgets/source_item.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// class CategoryTab extends StatelessWidget {
//   const CategoryTab({Key? key});
//
//   static const String routeName = "CategoryTab";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           AppLocalizations.of(context)!.appName,
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 0.02.sh,
//           ),
//            SourceItem(),
//           SizedBox(
//             height: 0.04.sh,
//           ),
//           Expanded(
//             flex: 14,
//             child: FutureBuilder(
//                 future: ApiManager.getSources(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (snapshot.hasError) {
//                     return const Column(
//                       children: [Text("Something went wrong")],
//                     );
//                   }
//                   if (snapshot.data?.status != STATUS) {
//                     return const Column(
//                       children: [Text("Error!")],
//                     );
//                   }
//                   var sources = snapshot.data?.sources ?? [];
//                   return ListView.separated(
//                       scrollDirection: Axis.vertical,
//                       separatorBuilder: (context, index) =>
//                           SizedBox(height: 0.03.sw),
//                       itemBuilder: (context, index) {
//                         return InkWell(
//                           onTap: () {},
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.green,
//                                 width: 2,
//                               ),
//                               borderRadius: BorderRadius.circular(25.r),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(12),
//                               child: Center(
//                                 child: Text(
//                                   sources[index].name ?? "",
//                                   style: GoogleFonts.novaSquare(
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                       itemCount: sources.length);
//                 }),
//           )
//         ],
//       ),
//     );
//   }
// }
