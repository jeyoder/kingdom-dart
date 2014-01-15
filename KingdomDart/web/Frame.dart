part of Kingdom;
class Frame {
  int scrollX; //center of the screen, in tiles
  int scrollY;
  double scale;
  CanvasRenderingContext2D context;
  int get w => context.canvas.width;
  int get h => context.canvas.height;
  Frame(this.scrollX, this.scrollY, this.scale);
  void scrollTo(int zoomLevel) {
    scale = pow(2, (zoomLevel + 1) * 0.15); //scale the mouse for a nice linear zoom
    scale = (scale * TileMap.tileW).floor() / TileMap.tileH; //round scale to the nearest tile width multiple. prevents tile gaps.
  }
}