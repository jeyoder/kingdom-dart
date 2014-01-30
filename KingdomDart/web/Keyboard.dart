part of Kingdom;
class Keyboard {
  int _wheel = 1;
  Map<int, bool> _keyMap = {};
  bool _clickHappened = false;
  int _clickX = -1;
  int _clickY = -1;
  
  bool get clickHappened => _clickHappened;
  int get clickX => _clickX;
  int get clickY => _clickY;
  void resetClick() {
    _clickHappened = false;
  }
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
    context.canvas.onClick.listen((MouseEvent e) {
      if(e.button == 0) {
        _clickHappened = true;
        _clickX = e.offset.x;
        _clickY = e.offset.y;
      }
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