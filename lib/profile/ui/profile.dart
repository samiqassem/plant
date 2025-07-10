import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/inspection/plant_inspection.dart';
import '../logic/profile__state.dart';
import '../logic/profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image;

  @override
  void initState() {
    super.initState();
    loadImage();
    context.read<ProfileCubit>().getProfile();
  }

  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('savedImagePath');
    if (imagePath != null) {
      setState(() {
        image = File(imagePath);
      });
    }
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('savedImagePath', pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[500],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final user = state.profile.user;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: getImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: image == null
                          ? const AssetImage('assets/images/profile/2.png') as ImageProvider
                          : FileImage(image!),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Click here to change profile photo',
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    user.username,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        '    Email : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  const ListTile(
                    leading: Icon(Icons.phone, color: Colors.green),
                    title: Text('Phone'),
                    subtitle: Text('+123 456 7890'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.location_on, color: Colors.orange),
                    title: Text('Address'),
                    subtitle: Text('123 Market Street, City, Country'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PlantInspectionScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.yellow[600],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.question_mark_rounded),
                            Text(
                              ' About us',
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
