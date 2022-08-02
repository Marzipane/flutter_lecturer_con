bool isLecturer(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@gau.edu.tr")
      .hasMatch(email);
}

bool isStudent(String? email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@std.gau.edu.tr")
      .hasMatch(email!);
}
