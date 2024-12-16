import 'dart:convert';

GetChatListModel getChatListModelFromJson(String str) => GetChatListModel.fromJson(json.decode(str));
String getChatListModelToJson(GetChatListModel data) => json.encode(data.toJson());

class GetChatListModel {
  GetChatListModel({
    bool? status,
    String? message,
    List<ChatList>? chatList,
  }) {
    _status = status;
    _message = message;
    _chatList = chatList;
  }

  GetChatListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['ChatList'] != null) {
      _chatList = [];
      json['ChatList'].forEach((v) {
        _chatList?.add(ChatList.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ChatList>? _chatList;
  GetChatListModel copyWith({
    bool? status,
    String? message,
    List<ChatList>? chatList,
  }) =>
      GetChatListModel(
        status: status ?? _status,
        message: message ?? _message,
        chatList: chatList ?? _chatList,
      );
  bool? get status => _status;
  String? get message => _message;
  List<ChatList>? get chatList => _chatList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_chatList != null) {
      map['ChatList'] = _chatList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

ChatList chatListFromJson(String str) => ChatList.fromJson(json.decode(str));
String chatListToJson(ChatList data) => json.encode(data.toJson());

class ChatList {
  ChatList({
    String? id,
    String? providerId,
    String? name,
    String? profileImage,
    bool? isOnline,
    List<String>? serviceName,
    String? chatTopic,
    String? senderId,
    num? messageType,
    String? message,
    num? unreadCount,
    String? time,
  }) {
    _id = id;
    _providerId = providerId;
    _name = name;
    _profileImage = profileImage;
    _isOnline = isOnline;
    _serviceName = serviceName;
    _chatTopic = chatTopic;
    _senderId = senderId;
    _messageType = messageType;
    _message = message;
    _unreadCount = unreadCount;
    _time = time;
  }

  ChatList.fromJson(dynamic json) {
    _id = json['_id'];
    _providerId = json['providerId'];
    _name = json['name'];
    _profileImage = json['profileImage'];
    _isOnline = json['isOnline'];
    _serviceName = json['serviceName'] != null ? json['serviceName'].cast<String>() : [];
    _chatTopic = json['chatTopic'];
    _senderId = json['senderId'];
    _messageType = json['messageType'];
    _message = json['message'];
    _unreadCount = json['unreadCount'];
    _time = json['time'];
  }
  String? _id;
  String? _providerId;
  String? _name;
  String? _profileImage;
  bool? _isOnline;
  List<String>? _serviceName;
  String? _chatTopic;
  String? _senderId;
  num? _messageType;
  String? _message;
  num? _unreadCount;
  String? _time;
  ChatList copyWith({
    String? id,
    String? providerId,
    String? name,
    String? profileImage,
    bool? isOnline,
    List<String>? serviceName,
    String? chatTopic,
    String? senderId,
    num? messageType,
    String? message,
    num? unreadCount,
    String? time,
  }) =>
      ChatList(
        id: id ?? _id,
        providerId: providerId ?? _providerId,
        name: name ?? _name,
        profileImage: profileImage ?? _profileImage,
        isOnline: isOnline ?? _isOnline,
        serviceName: serviceName ?? _serviceName,
        chatTopic: chatTopic ?? _chatTopic,
        senderId: senderId ?? _senderId,
        messageType: messageType ?? _messageType,
        message: message ?? _message,
        unreadCount: unreadCount ?? _unreadCount,
        time: time ?? _time,
      );
  String? get id => _id;
  String? get providerId => _providerId;
  String? get name => _name;
  String? get profileImage => _profileImage;
  bool? get isOnline => _isOnline;
  List<String>? get serviceName => _serviceName;
  String? get chatTopic => _chatTopic;
  String? get senderId => _senderId;
  num? get messageType => _messageType;
  String? get message => _message;
  num? get unreadCount => _unreadCount;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['providerId'] = _providerId;
    map['name'] = _name;
    map['profileImage'] = _profileImage;
    map['isOnline'] = _isOnline;
    map['serviceName'] = _serviceName;
    map['chatTopic'] = _chatTopic;
    map['senderId'] = _senderId;
    map['messageType'] = _messageType;
    map['message'] = _message;
    map['unreadCount'] = _unreadCount;
    map['time'] = _time;
    return map;
  }
}
