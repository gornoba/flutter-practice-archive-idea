import 'package:business_card/data/idea_info.dart';
import 'package:business_card/database/database_helper.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  IdeaInfo? ideaInfo;
  EditScreen({super.key, this.ideaInfo});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _motiveController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  bool isClickPoint1 = false;
  bool isClickPoint2 = false;
  bool isClickPoint3 = true;
  bool isClickPoint4 = false;
  bool isClickPoint5 = false;

  // default 3;
  int priorityPoint = 3;

  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '새 아이디어 작성하기',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('제목'),
              Container(
                margin: EdgeInsets.only(top: 8),
                height: 41,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    hintText: '아이디어 제목을 입력해주세요.',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0xffb4b4b4),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  controller: _titleController,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text('아이디어를 떠돌린 계기'),
              Container(
                margin: EdgeInsets.only(top: 8),
                height: 41,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    hintText: '아이디어를 떠올리게 된 계기를 입력해주세요.',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0xffb4b4b4),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  controller: _motiveController,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text('아이디어를 내용'),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: TextField(
                  maxLength: 500,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    hintText: '아이디어를 상세히 입력해주세요.',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0xffb4b4b4),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  controller: _contentController,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text('아이디어를 중요도 점수'),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color:
                              isClickPoint1 ? Color(0xffd6d6d6) : Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        width: 50,
                        height: 40,
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        initClickStatus();
                        setState(() {
                          isClickPoint1 = true;
                          priorityPoint = 1;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color:
                              isClickPoint2 ? Color(0xffd6d6d6) : Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        width: 50,
                        height: 40,
                        child: Text(
                          '2',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        initClickStatus();
                        setState(() {
                          isClickPoint2 = true;
                          priorityPoint = 2;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color:
                              isClickPoint3 ? Color(0xffd6d6d6) : Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        width: 50,
                        height: 40,
                        child: Text(
                          '3',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        initClickStatus();
                        setState(() {
                          isClickPoint3 = true;
                          priorityPoint = 3;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color:
                              isClickPoint4 ? Color(0xffd6d6d6) : Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        width: 50,
                        height: 40,
                        child: Text(
                          '4',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        initClickStatus();
                        setState(() {
                          isClickPoint4 = true;
                          priorityPoint = 4;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color:
                              isClickPoint5 ? Color(0xffd6d6d6) : Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        width: 50,
                        height: 40,
                        child: Text(
                          '5',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        initClickStatus();
                        setState(() {
                          isClickPoint5 = true;
                          priorityPoint = 5;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text('유저 피드백 사항 (선택)'),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: TextField(
                  maxLength: 500,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    hintText: '떠오르신 아이디어 기반으로\n전달받은 피드백을 정리해주세요.',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0xffb4b4b4),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  controller: _feedbackController,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                child: Container(
                  height: 41,
                  alignment: Alignment.center,
                  child: Text('아이디어 작성완료'),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onTap: () async {
                  String titleString = _titleController.text.toString();
                  String motiveString = _motiveController.text.toString();
                  String contentString = _contentController.text.toString();
                  String feedbackString = _feedbackController.text.toString();

                  if (titleString.isEmpty ||
                      motiveString.isEmpty ||
                      contentString.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('비어있는 항목이 있습니다.'),
                        duration: Duration(
                          seconds: 2,
                        ),
                      ),
                    );
                    return;
                  }

                  if (widget.ideaInfo == null) {
                    var ideaInfo = IdeaInfo(
                      title: titleString,
                      motive: motiveString,
                      content: contentString,
                      priority: priorityPoint,
                      feedback: feedbackString.isNotEmpty ? feedbackString : '',
                      createdAt: DateTime.now().millisecondsSinceEpoch,
                    );
                    await setInsertIdeaInfo(ideaInfo);
                  }

                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setInsertIdeaInfo(IdeaInfo ideaInfo) async {
    await dbHelper.initDatabase();
    await dbHelper.insertIdeaInfo(ideaInfo);
  }

  void initClickStatus() {
    isClickPoint1 = false;
    isClickPoint2 = false;
    isClickPoint3 = false;
    isClickPoint4 = false;
    isClickPoint5 = false;
  }
}
