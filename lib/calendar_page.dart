import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart'; // 로케일 초기화 필요

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now(); // 현재 날짜
  DateTime? _selectedDay; // 선택된 날짜
  Set<DateTime> _checkedDays = {}; // 출석 체크된 날짜들

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ko_KR'); // 한국어 로케일 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('상단 노치 영역', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 달력
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            locale: 'ko_KR', // 한국어 설정
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.grey, // 오늘 날짜 스타일
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.black, // 선택된 날짜 스타일
                shape: BoxShape.circle,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (_checkedDays.any((checkedDay) => isSameDay(checkedDay, day))) {
                  return Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFB0F4E6), // 출석 체크 색상
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false, // 월/주 선택 버튼 숨김
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 20),

          // 출석 체크 위젯
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 30),
                const SizedBox(width: 10),
                const Text('출석 체크', style: TextStyle(fontSize: 18)),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_selectedDay != null) {
                        // 출석 체크 토글 (체크/미체크)
                        if (_checkedDays.contains(_selectedDay)) {
                          _checkedDays.remove(_selectedDay);
                        } else {
                          _checkedDays.add(_selectedDay!);
                        }
                      }
                    });
                  },
                  child: Container(
                    width: 40, // 크기 고정
                    height: 40, // 크기 고정
                    decoration: BoxDecoration(
                      color: _selectedDay != null && _checkedDays.contains(_selectedDay)
                          ? const Color(0xFFB0F4E6) // 출석 체크 시 배경색 적용
                          : Colors.transparent, // 미체크 상태 배경색 투명
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5), // 테두리 색상 (연한 회색)
                        width: 2.0, // 테두리 두께
                      ),
                      borderRadius: BorderRadius.circular(10), // 모서리 둥글기
                    ),
                    child: Center(
                      child: _selectedDay != null && _checkedDays.contains(_selectedDay)
                          ? const Icon(Icons.check, color: Colors.black) // 체크 상태 아이콘
                          : const SizedBox.shrink(), // 미체크 상태 빈 위젯
                    ),
                  ),



                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),

      // 하단 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '달력',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
