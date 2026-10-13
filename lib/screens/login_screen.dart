import 'package:flutter/material.dart';
import 'package:tababa/constant/constant_style.dart';
import 'package:tababa/screens/nav_bar.dart';
import 'package:tababa/services/auth_service.dart';
import 'package:tababa/services/utils.dart';
import 'package:tababa/widgets/custom_form_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hasAccount=true;
  final _formKey=GlobalKey<FormState>();
  AuthService authService=AuthService();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController=TextEditingController();
    TextEditingController passController=TextEditingController();
    TextEditingController nameController=TextEditingController();
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: SizedBox(
            width: .infinity,
            child: Column(
              spacing: 20,
              // mainAxisAlignment: .spaceEvenly,
              children: [
                Image.asset('assets/images/logo.png',height: size.height/2,width: size.width,),
                Form(
                  key: _formKey,
                  child:Column(
                    spacing: 16,
                    children: [
                      if(!hasAccount)
                      
                        CustomFormTextField(
                        hint: 'اسمك',
                        label: 'username',
                        controller: nameController,
                        preIcon: Icons.email,
                        validator: (value) {
                          if(value==null || value.isEmpty)
                          {
                            return 'يجب ادخال الاسم';
                          }
                          if(!Utils.checkUsername(value))
                          {
                            return 'الاسم غير صحيح';
                          }
                          else
                          {
                            return null;
                          }
                        } ,
                      ),
                      
                      
                      CustomFormTextField(
                        hint: 'email@domain.com',
                        label: 'Email',
                        controller: emailController,
                        preIcon: Icons.email,
                        validator: (value) {
                          if(value==null || value.isEmpty)
                          {
                            return 'يجب ادخال الايميل';
                          }
                          if(!Utils.checkEmail(value))
                          {
                            return 'الايميل غير صحيح';
                          }
                          else
                          {
                            return null;
                          }
                        } ,
                      ),
                      CustomFormTextField(
                        hint: '******',
                        label: 'password',
                        controller: passController,
                        preIcon: Icons.password,
                        validator: (value) {
                          if(value==null || value.isEmpty)
                          {
                            return 'يجب ادخال كلمة المرور';
                          }
                          if(!Utils.checkPassword(value))
                          {
                            return 'كلمة المرور غير صحيحه';
                          }
                          else
                          {
                            return null;
                          }
                        } ,
                      )
          
                    
                    ],
                  ),
                  
                  
                  ),
                  SizedBox(
                    width: size.width,
                    child: ElevatedButton(
                      
                      onPressed: ()async{
                        setState(() {
                            isLoading=!isLoading;
                          });
                          String result;
                        if(_formKey.currentState!.validate())
                        {
                          if(hasAccount)
                          {
                           result=await authService.login(email: emailController.text.trim(), password: passController.text.trim());
                            if(result=='done login')
                            {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavBar()));
                            }
                            else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                            }
                            
                          }
                          else{
                            result=await authService.signUp(
                              email: emailController.text.trim(), 
                              password: passController.text.trim(), 
                              name: nameController.text.trim(), 
                              context: context
                              );
                              if(result=='done')
                              {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavBar()));
                              }
                              else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                            }
                              
                          }
                        }
                        setState(() {
                          isLoading=!isLoading;
                          passController.clear();
                          nameController.clear();
                          emailController.clear();
                        });
                      }, 
                      style: ConstantStyle.buttonStyle,
                      child: isLoading?CircularProgressIndicator():Text(hasAccount?'L o g i n':'Sign Up',style: ConstantStyle.textButtonStyle,),),
                  ),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text(hasAccount?'if you dont have an account ':'if you have an account '),
                      TextButton(onPressed: 
                      (){
                        setState(() {
                          hasAccount=!hasAccount;
                        });
                      }, child: Text(hasAccount?'Sign Up':'Login',))
                    ],
                  )
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}