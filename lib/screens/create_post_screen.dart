import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:golet/models/post_model.dart';
import 'package:golet/models/user_data.dart';
import 'package:golet/services/databaseService.dart';
import 'package:golet/services/storage_service.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File _image;
  TextEditingController _locationController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  String _location = '';
  String _type = '';
  String _description = '';
  String _price = '';
  bool _isLoading = false;

  _showSelectImageDialog() {
    return Platform.isIOS ? _iosBottomSheet() : _androidDialog();
  }

  _iosBottomSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Add Photo'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: _handleImage(ImageSource.camera),
              child: Text('Take Photo'),
            ),
            CupertinoActionSheetAction(
              onPressed: _handleImage(ImageSource.gallery),
              child: Text('Choose From Gallery'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        );
      },
    );
  }

  _androidDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Add Photo'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Take Photo'),
                onPressed: null,
              ),
              SimpleDialogOption(
                child: Text('Choose From Gallery'),
                onPressed: null,
              ),
              SimpleDialogOption(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  _handleImage(ImageSource source) async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: source);
    if (imageFile != null) {
      imageFile = await _cropImage(imageFile);
      setState(() {
        _image = imageFile;
      });
    }
  }

  _cropImage(File imageFile) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    return croppedImage;
  }

  _submit() async {
    if (!_isLoading &&
        _image != null &&
        _location.isNotEmpty &&
        _type.isNotEmpty &&
        _description.isNotEmpty &&
        _price.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      // create post
      String imageUrl = await StorageService.uploadPost(_image);
      Post post = Post(
        imageUrl: imageUrl,
        location: _location,
        type: _type,
        description: _description,
        price: _price,
        favs: {},
        authorId: Provider.of<UserData>(context).currentUserId,
        timeStamp: Timestamp.fromDate(DateTime.now()),
      );
      DatabaseService.createPost(post);

      // reset data
      _locationController.clear();
      _typeController.clear();
      _descriptionController.clear();
      _priceController.clear();

      setState(() {
        _location = '';
        _type = '';
        _description = '';
        _price = '';
        _image = null;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Title(
          color: Colors.white,
          child: Image.asset(
            'assets/inhabitants_logo.png',
            scale: 8,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _submit,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: _showSelectImageDialog,
                  child: Container(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[300],
                    child: _image == null
                        ? Icon(
                            Icons.add_a_photo,
                            color: Colors.white70,
                            size: 150,
                          )
                        : Image(
                            image: FileImage(_image),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: _locationController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Location',
                    ),
                    onChanged: (input) => _location = input,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: _typeController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(labelText: 'Type'),
                    onChanged: (input) => _type = input,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: _descriptionController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(labelText: 'Description'),
                    onChanged: (input) => _description = input,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(labelText: 'Price'),
                    onChanged: (input) => _price = input,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
