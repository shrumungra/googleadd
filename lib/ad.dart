import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ad extends StatefulWidget {
  const ad({super.key});

  @override
  State<ad> createState() => _adState();
}

class _adState extends State<ad> {
  late BannerAd myBanner;
  bool _isLoaded = false;

  final banneradUnitId = 'ca-app-pub-3940256099942544/6300978111';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBannerAd();
    myBanner.dispose();
    myBanner.load();
  }

  /// Loads a banner ad.
  void loadBannerAd() {
    myBanner = BannerAd(
      adUnitId: banneradUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {
          print("===============it's banner adds=============");
        },
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    );
    myBanner.load();
  }

  @override
  void dispose() {
    super.dispose();
    myBanner.dispose();
  }

  Widget adds() {
    return _isLoaded
        ? Container(
            width: myBanner.size.width.toDouble(),
            height: myBanner.size.height.toDouble(),
            margin: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: AdWidget(ad: myBanner,key: GlobalKey(debugLabel: "dfg")),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  child: Center(child: Text("index $index")),
                  height: 100,
                  color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1),
                ));
          },
          separatorBuilder: (context, index) {
            if (index  % 4 == 0) {
              return  adds();
            }
              return Container();
          },
         ),
    );
  }
}



// class _BannerAd extends StatefulWidget {
//   const _BannerAd({Key? key}) : super(key: key);
//
//   @override
//   _BannerAdState createState() => _BannerAdState();
// }
//
// class _BannerAdState extends State<_BannerAd>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;
//
//   late BannerAd myBanner;
//   final banneradUnitId = 'ca-app-pub-3940256099942544/6300978111';
//   @override
//   void initState() {
//     super.initState();
//     myBanner = BannerAd(
//       adUnitId: banneradUnitId,
//       size: AdSize.banner,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (ad) => print('Ad loaded.'),
//         onAdFailedToLoad: (ad, error) {
//           ad.dispose();
//           print('Ad failed to load .');
//         },
//         onAdOpened: (ad) => print('Ad opened.'),
//         onAdClosed: (ad) => print('Ad closed.'),
//         onAdImpression: (ad) => print('Ad impression.'),
//       ),
//     )..load();
//   }
//
//   // @override
//   // void dispose() {
//   //   myBanner.dispose();
//   //   super.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//
//     return Container(
//       width: myBanner.size.width.toDouble(),
//       height: myBanner.size.height.toDouble(),
//       margin: const EdgeInsets.all(20),
//       alignment: Alignment.center,
//       child: AdWidget(ad: myBanner),
//     );
//   }
// }
