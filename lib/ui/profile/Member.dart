import 'package:flutter/material.dart';

class MemberDetail extends StatelessWidget {
  const MemberDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[400],
        title: Text(
          "Group Members:",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                shadowColor: Colors.grey[300],
                color: Colors.teal[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 16,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [(Colors.teal[100])!, (Colors.teal[200])!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Name: ',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Liew Wei Jun',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.teal[400],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20, width: 350),
                      Row(
                        children: [
                          Text(
                            'Student Id: ',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            '1001955444',
                            style: TextStyle(fontSize: 23),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                shadowColor: Colors.grey[300],
                color: Colors.teal[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 16,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [(Colors.teal[100])!, (Colors.teal[200])!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Name: ',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Goh Kah Hoe',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.teal[400],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20, width: 350),
                      Row(
                        children: [
                          Text(
                            'Student Id: ',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            '1001955697',
                            style: TextStyle(fontSize: 23),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                shadowColor: Colors.grey[300],
                color: Colors.teal[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 16,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [(Colors.teal[100])!, (Colors.teal[200])!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Name: ',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Kee Heng Kai',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.teal[400],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20, width: 350),
                      Row(
                        children: [
                          Text(
                            'Student Id: ',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            '1001956081',
                            style: TextStyle(fontSize: 23),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                shadowColor: Colors.grey[300],
                color: Colors.teal[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 16,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [(Colors.teal[100])!, (Colors.teal[200])!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Name: ',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Hoo Soon Kee',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.teal[400],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20, width: 350),
                      Row(
                        children: [
                          Text(
                            'Student Id: ',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            '1001956253',
                            style: TextStyle(fontSize: 23),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                shadowColor: Colors.grey[300],
                color: Colors.teal[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 16,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [(Colors.teal[100])!, (Colors.teal[200])!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Name: ',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Guo Zheng Peng',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.teal[400],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20, width: 350),
                      Row(
                        children: [
                          Text(
                            'Student Id: ',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            '1001956762',
                            style: TextStyle(fontSize: 23),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
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
