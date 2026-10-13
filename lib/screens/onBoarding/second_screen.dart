import 'package:flutter/material.dart';
import 'package:tababa/constant/constant_style.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          spacing: 10,
          children: [
            Image.asset('assets/images/logo.png'),
            ListTile(
              title: Center(child: Text('حجز سريع ومواعيد دقيقة',style: ConstantStyle.title,)),
              subtitle: Text('احجز موعدك الطبي بضغطة زر، واحصل على تنبيهات لتذكيرك بموعدك دون عناء الانتظار.',style: ConstantStyle.subtitle,textAlign: .center,),
            )
          ],
        ),
      ),
    );;
  }
}