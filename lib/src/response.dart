class LogType {
  static String web = 'Flutter Web';
  static String api = 'API Web';
  static String apps = 'Flutter Apps';
}

class LogReporting {
  String type;
  String filename;
  int line;

  String classname;
  String function;

  String message;
  String trace;

  LogReporting({
    this.type = '',
    this.filename = '',
    this.classname = '',
    this.function = '',
    this.line = 0,
    this.message = '',
    this.trace = '',
  });

  factory LogReporting.fromJson(Map<String, dynamic> map) {
    return LogReporting(
      type: map['type'],
      filename: map['filename'],
      classname: map['classname'],
      function: map['function'],
      line: map['line'],
      message: map['message'].toString(),
      trace: map['trace'],
    );
  }

  static Map<String, dynamic> json({
    String? type,
    String? filename,
    String? classname,
    String? function,
    int? line,
    String? message,
    String? trace,
  }) {
    return {
      'type': type,
      'filename': filename,
      'classname': classname,
      'function': function,
      'line': line,
      'message': message,
      'trace': trace,
    };
  }
}

class Response {
  bool result;
  int? status;
  String message;
  int? code;
  dynamic data;

  Map<String, dynamic>? _reporting;

  Response({
    required this.result,
    this.status,
    this.code,
    required this.message,
    this.data,
    Map<String, dynamic>? reporting,
  }) : _reporting = reporting;

  factory Response.fromJSON(Map<String, dynamic> map) {
    return Response(
      result: map["result"],
      status: map["status"],
      code: map["code"],
      message: map["message"],
      data: map["data"],
      reporting: map["reporting"],
    );
  }

  LogReporting get reporting {
    if(_reporting != null)
      return LogReporting.fromJson(_reporting!);

    return LogReporting();
  }
}