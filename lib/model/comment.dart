import 'package:bmiterp/model/mention.dart';
import 'package:bmiterp/model/reply.dart';

class Comment {
  int id;
  String description;
  String name;
  String userId;
  String avatar;
  String createdAt;
  List<Mention> mentions;
  List<Reply> replies;

  Comment(this.id, this.description, this.name, this.userId, this.avatar,
      this.createdAt, this.mentions, this.replies);
}
