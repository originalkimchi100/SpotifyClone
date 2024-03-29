import 'package:chaleno/chaleno.dart';

Future<List<Map<dynamic,dynamic>>> scrapData() async {
  var srclist = [];
  var titlelist = [];
  final List<Map<String,String>> finallist = [];
  final albumclass = 'c-lazy-image__img lrv-u-background-color-grey-lightest lrv-u-width-100p lrv-u-display-block lrv-u-height-auto';

  final titleclass = '.lrv-u-font-size-16';

  final url = 'https://www.billboard.com/charts/hot-100/';
  var response  = await Chaleno().load(url);

  for (int i = 2; i < 17; i+= 2) { //  for (int i = 1; i < 17; i+= 2) {
    String? subscribeCount = response?.getElementsByClassName(albumclass)[i].src;
    srclist.add(subscribeCount.toString());
  }

  for (int i =3; i<11; i++){ //  for (int i =3; i<11; i++){
    String? titlecount = response?.querySelectorAll(titleclass)[i].innerHTML?.trim();
    titlelist.add(titlecount.toString());
  }
  for(int i = 0; i<8; i++){
    Map<String,String> musicCover = {};
    musicCover['src'] = srclist[i].toString();
    musicCover['title'] = "#" + (i+1).toString() + " " +titlelist[i].toString();
    finallist.add(musicCover);
  }
  return finallist;
}


