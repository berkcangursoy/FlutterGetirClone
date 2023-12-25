import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_uygulamasi/colors/colors.dart';
import 'package:yemek_uygulamasi/data/entity/yemekler.dart';
import 'package:yemek_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:yemek_uygulamasi/ui/views/detay_sayfa.dart';
import 'package:yemek_uygulamasi/ui/views/sepet_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  var tfcontrol = TextEditingController();

  // search bar
  bool aramaYapiliyorMu = false;

  int currentIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: ColorConstants.primaryColor,title: Image.asset("images/getir_logo.png"),centerTitle: true,),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Expanded(flex: 6,
                  child: Container(
                    decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(12),topRight: Radius.circular(12))),
                    child: const Row(
                      children: [
                        ShowButton(),
                  ],
                ),
              ),
                  ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: const BoxDecoration(color: ColorConstants.brandYellow,borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          bottomLeft: Radius.circular(16.0),
                        )),

                        child: const Column(
                          children: [
                            Text("TVS",style: TextStyle(color: ColorConstants.primaryColor,fontWeight: FontWeight.w500),),
                            Text("35dk",style: TextStyle(color: ColorConstants.primaryColor,fontSize: 20,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: aramaYapiliyorMu ? TextField(
                  decoration: const InputDecoration(
                    hintText: 'Ara..',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (aramaSonucu) {
                    context.read<AnasayfaCubit>().ara(aramaSonucu);
                  },
                ):  aramaYapiliyorMu? IconButton(onPressed: (){
                  setState(() {
                    aramaYapiliyorMu = false;
                  });
                  context.read<AnasayfaCubit>().yemekleriYukle();
                }, icon: const Icon(Icons.clear)) :
                IconButton(onPressed: (){
                  setState(() {
                    aramaYapiliyorMu = true;
                  });
                }, icon: const Icon(Icons.search)),
              ),
              SizedBox(width: 400,
                child: Column(
                  children: [
                    BlocBuilder<AnasayfaCubit,List<Yemekler>>(
                      builder: (context,yemeklerListesi){
                        if (yemeklerListesi.isNotEmpty){
                          return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: yemeklerListesi.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1/1.4),
                            itemBuilder: (context,index){
                              var yemek = yemeklerListesi[index];
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(yemek: yemek)));
                                },
                                child: Card(
                                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                                      Text("${yemek.yemek_adi}",style: const TextStyle(fontSize: 22),),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("${yemek.yemek_fiyat} ₺",style: const TextStyle(fontSize: 24),),
                                          ElevatedButton(onPressed: (){
                                            //context.read<SepetSayfaCubit>().sepeteEkle(yemek.yemek_adi, yemek.yemek_resim_adi, int.parse(yemek.yemek_fiyat), 0, "berk");
                                            print("eklendi ${yemek.yemek_resim_adi}");
                                          }, child: const Icon(Icons.add_box)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }else{
                          return const Center();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
      floatingActionButton: SizedBox(
      width: 70,
      height: 70,
      child: FloatingActionButton(backgroundColor: Colors.blue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),onPressed: () {
      },child: Image.asset("images/ic_fab.png",color:Colors.yellow,height: 50,width: 50,)),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (value) {
    setState(() {
    currentIndex = value;
    });
    },
    items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.black54),label: "Anasayfa"),
    BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.black54),label: "Hesap"),

    ],
    ),
    );
  }
}

class ShowButton extends StatelessWidget {
  const ShowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => DraggableScrollableSheet(expand: false,
          builder: (context, scrollController) => SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 16, left:16,top: 32 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Teslimat adresinizi seçin.",
                        style: TextStyle(fontWeight: FontWeight.w400,color: ColorConstants.blackLight,fontSize: 16),),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,color: ColorConstants.primaryColor,),
                          Text(
                            "Adreslerim",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,decoration: TextDecoration.underline,
                                color: ColorConstants.primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }, child: const Row(
      children: [
        Text("Ev, ",style: TextStyle(color: ColorConstants.primaryColor,fontWeight: FontWeight.bold,fontSize: 16),),
        Text("Tepealtı Mahallesi Coşkun Sk..",style: TextStyle(color: Colors.black,fontFamily: 'OpenSans',fontWeight: FontWeight.w400),),
        SizedBox(width: 15),
        Icon(Icons.keyboard_arrow_down_outlined,color: ColorConstants.primaryColor,),
      ],
    ));
  }
}


/*
        floatingActionButton: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(backgroundColor: Colors.blue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),onPressed: () {
            //Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa(yemek: widget.yemek)));
          },child: Image.asset("images/ic_fab.png",color:Colors.yellow,height: 50,width: 50,)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.black54),label: "Anasayfa"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_outlined,color: Colors.black54),label: "Favoriler"),
            BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.black54),label: "Hesap"),

          ],
        ), */
  




