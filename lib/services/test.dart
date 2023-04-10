import 'package:flutter/material.dart';
import 'package:note_taking/style/app_style.dart';

class testing extends StatefulWidget {
  const testing(this.search ,{Key? key}) : super(key: key);
  final search;
  @override
  State<testing> createState() => _testingState();
}

class _testingState extends State<testing> {
  var searchTerm;
  @override
  void initState() {
    // TODO: implement initState
    searchTerm = widget.search;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(searchTerm);
    return Text(searchTerm,
    style: AppStyle.test1,);
  }
}
