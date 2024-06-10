// ignore_for_file: unnecessary_import, prefer_const_constructors

import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';  //instala os pacotes basicos para o layout do app

void main() { //(main-> ponto de entrada da aplicação)
  runApp(const MyApp());  //(runApp-> inicia o aplicativo definindo o MyApp como conteudo inicial) 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});//(super.key-> identifica o widget como único)

  @override //indica que o método subsequente está sobrescrevendo um método da classe pai StatefulWidget
  Widget build(BuildContext context) {//(build-> responsável por construir a interface do usuário deste widget)
    return MaterialApp(
      title: 'To-Do List',//titulo do apliativo
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListPage(),//(home-> Define a pagina inicial do aplicativo)
    );
  }
}

class TodoListPage extends StatefulWidget {//(class-> Define uma nova classe(x)  extends-> indica que a classe(x) criada herda a StatefulWidget)
  const TodoListPage({super.key});

  @override //indica que o método subsequente está sobrescrevendo um método da classe pai StatefulWidget
  _TodoListPageState createState() => _TodoListPageState(); //(createState-> cria e retorna uma instância da classe)
}

class _TodoListPageState extends State<TodoListPage> {//(class-> define uma nova classe    _-> Indica que a classe é privada(só pode sr acessada dendro do arquivo onde esta definida) extends-> indica que a classe criada herda da classe State)
  final List<String> _todoItems = [];  //(final-> definir a variavel final(Variavel final indica que um valor, depois de criado nao pode ser alterado, neste caso é uma lista, não os cards depois) List<String>-> indica que a lista será uma lista de string   _todoItems-> nome da variavel  []-> indica que a lista inicia vazia)
  final TextEditingController _textFieldController = TextEditingController(); //(TextEditingController-> usado para controlar um campo de texto   _textFieldController-> variável que vai armazenar a instancia do controlador de texto)
  final FocusNode _addButtonFocusNode = FocusNode(); //

  void _addTodoItem(String task) {//(void-> define um metodo (x) que recebe uma (String task) como argumento sem retornar valor )
    if (task.isNotEmpty) {//(isNotEmpty-> verificar que nao esta vazia)
      setState(() {//(indica que o estado do widget mudou e deve ser reconstruido)
        _todoItems.add(task);//(adiciona os item dentro da lista "_todoItems")
      });
      _textFieldController.clear();//(limpar o campo apos add)
    }
  }

  void _editTodoItem(int index, String newTask) {
    if (newTask.isNotEmpty) {
      setState(() {
        _todoItems[index] = newTask;
      });
    }
  }

  void _removeTodoItem(int index) {//(metodo para remover item da lista)
    setState(() {
      _todoItems.removeAt(index);//(removeAt(index)-> metodo que realiza a exclusao)
    });
  }

  Widget _buildTodoItem(String task, int index) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 186, 178, 194),
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(255, 0, 0, 0), // Cor da borda inferior de cada item
                width: 1.0,
              ),
            ),
          ),
          child: ListTile(//(retorna um unico item da lista (ListTile))
            title: Text(task, //recebe a informação de texto
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Color.fromARGB(255, 0, 0, 0)),
                  onPressed: () => _displayEditTodoDialog(index, task),
                ),
                
                IconButton(
                  icon: const Icon(Icons.delete, color: Color.fromARGB(255, 0, 0, 0)),
                  onPressed: () => _removeTodoItem(index),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }

  void _displayAddTodoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Task',
            style: TextStyle(
              color: Color.fromARGB(255, 30, 116, 4),
              fontWeight: FontWeight.bold, 
            ),
          ),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Enter task here'),
            onSubmitted: (String value) {
              _addTodoItem(value);
              _textFieldController.clear();//para limpar
              Navigator.of(context).pop();
            },
            textInputAction: TextInputAction.done,
            onEditingComplete: () {
              _addButtonFocusNode.requestFocus();//press enter
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {// para botao cancelar
                Navigator.of(context).pop(); 
                _textFieldController.clear();//para limpar
              },
              child: const Text('Cancel',
                style: TextStyle(
                  color: Color.fromARGB(255, 126, 68, 68)
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 211, 191, 206),
              ),
              onPressed: () {
                _addTodoItem(_textFieldController.text); // Adiciona a tarefa
                _textFieldController.clear(); // Limpa o campo de texto
                Navigator.of(context).pop(); // Fecha a caixa de diálogo
              },
              child: const Text('Add',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 30, 29)
                  ),
              ),
            ),
          ],
          backgroundColor: Color.fromARGB(255, 192, 219, 195),
        );
      },
    );
  }

  void _displayEditTodoDialog(int index, String currentTask) {
    _textFieldController.text = currentTask;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task', 
          style: TextStyle(
              color: Color.fromARGB(255, 199, 145, 30),
              fontWeight: FontWeight.bold, 
            ),
          ),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Editing this Task'),
            textInputAction: TextInputAction.done,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',
                style: TextStyle(
                  color: Color.fromARGB(255, 126, 68, 68)
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 211, 191, 206),
              ),
              onPressed: () {
                _editTodoItem(index, _textFieldController.text);
                _textFieldController.clear();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Save', 
                  style: TextStyle(
                    color: Color.fromARGB(255, 31, 30, 29)
                  ),
              ),
            ),
          ],
          backgroundColor: Color.fromARGB(255, 247, 233, 182),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(//header do aplicativo
        title: const Text(
          'ToDo', 
          style: TextStyle(
            color: Color.fromARGB(255, 179, 161, 185),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 29, 22, 34),
      ),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListView.builder(
          itemCount: _todoItems.length,
          itemBuilder: (context, index) {
            return _buildTodoItem(_todoItems[index], index);
          },
        ),
      ),
      
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: _displayAddTodoDialog,
            child: const Text('New task',
              style: TextStyle(
                color: Color.fromARGB(255, 67, 37, 134),
                fontWeight: FontWeight.bold, 
                fontSize: 20.0,
              ),
            ),
          ),
      ),
      backgroundColor: Color.fromARGB(255, 64, 47, 73),
    );
  }
}
