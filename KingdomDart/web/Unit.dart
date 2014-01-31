part of Kingdom;
abstract class Unit extends PlayerAsset{
  static const int INPUT = 0;
  static const int ANIMATING = 1;
  
  int tileX, tileY;
  int offsetX=0,offsetY=0;
  String myImagePlayerSufix;
  String myImagePlayerPrefix;
  String get myImage => myImagePlayerPrefix+myImagePlayerSufix+".png";
  int tilesPerTurn = 1; //Would likely be called something like "Movement Speed" in game UI
  int timePerTile = 1000; //How many miliseconds it takes to move one tile while animating
  int tilesMovedAlready = 0;
  int msAlreadyAnimated = 0;
  int _currentUnitTurnState = INPUT;
  int get currentUnitTurnState => _currentUnitTurnState;
 // SDL_Texture* texture;urnState 
  List<Order> orders = new List<Order>();
  Order currentOrder;
  WayPoint currentMovingToPoint = new WayPoint(0,0);
  
  Unit(int PlayerNumber, int TileX, int TileY) : super(){
    _player = PlayerNumber;
    tileX = TileX;
    tileY = TileY;
    switch(_player){
      case 0:
        myImagePlayerSufix = "Green";
        break;
      case 1:
        myImagePlayerSufix = "Red";
        break;
    }
  }

  void draw(Frame frame) {
    /*Rectangle<int> destRect = new Rectangle<int>(
      ((tileX - frame.scrollX) * frame.getW() * frame.scale) + (frame.getW() / 2),
      ((tileY - frame.scrollY) * frame.getH() * frame.scale) + (frame.getH() / 2),
      tileW * frame.scale,
      tileH * frame.scale
    );
    Rectangle<int> animatedDestRect(destRect.left + offsetX * frame.scale)
    //cout << "offsetX = " << drawingUnit.offsetX;
    animatedDestRect.left += ;
    animatedDestRect.top += offsetY * frame.scale;
    SDL_RenderCopy(frame.renderer, texture, NULL, animatedDestRect); //draw the unit, if exists*/
  }


  WayPoint getPosition() {
    return new WayPoint(tileX, tileY);
  }
  /*void Unit::render(SDL_Renderer* Renderer,SDL_Window* Window){

  }*/
  void giveOrder(Order theOrder){
    window.console.log("Looky here unit at ($tileX,$tileY) got a order");
    orders.add(theOrder); //????????????????????????????????????????????????????????????????????
  }
  void nextUnitTurn(){
    if(orders.length > 0){ //if we have orders...
      for(Order o in orders) {
        o.decrementTurns(); //, then decrement their turns
      }
      for(int i = orders.length - 1; i >= 0; i--){
        //loop through and look for most recent order that is is ready
        if(orders[i].turnsTillExecute <= 0){
          orders[i].activated = true;
          currentOrder = orders[i];
          _currentUnitTurnState = ANIMATING;
          currentMovingToPoint = currentOrder.nextTile(getPosition());
          //delete everything before it
          for(int ii = 0; ii < i; ii++){
            window.console.log("deleting ii $ii\n");
            orders.removeAt(ii);
          }

          break;
        }
      }
    }
  }
  void moveAnimate(double delta){

    if(currentUnitTurnState == ANIMATING){
      //if(msAlreadyAnimated == -1){
      //If this is the first time this turn

      currentOrder.updateStatus(getPosition());
      //msAlreadyAnimated = 0;
    //}
    //std::cout << "----- \n next closest tile " << currentMoveingToPoint.getX() << ", " << currentMoveingToPoint.getY() << " tiles already movied " << tilesMovedAlready <<"\n";
    if(currentOrder != null && !currentOrder.completed && tilesMovedAlready < tilesPerTurn){
      msAlreadyAnimated += delta;
      int workingTime = msAlreadyAnimated;
      if(msAlreadyAnimated > timePerTile){
        workingTime = timePerTile;
      }
      int xFinalOff = (currentMovingToPoint.x-tileX != 0) ? (currentMovingToPoint.x-tileX).abs()/(currentMovingToPoint.x-tileX)*TileMap.tileW : 0;
      int yFinalOff = (currentMovingToPoint.y-tileY != 0) ? (currentMovingToPoint.y-tileY).abs()/(currentMovingToPoint.y-tileY)*TileMap.tileH : 0;

      //std::cout << "t parts " <<abs(currentMoveingToPoint.getY()-tileX) << ", " << (currentMoveingToPoint.getY()-tileY) << ", " << TileMap::tileH;
      //std::cout.flush();
      double movedPercent = workingTime/timePerTile;
      offsetX = xFinalOff*movedPercent as int;
      offsetY = yFinalOff*movedPercent as int;
      //std::cout << "offset " <<offsetX << ", " << offsetY <<  " movedPercent " << movedPercent << " wt " << workingTime << " FinalOff " << xFinalOff << ", " << yFinalOff << "\n";
      //std::cout.flush();
      if(msAlreadyAnimated > timePerTile){ // find a new tile

        //Done for this time
        tileX = currentMovingToPoint.x;
        tileY = currentMovingToPoint.y;
        offsetX = 0;
        offsetY = 0;
        tilesMovedAlready++;
        currentMovingToPoint = currentOrder.nextTile(new WayPoint(tileX, tileY));
        msAlreadyAnimated = msAlreadyAnimated-timePerTile;
      }
    }
    else{
      //ok current order is done. Let's call go back to input
      msAlreadyAnimated = 0;
      //tilesMovedAlready = 0;
      //tilesMovedAlready++;
      if(tilesMovedAlready >= tilesPerTurn || currentOrder.completed){
        tilesMovedAlready = 0;
        _currentUnitTurnState = INPUT;
      }
      if(currentOrder.completed){
        orders.remove(currentOrder);
        print("made5 and size is now $orders.length");
      }
    }
  }
}
int getUnitTurnState(){
  return currentUnitTurnState;
}

}