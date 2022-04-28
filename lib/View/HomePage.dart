import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quize_project/Model/Quez.dart';
import 'package:quize_project/View/singnIn.dart';

import '../Servise/FarebaseBackend.dart';
import '../Servise/auth.dart';
import 'CreatQuize.dart';
import 'QuationPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _QuizeFuture = FirestoreBackend().getQuize();
  List<Quize>? _Quize;

  BannerAd? bannerAd;
  bool isLodded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      listener: BannerAdListener(onAdLoaded: (a) {
        setState(() {
          isLodded = true;
        });
      }, onAdFailedToLoad: (a, error) {
        a.dispose();
      }),
      request: const AdRequest(),
    );
    bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Quize>>(
      future: _QuizeFuture,
      builder: (context, snapshot) {
        _Quize = snapshot.hasData ? snapshot.data! : [];
        return Scaffold(
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Sign out'),
                    onTap: () {
                      AuthServise.signOut();

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => singin()),
                          (_) => false);
                    },
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(title: Text('Home Page')),
          body: Container(
            child: ListView.separated(
              itemBuilder: (_, index) {
                return _toWidget(_Quize![index]);
              },
              separatorBuilder: (_, __) => Divider(),
              itemCount: _Quize!.length,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateQuize()));
            },
          ),
          persistentFooterButtons: [
            Column(children: [
              const Spacer(),
              isLodded
                  ? SizedBox(
                      height: 50,
                      child: AdWidget(
                        ad: bannerAd!,
                      ),
                    )
                  : const SizedBox(),
            ])
          ],
        );
      },
    );
  }

  Widget _toWidget(Quize Q) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            String? id = Q.id;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuationPage(
                          quizeId: id,
                        )));
            print(Q.id);
          },
          child: Container(
            color: Colors.grey,
            alignment: Alignment.center,
            child: Column(children: [
              Text(Q.QuizeTitle.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
              Text(Q.QuizeDescription.toString(),
                  style:TextStyle(color: Colors.white))
            ]),
          ),
        )
      ],
    );
  }
}
