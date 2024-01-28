class OutletListModel {
  int? id;
  String? name;
  String? address;
  String? personName;
  String? number;
  String? outletType;
  OutletListModel(
      {this.id,
      this.name,
      this.address,
      this.personName,
      this.number,
      this.outletType});

  factory OutletListModel.fromMap(Map<String, dynamic> json) => OutletListModel(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        personName: json['personName'],
        number: json['number'],
        outletType: json['outletType'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
        'personName': personName,
        'number': number,
        'outletType': outletType,
      };
}
