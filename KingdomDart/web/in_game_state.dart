part of Kingdom;

const int INPUT = 0;
const int PROCESSING = 1;
const int ANIMATING = 2;
class InGameState extends AppState {
  static const double _scrollSpeed = 0.01;
  int _turnState = INPUT;
  int get turnState => turnState;
  
  TileMap _map;
  int _turnNumber = 0;
  double _timeSinceLastTurn = 0.0;
  double _turnLength = 5.0;
  List<Unit> _selectedUnits;
  bool _inOrderMode = false;
  Order _tempOrder;
  List<WayPoint> _tempOrderPath;
  int _mouseZoom = 0 ;// mouse zoom (starts at 0, number of clicks of the scroll wheel)
  Frame _frame = new Frame(10, 10, 1.0);
  Keyboard _keyboard;
  
  InGameState(this._keyboard) {
    
  }
  
  void nextTurn() {
    
  }
  bool render(CanvasRenderingContext2D context, num delta) {
    _frame.context = context;
    _frame.scrollTo(_mouseZoom);
    _handleInput(delta);
    _renderMap(_frame);
  }
  _handleInput(num delta) {
    var scrollAmt = delta * _scrollSpeed;
    if(_keyboard.isKeyDown(KeyCode.W)) {
      _frame.scrollY -= scrollAmt;
    }
    if(_keyboard.isKeyDown(KeyCode.A)) {
      _frame.scrollX -= scrollAmt;
    }
    if(_keyboard.isKeyDown(KeyCode.S)) {
      _frame.scrollY += scrollAmt;
    }
    if(_keyboard.isKeyDown(KeyCode.D)) {
      _frame.scrollX += scrollAmt;
    }
    
    
    
  }
  _renderMap(Frame frame) {
    _map.draw(frame);
  }
  _renderUnits(Frame frame) {
    
  }
  _renderUI (Frame frame) {
    
  }

}
