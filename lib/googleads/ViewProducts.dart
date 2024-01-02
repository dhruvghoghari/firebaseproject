import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../resources/AdResources.dart';

class ViewProducts extends StatefulWidget {
  @override
  State<ViewProducts> createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  Future<List<dynamic>>? alldata;
  BannerAd? _topBannerAd;
  bool _isTop = false;


  TopBanner() {
    _topBannerAd = BannerAd(
      adUnitId: AdResources.TOP_BANNER,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isTop = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _topBannerAd!.load();
  }

  Future<List<dynamic>> getdata() async {

    Uri url = Uri.parse("https://studiogo.tech/student/studentapi/getProducts.php");
    var response = await http.get(url);
    if (response.statusCode == 200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      return json["data"];
    }
    else
    {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      alldata = getdata();
    });
    TopBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: alldata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length <= 0) {
              return Center(
                child: Text("No data"),
              );
            }
            else
            {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]["pname"].toString()),
                    subtitle: Text(snapshot.data![index]["qty"].toString()),
                    trailing: Text(snapshot.data![index]["price"].toString()),
                  );
                },
                separatorBuilder: (context, index) {
                  if(index==2)
                    {
                      return Container(
                        height: _topBannerAd!.size.height.toDouble(),
                        width: _topBannerAd!.size.width.toDouble(),
                        child: AdWidget(ad: _topBannerAd!),
                      );
                    }
                  else
                    {
                      return SizedBox();
                    }
                },
              );
            }
          }
          else
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
