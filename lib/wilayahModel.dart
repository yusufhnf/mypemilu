class WilayahModel {
    String nama;
    List<int> dapil;

    WilayahModel({
        this.nama,
        this.dapil,
    });

    factory WilayahModel.fromJson(Map<String, dynamic> json) => new WilayahModel(
        nama: json["nama"] == null ? null : json["nama"],
        dapil: json["dapil"] == null ? null : new List<int>.from(json["dapil"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "nama": nama == null ? null : nama,
        "dapil": dapil == null ? null : new List<dynamic>.from(dapil.map((x) => x)),
    };
}