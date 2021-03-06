///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class VillageModelDataTahsil {
/*
{
  "id": 1,
  "ser_id": 1,
  "country_id": 1,
  "state_id": 1,
  "city_id": 1,
  "name": "Pune",
  "status": true,
  "created_at": "2021-09-30T06:30:28.000000Z",
  "updated_at": "2021-09-30T06:30:28.000000Z",
  "deleted_at": null
} 
*/

  int? id;
  int? serId;
  int? countryId;
  int? stateId;
  int? cityId;
  String? name;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  VillageModelDataTahsil({
    this.id,
    this.serId,
    this.countryId,
    this.stateId,
    this.cityId,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  VillageModelDataTahsil.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    serId = json["ser_id"]?.toInt();
    countryId = json["country_id"]?.toInt();
    stateId = json["state_id"]?.toInt();
    cityId = json["city_id"]?.toInt();
    name = json["name"]?.toString();
    status = json["status"];
    createdAt = json["created_at"]?.toString();
    updatedAt = json["updated_at"]?.toString();
    deletedAt = json["deleted_at"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["ser_id"] = serId;
    data["country_id"] = countryId;
    data["state_id"] = stateId;
    data["city_id"] = cityId;
    data["name"] = name;
    data["status"] = status;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["deleted_at"] = deletedAt;
    return data;
  }
}

class VillageModelData {
/*
{
  "tahsil": [
    {
      "id": 1,
      "ser_id": 1,
      "country_id": 1,
      "state_id": 1,
      "city_id": 1,
      "name": "Pune",
      "status": true,
      "created_at": "2021-09-30T06:30:28.000000Z",
      "updated_at": "2021-09-30T06:30:28.000000Z",
      "deleted_at": null
    }
  ]
} 
*/

  List<VillageModelDataTahsil?>? tahsil;

  VillageModelData({
    this.tahsil,
  });
  VillageModelData.fromJson(Map<String, dynamic> json) {
  if (json["tahsil"] != null) {
  final v = json["tahsil"];
  final arr0 = <VillageModelDataTahsil>[];
  v.forEach((v) {
  arr0.add(VillageModelDataTahsil.fromJson(v));
  });
    tahsil = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (tahsil != null) {
      final v = tahsil;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data["tahsil"] = arr0;
    }
    return data;
  }
}

class VillageModel {
/*
{
  "success": true,
  "data": {
    "tahsil": [
      {
        "id": 1,
        "ser_id": 1,
        "country_id": 1,
        "state_id": 1,
        "city_id": 1,
        "name": "Pune",
        "status": true,
        "created_at": "2021-09-30T06:30:28.000000Z",
        "updated_at": "2021-09-30T06:30:28.000000Z",
        "deleted_at": null
      }
    ]
  },
  "message": "tahsil list."
} 
*/

  bool? success;
  VillageModelData? data;
  String? message;

  VillageModel({
    this.success,
    this.data,
    this.message,
  });
  VillageModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = (json["data"] != null) ? VillageModelData.fromJson(json["data"]) : null;
    message = json["message"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["success"] = success;
    if (data != null) {
      data["data"] = this.data!.toJson();
    }
    data["message"] = message;
    return data;
  }
}
