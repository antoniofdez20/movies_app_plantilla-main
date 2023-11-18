import 'models.dart';

class UpcomingFilmsResponse {
  Dates dates;
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  UpcomingFilmsResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory UpcomingFilmsResponse.fromJson(String str) =>
      UpcomingFilmsResponse.fromMap(json.decode(str));

  factory UpcomingFilmsResponse.fromMap(Map<String, dynamic> json) =>
      UpcomingFilmsResponse(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
