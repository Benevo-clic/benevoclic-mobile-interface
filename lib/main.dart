import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/announcement/announcement_cubit.dart';
import 'package:namer_app/cubit/user/user_cubit.dart';
import 'package:namer_app/repositories/api/user_repository.dart';
import 'package:provider/provider.dart';

import 'cubit/user/user_state.dart';
import 'views/home_page.dart';

void main() async {
  //Initialisation de firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserCubit(userRepository: UserRepository())),
          BlocProvider(create: (context) => AnnouncementCubit()),
        ],
         child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Namer',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              debugShowCheckedModeBanner: false,
              home: HomePage(),
            );
          },
        )
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}
