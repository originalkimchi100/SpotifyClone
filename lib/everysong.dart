import 'package:chaleno/chaleno.dart';

List<String> srclist  = [];

List<String> titlelist  = [];

Future<List<String>> scrapData() async {
  final albumclass = 'c-lazy-image__img lrv-u-background-color-grey-lightest lrv-u-width-100p lrv-u-display-block lrv-u-height-auto';
  final titleclass = '.lrv-u-font-size-16';

  final url = 'https://www.billboard.com/charts/hot-100/';
  var response  = await Chaleno().load(url);
  for (int i = 1; i < 17; i+= 2) {
    String? subscribeCount = response?.getElementsByClassName(albumclass)[i].src;
    srclist.add(subscribeCount.toString());


  }

  for (int i =3; i<11; i++){
    String? titlecount = response?.querySelectorAll(titleclass)[i].innerHTML?.trim();
    print(titlecount);
    titlelist.add(titlecount.toString());
  }
  print(titlelist);
  return srclist;
}

void main() async{
  var dfdf = await scrapData();
  print(dfdf);
  print("계산중");
}


