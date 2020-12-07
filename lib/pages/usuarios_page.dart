import 'package:flutter/material.dart';
import 'package:real_time_chat/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key key}) : super(key: key);

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarios = [
    Usuario(uid: '1', nombre: 'Paul', email: 'test1@gmail.com', online: true),
    Usuario(uid: '2', nombre: 'Pablo', email: 'test2@gmail.com', online: false),
    Usuario(uid: '3', nombre: 'Alex', email: 'test3@gmail.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Mi nombre', 
          style: TextStyle(color: Colors.black54)
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black54), 
          onPressed: (){}
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon( Icons.check_circle, color: Colors.blue[400] ),
          )
        ],
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => ListTile(
          title: Text(usuarios[i].nombre),
          leading: CircleAvatar(
            child: Text(usuarios[i].nombre.substring(0,2)),
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: usuarios[i].online ? Colors.green[300] : Colors.red,
              borderRadius: BorderRadius.circular(100)
            ),
          ),
        ), 
        separatorBuilder: (_, i) => Divider(), 
        itemCount: usuarios.length
      ),
    );
  }
}