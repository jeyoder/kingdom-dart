part of Kingdom;

class TileMap {

  int _mapW;
  int _mapH;
  int get mapW => _mapW;
  int get mapH => _mapH;
  List<int> _mapData;
  List<Unit> _mapObjects;
  List<Unit> get mapObject => new List<Unit>.from(_mapObjects);
  static const int tileW = 32;
  static const int tileH = 32;
  ImageElement _selectedTex;
  ImageElement _waypointTex;
  ImageElement _waypointChooserTex;
  ImageElement _pathfindingTex;
  ImageElement _tileset;
TileMap(MapLoader generator) {
  _mapW = generator.width;
  _mapH = generator.height;
  _mapData = generator.getData();
 /* mapObjects = std::vector<Unit*> (); //create a vector containing pointers to our units
  mapObjects.push_back(new King(0,50, 50));
  mapObjects.push_back(new Pawn(0,51, 49));
  mapObjects.push_back(new Pawn(0,49, 49)); */
  _selectedTex = ImageLoader.images["selected.png"];
  _waypointTex = ImageLoader.images["target.png"];
  _waypointChooserTex = ImageLoader.images["target_chooser.png"];
  _pathfindingTex = ImageLoader.images["pathfinding-dot.png"];
  _tileset = ImageLoader.images["tileset-1.png"];
}
void draw( frame) {
  int minTileX = max((frame.scrollX - (frame.w / 2 / frame.scale / tileW)), 0);
  int maxTileX = min((frame.scrollX + (frame.w / 2 / frame.scale / tileW) + 1), _mapW - 1);
  int minTileY = max((frame.scrollY - (frame.h / 2 / frame.scale / tileH)), 0);
  int maxTileY = min((frame.scrollY + (frame.h / 2 / frame.scale / tileH) + 1), _mapH - 1);
  //Render Tiles
  for (int x = minTileX; x <= maxTileX; x++) {
      for (int y = minTileY; y <= maxTileY; y++) {
        int srcTile = tileAt(x, y);
        var srcRect = new Rectangle<int>((srcTile - 1) * tileW, 0, tileW, tileH);
        var destRect= new Rectangle<int>(
        ((x - frame.scrollX) * tileW * frame.scale) + (frame.w / 2) as int,
        ((y - frame.scrollY) * tileH * frame.scale) + (frame.h / 2) as int,
        tileW * frame.scale as int,
        destRect.h = tileH * frame.scale as int);
        frame.context.drawImageToRect(_tileset, destRect, sourceRect: srcRect);
        /*SDL_RenderCopy(frame.renderer, tileset, &srcRect, &destRect); //draw the tile*/
      }
  }
  //Render stuff on tiles
  for (int x = minTileX; x <= maxTileX; x++) {
    for (int y = minTileY; y <= maxTileY; y++) {
      //int srcTile = tileAt(x, y);
      //var srcRect = new Rectangle<int>((srcTile - 1) * tileW, 0, tileW, tileH);
      Rectangle destRect= new Rectangle<int>(
          ((x - frame.scrollX) * tileW * frame.scale) + (frame.w / 2) as int,
          ((y - frame.scrollY) * tileH * frame.scale) + (frame.h / 2) as int,
          tileW * frame.scale as int,
          tileH * frame.scale as int);
      //
      /*for(vector<Unit*>::iterator it = selectedUnits.begin(); it != selectedUnits.end(); ++it) {
        Unit* unit = *it;
        if(unit->tileX == x && unit->tileY == y) {
          SDL_RenderCopy(renderer, selectedTex, NULL, &destRect);
        }
      }

      for(vector<WayPoint>::iterator it = waypoints.begin(); it!=waypoints.end(); ++it) {
        WayPoint wp = *it;
        if(wp.getX() == x && wp.getY() == y) {
          SDL_RenderCopy(renderer, waypointChooserTex, NULL, &destRect);
        }
      }
      for(WayPoint wp : path) {
              if(wp.getX() == x && wp.getY() == y) {
                SDL_RenderCopy(renderer, pathfindingTex, NULL, &destRect);
              }
            }*/
      //Units
      Unit drawingUnit = unitAt(x, y);
      if(drawingUnit != null){
        Rectangle animatedDestRect = new Rectangle<int>(
          animatedDestRect.left + drawingUnit.offsetX * frame.scale as int,
          animatedDestRect.top + drawingUnit.offsetY * frame.scale as int,
          tileW * frame.scale as int,
          tileH * frame.scale as int);
        frame.context.drawImageToRect(ImageLoader.images[drawingUnit.myImage], destRect);
      }
      //
    }
  }
  
}
int tileAt(int x, int y) => _mapData[y * _mapW + x];

int tileAtPoint(WayPoint pt) => tileAt(pt.x, pt.y);

Unit unitAt(int x, int y) {
 for(Unit unit in _mapObjects) {
    if(unit.tileX == x && unit.tileY == y) {
      return unit;
    }
  }
  return null;
}



bool isTilePassable(int x, int y) {
  int tile = tileAt(x,y);
  return (tile == 1);
}

}