class FaqModel {
  final String id;
  final String question;
  final String answer;
  final bool isExpanded;

  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      isExpanded: json['isExpanded'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'isExpanded': isExpanded,
    };
  }

  FaqModel copyWith({
    String? id,
    String? question,
    String? answer,
    bool? isExpanded,
  }) {
    return FaqModel(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}
