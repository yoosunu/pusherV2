import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class FetchUtil {
  static Future fetchData() async {
    // fetching section
    var extractedData = []; // total data
    var codesGet = [];
    var tagsGet = [];
    var titlesGet = [];
    var fromsGet = [];
    // var links = [];
    // var times = [];
    // int timeCode = DateTime.now().millisecondsSinceEpoch;
    // String formattedTime =
    //     DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(timeCode));

    var url = Uri.parse(
        'https://www.jbnu.ac.kr/web/news/notice/sub01.do?pageIndex=1&menu=2377');
    // var url2 = Uri.parse(
    //     'https://www.jbnu.ac.kr/web/news/notice/sub01.do?pageIndex=2&menu=2377');
    // var url3 = Uri.parse(
    //     'https://www.jbnu.ac.kr/web/news/notice/sub01.do?pageIndex=3&menu=2377');
    var response = await http.get(url);
    // var response2 = await http.get(url2);
    // var response3 = await http.get(url3);

    if (response.statusCode == 200) {
      // page 1
      var document = parser.parse(response.body);
      var noticesPage1 = document.getElementsByTagName('tbody');

      // var noticesPage1 = document.getElementsByClassName('tr-normal');

      for (var noticePage1 in noticesPage1) {
        var trs = noticePage1
            .getElementsByClassName('tr-normal'); // for the length of for loop.
        var nums = noticePage1.getElementsByClassName('brd-num');
        var tags = noticePage1.getElementsByClassName('tag-type-01');
        var titles = noticePage1.getElementsByClassName('title');
        var etcs = noticePage1.getElementsByClassName('etc-list');
        var froms = noticePage1.getElementsByClassName('brd-writer');
        // var anchors = noticePage1.getElementsByTagName('a');

        for (var i = 0; i < trs.length; i++) {
          var num = nums[i].text.trim();
          int numInt = int.parse(num);
          var tag = tags[i].text.trim();
          var title = titles[i].text.trim();
          // var etc = etcs[i].text.trim();
          var from = froms[i].text.trim();

          codesGet.add(numInt);
          tagsGet.add(tag);
          titlesGet.add(title);
          fromsGet.add(from);
        }
      }

      // page 2
      // var document2 = parser.parse(response2.body);
      // var noticesPage2 = document2.getElementsByTagName('tr');

      // for (var noticePage2 in noticesPage2) {
      //   var mnoms = noticePage2.getElementsByClassName('mnom');
      //   var anchors = noticePage2.getElementsByTagName('a');
      //   for (var i = 0; i < mnoms.length; i++) {
      //     var mnom = mnoms[i];
      //     var anchor = anchors[i];
      //     if (mnom.text.isNotEmpty) {
      //       int mnonInt = int.parse(mnom.text);
      //       codes.add(mnonInt);
      //       titles.add(anchor.text.trim());
      //       links.add(anchor.attributes['href']);
      //       times.add(formattedTime);
      //     }
      //   }
      // }

      // page 3
      // var document3 = parser.parse(response3.body);
      // var noticesPage3 = document3.getElementsByTagName('tr');

      // for (var noticePage3 in noticesPage3) {
      //   var mnoms = noticePage3.getElementsByClassName('mnom');
      //   var anchors = noticePage3.getElementsByTagName('a');
      //   for (var i = 0; i < mnoms.length; i++) {
      //     var mnom = mnoms[i];
      //     var anchor = anchors[i];
      //     if (mnom.text.isNotEmpty) {
      //       int mnonInt = int.parse(mnom.text);
      //       codes.add(mnonInt);
      //       titles.add(anchor.text.trim());
      //       links.add(anchor.attributes['href']);
      //       times.add(formattedTime);
      //     }
      //   }
      // }

      extractedData.add(codesGet);
      extractedData.add(tagsGet);
      extractedData.add(titlesGet);
      extractedData.add(fromsGet);

      // extractedData.add(links);
      // extractedData.add(times);
    }
    return extractedData;
  }
}
