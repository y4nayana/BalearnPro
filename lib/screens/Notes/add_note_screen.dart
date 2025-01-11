import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'note_model.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;

  const AddNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final description = _descriptionController.text;

      if (widget.note == null) {
        // Tambah catatan baru
        await DatabaseHelper.instance.create(Note(
          title: title,
          description: description,
        ));
      } else {
        // Update catatan yang ada
        await DatabaseHelper.instance.update(Note(
          id: widget.note!.id,
          title: title,
          description: description,
        ));
      }

      // Navigasi kembali ke layar sebelumnya dengan true
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note == null ? 'Tambah Catatan' : 'Edit Catatan',
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Card-style untuk Title
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: TextFormField(
                    controller: _titleController,
                    style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: 'Judul',
                      labelStyle: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Judul tidak boleh kosong.';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Card-style untuk Description
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: TextFormField(
                    controller: _descriptionController,
                    style: theme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                      labelText: 'Deskripsi',
                      labelStyle: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    maxLines: 8,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Deskripsi tidak boleh kosong.';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              SizedBox(height: 32),

              // Tombol Simpan
              ElevatedButton(
                onPressed: _saveNote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Simpan',
                  style: theme.textTheme.labelLarge?.copyWith(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
