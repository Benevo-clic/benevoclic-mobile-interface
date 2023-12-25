import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/cubit/announcement/announcement_cubit.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/user/user_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/repositories/api/Announcement_repository.dart';
import 'package:namer_app/repositories/api/association_repository.dart';
import 'package:namer_app/repositories/api/user_repository.dart';
import 'package:namer_app/repositories/api/volunteer_repository.dart';
import 'package:namer_app/repositories/auth_repository.dart';
import 'package:namer_app/settings/cubit/setting_cubit.dart';
import 'package:namer_app/settings/cubit/setting_state.dart';
import 'package:namer_app/views/common/authentification/cubit/typeAuth/auth_type_cubit.dart';

import 'cubit/dropdown/dropdown_cubit.dart';
import 'cubit/otherAuth/other_auth_cubit.dart';
import 'cubit/page/page_cubit.dart';
import 'views/home_view.dart';

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
          BlocProvider(
              create: (context) => UserCubit(
                  userRepository: UserRepository(),
            authRepository: AuthRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => AnnouncementCubit(
            announcementRepository: AnnouncementRepository(),
          ),
        ),
        BlocProvider(create: (context) => SettingCubit()),
        BlocProvider(create: (context) => AuthTypeCubit()),
        BlocProvider(
          create: (context) => OtherAuthCubit(
            AuthRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => VolunteerCubit(
            volunteerRepository: VolunteerRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => AssociationCubit(
            associationRepository: AssociationRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(create: (context) => DropdownCubit())
        ],
        child: BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            return MaterialApp(
            title: 'Bénévoclic',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: GoogleFonts.latoTextTheme(),
            ),
            home: HomeView(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
