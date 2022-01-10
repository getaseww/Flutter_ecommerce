import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier{
   late File _image;
   File get image=>_image;

   final ImagePicker _picker=ImagePicker();
    void pickImage() async {
    try {
      var pickedImage = await _picker.getImage(source: ImageSource.gallery);
      if(pickedImage !=null){
        _image = File(pickedImage.path);
        notifyListeners();
      }      
     // String fileName = image.path.split('/').last;
      // if (image != null) {
      //   bool result = await Provider.of<ProfileProvider>(context, listen: false)
      //       .uploadImage(image, fileName);
      // }
    } catch (error) {
      print("Image picker error " + "$error");
    }
  }

}