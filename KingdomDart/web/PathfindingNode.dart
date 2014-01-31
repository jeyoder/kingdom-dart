part of Kingdom;

class PathfindingNode {
  WayPoint _waypoint;
  WayPoint get waypoint => _waypoint;
  bool scored = false;
  int totalScore = -1;
  int pastScore = -1;

  PathfindingNode() {
    this.scored = false;
    this.totalScore = -1;
    this.pastScore = -1;
    _waypoint = new WayPoint(-1, -1);
  }
  PathfindingNode.withCordinates(int X, int Y) {
    this.scored = false;
    this.totalScore = -1;
    this.pastScore = -1;
    _waypoint = new WayPoint(X,Y);
  }
  int distanceTo(WayPoint pt) {
    return (_waypoint.x - pt.x).abs() + (_waypoint.y - pt.y).abs();
  }
 bool operator==(PathfindingNode comp) {
   return (_waypoint.x == comp.waypoint.x && _waypoint.y == comp.waypoint.y);
 }
  bool operator<(PathfindingNode comp) { //for binary searching
    if(_waypoint.y < comp.waypoint.y) return true;
    else if (_waypoint.y > comp.waypoint.y) return false;
    else {
      if (_waypoint.x < comp.waypoint.x) return true;
      else return false;
    }
  }
  
  bool operator>(PathfindingNode comp) {
    return !(this < comp || this == comp);
  }
}