// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/auth_provider.dart';
//
// class AuthForm extends ConsumerStatefulWidget {
//   final bool isLogin;
//   final VoidCallback onToggle;
//
//   const AuthForm({
//     super.key,
//     required this.isLogin,
//     required this.onToggle,
//   });
//
//   @override
//   ConsumerState<AuthForm> createState() => _AuthFormState();
// }
//
// class _AuthFormState extends ConsumerState<AuthForm> {
//   final email = TextEditingController();
//   final password = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final notifier = ref.read(authStateProvider.notifier);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 40),
//
//         Text(
//           widget.isLogin ? 'Welcome back' : 'Create account',
//           style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//         ),
//
//         const SizedBox(height: 30),
//
//         TextField(
//           controller: email,
//           decoration: const InputDecoration(labelText: 'Email'),
//         ),
//
//         const SizedBox(height: 12),
//
//         TextField(
//           controller: password,
//           obscureText: true,
//           decoration: const InputDecoration(labelText: 'Password'),
//         ),
//
//         const SizedBox(height: 20),
//
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: () async {
//               if (widget.isLogin) {
//                 await notifier.signInEmail(email.text, password.text);
//               } else {
//                 await notifier.registerEmail(email.text, password.text);
//               }
//             },
//             child: Text(widget.isLogin ? 'Login' : 'Register'),
//           ),
//         ),
//
//         const SizedBox(height: 20),
//
//         const Center(child: Text('or continue with')),
//
//         const SizedBox(height: 16),
//
//         Row(
//           children: [
//             Expanded(
//               child: OutlinedButton(
//                 onPressed: () async {
//                   await notifier.signInGoogle();
//                 },
//                 child: const Text('Google'),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: OutlinedButton(
//                 onPressed: () async {
//                   await notifier.signInApple();
//                 },
//                 child: const Text('Apple'),
//               ),
//             ),
//           ],
//         ),
//
//         const SizedBox(height: 20),
//
//         Center(
//           child: TextButton(
//             onPressed: widget.onToggle,
//             child: Text(
//               widget.isLogin
//                   ? "Don't have an account? Register"
//                   : "Already have an account? Login",
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
