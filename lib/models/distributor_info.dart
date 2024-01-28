class DistributorInfo {
  int? id;
  String? distributorName;
  String? distributorAddress;
  String? name;
  String? number;
  String? companyName;
  DistributorInfo(
      {this.id,
      this.distributorName,
      this.distributorAddress,
      this.name,
      this.number,
      this.companyName});

  factory DistributorInfo.fromMap(Map<String, dynamic> json) => DistributorInfo(
        id: json['id'],
        distributorName: json['distributorName'],
        distributorAddress: json['distributorAddress'],
        name: json['name'],
        number: json['number'],
        companyName: json['companyName'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'distributorName': distributorName,
        'distributorAddress': distributorAddress,
        'name': name,
        'number': number,
        'companyName': companyName,
      };
}
