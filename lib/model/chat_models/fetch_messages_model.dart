class FetchMessagesModel {
  final int total;
  final int lastPage;
  final String lastMessageId;
  final List<MessageData> messages;

  FetchMessagesModel({
    required this.total,
    required this.lastPage,
    required this.lastMessageId,
    required this.messages,
  });

  factory FetchMessagesModel.fromJson(Map<String, dynamic> json) {
    return FetchMessagesModel(
      total: json['total'],
      lastPage: json['last_page'],
      lastMessageId: json['last_message_id'],
      messages: List<MessageData>.from(json['messages'].map((message) => MessageData.fromJson(message))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'last_page': lastPage,
      'last_message_id': lastMessageId,
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }
}

class MessageData {
  final String id;
  final int chatId;
  final int fromId;
  final int toId;
  final String body;
  final String? attachment;
  final int seen;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessageData({
    required this.id,
    required this.chatId,
    required this.fromId,
    required this.toId,
    required this.body,
    this.attachment,
    required this.seen,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      id: json['id'],
      chatId: json['chat_id'],
      fromId: json['from_id'],
      toId: json['to_id'],
      body: json['body'],
      attachment: json['attachment'],
      seen: json['seen'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_id': chatId,
      'from_id': fromId,
      'to_id': toId,
      'body': body,
      'attachment': attachment,
      'seen': seen,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class FetchMessagesRequest {
  final int chatId;

  FetchMessagesRequest({
    required this.chatId,
  });

  factory FetchMessagesRequest.fromJson(Map<String, dynamic> json) {
    return FetchMessagesRequest(
      chatId: json['chat_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_id': chatId,
    };
  }
}
