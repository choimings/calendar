import 'package:flutter/material.dart';

class MemoPage extends StatefulWidget {
  final DateTime selectedDate;

  const MemoPage({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  String _alarmName = '';
  String _alarmFrequency = '매일'; // 초기 선택값
  bool _alarmEnabled = true;
  TextEditingController _memoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상단 노치 영역'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.selectedDate.year}년 ${widget.selectedDate.month}월 ${widget.selectedDate.day}일',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('알림 이름'),
            TextField(
              decoration: InputDecoration(
                hintText: '알림 이름을 입력하세요.',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _alarmName = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('알림 설정'),
                Switch(
                  value: _alarmEnabled,
                  onChanged: (value) {
                    setState(() {
                      _alarmEnabled = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFrequencyButton('매일'),
                _buildFrequencyButton('매주'),
                _buildFrequencyButton('매월'),
              ],
            ),
            const SizedBox(height: 20),
            const Text('알림 메모'),
            TextField(
              controller: _memoController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: '메모를 입력하세요.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('취소'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    _saveMemo();
                  },
                  child: const Text('저장', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text('홈'),
            Text('달력'),
            Text('마이페이지'),
          ],
        ),
      ),
    );
  }

  Widget _buildFrequencyButton(String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _alarmFrequency == label ? Colors.grey : Colors.white,
        foregroundColor: _alarmFrequency == label ? Colors.white : Colors.black,
        side: const BorderSide(color: Colors.black),
      ),
      onPressed: () {
        setState(() {
          _alarmFrequency = label;
        });
      },
      child: Text(label),
    );
  }

  void _saveMemo() {
    // 메모 저장 로직
    print('날짜: ${widget.selectedDate}');
    print('알림 이름: $_alarmName');
    print('설정: $_alarmEnabled');
    print('반복 주기: $_alarmFrequency');
    print('메모: ${_memoController.text}');
  }
}