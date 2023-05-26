class BooksModel {
  final int count;
  final String? next;
  final String? previous;
  List<Results> results;

  BooksModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory BooksModel.fromJson(Map<String, dynamic> json) {
    return BooksModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: json['results'] != null
          ? json['results'].forEach((v) {
              List<Results> results = [];
              results.add(Results.fromJson(v));
            })
          : [],
    );
  }
}

class Results {
  int id;
  String? type;
  String title;
  String? description;
  int? downloads;
  String? license;
  List<String>? subjects;
  List<String>? bookshelves;
  List<String>? languages;
  List<Authors>? authors;
  Formats? formats;

  Results({
    required this.id,
    this.type,
    required this.title,
    this.description,
    this.downloads,
    this.license,
    this.subjects,
    this.bookshelves,
    this.languages,
    this.authors,
    this.formats,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      description: json['description'],
      downloads: json['downloads'],
      license: json['license'],
      subjects: json['subjects'].cast<String>(),
      bookshelves: json['bookshelves'].cast<String>(),
      languages: json['languages'].cast<String>(),
      authors: (json['authors'] as List).map((e) {
        return Authors.fromJson(e);
      }).toList(),
      formats: Formats.fromJson(json['formats']),
    );
  }
}

class Authors {
  int? birthYear;
  int? deathYear;
  String? name;

  Authors({this.birthYear, this.deathYear, this.name});

  factory Authors.fromJson(Map<String, dynamic> json) {
    return Authors(
      birthYear: json['birth_year'],
      deathYear: json['death_year'],
      name: json['name'],
    );
  }
}

class Formats {
  String? applicationXMobipocketEbook;
  String? textPlainCharsetUsAscii;
  String? applicationEpubZip;
  String? textPlainCharsetIso88591;
  String? applicationZip;
  String? textPlain;
  String? imageJpeg;
  String? applicationRdfXml;
  String? textHtmlCharsetIso88591;
  String? textHtmlCharsetUsAscii;
  String? textPlainCharsetUtf8;
  String? textHtmlCharsetUtf8;
  String? textHtml;
  String? applicationPdf;

  Formats({
    this.applicationXMobipocketEbook,
    this.textPlainCharsetUsAscii,
    this.applicationEpubZip,
    this.textPlainCharsetIso88591,
    this.applicationZip,
    this.textPlain,
    this.imageJpeg,
    this.applicationRdfXml,
    this.textHtmlCharsetIso88591,
    this.textHtmlCharsetUsAscii,
    this.textPlainCharsetUtf8,
    this.textHtmlCharsetUtf8,
    this.applicationPdf,
    this.textHtml,
  });

  factory Formats.fromJson(Map<String, dynamic> json) {
    return Formats(
      applicationXMobipocketEbook: json['application/x-mobipocket-ebook'],
      textPlainCharsetUsAscii: json['text/plain; charset=us-ascii'],
      applicationEpubZip: json['application/epub+zip'],
      textPlainCharsetIso88591: json['text/plain; charset=iso-8859-1'],
      applicationZip: json['application/zip'],
      textPlain: json['text/plain'],
      imageJpeg: json['image/jpeg'],
      applicationRdfXml: json['application/rdf+xml'],
      textHtmlCharsetIso88591: json['text/html; charset=iso-8859-1'],
      textHtmlCharsetUsAscii: json['text/html; charset=us-ascii'],
      textPlainCharsetUtf8: json['text/plain; charset=utf-8'],
      textHtmlCharsetUtf8: json['text/html; charset=utf-8'],
      textHtml: json['text/html'],
      applicationPdf: json['application/pdf'],
    );
  }
}
