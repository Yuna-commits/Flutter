import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Timer? _timer; //? : Null 허용

  int _time = 0;
  bool _isRunning = false;//시작 버튼을 누를 때의 상태

  final List<String> _lapTimes = [];//시간 기록 리스트, 수정 x

  void _clickButton() {
    _isRunning = !_isRunning;//true, false 바꿈

    if(_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  //스톱 워치 시작 버튼을 눌렀을 때
  void _start() {//10ms 마다 실행
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  //정지 버튼을 눌렀을 때
  void _pause() {
    _timer?.cancel();
  }

  //초기화 버튼을 눌렀을 때
  void _reset() {
    _isRunning = false;
    _timer?.cancel();//타이머 정지
    _lapTimes.clear();//리스트의 모든 내용 삭제
    _time = 0;//타이머 초기화
  }

  //기록 버튼을 눌렀을 때마다 타이머 시간 표시
  void _recordLapTime(String time) {
    _lapTimes.insert(0, '${_lapTimes.length+1}등 $time');
  }

  @override
  void dispose() {
    _timer?.cancel();//_timer 가 null 이 아니면 cancel
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int sec = _time ~/ 100;
    //padLeft: 두자리 표시, 두 자리가 안되면 앞에 0 삽입
    String hundredth = '${_time % 100}'.padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: const Text('스톱워치'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30,),
          //타이머
          Row(
            //세컨드 센터 정렬
            mainAxisAlignment: MainAxisAlignment.center,
            //밀리 세컨드 위치를 더 아래(end)로(???)
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [//second, millisecond
              Text('$sec',
                style: const TextStyle(fontSize: 50),),
              Text(
                hundredth,
                ),
            ],
          ),
          //시간 기록 리스트 (스크롤)
          SizedBox(
            width: 100,
            height: 200,
            child: ListView(//스크롤 발생
              children:
                //기록 가운데 정렬
                _lapTimes.map((time) => Center(child: Text(time))).toList()
              ,
            ),
          ),
          const Spacer(),//Row 윗부분 빈 공간 space 로 채우기
          //버튼
          Row(
            //버튼 사이 간격 space
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //초기화 버튼
              FloatingActionButton(
                backgroundColor: Colors.orange,
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
                child: const Icon(Icons.refresh),
              ),
              //시작 버튼
              FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: () {
                  setState(() {
                    _clickButton();
                  });
                },
                //실행 중이면 pause 버튼, 아니면 play 버튼
                child: _isRunning
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
              ),
              //시간 기록 버튼(+ 모양)
              FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  setState(() {
                    _recordLapTime('$sec.$hundredth');
                  });
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}
