import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height,
            ),

            child: Form(
              key: _formKey,

              child: IntrinsicHeight(
                child: Column(
                  children: [

                    // TOP IMAGE SECTION
                    Expanded(
                      flex: 4,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [

                          // BACKGROUND IMAGE
                          Image.asset(
                            "assets/loginpage.png",
                            fit: BoxFit.cover,
                          ),

                          // DARK OVERLAY
                          Container(
                            color: Colors.black.withOpacity(
                              0.35,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // BOTTOM LOGIN SECTION
                    Expanded(
                      flex: 6,
                      child: Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 24,
                        ),

                        decoration:
                            const BoxDecoration(
                          color: Color(0xFF0A0F1F),

                          borderRadius:
                              BorderRadius.only(
                            topLeft: Radius.circular(
                              28,
                            ),
                            topRight: Radius.circular(
                              28,
                            ),
                          ),
                        ),

                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min,

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            // LOGIN TITLE
                            const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // SUBTITLE
                            const Text(
                              "Secure access to SafeCampus",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 28),

                            // EMAIL FIELD
                            _buildTextField(
                              controller:
                                  _emailController,
                              hint:
                                  "User ID / Email",
                              icon: Iconsax.user,

                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return "Please enter email";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(
                              height: 18,
                            ),

                            // PASSWORD FIELD
                            _buildTextField(
                              controller:
                                  _passwordController,
                              hint: "Password",
                              icon: Iconsax.lock,

                              obscure:
                                  _obscurePassword,

                              suffix: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Iconsax.eye
                                      : Iconsax
                                          .eye_slash,

                                  color:
                                      Colors.white70,
                                ),

                                onPressed: () {
                                  setState(() {
                                    _obscurePassword =
                                        !_obscurePassword;
                                  });
                                },
                              ),

                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return "Please enter password";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 8),

                            // FORGOT PASSWORD
                            Align(
                              alignment:
                                  Alignment.centerRight,

                              child: TextButton(
                                onPressed: () {},

                                child: const Text(
                                  "Forgot Password?",

                                  style: TextStyle(
                                    color: Color(
                                      0xFF1E88FF,
                                    ),

                                    fontWeight:
                                        FontWeight
                                            .w600,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // LOGIN BUTTON
                            SizedBox(
                              width: double.infinity,
                              height: 56,

                              child: ElevatedButton(
                                onPressed:
                                    _isLoading
                                        ? null
                                        : _handleLogin,

                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(
                                    0xFF1565FF,
                                  ),

                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                      14,
                                    ),
                                  ),
                                ),

                                child:
                                    _isLoading
                                        ? const CircularProgressIndicator(
                                            color:
                                                Colors
                                                    .white,
                                          )
                                        : const Text(
                                            "LOGIN",

                                            style:
                                                TextStyle(
                                              color:
                                                  Colors
                                                      .white,

                                              fontSize:
                                                  18,

                                              fontWeight:
                                                  FontWeight
                                                      .bold,
                                            ),
                                          ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // SIGNUP LINK
                            Center(
                              child: Wrap(
                                alignment:
                                    WrapAlignment
                                        .center,

                                children: [

                                  const Text(
                                    "Don't have an account? ",

                                    style: TextStyle(
                                      color:
                                          Colors
                                              .white70,

                                      fontSize: 15,
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      context.push(
                                        '/signup',
                                      );
                                    },

                                    child: const Text(
                                      "Sign Up",

                                      style:
                                          TextStyle(
                                        color: Color(
                                          0xFF1565FF,
                                        ),

                                        fontSize:
                                            16,

                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    Widget? suffix,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),

        borderRadius: BorderRadius.circular(14),

        border: Border.all(
          color: Colors.white24,
        ),
      ),

      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,

        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),

        decoration: InputDecoration(
          border: InputBorder.none,

          hintText: hint,

          hintStyle: const TextStyle(
            color: Colors.white54,
          ),

          prefixIcon: Icon(
            icon,
            color: Colors.white70,
          ),

          suffixIcon: suffix,

          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 20,
          ),
        ),
      ),
    );
  }
}