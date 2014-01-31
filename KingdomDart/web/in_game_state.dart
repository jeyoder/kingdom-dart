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
  King fred = new King(0,0,0);
  Unit selectedUnit = null;
  InGameState(this._keyboard, MapLoader loader) {
    _map = new TileMap(loader);
    _map.add(fred);
  }
  
  void nextTurn() {
    
  }
  bool render(CanvasRenderingContext2D context, num delta) {
    _frame.context = context;
    _handleInput(delta);
    _renderMap(_frame);
  }
  _handleInput(num delta) {
    if(_keyboard.rDown && selectedUnit != null) {
      var clickX = (_frame.scrollX * TileMap.tileW * _frame.scale) - (_frame.w / 2) + _keyboard.x; //tile location in pixels
      var clickY = (_frame.scrollY * TileMap.tileH * _frame.scale) - (_frame.h / 2) + _keyboard.y;
      var clickedTileX = clickX / (TileMap.tileW * _frame.scale); //convert to tiles
      var clickedTileY = clickY / (TileMap.tileH * _frame.scale);
      var o = new Order([new WayPoint(clickedTileX.toInt(), clickedTileY.toInt())], 0, _map);
      _tempOrderPath = o.getPath(new WayPoint(selectedUnit.tileX, selectedUnit.tileY));
    } else {
      _tempOrderPath = null;
    }
    if(_keyboard.clickHappened) {
      window.console.log(_frame.scale);
      window.console.log("screen loc ${_keyboard.clickX}, ${_keyboard.clickY}");
      var clickX = (_frame.scrollX * TileMap.tileW * _frame.scale) - (_frame.w / 2) + _keyboard.clickX; //tile location in pixels
      var clickY = (_frame.scrollY * TileMap.tileH * _frame.scale) - (_frame.h / 2) + _keyboard.clickY;
      window.console.log("clickPix $clickX, $clickY");
      var clickedTileX = clickX / (TileMap.tileW * _frame.scale); //convert to tiles
      var clickedTileY = clickY / (TileMap.tileH * _frame.scale);
      window.console.log("click on $clickedTileX, $clickedTileY");
      selectedUnit = _map.unitAt(clickedTileX.toInt(), clickedTileY.toInt());
      
      _keyboard.resetClick();
    }
    
    if(_keyboard.rClickHappened) {
      window.console.log(_frame.scale);
      window.console.log("screen loc ${_keyboard.clickX}, ${_keyboard.clickY}");
      var clickX = (_frame.scrollX * TileMap.tileW * _frame.scale) - (_frame.w / 2) + _keyboard.clickX; //tile location in pixels
      var clickY = (_frame.scrollY * TileMap.tileH * _frame.scale) - (_frame.h / 2) + _keyboard.clickY;
      window.console.log("clickPix $clickX, $clickY");
      var clickedTileX = clickX / (TileMap.tileW * _frame.scale); //convert to tiles
      var clickedTileY = clickY / (TileMap.tileH * _frame.scale);
      if(selectedUnit != null) {
        selectedUnit.giveOrder(new Order([new WayPoint(clickedTileX.toInt(), clickedTileY.toInt())],1,_map));
      }
      
      _keyboard.resetRClick();
    }
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
    
    _frame.scrollTo(_keyboard.mouseWheel);
  }
  _renderMap(Frame frame) {
    _map.draw(frame, selectedUnit, _tempOrderPath);
  }
  _renderUnits(Frame frame) {
    
  }
  _renderUI (Frame frame) {
    
  }

}
