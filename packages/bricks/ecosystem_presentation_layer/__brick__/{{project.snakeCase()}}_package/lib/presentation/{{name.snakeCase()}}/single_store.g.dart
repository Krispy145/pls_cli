// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatStore on _ChatStore, Store {
  late final _$currentChatAtom =
      Atom(name: '_ChatStore.currentChat', context: context);

  @override
  ChatModel? get currentChat {
    _$currentChatAtom.reportRead();
    return super.currentChat;
  }

  @override
  set currentChat(ChatModel? value) {
    _$currentChatAtom.reportWrite(value, super.currentChat, () {
      super.currentChat = value;
    });
  }

  @override
  String toString() {
    return '''
currentChat: ${currentChat}
    ''';
  }
}
