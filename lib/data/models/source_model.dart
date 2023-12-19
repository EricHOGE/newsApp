import 'package:equatable/equatable.dart';

class SourceModel extends Equatable {
  final String? id;
  final String? sourceName;

  const SourceModel({this.id, this.sourceName});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'] as String?,
      sourceName: json['name'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, sourceName];
}
