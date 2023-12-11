// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../util/email_verification.dart';
//
// class FormulaireWidget extends StatelessWidget {
//   const FormulaireWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(
//           height: 10,
//         ),
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.8,
//           child: TextFormField(
//             obscureText: false,
//             validator: (value) {
//               var email = EmailVerification(value.toString());
//               if (email.security()) {
//                 setState(() {
//                   _email = value;
//                 });
//                 return null;
//               } else {
//                 return email.message;
//               }
//             },
//             decoration: InputDecoration(
//               fillColor: Colors.white.withOpacity(0.5),
//               filled: true,
//               prefixIcon: Icon(
//                 Icons.account_circle,
//                 color: Colors.black54,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//                 borderSide: BorderSide.none,
//               ),
//               hintText: "Email",
//               hintStyle: TextStyle(color: Colors.black54),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.8,
//           child: TextFormField(
//             obscureText: true,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return "Veuillez rentrer un mot de passe";
//               } else {
//                 setState(() {
//                   _password = value;
//                 });
//                 return null;
//               }
//             },
//             decoration: InputDecoration(
//               fillColor: Colors.white.withOpacity(0.5),
//               filled: true,
//               prefixIcon: Icon(
//                 Icons.lock,
//                 color: Colors.black54,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//                 borderSide: BorderSide.none,
//               ),
//               hintText: "Password",
//               hintStyle: TextStyle(color: Colors.black54),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         TextButton(
//           onPressed: () {},
//           child: Text(
//             "Mot de passe oublié ?",
//             style: TextStyle(
//                 decoration: TextDecoration.underline, color: Colors.black),
//           ),
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         BlocConsumer<UserCubit, UserState>(
//           listener: (context, state) {
//             if (state is UserErrorState) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.message),
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is UserInitialState) {
//               return _buildInitialInput();
//             } else if (state is UserLoadingState) {
//               return _buildLoading(context, state);
//             } else if (state is ResponseUserState) {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => NavigationExample()));
//                 final cubit = context.read<UserCubit>();
//                 cubit.userConnexion(state.user);
//               });
//               return Text("Connexion réussie");
//             } else if (state is UserErrorState) {
//               return _buildError();
//             }
//             return Text('Unknown state: $state');
//           },
//         ),
//         Container(
//           width: MediaQuery.sizeOf(context).width * 0.60,
//           padding: EdgeInsets.only(),
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color.fromRGBO(170, 77, 79, 1),
//             ),
//             onPressed: () async {
//               if (_formKey.currentState!.validate()) {
//                 try {
//                   await AuthRepository().authAdressPassword(
//                       _email.toString(), _password.toString());
//                   BlocProvider.of<UserCubit>(context).connexion();
//                 } on FirebaseAuthException catch (e) {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return ErrorMessage(
//                           type: "login incorrect", message: "retour");
//                     },
//                   );
//                   print(e.code);
//                 }
//               }
//             },
//             child:
//                 const Text("Connexion", style: TextStyle(color: Colors.white)),
//           ),
//         ),
//       ],
//     );
//   }
// }
