import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'note_model.dart';
import 'add_note_screen.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late Future<List<Note>> _noteList;

  @override
  void initState() {
    super.initState();
    _refreshNoteList(); // Refresh data saat layar dibuka
  }

  void _refreshNoteList() {
    setState(() {
      _noteList = DatabaseHelper.instance.readAllNotes(); // Ambil data dari database
      print('Data diperbarui: Memuat ulang catatan...');
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Note>>(
          future: _noteList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Loader saat data sedang dimuat
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Tampilkan pesan error jika ada
              print('Error saat memuat catatan: ${snapshot.error}');
              return Center(
                child: Text(
                  'Terjadi kesalahan saat memuat catatan.\nPeriksa log untuk detailnya.',
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // Tampilkan pesan jika tidak ada catatan
              return Center(
                child: Text(
                  'Tidak ada catatan.\nKlik tombol "+" untuk menambahkan.',
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              // Tampilkan data dalam ListView
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final note = snapshot.data![index];

                  // Desain kartu untuk setiap catatan
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        note.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          note.description,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blueAccent),
                            onPressed: () async {
                              // Navigasi ke AddNoteScreen untuk mengedit catatan
                              final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => AddNoteScreen(note: note),
                                ),
                              );
                              if (result == true) {
                                _refreshNoteList();
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () async {
                              // Hapus catatan
                              await DatabaseHelper.instance.delete(note.id!);
                              _refreshNoteList();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),

      // Tombol Tambah Catatan
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Navigasi ke AddNoteScreen untuk menambah catatan
          final result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddNoteScreen()),
          );
          if (result == true) {
            _refreshNoteList();
          }
        },
        label: Text(
          'Tambah Catatan',
          style: TextStyle(color: Colors.white), // Warna teks tombol diubah menjadi putih
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
