part of Kingdom;
class WayPoint {
  int _x;
  int _y;
  int get x => _x;
  int get y => _y;
  WayPoint(this._x, this._y); 

 /* WayPoint closestTile(int YourX, int YourY){
    int xRealOff = this->x-YourX;
    int yRealOff = this->y-YourY;
    int xOff = 0;
    int yOff = 0;
    if(abs(xRealOff) > 0 || abs(yRealOff) > 0){
      if(abs(xRealOff) > abs(yRealOff)){
        xOff = (xRealOff != 0) ? abs(xRealOff)/xRealOff : 0; //will out put 1 or -1 depending on sign of reall offset
      }
      else{
        yOff = (yRealOff != 0) ? abs(yRealOff)/yRealOff : 0;
      }
    }
    //cout << "waypoint Off " << xOff << ", " << yOff << "real off " << xRealOff << ", " << yRealOff;
    //cout.flush();
    return WayPoint(YourX+xOff, YourY+yOff);
  } */

bool operator== (WayPoint comp) {
    return (x == comp.x && y == comp.y);
  }
}