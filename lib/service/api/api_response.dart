// ignore_for_file: constant_identifier_names

class ApiResponse<T> {
  String? message;
  dynamic data;
  bool? status;

  ApiResponse({
    this.message,
    this.data,
    this.status,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        message: json['message'],
        data: json['data'],
        status: json['status'],
      );

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data: $data";
  }
}
