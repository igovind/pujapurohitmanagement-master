import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../pages/manage/puja/magic_screen.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:pujapurohitmanagement/pages/manage/custom_searchable_dropdown.dart';
import 'package:pujapurohitmanagement/pages/manage/puja/magic_screen.dart';

class CustomTextFormField extends StatelessWidget {
  final initialText;
  final lable;
  final onPress;

  const CustomTextFormField(
      {Key? key, this.initialText, this.lable, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MagicScreen(width: 600, context: context).getWidth,

      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(16),
      // height: 500,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 2)]),
      child: TextFormField(
        initialValue: initialText,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onSaved: onPress,
        validator: (value) =>
            value!.isNotEmpty ? null : "Please Add this Field",
        decoration: InputDecoration(
          labelText: lable,
          border: InputBorder.none,
        ),
        // onSaved: (value) => langE = value!,
      ),
    );
  }
}

class CustomDropdownMenuMultiple extends StatelessWidget {
  final items;
  final lable;
  final selectedItems;
  final onChanged;

  const CustomDropdownMenuMultiple(
      {Key? key, this.items, this.lable, this.onChanged, this.selectedItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MagicScreen(width: 600, context: context).getWidth,

      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(16),
      // height: 500,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 2)]),
      child: SearchChoices.multiple(
        items: items,
        onChanged: onChanged,
        label: lable,
        underline: SizedBox(),
        selectedItems: selectedItems,
        //isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down_circle_outlined,
        ),

        //icon: Icon(Icons.description),
        displayClearIcon: false,
      ),
    );
  }
}

class CustomDropdownMenu extends StatelessWidget {
  final items;
  final lable;
  final value;
  final onChanged;

  const CustomDropdownMenu(
      {Key? key, this.items, this.lable, this.onChanged, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MagicScreen(width: 600, context: context).getWidth,

      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(16),
      // height: 500,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 2)]),
      child: SearchChoices.single(
        items: items,
        onChanged: onChanged,
        label: lable,
        underline: SizedBox(),
        value: value,
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down_circle_outlined,
        ),

        //icon: Icon(Icons.description),
        displayClearIcon: false,
      ),
    );
  }
}

class CustomSimpleDropdown extends StatelessWidget {
  final items;
  final lable;
  final value;
  final onChanged;

  const CustomSimpleDropdown(
      {Key? key, this.items, this.lable, this.onChanged, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MagicScreen(width: 600, context: context).getWidth,

      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(16),
      // height: 500,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 2)]),
      child: DropdownButton<String>(
        value: value,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}

class CustomImageUploader extends StatefulWidget {
  final networkImageUrl;
  final path;
  final imageHeight;
  final imageWidth;
  final Function(String string) onPressed;

  const CustomImageUploader(
      {Key? key,
      this.networkImageUrl =
          "https://lanecdr.org/wp-content/uploads/2019/08/placeholder.png",
      required this.path,
      required this.onPressed,
      this.imageHeight = 100,
      this.imageWidth = 100})
      : super(key: key);

  @override
  _CustomImageUploaderState createState() => _CustomImageUploaderState();
}

class _CustomImageUploaderState extends State<CustomImageUploader> {
  String? imgUrl;

  uploadToStorage() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Alert"),
              content:
                  Text("Are you sure that you want to update this picture?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      FileUploadInputElement input = FileUploadInputElement()
                        ..accept = 'image/*';
                      FirebaseStorage fs = FirebaseStorage.instance;
                      input.click();
                      input.onChange.listen((event) {
                        final file = input.files!.first;
                        final reader = FileReader();
                        reader.readAsDataUrl(file);
                        reader.onLoadEnd.listen((event) async {
                          var snapshot =
                              await fs.ref().child(widget.path).putBlob(file);
                          String downloadUrl =
                              await snapshot.ref.getDownloadURL();
                          setState(() {
                            imgUrl = downloadUrl;
                            widget.onPressed(downloadUrl);
                          });
                        });
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("Continue")),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          uploadToStorage();
        },
        child: Container(
          height: widget.imageHeight,
          width: widget.imageWidth,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    blurStyle: BlurStyle.solid,
                    color: Colors.black)
              ],
              image: DecorationImage(
                  image: NetworkImage(
                    imgUrl == null
                        ? widget.networkImageUrl == null
                            ? "https://lanecdr.org/wp-content/uploads/2019/08/placeholder.png"
                            : widget.networkImageUrl
                        : imgUrl,
                  ),
                  fit: BoxFit.contain)),
        ));
  }
}

class CircularProfileViewer extends StatelessWidget {
  final url;

  const CircularProfileViewer(
      {Key? key,
      this.url =
          "https://lanecdr.org/wp-content/uploads/2019/08/placeholder.png"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MagicScreen(context: context, height: 100).getHeight,
      width: MagicScreen(context: context, width: 100).getWidth,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 5, blurStyle: BlurStyle.solid, color: Colors.black)
          ],
          image: DecorationImage(
              image: NetworkImage(
                url,
              ),
              fit: BoxFit.fill)),
    );
  }
}

Widget checkText(String? string) {
  return string == null
      ? Text(
          "$string",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        )
      : Text("$string");
}
