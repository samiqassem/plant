import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../auth/data/auth_repository.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  String? message;

  Future<void> _submit() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        message = 'من فضلك أدخل البريد الإلكتروني';
      });
      return;
    }

    setState(() {
      isLoading = true;
      message = null;
    });

    try {
      final authRepo = AuthRepository();
      await authRepo.forgotPassword(email);
      setState(() {
        message = '✅ إذا كان الإيميل مسجلاً، سيتم إرسال رابط إعادة تعيين كلمة المرور';
      });
    } catch (e) {
      setState(() {
        message = '⛔ حصل خطأ: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نسيت كلمة المرور', style: TextStyle(fontSize: 20.sp)),
        centerTitle: true,
        backgroundColor: Colors.green[600],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'أدخل بريدك الإلكتروني وسنرسل لك رابط إعادة تعيين كلمة المرور.',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[800]),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20.h),
            if (message != null)
              Text(
                message!,
                style: TextStyle(
                  color: message!.startsWith('✅') ? Colors.green : Colors.red,
                  fontSize: 14.sp,
                ),
              ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  'إرسال رابط إعادة التعيين',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
