part of Kingdom;
class Keyboard {
  int _wheel = 1;
  Map<int, bool> _keyMap = {};
  bool _clickHappened = false;
  bool _rClickHappened = false;
  int _clickX = -1;
  int _clickY = -1;
  int _rClickX = -1;
  int _rClickY = -1;
  int _x = -1;
  int _y = -1;
  bool get clickHappened => _clickHappened;
  bool get rClickHappened => _rClickHappened;
  int get clickX => _clickX;
  int get clickY => _clickY;
  int get rClickX => _rClickX;
  int get rClickY => _rClickY;
  int get x => _x;
  int get y => _y;
  bool rDown = false;
  void resetClick() {
    _clickHappened = false;
  }
  void resetRClick() {
    _rClickHappened = false;
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
    context.canvas.onMouseDown.listen((MouseEvent e) {
      if(e.button == 2) {
        window.console.log("moseDoun");
        rDown = true;
      }
    });
    context.canvas.onMouseUp.listen((MouseEvent e) {
      if(e.button == 2) {
        window.console.log("moseUp");
        rDown = false;
      }
    });
    context.canvas.onClick.listen((MouseEvent e) {
      if(e.button == 0) {
        _clickHappened = true;
        _clickX = e.offset.x;
        _clickY = e.offset.y;
      }
      else if(e.button == 1) {
       
      }
    });
    context.canvas.onContextMenu.listen((MouseEvent e) {
      e.preventDefault();
      _rClickHappened = true;
      _rClickX = e.offset.x;
      _rClickY = e.offset.y;
    });
    context.canvas.onMouseMove.listen((MouseEvent e) {
      _x = e.offset.x;
      _y = e.offset.y;
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