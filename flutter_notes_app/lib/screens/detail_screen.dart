import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  final int postId;

  const DetailScreen({super.key, required this.postId});

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
    try {
      final response = await http
          .get(Uri.parse("https://dummyjson.com/posts/${widget.postId}"));

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
        error = "Blad pobierania danych";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Szczegoly wpisu"),
      ),

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
                        post!["body"],
                        style: const TextStyle(fontSize: 16),
                      ),

                      const Spacer(),

                      Text(
                        "ID: ${post!["id"]}",
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),
    );
  }
}
