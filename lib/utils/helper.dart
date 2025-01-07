// utils/helper.dart

class Helper {
  // Validasi email format
  static bool isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  // Validasi password panjang minimal 6 karakter
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  // Menampilkan snackbar dengan pesan
  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Mengkonversi tanggal menjadi format tertentu
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
