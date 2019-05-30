class Pemilu {
    DateTime ts;
    Chart chart;
    Map<String, Chart> table;
    Progress progress;

    Pemilu({
        this.ts,
        this.chart,
        this.table,
        this.progress,
    });

    factory Pemilu.fromJson(Map<String, dynamic> json) => new Pemilu(
        ts: json["ts"] == null ? null : DateTime.parse(json["ts"]),
        chart: json["chart"] == null ? null : Chart.fromJson(json["chart"]),
        table: json["table"] == null ? null : new Map.from(json["table"]).map((k, v) => new MapEntry<String, Chart>(k, Chart.fromJson(v))),
        progress: json["progress"] == null ? null : Progress.fromJson(json["progress"]),
    );

    Map<String, dynamic> toJson() => {
        "ts": ts == null ? null : ts.toIso8601String(),
        "chart": chart == null ? null : chart.toJson(),
        "table": table == null ? null : new Map.from(table).map((k, v) => new MapEntry<String, dynamic>(k, v.toJson())),
        "progress": progress == null ? null : progress.toJson(),
    };
}

class Chart {
    int the21;
    int the22;
    double persen;

    Chart({
        this.the21,
        this.the22,
        this.persen,
    });

    factory Chart.fromJson(Map<String, dynamic> json) => new Chart(
        the21: json["21"] == null ? null : json["21"],
        the22: json["22"] == null ? null : json["22"],
        persen: json["persen"] == null ? null : json["persen"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "21": the21 == null ? null : the21,
        "22": the22 == null ? null : the22,
        "persen": persen == null ? null : persen,
    };
}

class Progress {
    int total;
    int proses;

    Progress({
        this.total,
        this.proses,
    });

    factory Progress.fromJson(Map<String, dynamic> json) => new Progress(
        total: json["total"] == null ? null : json["total"],
        proses: json["proses"] == null ? null : json["proses"],
    );

    Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "proses": proses == null ? null : proses,
    };
}
