import 'package:firebase_storage/firebase_storage.dart';

class Post {
  String userID;

  Post({required this.userID});

  getAllPostsFromUserId({required String userID}) async{
    List urlList = [];
    final ListResult result =
        await FirebaseStorage.instance.ref('feed/$userID/images/').listAll();
    for (final ref in result.items) {
      final url = await ref.getDownloadURL();
      urlList.add(url.toString());
    }
    return urlList;
  }

  Future<List<String>> getImages() async {
    List<String> imageUrls = [];
    final ref = FirebaseStorage.instance.ref('feed/$userID/images/').child(userID);
    final result = await ref.listAll();
    final urls = await Future.wait(result.items.map((ref) => ref.getDownloadURL()));
    imageUrls.addAll(urls);
    return imageUrls;
  }
}
