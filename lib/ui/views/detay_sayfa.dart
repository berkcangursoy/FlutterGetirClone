import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_uygulamasi/data/entity/yemekler.dart';
import 'package:yemek_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:yemek_uygulamasi/ui/cubit/detay_sayfa_cubit.dart';
import 'package:yemek_uygulamasi/ui/views/sepet_sayfa.dart';

class DetaySayfa extends StatefulWidget {
  Yemekler yemek;


  @override
  State<DetaySayfa> createState() => _DetaySayfaState();

  DetaySayfa({required this.yemek});
}

class _DetaySayfaState extends State<DetaySayfa> {

  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Detayı"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
            Text("${widget.yemek.yemek_fiyat} ₺",style: TextStyle(fontSize: 50),),
            Text("${widget.yemek.yemek_adi}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: (){
                  setState(() {
                    counter -= 1;
                  });
                }, icon: Icon(Icons.add_box)),
                Text("${counter}"),
                IconButton(onPressed: (){
                  setState(() {
                    counter += 1;
                  });
                }, icon: Icon(Icons.add_box)),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: (){}, child: const Text("25-35dk")),
                TextButton(onPressed: (){}, child: const Text("Ücretsiz Teslimat")),
                TextButton(onPressed: (){}, child: const Text("İndirim %10")),
              ],
            ),
            ElevatedButton(onPressed: (){
              Navigator.push((context), MaterialPageRoute(builder: (context) => SepetSayfa(yemek: widget.yemek))).then((value) {
                context.read<DetaySayfaCubit>().sepeteEkle(widget.yemek.yemek_adi, widget.yemek.yemek_resim_adi, int.parse(widget.yemek.yemek_fiyat)*counter, counter, "berk");
              });
            }, child: const Text("Sepete Ekle")),
          ],
        ),
      ),
    );
  }
}
