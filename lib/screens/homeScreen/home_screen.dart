import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankar_task/authController/auth_controller.dart';
import 'package:sankar_task/screens/auth_gateway/auth_gateway.dart';
import 'package:sankar_task/theme/app_Colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authController = Get.put(AuthController());
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  String _displayName = 'Guest';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        final doc = await _db.collection('users').doc(uid).get();
        final data = doc.data();
        if (data != null &&
            (data['name'] as String?)?.trim().isNotEmpty == true) {
          _displayName = (data['name'] as String).trim();
        }
      }
    } catch (e) {
      // ignore and keep Guest
      Get.snackbar('Error', e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.home, size: 28),
        ),
        leadingWidth: 30,
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
        // actions: [
        //   IconButton(
        //     onPressed: () {}, // optional settings/menu
        //     icon: const Icon(Icons.settings_outlined),
        //   ),
        // ],
      ),
      // FloatingActionButton kept exactly as requested
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.logout, size: 24),
        onPressed: () async {
          await authController.signOut();
          Get.offAll(AuthGateway());
        },
      ),
      body: const Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      // body: _loading
      //     ? const Center(child: CircularProgressIndicator())
      //     : SingleChildScrollView(
      //         padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             HomeHeader(name: _displayName),
      //             const SizedBox(height: 8),

      //             // Lottie banner from assets (offline)
      //             FeatureCard(
      //               icon: Icons.checklist_outlined,
      //               title: 'Checklist',
      //               subtitle: 'Track tasks and deadlines',
      //               onPressed: () {
      //                 Get.to(() => ChecklistScreen());
      //               },
      //             ),
      //             const SizedBox(height: 10),
      //             FeatureCard(
      //               icon: Icons.location_on_outlined,
      //               title: 'Venues',
      //               subtitle: 'Browse and filter venues',
      //               onPressed: () {
      //                 Get.to(() => VenuesScreen());
      //               },
      //             ),
      //             const SizedBox(height: 10),
      //             FeatureCard(
      //               icon: Icons.calculate_outlined,
      //               title: 'Budget',
      //               subtitle: 'Plan and adjust allocations',
      //               onPressed: () {
      //                 Get.to(() => BudgetCalculatorScreen());
      //               },
      //             ),
      //             const SizedBox(height: 10),
      //             FeatureCard(
      //               icon: Icons.group_outlined,
      //               title: 'Guests',
      //               subtitle: 'Manage invitations and RSVPs',
      //               onPressed: () {
      //                 Get.to(() => GuestsScreen());
      //               },
      //             ),
      //             const SizedBox(height: 12),
      //             Container(
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(12)
      //               ),
      //               child: SizedBox(
                      
      //                 width: double.infinity,
      //                 child: Lottie.asset(
      //                   'lib/assets/images/animation.json',
      //                   repeat: true,
      //                   fit: BoxFit.contain,
      //                   frameBuilder: (context, child, composition) {
      //                     final ready = composition != null;
      //                     return AnimatedSwitcher(
      //                       duration: const Duration(milliseconds: 250),
      //                       child: ready
      //                           ? child
      //                           : const Center(
      //                               child: CircularProgressIndicator(),
      //                             ),
      //                     );
      //                   },
      //                 ),
      //               ),
      //             ),

      //             const SizedBox(height: 24),
      //           ],
      //         ),
      //       ),
    );
  }
}
