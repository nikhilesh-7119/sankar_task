// import 'package:ever_after_planner/assets/theme/app_Colors.dart';
// import 'package:flutter/material.dart';

// class FeatureCard extends StatelessWidget {
//   const FeatureCard({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.onPressed,
//   });

//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onPressed, // will be provided later
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.cardBg,
//           borderRadius: BorderRadius.circular(16),
//           border: const Border.fromBorderSide(BorderSide(color: AppColors.border)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 12,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: AppColors.accent.withOpacity(0.15),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(icon, color: Colors.black87),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title,
//                       style: const TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.w700)),
//                   const SizedBox(height: 4),
//                   Text(subtitle, style: const TextStyle(color: Colors.black54)),
//                 ],
//               ),
//             ),
//             const Icon(Icons.chevron_right, color: Colors.black45),
//           ],
//         ),
//       ),
//     );
//   }
// }
