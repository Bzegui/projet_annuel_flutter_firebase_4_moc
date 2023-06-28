import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages_navigation_block/pages_navigator/bloc/pages_navigator_bloc.dart';
import '../../pages_navigation_block/pages_navigator/pages_routes/pages_routes.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: ContactsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: const Alignment(0, -1 / 3),
          child: FlowBuilder<ChatRoomActionButtonStatus>(
              state: context.select((PagesNavigatorBloc bloc) => bloc.state.status),
              onGeneratePages: onGenerateContactsViewPage
          )
      ),
    );
  }
}

