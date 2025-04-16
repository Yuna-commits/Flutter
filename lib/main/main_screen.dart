import 'package:bmi_calculator/result/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();//Form의 상태
  //TextEditingController: 텍스트 필드 제어 클래스
  //텍스트 필드의 텍스트 편집, 입력된 값을 가져오거나 상태 변경 등의 작업 수행
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();


  //화면의 첫 시작
@override
  void initState() {
    super.initState();

   load();
  }

  //앱이 종료될 때 메모리 해제
  @override
 void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  //앱이 종료될 때 현재 입력 값을 임시 저장
  Future save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('height', double.parse(_heightController.text));
    await prefs.setDouble('weight', double.parse(_weightController.text));
  }

  Future load() async {
    final prefs = await SharedPreferences.getInstance();
    final double? height =prefs.getDouble('height');
    final double? weight =prefs.getDouble('weight');

    if(height != null && weight != null)
    _heightController.text = '$height';
    _weightController.text = '$weight';
    print('키 : $height, 몸무게 : $weight');
  }

  //메인 화면
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('비만도 계산기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              //Column 의 오른쪽으로 정렬
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //TextFormField(): TextField 에 잘못된 정보를 입력했을 때 에러 처리
                //키
                TextFormField(
                  controller: _heightController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '키'
                  ),
                  //숫자 키패드가 나오도록 설정
                  keyboardType: TextInputType.number,
                  //결과 버튼을 눌렀을 때, 올바른 값이 입력됐는지 에러 체크
                  validator: (value) { //value: 키 텍스트 필드에 입력된 값, String? 타입
                    if(value == null || value.isEmpty) {
                      return '키를 입력하세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8,),
                //몸무게
                TextFormField(
                  controller: _weightController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '몸무게'
                  ),
                  //숫자 키패드가 나오도록 설정
                  keyboardType: TextInputType.number,
                  //결과 버튼을 눌렀을 때, 올바른 값이 입력됐는지 에러 체크
                  validator: (value) { //value: 키 텍스트 필드에 입력된 값, String? 타입
                    if(value == null || value.isEmpty) {
                      return '몸무게를 입력하세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8,),
                //결과 버튼을 누르면
                ElevatedButton(
                  onPressed: () {
                    //null이 아닌 경우에만 validate() 수행, null이면 false 치환
                    //false, 에러가 있으면 return, 그렇지 않으면 결과 화면으로 넘어감
                    if (_formKey.currentState?.validate() == false) {
                      return;
                    }

                    save();

                    //ResultScreen 으로 이동
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                              //입력 받은 height, weight를 ResultScreen으로 보냄
                              //String -> double 변환
                              height: double.parse(_heightController.text),
                              weight: double.parse(_weightController.text),
                          ),
                        ),
                    );
                  },
                  child: const Text('결과'),),
              ],
            ),
        ),
      ),
    );
  }
}
