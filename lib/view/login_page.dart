import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/login_controller.dart';

class LoginpageView extends StatelessWidget {
  const LoginpageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.local_movies,
                size: 80,
                color: const Color.fromARGB(255, 229, 60, 48),
              ),
              const SizedBox(height: 20),
              const Text(
                "NontonSkuy!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              _usernameTextField(controller),
              const SizedBox(height: 20),
              _passwordTextField(controller),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.login(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 229, 60, 48),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameTextField(LoginController controller) {
    return TextField(
      controller: controller.usernameController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black,
        hintText: "Username",
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: Icon(Icons.person_outlined, color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  Widget _passwordTextField(LoginController controller) {
    return Obx(
      () => TextField(
        controller: controller.passwordController,
        obscureText: controller.obscurePassword.value,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black,
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade400),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          suffixIcon: IconButton(
            icon: Icon(
              controller.obscurePassword.value
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.grey.shade400,
            ),
            onPressed: () => controller.togglePasswordVisibility(),
          ),
        ),
      ),
    );
  }
}
