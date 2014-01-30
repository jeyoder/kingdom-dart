part of Kingdom;
class Frame {
  num scrollX; //center of the screen, in tiles
  num scrollY;
  double scale;
  CanvasRenderingContext2D context;
  num get w => context.canvas.width;
  num get h => context.canvas.height;
  Frame(this.scrollX, this.scrollY, this.scale);
  void scrollTo(num zoomLevel) {
   /// window.console.log("scaling to $zoomLevel");
    scale = pow(2, (zoomLevel + 1) * 0.15); //scale the mouse for a nice linear zoom
    scale = (scale * TileMap.tileW).floor() / TileMap.tileH; //round scale to the nearest tile width multiple. prevents tile gaps.
  }
}