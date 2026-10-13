import 'package:flutter/material.dart';
import 'package:tababa/constant/constant_style.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

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
              title: Center(child: Text('طبيبك الأقرب إليك',style: ConstantStyle.title,)),
              subtitle: Text('ابحث عن أفضل الأطباء والعيادات في منطقتك، واكتشف التخصصات الطبية بسهولة.',style: ConstantStyle.subtitle,textAlign: .center,),
            )
          ],
        ),
      ),
    );
  }
}