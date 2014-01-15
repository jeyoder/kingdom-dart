part of Kingdom;
class Keyboard {
  Map<int, bool> _keyMap = {};
  Keyboard (){
    window.onKeyDown.listen((KeyboardEvent e) {
       _keyMap[e.keyCode] = true;
    });
    window.onKeyUp.listen((KeyboardEvent e) {
      _keyMap[e.keyCode] = false;
    });
  }
  
  bool isKeyDown(int code) {
    if(_keyMap.containsKey(code)) {
      return _keyMap[code];
    } else {
      return false;
    }
  }
}