import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  final Map post;

  const DetailScreen({super.key, required this.post});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Map<String, dynamic>? post;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadPost();
  }

  Future<void> loadPost() async {
    if (widget.post["id"] > 1000) {
      setState(() {
        post = Map<String, dynamic>.from(widget.post);
        loading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("https://dummyjson.com/posts/${widget.post["id"]}"),
      );

      if (response.statusCode == 200) {
        setState(() {
          post = json.decode(response.body);
          loading = false;
        });
      } else {
        setState(() {
          error = "Nie znaleziono wpisu";
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = "Błąd pobierania danych";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Szczegóły wpisu")),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post!["title"],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),

                      Text(
                        post!["body"] ?? "Brak treści",
                        style: const TextStyle(fontSize: 16),
                      ),

                      const Spacer(),
                      Text("ID: ${post!["id"]}",
                          style: const TextStyle(color: Colors.grey)),
                        
                      const SizedBox(height: 12),

                      if (post!.containsKey("lat") && post!.containsKey("lng"))
                        Text(
                          "Lokalizacja: ${post!["lat"]}, ${post!["lng"]}",
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                    ],
                  ),
                ),
    );
  }
}
