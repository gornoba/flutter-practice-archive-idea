import 'package:business_card/data/idea_info.dart';
import 'package:business_card/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var dbHelper = DatabaseHelper();
  List<IdeaInfo> listIdeaInfo = [];

  @override
  void initState() {
    super.initState();

    getIdeaInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Archive Idea',
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: listIdeaInfo.length,
          itemBuilder: (context, index) {
            return listItem(index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 새 아이디어 작성 화면 이동
          Navigator.pushNamed(context, '/edit');
        },
        child: Image.asset(
          'assets/ideas.png',
          width: 48,
          height: 48,
        ),
        backgroundColor: Color(0xff7f52fd).withOpacity(0.7),
      ),
    );
  }

  Future<void> getIdeaInfo() async {
    await dbHelper.initDatabase();
    listIdeaInfo = await dbHelper.getAllIdeaInfo();
    listIdeaInfo.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    setState(() {});
  }

  Widget listItem(int index) {
    return Container(
      height: 82,
      margin: EdgeInsets.only(top: 16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xffd9d9d9),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 16,
              bottom: 16,
            ),
            child: Text(
              listIdeaInfo[index].title,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(
                right: 16,
                bottom: 8,
              ),
              child: Text(
                DateFormat("yyyy-MM-dd HH:mm:ss").format(
                  DateTime.fromMillisecondsSinceEpoch(
                    listIdeaInfo[index].createdAt,
                  ),
                ),
                style: TextStyle(
                  color: Color(0xffaeaeae),
                  fontSize: 10,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(
                left: 16,
                bottom: 8,
              ),
              child: RatingBar.builder(
                initialRating: listIdeaInfo[index].priority.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 16,
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
            ),
          ),
        ],
      ),
    );
  }

  Future<void> setInsertIdeaInfo() async {
    await dbHelper.initDatabase();
    IdeaInfo ideaInfo = IdeaInfo(
      title: 'flutter를 개발하기 위한 방법',
      content: 'flutter를 개발하기 위한 방법은 다양한 방법이 있습니다.',
      motive: 'flutter를 개발하기 위한 방법을 알고 싶어서',
      priority: 5,
      feedback: 'flutter를 개발하기 위한 방법을 알게 되었습니다.',
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    await dbHelper.insertIdeaInfo(ideaInfo);
  }
}
