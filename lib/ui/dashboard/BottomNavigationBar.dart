import 'package:flutter/material.dart';
class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;

  CustomBottomNavigationBar({
    this.defaultSelectedIndex=0,
    required this.onChange,
  });

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _selectedIndex=widget.defaultSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
        children: <Widget>[
          BuildNavBarItem(size,Icons.event,0),
          BuildNavBarItem(size,Icons.home,1),
          BuildNavBarItem(size,Icons.person,2),
        ]
    );
  }
  Widget BuildNavBarItem(Size size, IconData icon, int index) {
    return GestureDetector(
      onTap: (){
        widget.onChange(index);
        setState(() {
          _selectedIndex=index;
        });
      },
      child: Container(
        height: 45,
        width: size.width / 3,
        decoration: index == _selectedIndex
            ? BoxDecoration(
          border: Border(
              bottom: BorderSide(width : 4, color: (Colors.teal[400])!)
          ),
          color: Colors.transparent,
        ): BoxDecoration(),
        child: Icon(
          icon,
          color: index ==_selectedIndex ? Colors.teal[400] : Colors.grey,
        ),
      ),
    );
  }
}