import 'package:json_annotation/json_annotation.dart';

part 'message.model.g.dart';

@JsonSerializable(explicitToJson: true)
class Message {
  final String? message;

  Message({this.message});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
