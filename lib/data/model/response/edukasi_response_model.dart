import 'dart:convert';

class EdukasiResponModel {
    final bool? success;
    final String? message;
    final List<Edukasi>? data;

    EdukasiResponModel({
        this.success,
        this.message,
        this.data,
    });

    factory EdukasiResponModel.fromJson(String str) => EdukasiResponModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory EdukasiResponModel.fromMap(Map<String, dynamic> json) => EdukasiResponModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Edukasi>.from(json["data"]!.map((x) => Edukasi.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Edukasi {
    final int? id;
    final String? title;
    final String? content;
    final String? type;
    final String? thumbnail;
    final String? source;
    final String? institutionLogo;
    final String? authorName;
    final DateTime? publishedAt;
    final String? videoUrl;
    final dynamic shareLink;
    final int? educationCategoryId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Category? category;

    Edukasi({
        this.id,
        this.title,
        this.content,
        this.type,
        this.thumbnail,
        this.source,
        this.institutionLogo,
        this.authorName,
        this.publishedAt,
        this.videoUrl,
        this.shareLink,
        this.educationCategoryId,
        this.createdAt,
        this.updatedAt,
        this.category,
    });

    factory Edukasi.fromJson(String str) => Edukasi.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Edukasi.fromMap(Map<String, dynamic> json) => Edukasi(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        type: json["type"],
        thumbnail: json["thumbnail"],
        source: json["source"],
        institutionLogo: json["institution_logo"],
        authorName: json["author_name"],
        publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
        videoUrl: json["video_url"],
        shareLink: json["share_link"],
        educationCategoryId: json["education_category_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        category: json["category"] == null ? null : Category.fromMap(json["category"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "content": content,
        "type": type,
        "thumbnail": thumbnail,
        "source": source,
        "institution_logo": institutionLogo,
        "author_name": authorName,
        "published_at": publishedAt?.toIso8601String(),
        "video_url": videoUrl,
        "share_link": shareLink,
        "education_category_id": educationCategoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category": category?.toMap(),
    };
}

class Category {
    final int? id;
    final String? name;
    final String? icon;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Category({
        this.id,
        this.name,
        this.icon,
        this.createdAt,
        this.updatedAt,
    });

    factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "icon": icon,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}