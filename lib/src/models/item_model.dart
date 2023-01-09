import "dart:convert";

class ItemModel {
  //!Api Hacker News for item
  //*id	      The item's unique id.
  //*deleted	true if the item is deleted.
  //*type	    The type of item. One of "job", "story", "comment", "poll", or "pollopt".
  //*by	      The username of the item's author.
  //*time	    Creation date of the item, in Unix Time.
  //*text	    The comment, story or poll text. HTML.
  //*dead	    true if the item is dead.
  //*parent	  The comment's parent: either another comment or the relevant story.
  //*poll	    The pollopt's associated poll.
  //*kids	    The ids of the item's comments, in ranked display order.
  //*url	    The URL of the story.
  //*score	  The story's score, or the votes for a pollopt.
  //*title	  The title of the story, poll or job. HTML.
  //*parts	  A list of related pollopts, in display order.
  //*descendants	In the case of stories or polls, the total comment count.

  final int id;
  final bool? deleted;
  final String? type;
  final String? by;
  final int? time;
  final String? text;
  final bool? dead;
  final int? parent;
  final List<dynamic>? kids;
  final String? url;
  final int? score;
  final String? title;
  final int? descendants;
  //final poll;
  //final parts;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'],
        type = parsedJson['type'],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'],
        dead = parsedJson['dead'],
        parent = parsedJson['parent'],
        kids = parsedJson['kids'],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] == 1,
        type = parsedJson['type'],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'],
        dead = parsedJson['dead'] == 1,
        parent = parsedJson['parent'],
        kids = jsonDecode(parsedJson['kids']),
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "parent": parent,
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
      "dead": dead! ? 1 : 0,
      "deleted": deleted! ? 1 : 0,
      "kids": jsonEncode(kids),
    };
  }
}
