// ignore_for_file: public_member_api_docs, sort_constructors_first
class FailureApp {
  final String message;
  FailureApp([this.message = "Sorry, an unexpected error occurred!"]);

  @override
  String toString() => message;
}
