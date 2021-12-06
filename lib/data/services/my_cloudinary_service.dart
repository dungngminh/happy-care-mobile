import 'package:cloudinary_public/cloudinary_public.dart';

class MyCloudinaryService {
  CloudinaryPublic? cloudinary;

  MyCloudinaryService() {
    cloudinary = CloudinaryPublic('dlg7e32t9', 'eupybqb8', cache: false);
  }

  Future<String?> uploadFileOnCloudinary({required String filePath}) async {
    try {
    var response = await cloudinary!.uploadFile(
        CloudinaryFile.fromFile(filePath,folder: "Image", resourceType: CloudinaryResourceType.Image),
    
    );
    print("URL is" + response.secureUrl);
    return response.secureUrl;
    } on CloudinaryException catch (e) {
      print(e.message);
      print(e.request);
      return null;
    }
  }
}
