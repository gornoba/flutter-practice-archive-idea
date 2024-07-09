import 'package:business_card/data/idea_info.dart';
import 'package:business_card/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailScreen extends StatelessWidget {
  IdeaInfo? ideaInfo;
  final dbHelper = DatabaseHelper();

  DetailScreen({super.key, this.ideaInfo});

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
          ideaInfo!.title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // 지우기 전에 확인 다이얼로그
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('주의'),
                    content: Text('정말로 삭제하시겠습니까?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          // 삭제 처리
                          await setDeleteIdeaInfo(ideaInfo!.id!);

                          if (context.mounted) {
                            Navigator.of(context).pop();
                            Navigator.pop(context, 'delete');

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('삭제되었습니다.'),
                              ),
                            );
                          }
                        },
                        child: Text(
                          '삭제',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            child: Text(
              '삭제',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '아이디어를 떠올린 계기',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ideaInfo!.motive,
                      style: TextStyle(
                        color: Color(0xffa5a5a5),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '아이디어 내용',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ideaInfo!.content,
                      style: TextStyle(
                        color: Color(0xffa5a5a5),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '아이디어 중요도 점수',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: ideaInfo!.priority.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 35,
                      itemPadding: EdgeInsets.symmetric(
                        horizontal: 0,
                      ),
                      ignoreGestures: true,
                      updateOnDrag: false,
                      itemBuilder: (context, index) {
                        return Icon(
                          Icons.star,
                          color: Colors.amber,
                        );
                      },
                      onRatingUpdate: (value) {},
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '유저 피드백 사항',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ideaInfo!.feedback!,
                      style: TextStyle(
                        color: Color(0xffa5a5a5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              height: 60,
              alignment: Alignment.center,
              child: Text('내용 편집하기'),
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
              var result = await Navigator.pushNamed(
                context,
                '/edit',
                arguments: ideaInfo,
              );

              if (result != null) {
                Navigator.pop(
                  context,
                  'update',
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future setDeleteIdeaInfo(int id) async {
    // 삭제 처리
    await dbHelper.initDatabase();
    await dbHelper.deleteIdeaInfo(id);
  }
}
