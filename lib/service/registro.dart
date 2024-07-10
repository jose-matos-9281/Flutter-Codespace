import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

  // Enviar los datos mediante una petición POST
String url = 'https://prueba-control.azurewebsites.net/api/registro'; // Reemplazon tu URL

Future saveRegistro(String formattedDate, String description, double amount, bool completed, bool ignored) async {
  // Procesar los datos del formulario

  // Crear el JSON a partir de los datos del formulario
  Map<String, dynamic> formData = <String, dynamic>{
    "fecha": formattedDate,
    "descripcion": description,
    "monto": amount,
    "realizado": completed,
    "ignorar": ignored
  };

  try {
    final response = await createAlbum(formData);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Petición exitosa
      return jsonDecode(response.body);
    } else {
      // Error en la petición
      return "Error en la petición ${response.statusCode} - ${response.body}";
    }
  } catch (e) {
    // Error en la conexión
    return e.toString();
  }
}

Future<http.Response> createAlbum(Map<String, dynamic> data) {
  return http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
}
