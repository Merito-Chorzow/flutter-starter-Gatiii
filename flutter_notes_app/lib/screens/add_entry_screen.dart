import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  Position? position;
  bool loadingLocation = false;
  String? error;

  Future<void> getLocation() async {
    setState(() {
      loadingLocation = true;
      error = null;
    });

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        error = "Brak uprawnień do GPS";
        loadingLocation = false;
      });
      return;
    }

    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        position = pos;
        loadingLocation = false;
      });
    } catch (e) {
      setState(() {
        error = "Nie udało się pobrać lokalizacji";
        loadingLocation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dodaj wpis")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Tytuł"),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: "Opis"),
              maxLines: 4,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: getLocation,
              child: loadingLocation
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text("Pobierz lokalizację"),
            ),

            const SizedBox(height: 10),

            if (position != null)
              Text(
                "Lokacja: ${position!.latitude}, ${position!.longitude}",
                style: const TextStyle(color: Colors.green),
              ),

            if (error != null)
              Text(
                error!,
                style: const TextStyle(color: Colors.red),
              ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                // Na razie tylko wracamy
                Navigator.pop(context);
              },
              child: const Text("Zapisz wpis"),
            )
          ],
        ),
      ),
    );
  }
}
