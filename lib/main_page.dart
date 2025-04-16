import 'package:flutter/material.dart';

//StatefulWidget: 상태가 있는 위젯, 생성된 화면에 계속 변화가 있음
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int number = 10;//전역변수
  String _text = '';
  final _textController = TextEditingController();

  @override
  void dispose() {//TextEditingController() 메모리 해제
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold: 디자인적인 뼈대를 구성하는 위젯
    // 기본적인 Material Design(구글식 디자인 컨셉)의 시각적인 레이아웃 구조를 실행
    return Scaffold(
      appBar: AppBar(
          title: Text('카운터')
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,//Column 내부에서 정렬
            children: [
              Container(
                color: Colors.red,
                width: 100,
                height: 100,
              ),
              SizedBox(height: 30,),
              Container(height: 30,),
              Text(
                '숫자',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
              Text(
                '$number',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 70,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('ElevatedButton');
                },
                child: Text('ElevatedButton'),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text('TextButton')
              ),
              OutlinedButton(
                  onPressed: () {},
                  child: Text('OutlinedButton')
              ),
              Row(
                children: [
                  Expanded(//child 요소를 최대 사이즈까지(남은 부분 전부) 확장
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: '글자',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        _text = text;
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print(_textController.text);

                        //화면 갱신
                        setState(() { });
                      },
                      child: Text('login'),
                  ),
                ],
              ),
              Text(_textController.text),
              Image.network(
                  'https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                      'assets/image.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //FloatingActionButton: 앱 주요 인터페이스 위에 떠있는 버튼, 주요 액션을 사용자가 쉽게 수행
      //ex) 메일 앱의 '편지 쓰기' 버튼, 최상단, 최하단 이동 버튼
      floatingActionButton: FloatingActionButton(
        //onPressed: 버튼을 눌렀을 때의 처리 함수
        onPressed: () {
          //화면 갱신
          setState(() {
            number++;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
