import 'package:flutter/material.dart';
import 'package:jankoyer/const/colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'BIZ BARADA',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '''«Janköýer» saýtynyň esasy maksady: Hemmelere türkmen futbolyny söýdürmek. 
              
              «Janköýer» adyny türkmenistanly janköýerleriň futbola bolan belent söýgüsinden alýan web saýtdyr. 2023-nji ýylda döredilen saýtymyzyň beýleki habar portallaryndan tapawudy «millionlaryň söýgüli oýny» hasaplanylýan futboly wagyz etmäge gönükdirilendir. Esasan hem, türkmen futbolynyň janköýerleriniň ösen isleglerini nazarda tutup, milli futbol ýaryşlarymyz, şol sanda, Türkmenistanyň çempionaty, Kubok ýaryşy, TFF-niň Kubogy we futzal boýunça dürli derejeli ýaryşlar, dünýä futboly, milli ýygyndymyzyň we toparlarymyzyň halkara duşuşyklary, toparlaryň düzümlerindäki täzelikler we beýleki habarlary gyzgyny bilen ýetirip durmakdan ugur alyp ýola düşdük. Biziň türkmen futbolynyň hakyky muşdagyna öwrülen toparymyz bar. Toparymyzyň üstünlikli işlemegi bolsa ähli janköýerlerimize baglydyr! Ýekelikde asgyn bolsak, bilelikde üstündiris!
              
              Saýtdaky maglumatlar häzirlikçe diňe türkmen dilinde berilýär.
              ''',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
