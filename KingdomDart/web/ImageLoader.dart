part of Kingdom;
class ImageLoader {
  static final String imageRoot = "assets/";
  static Map<String, ImageElement> images = new Map<String, ImageElement> ();
  static var filenames = ['target.png', 
                          'selected.png', 
                          'target.png', 
                          'target_chooser.png',
                          'pathfinding-dot.png',
                          'tileset-1.png',
                          'PawnGreen.png',
                          'PawnOrigional.png',
                          'King.png',
                          'KingGreen.png',
                          'KingRed.png'];
  static Future loadImages() {
    var futures = new List();
    for(String filename in filenames) {
      var elemeno = new ImageElement()
        ..src = imageRoot+filename;
      images[filename] = elemeno;
      futures.add(elemeno.onLoad.first);
    }
    return Future.wait(futures);
  }
}