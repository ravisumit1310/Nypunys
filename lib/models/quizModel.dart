class Quiz {
  int id;
  String question;
  List<Option> options;
  int? selectedOptionId;
  String? submissionStatus;

  Quiz({
    required this.id,
    required this.question,
    required this.options,
    this.selectedOptionId,
    this.submissionStatus,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json["quiz_id"] ?? 0,
      question: json["question"] ?? "No question",
      options: (json["options"] as List<dynamic>?)
              ?.map((optionJson) => Option.fromJson(optionJson))
              .toList() ??
          [],
      selectedOptionId: json["selected_option_id"], // Nullable field
      submissionStatus: json["submission_status"], // Nullable field
    );
  }
}

class Option {
  int id;
  String text;

  Option({required this.id, required this.text});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json["id"] ?? 0,
      text: json["text"] ?? "No text",
    );
  }
}
