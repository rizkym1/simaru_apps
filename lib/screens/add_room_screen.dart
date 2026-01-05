import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart'; // Digunakan untuk mengecek apakah aplikasi berjalan di Web

import 'package:simaru_app/controllers/room_controller.dart';

class AddRoomScreen extends StatelessWidget {
  AddRoomScreen({super.key});

  // Mengambil RoomController menggunakan GetX
  final RoomController controller = Get.find();

  // Controller untuk input form
  final nameC = TextEditingController();
  final facultyC = TextEditingController();
  final capacityC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Ruangan")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input nama ruangan
            TextField(
              controller: nameC,
              decoration: const InputDecoration(labelText: "Nama Ruangan"),
            ),
            const SizedBox(height: 12),

            // Input fakultas
            TextField(
              controller: facultyC,
              decoration: const InputDecoration(labelText: "Fakultas"),
            ),
            const SizedBox(height: 12),

            // Input kapasitas ruangan
            TextField(
              controller: capacityC,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Kapasitas"),
            ),
            const SizedBox(height: 16),

            // PREVIEW GAMBAR
            // Web dan Android memiliki cara berbeda dalam menampilkan gambar
            Obx(() {
              // Jika aplikasi dijalankan di Web
              if (kIsWeb) {
                return controller.pickedImageBytes.value == null
                    // Jika belum memilih gambar
                    ? const Text("Belum pilih gambar")
                    // Web menggunakan Image.memory (berbasis byte)
                    : Image.memory(
                      controller.pickedImageBytes.value!,
                      height: 150,
                    );
              }
              // Jika aplikasi dijalankan di Android / iOS
              else {
                return controller.pickedImageFile.value == null
                    // Jika belum memilih gambar
                    ? const Text("Belum pilih gambar")
                    // Mobile menggunakan Image.file (berbasis file lokal)
                    : Image.file(
                      controller.pickedImageFile.value!,
                      height: 150,
                    );
              }
            }),

            const SizedBox(height: 12),

            // Tombol untuk memilih gambar dari galeri
            ElevatedButton.icon(
              onPressed: controller.pickImage, // Logika ada di controller
              icon: const Icon(Icons.image),
              label: const Text("Pilih Foto"),
            ),

            const SizedBox(height: 24),

            // Tombol simpan data ruangan
            ElevatedButton(
              onPressed: () {
                // Mengirim data input ke controller
                controller.createRoom(
                  name: nameC.text,
                  facultyName: facultyC.text,
                  capacity: capacityC.text,
                );
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
