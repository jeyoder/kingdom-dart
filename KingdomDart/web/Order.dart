part of Kingdom;
class Order {
  List<WayPoint> _waypoints;
  List<WayPoint> get waypoints => new List<WayPoint>.from(_waypoints);
  bool get completed => _waypoints.length == 0;
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
  List<WayPoint> aStar(WayPoint from, WayPoint to) {
    Map<PathfindingNode, PathfindingNode> parent = new Map<PathfindingNode, PathfindingNode> ();
    Set<PathfindingNode> closedSet = new Set<PathfindingNode> ();
    Set<PathfindingNode> openSet = new Set<PathfindingNode> ();
    PathfindingNode initialNode = new PathfindingNode.withCordinates(from.x, from.y);
    initialNode.pastScore = 0;
    initialNode.totalScore = initialNode.distanceTo(to);
    initialNode.scored = true;
  //  cout << "Initial Node: " << from.getX() << ", " << from.getY() << endl;
    openSet.add(initialNode);
    List<PathfindingNode> path;
  
    while(openSet.length > 0) {
      //find the node with the lowest f score from the open set
      PathfindingNode current = openSet.first;
      for(PathfindingNode it in openSet) {
        if(it.totalScore < current.totalScore) {
          current = it;
        }
      }
      //cout << "Processing node: " << current.waypoint.getX() << "," << current.waypoint.getY() << endl;
      if(current.waypoint.x == to.x && current.waypoint.y == to.y) {
      //  cout << "DONE! found node " << to.getX() << "," << to.getY() << ", rebuilding path..." << endl;
        List<WayPoint> result = new List<WayPoint>();
        PathfindingNode resultNode = current;
        while(resultNode.waypoint != from) {
          result.insert(0, resultNode.waypoint);
      //    cout << "<= (" << resultNode.waypoint.getX() << "," << resultNode.waypoint.getY() << ")"  << endl;
          resultNode = parent[resultNode];
        }
        return result;
      }
      //put that node into the closed set
      openSet.remove(current);
      closedSet.add(current);
  
      //iterate through its neighbors
      int curX = current.waypoint.x;
      int curY = current.waypoint.y;
        for (int dir=0; dir<4; dir++) {
          int x = curX;
          int y = curY;
          if    (dir == 0) x--;
          else if (dir == 1) x++;
          else if (dir == 2) y--;
          else if (dir == 3) y++;
          PathfindingNode neighbor = new PathfindingNode.withCordinates(x,y);
          if (!(x == curX && y == curY) && x >= 0 && x < _map.mapW && y >=0 && y < _map.mapH && !closedSet.contains(neighbor)
            && _map.isTilePassable(x,y) && _map.unitAt(x,y) == null) { //if it's actually a neighbor, and not in the closed set
            //cout << "  Processing Neighbor: " << x << "," << y ;
            int possiblePastScore = current.pastScore + 1;
            int possibleTotalScore = possiblePastScore + neighbor.distanceTo(to); //find its probable scores
            //cout << ": probPast = " << possiblePastScore << " propTot = " << possibleTotalScore;
            if(!openSet.contains(neighbor) || possibleTotalScore < neighbor.totalScore) { // if the neighbor's already in the open set and has a lower score, we don't care about it
            //  cout << " it's new! key " << neighbor.waypoint.getX() << "," << neighbor.waypoint.getY() << " val" << curX << "," << curY;
              //parent.insert(std::map<PathfindingNode, PathfindingNode>::value_type(neighbor, current));
              parent[neighbor] = current;
  
              //parent.at(neighbor); ?????
  
              neighbor.pastScore = possiblePastScore;
              neighbor.totalScore = possibleTotalScore;
              if(!openSet.contains(neighbor) && neighbor.totalScore <= 8) {
            //    cout << " ..insert to openSet";
                openSet.add(neighbor);
              }
            }
      //      cout << endl;
          }
        }
    }
    List<WayPoint> bad;
    return bad;
  }
}


