class Status<T> {
  final bool success;
  final String message;
  final T? data;

  Status({required this.success, required this.message, this.data});
}
