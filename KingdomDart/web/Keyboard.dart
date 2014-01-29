part of Kingdom;
class Keyboard {
  int _wheel = 1;
  Map<int, bool> _keyMap = {};
  Keyboard (){
    window.onKeyDown.listen((KeyboardEvent e) {
       _keyMap[e.keyCode] = true;
    });
    window.onKeyUp.listen((KeyboardEvent e) {
      _keyMap[e.keyCode] = false;
    });
    window.onMouseWheel.listen((WheelEvent e) {
      _wheel += ((e.deltaY.toInt()) ~/ -100);
    });
  }
  bool isKeyDown(int code) {
    if(_keyMap.containsKey(code)) {
      return _keyMap[code];
    } else {
      return false;
    }
  }
  
  int get mouseWheel => _wheel;
}