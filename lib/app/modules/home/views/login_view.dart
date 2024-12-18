import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makanyuk/app/modules/home/controllers/auth_controller.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C2D),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Log In",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: authController.usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.red),
                  hintText: "Username",
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 15),
              Obx(() => TextField(
                    controller: authController.passwordController,
                    obscureText: !authController.isPasswordVisible.value,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.red),
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      suffixIcon: IconButton(
                        icon: Icon(
                          authController.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.red,
                        ),
                        onPressed: authController.togglePasswordVisibility,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: authController.login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "Log In",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.to(() => RegisterView());
                },
                child: Text(
                  "Don't have an account? Register",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
