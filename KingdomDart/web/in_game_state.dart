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
  
  List<Unit> _selectedUnits;
  bool _inOrderMode = false;
  Order _tempOrder;
  List<WayPoint> _tempOrderPath;
  int _mouseZoom = 0 ;// mouse zoom (starts at 0, number of clicks of the scroll wheel)
  Frame _frame = new Frame(10, 10, 1.0);
  Keyboard _keyboard;
  King fred = new King(0,0,0);
  Unit selectedUnit = null;
  int _turnLength = 5000; //in Miliseconds
 
  Element _turnInfo = querySelector("#turnInfo");
  
  InGameState(this._keyboard, MapLoader loader) {
    _map = new TileMap(loader);
    _map.add(fred);
    _timeSinceLastTurn = 0.0;
    List<WayPoint> fredsOrders = [new WayPoint(3,3)];
    fred.giveOrder(new Order(fredsOrders, 1, _map));
  }
  
  void nextTurn() {
    _turnNumber++;
    _turnState = PROCESSING;
    print( "Next Turn");
    //Tell all the units to take their turn
    List<Unit> unitList = _map.mapObjects;
    for(int i = 0; i < unitList.length; i++){
      unitList[i].nextUnitTurn();
    }
    //Change turn state
    _turnState = ANIMATING; //Will remain in animated state until all units report their state to input
  }
  bool render(CanvasRenderingContext2D context, num delta) {
    _frame.context = context;
    //Game Logic
    switch (_turnState){
      case INPUT:
        _timeSinceLastTurn += delta;
        if(_timeSinceLastTurn >= _turnLength){
          nextTurn();
          _timeSinceLastTurn = _timeSinceLastTurn - _turnLength;
        }
        break;
      case ANIMATING:
        bool StillAnimating = false;
        List<Unit> unitList = _map.mapObjects;
        for(int i = 0; i < unitList.length; i++){
          if(unitList[i].currentUnitTurnState == ANIMATING){
            StillAnimating = true; //if someone is still animating we have to stay in the animating state
            unitList[i].moveAnimate(delta);
          }
        }
        if(!StillAnimating){
          _turnState = INPUT;
        }
        break;
    }
    _handleInput(delta);
    _renderMap(_frame);
    _renderUI(_frame);
  }
  
  //
  _handleInput(num delta) {
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
    _map.draw(frame, selectedUnit);
  }
  _renderUnits(Frame frame) {
    
  }
  _renderUI (Frame frame) {
    //All the render code probably should not go her
    //Should eventually have UIelement objects that can each be told to render themselves
    _turnInfo.text = "Turn $_turnNumber : (${((_turnLength-_timeSinceLastTurn)/1000).ceil()})";
  }

}
