import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RoomService extends GetxService {
  final http.Client client = http.Client();

  Future<dynamic> getRoom(String token, String search, String status) async {
    try {
      final response = await client.get(
        Uri.parse(
          'http://10.0.2.2:8000/api/rooms?search=$search&status=$status',
        ),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// ✅ FIX UPLOAD FILE (WEB & ANDROID)
  Future<http.StreamedResponse> createRoom(
    Map<String, dynamic> data,
    String token,
  ) async {
    final uri = Uri.parse('http://10.0.2.2:8000/api/rooms');
    final request = http.MultipartRequest('POST', uri);

    // Header
    request.headers.addAll({
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    // Field text
    request.fields['name'] = data['name'];
    request.fields['faculty_name'] = data['faculty_name'];
    request.fields['capacity'] = data['capacity'];

    // File upload
    if (data['file'] is File) {
      request.files.add(
        await http.MultipartFile.fromPath('photo', data['file'].path),
      );
    }

    if (data['file'] is Uint8List) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'photo',
          data['file'],
          filename: data['filename'],
        ),
      );
    }

    return await request.send();
  }
}
