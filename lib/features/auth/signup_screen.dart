import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please accept Terms & Conditions",
          ),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior
                      .onDrag,

              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      constraints.maxHeight,
                ),

                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,

                    child: Column(
                      children: [

                        // TOP IMAGE SECTION
                        Expanded(
                          flex: 4,

                          child: Stack(
                            fit: StackFit.expand,

                            children: [

                              // IMAGE
                              Image.asset(
                                "assets/loginpage.png",
                                fit: BoxFit.cover,
                              ),

                              // OVERLAY
                              Container(
                                color: Colors.black
                                    .withOpacity(0.35),
                              ),
                            ],
                          ),
                        ),

                        // BOTTOM SECTION
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
                              color:
                                  Color(0xFF0A0F1F),

                              borderRadius:
                                  BorderRadius.only(
                                topLeft:
                                    Radius.circular(
                                  28,
                                ),
                                topRight:
                                    Radius.circular(
                                  28,
                                ),
                              ),
                            ),

                            child: Column(
                              mainAxisSize:
                                  MainAxisSize.min,

                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                // TITLE
                                const Text(
                                  "Create Account",

                                  style: TextStyle(
                                    color:
                                        Colors.white,

                                    fontSize: 30,

                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                const Text(
                                  "Join SafeCampus Security",

                                  style: TextStyle(
                                    color:
                                        Colors
                                            .white70,

                                    fontSize: 15,
                                  ),
                                ),

                                const SizedBox(
                                  height: 24,
                                ),

                                // NAME
                                _buildTextField(
                                  controller:
                                      _nameController,

                                  hint:
                                      "Full Name",

                                  icon:
                                      Iconsax.user,

                                  validator:
                                      (value) {
                                    if (value ==
                                            null ||
                                        value
                                            .isEmpty) {
                                      return "Enter your name";
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(
                                  height: 16,
                                ),

                                // EMAIL
                                _buildTextField(
                                  controller:
                                      _emailController,

                                  hint:
                                      "User ID / Email",

                                  icon:
                                      Iconsax.sms,

                                  validator:
                                      (value) {
                                    if (value ==
                                            null ||
                                        value
                                            .isEmpty) {
                                      return "Enter email";
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(
                                  height: 16,
                                ),

                                // PASSWORD
                                _buildTextField(
                                  controller:
                                      _passwordController,

                                  hint:
                                      "Password",

                                  icon:
                                      Iconsax.lock,

                                  obscure:
                                      _obscurePassword,

                                  suffix:
                                      IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Iconsax
                                              .eye
                                          : Iconsax
                                              .eye_slash,

                                      color: Colors
                                          .white70,
                                    ),

                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword =
                                            !_obscurePassword;
                                      });
                                    },
                                  ),

                                  validator:
                                      (value) {
                                    if (value ==
                                            null ||
                                        value
                                            .isEmpty) {
                                      return "Enter password";
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(
                                  height: 12,
                                ),

                                // TERMS
                                Row(
                                  children: [

                                    Checkbox(
                                      value:
                                          _acceptTerms,

                                      activeColor:
                                          const Color(
                                        0xFF1565FF,
                                      ),

                                      onChanged:
                                          (value) {
                                        setState(() {
                                          _acceptTerms =
                                              value ??
                                                  false;
                                        });
                                      },
                                    ),

                                    const Expanded(
                                      child: Text(
                                        "I agree to Terms & Conditions",

                                        style:
                                            TextStyle(
                                          color: Colors
                                              .white70,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 18,
                                ),

                                // BUTTON
                                SizedBox(
                                  width:
                                      double.infinity,

                                  height: 56,

                                  child:
                                      ElevatedButton(
                                    onPressed:
                                        _isLoading
                                            ? null
                                            : _handleSignup,

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
                                                    Colors.white,
                                              )
                                            : const Text(
                                                "CREATE ACCOUNT",

                                                style:
                                                    TextStyle(
                                                  color:
                                                      Colors.white,

                                                  fontSize:
                                                      17,

                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 18,
                                ),

                                // LOGIN LINK
                                Center(
                                  child: Wrap(
                                    alignment:
                                        WrapAlignment
                                            .center,

                                    children: [

                                      const Text(
                                        "Already have an account? ",

                                        style:
                                            TextStyle(
                                          color: Colors
                                              .white70,

                                          fontSize:
                                              15,
                                        ),
                                      ),

                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .pop();
                                        },

                                        child:
                                            const Text(
                                          "Login",

                                          style:
                                              TextStyle(
                                            color: Color(
                                              0xFF1E88FF,
                                            ),

                                            fontSize:
                                                16,

                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
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
        color: Colors.white.withOpacity(
          0.08,
        ),

        borderRadius:
            BorderRadius.circular(14),

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