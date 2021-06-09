import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  final bool focus;

  const SearchWidget({Key key, this.text, this.onChanged, this.hintText, this.focus})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchWidget();
  }
}

class _SearchWidget extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextField(
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        autofocus: widget.focus,
        decoration: InputDecoration(
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            borderSide: BorderSide(color: Colors.black26),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          fillColor: Colors.white,
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : GestureDetector(
                  child: Icon(Icons.search, color: Colors.black45),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
          hintText: widget.hintText,
          hintStyle: new TextStyle(
            color: Colors.black38,
            fontSize: 16.sp,
          ),
          contentPadding: EdgeInsets.all(15),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
