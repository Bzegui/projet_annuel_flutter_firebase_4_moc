import 'package:flutter/cupertino.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/pages_navigation_block/pages_navigator/bloc/pages_navigator_bloc.dart';
import '../../../pages_block/pages/contacts_page.dart';
import '../../../tabs_navigation_block/tabs/tab_views/chat_room/chat_room_page.dart';

List<Page<dynamic>> onGenerateContactsViewPage(
    ChatRoomActionButtonStatus state,
    List<Page<dynamic>> pages,
    ) {
  switch (state) {
    case ChatRoomActionButtonStatus.pressed:
      return [ContactsPage.page()];
    case ChatRoomActionButtonStatus.unpressed:
      return [ChatRoomPage.page()];
  }
}