import 'dart:typed_data'; // Untuk byte gambar (Web)
import 'dart:io' show File; // Untuk File gambar (Mobile)

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart'; // kIsWeb

import 'package:simaru_app/services/room_service.dart';

class RoomController extends GetxController {
  // Service API ruangan
  final RoomService _service = Get.put(RoomService());

  // Storage untuk token login
  final box = GetStorage();

  // Status loading
  var isLoading = false.obs;

  // =====================
  // HANDLE GAMBAR
  // =====================

  // Mobile (Android / iOS)
  var pickedImageFile = Rx<File?>(null);

  // Web
  var pickedImageBytes = Rx<Uint8List?>(null);
  var pickedImageName = ''.obs;

  // Image picker
  final picker = ImagePicker();

  // Data ruangan
  var rooms = <dynamic>[].obs;

  // Controller input
  final searchController = TextEditingController();
  final statusController = TextEditingController();

  @override
  void onInit() {
    fetchRooms(); // Ambil data saat pertama kali
    super.onInit();
  }

  /// ============================
  /// PICK IMAGE (WEB & MOBILE)
  /// ============================
  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (kIsWeb) {
        // Web → simpan bytes
        pickedImageBytes.value = await image.readAsBytes();
        pickedImageName.value = image.name;
      } else {
        // Mobile → simpan File
        pickedImageFile.value = File(image.path);
      }
    }
  }

  /// ============================
  /// CREATE ROOM
  /// ============================
  Future<void> createRoom({
    required String name,
    required String facultyName,
    required String capacity,
  }) async {
    // Validasi gambar
    if (kIsWeb && pickedImageBytes.value == null) {
      Get.snackbar("Error", "Foto wajib diisi");
      return;
    }

    if (!kIsWeb && pickedImageFile.value == null) {
      Get.snackbar("Error", "Foto wajib diisi");
      return;
    }

    isLoading.value = true;

    // Kirim ke service (multipart)
    final response = await _service.createRoom({
      'name': name,
      'faculty_name': facultyName,
      'capacity': capacity,
      'file': kIsWeb ? pickedImageBytes.value : pickedImageFile.value,
      'filename': pickedImageName.value,
    }, box.read('accessToken'));

    isLoading.value = false;

    // Cek hasil response
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      Get.snackbar("Sukses", "Ruangan berhasil ditambahkan");
      fetchRooms();
    } else {
      Get.snackbar("Error", "Status: ${response.statusCode}");
    }
  }

  /// ============================
  /// AMBIL DATA RUANGAN
  /// ============================
  Future<void> fetchRooms() async {
    final search = searchController.text.trim();
    final status = statusController.text.trim();

    try {
      isLoading.value = true;

      final response = await _service.getRoom(
        box.read('accessToken'),
        search,
        status,
      );

      if (response != null) {
        rooms.value = response['data'];
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
