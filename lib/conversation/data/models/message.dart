import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_chat/utilities/keys/message_keys.dart';

class Message extends Equatable {
  final String conversationId;
  final String senderUID;
  final String receiverUID;
  final String content;
  final String timeStamp;

  const Message({
    required this.conversationId,
    required this.senderUID,
    required this.receiverUID,
    required this.content,
    required this.timeStamp,
  });

  Message copyWith({
    String? conversationId,
    String? senderUID,
    String? receiverUID,
    String? content,
    String? timeStamp,
  }) {
    return Message(
      conversationId: conversationId ?? this.conversationId,
      senderUID: senderUID ?? this.senderUID,
      receiverUID: receiverUID ?? this.receiverUID,
      content: content ?? this.content,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      MessageKeys.conversationId: conversationId,
      MessageKeys.senderUID: senderUID,
      MessageKeys.receiverUID: receiverUID,
      MessageKeys.content: content,
      MessageKeys.timeStamp: timeStamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      conversationId: map[MessageKeys.conversationId]?.toString() ?? '',
      senderUID: map[MessageKeys.senderUID]?.toString() ?? '',
      receiverUID: map[MessageKeys.receiverUID]?.toString() ?? '',
      content: map[MessageKeys.content]?.toString() ?? '',
      timeStamp: map[MessageKeys.timeStamp]?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'Message(conversationId: $conversationId, senderUID: $senderUID, receiverUID: $receiverUID, content: $content, timeStamp: $timeStamp)';
  }

  @override
  List<Object> get props {
    return [
      conversationId,
      senderUID,
      receiverUID,
      content,
      timeStamp,
    ];
  }
}
