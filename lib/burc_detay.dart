import 'package:flutter/material.dart';
import 'package:flutter_app/burc_liste.dart';
import 'package:flutter_app/model/burc.dart';
import 'package:palette_generator/palette_generator.dart';

class BurcDetay extends StatefulWidget {

  int gelenIndex;

  BurcDetay(this.gelenIndex);

  @override
  _BurcDetayState createState() => _BurcDetayState();
}

class _BurcDetayState extends State<BurcDetay> {
  Burc secilenBurc;
  Color baskinRenk;
  PaletteGenerator paletteGenerator;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    secilenBurc=BurcListesi.tumBurclar[widget.gelenIndex];
    baskinRengiBul();
  }

  void baskinRengiBul(){
    Future<PaletteGenerator> fPaletGenerator = PaletteGenerator.fromImageProvider(AssetImage("images/"+secilenBurc.burcBuyukResim));

    fPaletGenerator.then((value){
      paletteGenerator = value;
      setState(() {
        baskinRenk = paletteGenerator.dominantColor.color;
      });

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            primary: true,
            backgroundColor: baskinRenk !=null ? baskinRenk:Colors.pink,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset("images/"+secilenBurc.burcBuyukResim,fit: BoxFit.cover,),
              title: Text(secilenBurc.burcAdi + " ve Özellikleri"),
              centerTitle: true,
            ),

          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(secilenBurc.burcDetay,style: TextStyle(fontSize: 18,color: Colors.black),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
