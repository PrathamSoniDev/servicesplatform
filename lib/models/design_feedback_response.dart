class DesignFeedback {
  final String id;
  final String userName;
  final String? userRole;
  final int rating;
  final String feedbackText;
  final DateTime createdAt;

  DesignFeedback({
    required this.id,
    required this.userName,
    this.userRole,
    required this.rating,
    required this.feedbackText,
    required this.createdAt,
  });

  factory DesignFeedback.fromJson(Map<String, dynamic> json) {
    return DesignFeedback(
      id: json['_id'],
      userName: json['userName'],
      userRole: json['userRole'],
      rating: json['rating'],
      feedbackText: json['feedbackText'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class DesignFeedbackListResponse {
  final List<DesignFeedback> items;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  DesignFeedbackListResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory DesignFeedbackListResponse.fromJson(Map<String, dynamic> json) {
    return DesignFeedbackListResponse(
      items:
          (json['items'] as List)
              .map((e) => DesignFeedback.fromJson(e))
              .toList(),
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
    );
  }
}
