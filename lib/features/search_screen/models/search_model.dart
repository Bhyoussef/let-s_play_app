class SearchModel {
  SearchModel({
    required this.data,
  });
  late final Data data;

  SearchModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });
  late final int? currentPage;
  late final List<SearchData>? data;
  late final String? firstPageUrl;
  late final int? from;
  late final int? lastPage;
  late final String? lastPageUrl;
  late final List<Links>? links;
  late final String? nextPageUrl;
  late final String? path;
  late final int? perPage;
  late final String? prevPageUrl;
  late final int? to;
  late final int? total;

  Data.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    data = List.from(json['data']).map((e)=>SearchData.fromJson(e)).toList();
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    links = List.from(json['links']).map((e)=>Links.fromJson(e)).toList();
    nextPageUrl = null;
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = null;
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['data'] = data?.map((e)=>e.toJson()).toList();
    _data['first_page_url'] = firstPageUrl;
    _data['from'] = from;
    _data['last_page'] = lastPage;
    _data['last_page_url'] = lastPageUrl;
    _data['links'] = links?.map((e)=>e.toJson()).toList();
    _data['next_page_url'] = nextPageUrl;
    _data['path'] = path;
    _data['per_page'] = perPage;
    _data['prev_page_url'] = prevPageUrl;
    _data['to'] = to;
    _data['total'] = total;
    return _data;
  }
}

class Links {
  Links({
    this.url,
    required this.label,
    required this.active,
  });
  late final String? url;
  late final String? label;
  late final bool? active;

  Links.fromJson(Map<String, dynamic> json){
    url = null;
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['label'] = label;
    _data['active'] = active;
    return _data;
  }
}

class SearchData {
  SearchData({
    required this.id,
    required this.enName,
    required this.arName,
    required this.enDescription,
    required this.arDescription,
    required this.workingDays,
    required this.price,
    required this.mainImage,
    required this.fullAddress,
    required this.buildingNo,
    required this.zoneNo,
    required this.streetNo,
    required this.latitude,
    required this.longitude,
    required this.crFile,
    required this.status,
    required this.gender,
    required this.categoryId,
    required this.merchantId,
    required this.grassTypeId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String enName;
  late final String arName;
  late final String enDescription;
  late final String arDescription;
  late final String workingDays;
  late final double price;
  late final String mainImage;
  late final String fullAddress;
  late final String buildingNo;
  late final String zoneNo;
  late final String streetNo;
  late final double latitude;
  late final double longitude;
  late final String crFile;
  late final bool status;
  late final String gender;
  late final int categoryId;
  late final int merchantId;
  late final int grassTypeId;
  late final String createdAt;
  late final String updatedAt;

  SearchData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    enDescription = json['en_description'];
    arDescription = json['ar_description'];
    workingDays = json['working_days'];
    price = json['price'].toDouble();
    mainImage = json['main_image'];
    fullAddress = json['full_address'];
    buildingNo = json['building_no'];
    zoneNo = json['zone_no'];
    streetNo = json['street_no'];
    latitude = json['latitude'].toDouble();
    longitude = json['longitude'].toDouble();
    crFile = json['cr_file'];
    status = json['status'];
    gender = json['gender'];
    categoryId = json['category_id'];
    merchantId = json['merchant_id'];
    grassTypeId = json['grass_type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['en_name'] = enName;
    _data['ar_name'] = arName;
    _data['en_description'] = enDescription;
    _data['ar_description'] = arDescription;
    _data['working_days'] = workingDays;
    _data['price'] = price;
    _data['main_image'] = mainImage;
    _data['full_address'] = fullAddress;
    _data['building_no'] = buildingNo;
    _data['zone_no'] = zoneNo;
    _data['street_no'] = streetNo;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['cr_file'] = crFile;
    _data['status'] = status;
    _data['gender'] = gender;
    _data['category_id'] = categoryId;
    _data['merchant_id'] = merchantId;
    _data['grass_type_id'] = grassTypeId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}