part of Kingdom;
class Order {
  List<WayPoint> _waypoints;
  List<WayPoint> get waypoints => new List<WayPoint>.from(_waypoints);
  bool get completed => _waypoints.size() == 0;
  int _turnsTillExecute;
  int get turnsTillExecute => _turnsTillExecute;
  TileMap _map;
  bool activated = false;
  Order(this._waypoints, _TurnsTillExecute, this._map);
  void decrementTurns(){
    _turnsTillExecute--;
  }
  WayPoint nextTile(WayPoint currentPos){
    if (_waypoints.length == 0 || _waypoints[0] == currentPos) return currentPos;
    List<WayPoint> path =  aStar(currentPos,_waypoints[0]);
  
      return path.length > 0 ? path[0] : currentPos;
  }
  
  void updateStatus(WayPoint currentPos) {
    if(_waypoints.length > 0 && currentPos == _waypoints[0]) { //reached goal waypoint
      _waypoints.removeAt(0);
    }
  }
  

  List<WayPoint> getPath(WayPoint startPos) {
    return aStar(startPos, _waypoints[0]); //TODO: do all waypoints
  }
  /*List<WayPoint> aStar(WayPoint from, WayPoint to) {
    std::map<PathfindingNode, PathfindingNode> parent;
    set<PathfindingNode> closedSet;
    set<PathfindingNode> openSet;
    PathfindingNode initialNode = PathfindingNode(from);
    initialNode.pastScore = 0;
    initialNode.totalScore = initialNode.distanceTo(to);
    initialNode.scored = true;
  //  cout << "Initial Node: " << from.getX() << ", " << from.getY() << endl;
    openSet.insert(initialNode);
    vector<PathfindingNode> path;
  
    while(openSet.size() > 0) {
      //find the node with the lowest f score from the open set
      PathfindingNode current = *openSet.begin();
      for(set<PathfindingNode>::iterator it = openSet.begin(); it != openSet.end(); ++it) {
        if((*it).totalScore < current.totalScore) {
          current = *it;
        }
      }
      //cout << "Processing node: " << current.waypoint.getX() << "," << current.waypoint.getY() << endl;
      if(current.waypoint.getX() == to.getX() && current.waypoint.getY() == to.getY()) {
      //  cout << "DONE! found node " << to.getX() << "," << to.getY() << ", rebuilding path..." << endl;
        vector<WayPoint> result;
        PathfindingNode resultNode = current;
        while(resultNode.waypoint != from) {
          result.insert(result.begin(), resultNode.waypoint);
      //    cout << "<= (" << resultNode.waypoint.getX() << "," << resultNode.waypoint.getY() << ")"  << endl;
          resultNode = parent.at(resultNode);
        }
        return result;
      }
      //put that node into the closed set
      openSet.erase(current);
      closedSet.insert(current);
  
      //iterate through its neighbors
      int curX = current.waypoint.getX();
      int curY = current.waypoint.getY();
        for (int dir=0; dir<4; dir++) {
          int x = curX;
          int y = curY;
          if    (dir == 0) x--;
          else if (dir == 1) x++;
          else if (dir == 2) y--;
          else if (dir == 3) y++;
          PathfindingNode neighbor(WayPoint(x,y));
          if (!(x == curX && y == curY) && x >= 0 && x < map->getW() && y >=0 && y < map->getH() && closedSet.find(neighbor) == closedSet.end()
            && map->isTilePassable(x,y) && map->unitAt(x,y) == nullptr) { //if it's actually a neighbor, and not in the closed set
            //cout << "  Processing Neighbor: " << x << "," << y ;
            int possiblePastScore = current.pastScore + 1;
            int possibleTotalScore = possiblePastScore + neighbor.distanceTo(to); //find its probable scores
            //cout << ": probPast = " << possiblePastScore << " propTot = " << possibleTotalScore;
            if(openSet.find(neighbor) == openSet.end() || possibleTotalScore < neighbor.totalScore) { // if the neighbor's already in the open set and has a lower score, we don't care about it
            //  cout << " it's new! key " << neighbor.waypoint.getX() << "," << neighbor.waypoint.getY() << " val" << curX << "," << curY;
              //parent.insert(std::map<PathfindingNode, PathfindingNode>::value_type(neighbor, current));
              parent[neighbor] = current;
  
              parent.at(neighbor);
  
              neighbor.pastScore = possiblePastScore;
              neighbor.totalScore = possibleTotalScore;
              if(openSet.find(neighbor) == openSet.end()) {
            //    cout << " ..insert to openSet";
                openSet.insert(neighbor);
              }
            }
      //      cout << endl;
          }
        }
    }
    vector<WayPoint> bad;
    return bad;
  }*/
}

class PathfindingNode {
  WayPoint _waypoint;
  WayPoint get waypoint => _waypoint;
  bool scored = false;
  int totalScore = -1;
  int pastScore = -1;

  PathfindingNode(this._waypoint);
  
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
