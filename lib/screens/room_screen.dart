import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simaru_app/controllers/room_controller.dart';
import 'add_room_screen.dart';

class RoomScreen extends StatelessWidget {
  RoomScreen({super.key});

  // Inisialisasi RoomController dengan GetX
  final RoomController controller = Get.put(RoomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Ruangan")),

      // Tombol tambah ruangan
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddRoomScreen());
        },
        child: const Icon(Icons.add),
      ),

      body: Obx(() {
        // Saat data masih di-load
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Jika data kosong
        if (controller.rooms.isEmpty) {
          return const Center(child: Text("Tidak ada data ruangan"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.rooms.length,
          itemBuilder: (context, index) {
            final room = controller.rooms[index];

            return Card(
              elevation: 3,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    // URL FULL + field foto dari API
                    // Android Emulator → 10.0.2.2
                    // Web → 127.0.0.1
                    "http://10.0.2.2:8000${room['photo']}",

                    width: 55,
                    height: 55,
                    fit: BoxFit.cover,

                    // Jika gambar gagal dimuat
                    errorBuilder:
                        (ctx, obj, stack) =>
                            const Icon(Icons.image_not_supported, size: 40),
                  ),
                ),

                // Nama ruangan
                title: Text(room['name']),

                // Fakultas dan kapasitas
                subtitle: Text(
                  "${room['faculty_name']} • Kapasitas ${room['capacity']}",
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
