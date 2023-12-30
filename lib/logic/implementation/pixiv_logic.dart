// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../model/image.dart';
import '../interface/core_logic.dart';

class PixivLogicImp implements CoreLogic {
  @override
  Future<List<ImageModel>> getData(Map<String, String> header, String query,
      int pageNumber, String whereToSearch) async {
    List<ImageModel> modelItems = [];
    var url =
        'https://www.pixiv.net/ajax/search/artworks/$query?word=$query&order=date_d&mode=all&p=$pageNumber&s_mode=s_tag&type=all&lang=en&version=756be60366a5fe018a9a6dad3939c8a57e00ec57';
    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(header);
    await Future.delayed(const Duration(milliseconds: 200));
    final response = await request.send();

    if (response.statusCode == 200) {
      final finalResponse =
          json.decode(await response.stream.bytesToString())["body"]
              ["illustManga"]["data"];
      finalResponse.map((e) async {
        modelItems.add(ImageModel(
            id: e["id"],
            title: e["title"],
            url: [e["url"].replaceAll(RegExp(r"/c/(.*?)/"), "/")],
            subImagesSize: e["pageCount"],
            lastElementId: pageNumber,
            isFavorite: false,
            header: getHeader()));
      }).toList();
    } else {
      print(response.reasonPhrase);
    }
    return modelItems;
  }

  @override
  Future<ImageModel> getOriginalData(ImageModel modelItem) async {
    late ImageModel finalModelItem;
    List<String>? subList;
    String url =
        'https://www.pixiv.net/ajax/illust/${modelItem.id}?lang=en&version=a0d9faa28bc2501720d4accef5bb6e84e5e367f9';
    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll(getHeader());
    await Future.delayed(const Duration(milliseconds: 200));
    final response = await request.send();

    if (response.statusCode == 200) {
      if (modelItem.subImagesSize > 1) {
        subList = await getSubImagesUrls(modelItem.id);
      }
      final finalResponse =
          json.decode(await response.stream.bytesToString())["body"];
      finalModelItem = ImageModel(
          id: finalResponse["illustId"],
          title: finalResponse["illustTitle"],
          url: [finalResponse["urls"]["original"]],
          subImages: subList ?? [],
          lastElementId: 0,
          isFavorite: false,
          header: getHeader());
    } else {
      print(response.reasonPhrase);
    }
    return finalModelItem;
  }

  Future<List<String>> getSubImagesUrls(String imageId) async {
    List<String> subList = [];
    String url =
        'https://www.pixiv.net/ajax/illust/$imageId/pages?lang=en&version=9126463b2be1daaebd8bdadabf9aa9ea9abf55c5';
    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(getHeader());
    await Future.delayed(const Duration(milliseconds: 200));
    final response = await request.send();

    if (response.statusCode == 200) {
      final finalResponse =
          json.decode(await response.stream.bytesToString())["body"];
      finalResponse
              ?.map((e) => subList.add(e["urls"]["original"].toString()))
              .toList() ??
          [];
    } else {
      print(response.reasonPhrase);
    }
    return subList;
  }

  @override
  Future<Directory> initDirectory(String folderName) async {
    //Get this App Document Directory
    final Directory appDocDir = await getApplicationSupportDirectory();
    //App Document Directory + folder name
    final Directory appDocDirFolder =
        Directory('${appDocDir.path}/$folderName/');

    if (await appDocDirFolder.exists()) {
      //if folder already exists return path
      return appDocDirFolder;
    } else {
      //if folder not exists create folder and then return its path
      final Directory appDocDirNewFolder =
          await appDocDirFolder.create(recursive: true);
      return appDocDirNewFolder;
    }
  }

  @override
  Map<String, String> getHeader() {
    return {
      'authority': 'i.pximg.net',
      'accept':
          'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
      'accept-language': 'en-US,en;q=0.9,ar;q=0.8',
      'cache-control': 'no-cache',
      'pragma': 'no-cache',
      'referer': 'https://www.pixiv.net/',
      'sec-ch-ua':
          '"Chromium";v="110", "Not A(Brand";v="24", "Google Chrome";v="110"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Windows"',
      'sec-fetch-dest': 'document',
      'sec-fetch-mode': 'navigate',
      'sec-fetch-site': 'cross-site',
      'sec-fetch-user': '?1',
      'upgrade-insecure-requests': '1',
      'user-agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
      //TODO-> uncomment this line for r18
      // 'cookie':
      //     'first_visit_datetime_pc=2023-10-04%2016%3A07%3A19; p_ab_id=6; p_ab_id_2=7; p_ab_d_id=1782209338; _fbp=fb.1.1696403242243.1993147927; yuid_b=IZZDYHQ; _im_vid=01HBWR6MRXV3R5WGJWZP6862CB; _ga_MZ1NL4PHH0=GS1.1.1696403259.1.0.1696403266.0.0.0; device_token=f5b470064ff8d37ee1a6a6c57800f80d; c_type=24; privacy_policy_notification=0; a_type=0; b_type=1; __utmz=235335808.1697358264.2.2.utmcsr=youtube.com|utmccn=(referral)|utmcmd=referral|utmcct=/; cto_bundle=G-8hCF9VWlFVaTdiY2JXUllSVkZhd2JSN1RES3pXalNqaklwYnJiWktPa2ZhcDJBVmRwYVlUcmVGSUZIa3BXVWtKYnUxMG5GRVVRUFQwUjVJWkFEdGtMMDV6dkkyR2J5VHFScSUyQnBQMTU0azUlMkJuTjltNmtNUFhCR20xbFhtM3NtTG12QzlmOTFSb1RoZTNiQkZXaVFiMXJ4c2w0WCUyRjBPN3AzaXdMM0xJb1IxYyUyRnJPJTJGNngxZjZlN1QzaEJhM0Z3SVI2NnR4Z2Z2RnhDJTJCTyUyRjVpeEd1TVI3NGRtaGw5ODVCVkU5eDRaV3Zua1glMkJJZk50NERGOFhsY1hIdlU2MDA3M1RaUiUyRmhv; __cf_bm=11FukTtOxONPVH_DeDvmc5glIFyPGbfEY6XAHPNhi5s-1698877922-0-AQcwviPXoW4BvhmDhTGi2Nrk3t6jVE8BkGqZnBKzFb7v0hLm2/slKHhhhG6QDOpQ5i5RXrUY9Ek81DngFNe2+cyo9MX/3T7vJj0RAL+Qg7tl; _ga=GA1.1.222918872.1696403242; __utma=235335808.1633159875.1696403240.1697358264.1698877929.3; __utmc=235335808; __utmv=235335808.|2=login%20ever=no=1^3=plan=normal=1^5=gender=male=1^6=user_id=29804253=1^9=p_ab_id=6=1^10=p_ab_id_2=7=1^11=lang=en=1; __utmt=1; cf_clearance=E515YRccvfRHa5bAKGmbpLaUg1efMZKgaQdh5gve8Uc-1698877929-0-1-2abb405.6b669030.2df0de1b-0.2.1698877929; PHPSESSID=29804253_XmTqIYkEwSHLEWJdLBbHe9vUtAErqPfR; privacy_policy_agreement=0; _ga_75BBYNYN9J=GS1.1.1698877928.3.1.1698877943.0.0.0; __utmb=235335808.2.10.1698877929',
      //
    };
  }
}
