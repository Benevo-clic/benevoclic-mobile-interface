import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/page/page_cubit.dart';

import '../../../models/association_model.dart';
import '../../../models/volunteer_model.dart';
import '../../../type/rules_type.dart';
import '../../../widgets/app_bar_widget.dart';

class Messages extends StatelessWidget {
  RulesType? rulesType;
  Association? association;
  Volunteer? volunteer;

  Messages({Key? key, this.rulesType, this.association, this.volunteer})
      : super(key: key);

  Widget _buildContentText(BuildContext context) {
    String text = '';

    if (rulesType == RulesType.USER_ASSOCIATION) {
      text =
          'Cette fonctionnalité sera disponible prochainement. Restez à l\'écoute!';
    } else if (rulesType == RulesType.USER_VOLUNTEER) {
      text =
          'Cette fonctionnalité sera disponible prochainement. Restez à l\'écoute! \n\n En attendant, vous pouvez consulter les annonces. et contactez les associations par mail ou par téléphone.';
    }

    return Text(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * 0.15), // Hauteur personnalisée
        child: AppBarWidget(
            contexts: context,
            label: 'Messages',
            association: association,
            volunteer: volunteer),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AlertDialog(
              title: Text('Fonctionnalité à venir'),
              content: _buildContentText(context),
              actions: <Widget>[
                TextButton(
                  child: Text('Aller aux annonces'),
                  onPressed: () {
                    BlocProvider.of<PageCubit>(context).setPage(0);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
