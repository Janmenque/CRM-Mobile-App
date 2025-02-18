import 'package:flutter/material.dart';

class TaskCreate extends StatelessWidget {
  const TaskCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('For'),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 40,
                    width: 200,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 3,
                          bottom: 3,
                          left: 40,
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                            ),
                            padding: const EdgeInsets.only(
                                left: 16, right: 10, top: 8, bottom: 8),
                            child: const Row(
                              children:  [
                                Expanded(
                                  child: Text(
                                    'Rashed gsd fsdgsdfgfdsg sdgsdfg',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(
                                  Icons.clear,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 10,
                          top: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://www.w3schools.com/howto/img_avatar.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Text('In'),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 40,
                    width: 200,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 3,
                          bottom: 3,
                          left: 40,
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                            ),
                            padding: const EdgeInsets.only(
                                left: 16, right: 10, top: 8, bottom: 8),
                            child: const Row(
                              children:  [
                                Expanded(
                                  child: Text(
                                    'Rashed gsd fsdgsdfgfdsg sdgsdfg',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(
                                  Icons.clear,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 10,
                          top: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://www.w3schools.com/howto/img_avatar.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  maxLines: 5,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Description",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {

                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Text('Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
