class CreateProject {
  final String id;
  final String projectName;
  final String companyName;
  final String date;
  final String website;
  final String latitude;
  final String longitude;

  CreateProject(
      {required this.id,
      required this.projectName,
      required this.companyName,
      required this.date,
      required this.website,
      required this.latitude,
      required this.longitude});
  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'date': date,
      'projectName': projectName,
      'companyName': companyName,
      'website': website,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
