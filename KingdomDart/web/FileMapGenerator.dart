part of Kingdom;

class FileMapGenerator extends MapLoader{
  int _mapWidth;
  int _mapHeight;
  List<int> _data;
  FileMapGenerator(String data){
    window.console.log("start");
    _mapWidth = -1;
    _mapHeight = -1;
    data = data.replaceAll("\r", "");
   var lines = data.split("\n");
   for(String line in lines) {
     if(new RegExp('^[a-zA-Z]+=.+\$').hasMatch(line)) { 
       String key = line.split("=")[0];
       String val = line.split("=")[1];
       if(key == "width") _mapWidth = int.parse(val);
       if(key == "height") _mapHeight = int.parse(val);
     }
   }
   _data = new List<int>();
   var dataStart = 0;
   for(int i=0; i<lines.length; i++) {
     if (lines[i].indexOf("data") == 0) dataStart = i;
   }
   window.console.log("----------DATA--------");
   for(int i=dataStart+1; i<lines.length; i++) {
     var nums = lines[i].split(",");
     for(String num in nums) {
       if(new RegExp("[0-9]").hasMatch(num)) {
     //   window.console.log(num);
         _data.add(int.parse(num));
       }
     }
   }
   window.console.log("stahp");
 }

  List<int> getData(){
    return _data;
  }
  int get width => _mapWidth;
  int get height => _mapHeight;
  
  //int _stringToInt(const std::string& str);
  
}