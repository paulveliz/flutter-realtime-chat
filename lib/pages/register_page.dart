import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat/helpers/mostrar_alerta.dart';
import 'package:real_time_chat/services/auth_service.dart';
import 'package:real_time_chat/services/socket_service.dart';
import 'package:real_time_chat/widgets/boton_azul.dart';
import 'package:real_time_chat/widgets/custom_input.dart';
import 'package:real_time_chat/widgets/custom_labels.dart';
import 'package:real_time_chat/widgets/custom_logo.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(titulo: 'Registro'),
                _Form(),
                Labels(
                  ruta: 'login',
                  subText: '¿Ya tienes una cuenta?',
                  titleText: 'Ingresa ahora!',
                ),
                Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      )
    );
  }
}



class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameController = TextEditingController();
  final emailCtrl      = TextEditingController();
  final passwordCtrl   = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>( context );


    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.supervised_user_circle,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameController
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Password',
            keyboardType: TextInputType.text,
            textController: passwordCtrl,
            isPassword: true,
          ),
          BotonAzul(
            text: 'Ingrese',
            onPressed: authService.autenticando ? null : () async {
              final isRegistered = await authService.register( nameController.text.trim(), emailCtrl.text.trim(), passwordCtrl.text.trim() );
              if(isRegistered == true){
                socketService.connect();
                Navigator.pushReplacementNamed(context, 'usuarios');
              }else{
                mostrarAlerta(context, 'No se pudo registrar', isRegistered);
              }
            },
          )
        ],
      ),
    );
  }
}



