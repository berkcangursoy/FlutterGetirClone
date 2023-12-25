import 'package:flutter/material.dart';
import 'package:yemek_uygulamasi/data/entity/yemekler.dart';


class SepetSayfa extends StatefulWidget {
  Yemekler yemek;


  @override
  State<SepetSayfa> createState() => _SepetSayfaState();

  SepetSayfa({required this.yemek});
}

class _SepetSayfaState extends State<SepetSayfa> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepetim"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 200,
            child: Card(
              child: Row(
                children: [
                  Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
                  Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("${widget.yemek.yemek_adi}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      Text("${widget.yemek.yemek_fiyat} ₺",style: TextStyle(fontSize: 30),),
                    ],
                  ),
                  SizedBox(width: 50,),
                  Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: (){
                        //context.read<SepetSayfaCubit>().sepettenSil(widget.sepet_yemek_id, "berk");
                      }, child: const Icon(Icons.delete_rounded)),

                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
