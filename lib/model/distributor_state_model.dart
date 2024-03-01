class DisStateModel 
{
  bool? status;
  String? message;
  List<StateDataList>? result;

  DisStateModel({this.status, this.message, this.result});

  DisStateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <StateDataList>[];
      json['result'].forEach((v) {
        result!.add(new StateDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateDataList {
  int? id;
  String? stateName;
  String? stateCode;

  StateDataList({this.id, this.stateName, this.stateCode});

  StateDataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['state_name'];
    stateCode = json['state_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_name'] = this.stateName;
    data['state_code'] = this.stateCode;
    return data;
  }
}
