import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:golet/models/users.dart';
import 'package:golet/services/databaseService.dart';
import 'package:golet/services/storage_service.dart';

class EditProfile extends StatefulWidget {
  final User user;

  EditProfile({this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  File _profileImage;
  String _name = '';
  String _bio = '';
  bool _isLoading = false;

  @override
   void initState() {
    
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
  } 

  _handleImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  _displayProfileImage() {
    //No new profile image
    if (_profileImage == null) {
      //No existing profile image
      if (widget.user.profileImageUrl.isEmpty) {
        //Display placeholder
        return Colors.grey;
      } else {
        //user profile image exists
        return CachedNetworkImageProvider(widget.user.profileImageUrl);
      }
    } else {
      //New profile image
      return FileImage(_profileImage);
    }
  }

  _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      //udate user in database
      String _profileImageurl = '';

      if (_profileImage == null) {
        _profileImageurl = widget.user.profileImageUrl;
      } else {
        _profileImageurl = await StorageService.uploadUserProfileImage(
          widget.user.profileImageUrl,
          _profileImage,
        );
      }

      User user = User(
        id: widget.user.id,
        name: _name,
        profileImageUrl: _profileImageurl,
        bio: _bio,
      );
      //database update
      DatabaseService.updateUser(user);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      _isLoading
                          ? LinearProgressIndicator(
                              backgroundColor: Colors.blue.shade700,
                              valueColor: AlwaysStoppedAnimation(Colors.blue),
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: _displayProfileImage(),
                        backgroundColor: Colors.grey,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      FlatButton(
                        onPressed: _handleImageFromGallery,
                        child: Text(
                          'Change Profile Image',
                          style: TextStyle(
                            color: Colors.blue.shade600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue: _name,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                          ),
                          labelText: 'Name',
                        ),
                        validator: (input) => input.trim().length < 1
                            ? 'Please enter a valid name'
                            : null,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      TextFormField(
                        initialValue: _bio,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.book,
                            size: 30,
                          ),
                          labelText: 'Bio',
                        ),
                        validator: (input) => input.trim().length < 150
                            ? 'Please enter a bio less 150 characters'
                            : null,
                        onSaved: (input) => _bio = input,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.blue.shade800,
                          height: 40,
                          width: 250,
                          child: FlatButton(
                            onPressed: _submit,
                            child: Text(
                              'Save Profile',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
