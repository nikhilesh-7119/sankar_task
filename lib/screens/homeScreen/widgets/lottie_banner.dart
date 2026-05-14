// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class DeferredLottie extends StatefulWidget {
//   const DeferredLottie({
//     super.key,
//     required this.assetPath,
//     this.height = 140,
//     this.fit = BoxFit.contain,
//     this.repeat = true,
//   });

//   final String assetPath;
//   final double height;
//   final BoxFit fit;
//   final bool repeat;

//   @override
//   State<DeferredLottie> createState() => _DeferredLottieState();
// }

// class _DeferredLottieState extends State<DeferredLottie> {
//   bool _defer = true;

//   @override
//   void initState() {
//     super.initState();
//     // Ensure the first frame paints (spinner), then build Lottie next frame.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) setState(() => _defer = false);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: widget.height,
//       width: double.infinity,
//       child: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 200),
//         child: _defer
//             ? const Center(child: CircularProgressIndicator())
//             : Lottie.asset(
//                 widget.assetPath,
//                 repeat: widget.repeat,
//                 fit: widget.fit,
//               ),
//       ),
//     );
//   }
// }
