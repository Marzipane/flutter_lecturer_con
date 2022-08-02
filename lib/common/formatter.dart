class Formatters {
  String formatStatus(String status) {
    switch (status) {
      case 'A':
        return 'Answered';
      case 'D':
        return 'Discarded';
      case 'E':
        return 'Evaluated';
      default:
        return 'Not read yet';
    }
  }
}
