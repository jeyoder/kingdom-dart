part of Kingdom;

class TileMap {

  int _mapW;
  int _mapH;
  int get mapW => _mapW;
  int get mapH => _mapH;
  List<int> _mapData;
  List<Unit> _mapObjects = new List<Unit>();
  List<Unit> get mapObjects => new List<Unit>.from(_mapObjects);
  static const int tileW = 64;
  static const int tileH = 64;
  ImageElement _selectedTex;
  ImageElement _waypointTex;
  ImageElement _waypointChooserTex;
  ImageElement _pathfindingTex;
  ImageElement _tileset;
TileMap(MapLoader generator) {
  _mapW = generator.width;
  _mapH = generator.height;
  _mapData = generator.getData();
  _selectedTex = ImageLoader.images["selected.png"];
  _waypointTex = ImageLoader.images["target.png"];
  _waypointChooserTex = ImageLoader.images["target_chooser.png"];
  _pathfindingTex = ImageLoader.images["pathfinding-dot.png"];
  _tileset = ImageLoader.images["tileset-1.png"];
}
void add(Unit obj) {
  _mapObjects.add(obj);
}
void draw( frame, Unit selectedUnit) {
  int minTileX = max((frame.scrollX - (frame.w / 2 / frame.scale / tileW)), 0).toInt();
  int maxTileX = min((frame.scrollX + (frame.w / 2 / frame.scale / tileW) + 1), _mapW - 1).toInt();
  int minTileY = max((frame.scrollY - (frame.h / 2 / frame.scale / tileH)), 0).toInt();
  int maxTileY = min((frame.scrollY + (frame.h / 2 / frame.scale / tileH) + 1), _mapH - 1).toInt();
  for (int x = minTileX; x <= maxTileX; x++) {
      for (int y = minTileY; y <= maxTileY; y++) {
        int srcTile = tileAt(x, y);
        var srcRect = new Rectangle<int>((srcTile - 1) * tileW, 0, tileW, tileH);
        var destRect= new Rectangle<int>(
        (((x - frame.scrollX) * tileW * frame.scale) + (frame.w / 2)).toInt(),
        (((y - frame.scrollY) * tileH * frame.scale) + (frame.h / 2)).toInt(),
        (tileW * frame.scale).toInt(),
        (tileH * frame.scale).toInt());
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
          (((x - frame.scrollX) * tileW * frame.scale) + (frame.w / 2)).toInt(),
          (((y - frame.scrollY) * tileH * frame.scale) + (frame.h / 2)).toInt(),
          (tileW * frame.scale).toInt(),
          (tileH * frame.scale).toInt());
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
          (destRect.left + drawingUnit.offsetX * frame.scale).toInt(),
          (destRect.top + drawingUnit.offsetY * frame.scale).toInt(),
          (tileW * frame.scale).toInt(),
          (tileH * frame.scale).toInt());
        if(drawingUnit == selectedUnit) {
    //      window.console.log("su");
          frame.context.drawImageToRect(ImageLoader.images['selected.png'], destRect);
        }
        frame.context.drawImageToRect(ImageLoader.images[drawingUnit.myImage], destRect);
      }
      //
    }
  }
  
}
int tileAt(int x, int y) => _mapData[y * _mapW + x];

int tileAtPoint(WayPoint pt) => tileAt(pt.x, pt.y);

Unit unitAt(int x, int y) {
 if(_mapObjects == null) return null;
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
