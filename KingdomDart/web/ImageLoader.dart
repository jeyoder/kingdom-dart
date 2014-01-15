part of Kingdom;
class ImageLoader {
  static Map<String, ImageElement> images = new Map<String, ImageElement> ();
  static var filenames = ['target.png', 
                          'assets/selected.png', 
                          'assets/target.png', 
                          'assets/target_chooser.png',
                          'assets/pathfinding-dot.png',
                          'assets/tileset-1.png'];
  static Future loadImages() {
    var futures = new List();
    for(String filename in filenames) {
      var elemeno = new ImageElement()
        ..src = filename;
      images[filename] = elemeno;
      futures.add(elemeno.onLoad.first);
    }
    return Future.wait(futures);
  }
}