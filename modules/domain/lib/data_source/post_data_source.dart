
import 'package:domain/model/post.dart';
import 'package:domain/model/post_creation.dart';


abstract class PostDataSource {
  Future<Post?> postsWithGeocoords(double lat, double lon);

  Future<void> createPost(PostCreation? postCreation);
}