// ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/foundation.dart';
// import 'dart:developer';
import '../service/registro.dart' as registro;
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  bool _completed = false;
  bool _ignored = false;

  void _submitForm() async  {
    if (_formKey.currentState!.validate()) {
      // Procesar los datos del formulario
      // mostrar un alert 
      // hacer una peticion post
      // guardar en una base de datos
      var result = await registro.saveRegistro(
         _selectedDate != null ? _selectedDate!.toIso8601String() : "", 
        _descriptionController.text, 
        double.parse(_amountController.text), 
        _completed, _ignored
        );

       
      resumen(result);
      
    }
  }

  Future<dynamic> resumen(res) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Datos del formulario'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(res != null ?  'Formulario enviado correctamente o  $res': 'Error al enviar el formulario'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(_selectedDate == null
                    ? 'Seleccionar fecha'
                    : 'Fecha: ${_selectedDate!.toLocal()}'.split(' ')[0]),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese una descripción';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Monto'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un monto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, ingrese un número válido';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: const Text('Realizado'),
                value: _completed,
                onChanged: (bool value) {
                  setState(() {
                    _completed = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Ignorar'),
                value: _ignored,
                onChanged: (bool value) {
                  setState(() {
                    _ignored = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
