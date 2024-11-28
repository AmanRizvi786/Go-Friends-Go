import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/widgets/chat_widgets/gradient_icon.dart';

class ChatField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String hinttext;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Icon? icon;
  final Icon? prefixIcon;
  const ChatField({
    this.controller,
    super.key,
    this.label,
    required this.hinttext,
    this.keyboardType,
    this.validator,
    this.icon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(52),
        color: Colors.white,
        border: Border.all(color: const Color.fromARGB(54, 38, 8, 37)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              style: const TextStyle(color: Colors.black),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              validator: validator,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(52)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(52),
                    borderSide: BorderSide.none),
                labelText: label,
                hintText: hinttext,
                prefixIcon: prefixIcon,
                suffixIcon: icon,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 183, 177, 177)),
                labelStyle: const TextStyle(color: Colors.black),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(52)),
              ),
              keyboardType: keyboardType,
            ),
          ),
          IconButton(
            icon: GradientIcon(
              icon: Icons.attach_file,
              size: mediaquerywidth(0.06, context),
              gradient: const LinearGradient(
                  colors: AppColors.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            onPressed: () {
              showAttachmentOptions(context);
              // Handle attach file action
            },
          ),
          IconButton(
            icon: GradientIcon(
              icon: Icons.person_add_alt_1_outlined,
              size: mediaquerywidth(0.06, context),
              gradient: const LinearGradient(
                  colors: AppColors.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            onPressed: () {
              // Handle select contact action
            },
          ),
        ],
      ),
    );
  }
}

void showAttachmentOptions(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: EdgeInsets.only(bottom: mediaqueryheight(0.13, context)),
        alignment: Alignment.bottomCenter,
        backgroundColor: AppColors.blackColor,
        contentPadding: EdgeInsets.zero,
        content: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: mediaqueryheight(0.03, context)),
              child: SizedBox(
                width: mediaquerywidth(0.9, context),
                height: mediaqueryheight(0.14, context),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: [
                    _buildGridOption(
                      context,
                      CupertinoIcons.doc_text_fill,
                      'Document',
                      const Color.fromARGB(255, 61, 18, 181),
                          () {},
                    ),
                    _buildGridOption(
                      context,
                      Icons.photo,
                      'Gallery',
                      Colors.pink,
                          () {
                        // Your action here
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 15,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop(); // Closes the dialog
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}


Widget _buildGridOption(BuildContext context, IconData icon, String label,
    Color color, Function()? ontap) {
  return InkWell(
    //onTap: ontap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: ontap,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(16.0),
            child: Icon(icon, color: Colors.white, size: 30.0),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
