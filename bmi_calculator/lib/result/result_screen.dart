import 'package:flutter/material.dart';

//Stateless: 화면에 변경이 없는 경우 사용
class ResultScreen extends StatelessWidget {
  final double height;
  final double weight;

  //required: 반드시 필요함
  const ResultScreen({//ResultScreen 생성자
  super.key,
  required this.height,
  required this.weight,
});

  //BMI 결과 반환
  String _calcBmi(double bmi) {
    String result = '저체중';

    if (bmi >= 35) {
      result = '고도 비만';
    } else if (bmi >= 30) {
      result = '2단계 비만';
    } else if (bmi >= 25) {
      result = '1단계 비만';
    } else if (bmi >= 23) {
      result = '과체중';
    } else if (bmi >= 18.5) {
      result = '정상';
    }
    return result;
  }

  //BMI 아이콘 위젯 반환
  Widget _buildIcon(double bmi) {
    Icon icon = const Icon(//저체중
      Icons.sentiment_neutral,
      color: Colors.yellow,
      size: 100,
    );
    if (bmi >= 23) {//과체중 이상
      icon = const Icon(
        Icons.sentiment_dissatisfied_rounded,
        color: Colors.red,
        size: 100,);
    } else if (bmi >= 18.5) {//정상
      icon = const Icon(
        Icons.sentiment_satisfied_alt_outlined,
        color: Colors.green,
        size: 100,);
    }
    return icon;
  }

  //결과 화면
  @override
  Widget build(BuildContext context) {
    final double bmi = weight / ((height / 100.0) * (height / 100.0));

    return Scaffold(
      appBar: AppBar(
        title: const Text('결과'),
      ),
      body: Center(
        child: Column(//화면 전체의 중앙에 정렬
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _calcBmi(bmi),//결과 텍스트
              style: const TextStyle(fontSize: 36),
            ),
            _buildIcon(bmi),//결과 아이콘
          ],
        ),
      ),
    );
  }
}
