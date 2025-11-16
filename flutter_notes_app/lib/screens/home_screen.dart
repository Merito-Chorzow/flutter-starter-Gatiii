import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    List<dynamic> posts = [];
    bool loading = true;
    String? error;

    @override
    void initState() {
        super.initState();
        loadData();
    }

    void loadData() async {
        try {
            final data = await ApiService().fetchPosts();
        setState(() {
            posts = data;
            loading = false;
        });
        } catch (e) {
            setState(() {
                error = "Nie udało się pobrać danych";
                loading = false;
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text("Lista wpisów")),

            body: loading
                ? const Center(child: CircularProgressIndicator())
                : error != null
                    ? Center(child: Text(error!))
                    : ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                            final item = posts[index];
                            return ListTile(
                            title: Text(item["title"]),
                            subtitle: Text("ID: ${item["id"]}"),
                            onTap: () {
                                Navigator.pushNamed(
                                    context,
                                    "/details",
                                    arguments: item["id"],
                                );
                            },
                        );
                    },
                ),
        );
    }
}
