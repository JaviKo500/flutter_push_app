

class PushMessage {
  
  final String messageId;
  final String title;
  final String body;
  final DateTime sendDate;
  final Map< String, dynamic >? data;
  final String? url;

  PushMessage({
    required this.messageId, 
    required this.title, 
    required this.body, 
    required this.sendDate, 
    this.data, 
    this.url
  });

  @override
  String toString() => '''
  Push
  messageId: $messageId,
  title: $title,
  body: $body,
  sendDate: $sendDate,
  data: $data,
  url: $url
  ''';
}