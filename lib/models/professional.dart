class Professional {
  String name;
  String email;
  String phone;
  String date;
  int workId;
  int nCouncil;
  String council;

  Professional(
      {this.name, this.email, this.phone, this.date, this.workId, this.nCouncil, this.council});

  Professional.fromJson(Map<String, dynamic> json) {
    name = json['nome'];
    email = json['email'];
    phone = json['telefone'];
    date = json['data'];
    workId = json['profissaoId'];
    nCouncil = json['nConselho'];
    council = json['conselho'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.name;
    data['email'] = this.email;
    data['telefone'] = this.phone;
    data['data'] = this.date;
    data['profissaoId'] = this.workId;
    data['nConselho'] = this.nCouncil;
    data['conselho'] = this.council;
    return data;
  }

  @override
  String toString() {
    return 'Professional{name: $name, email: $email, phone: $phone, date: $date, workId: $workId, nCouncil: $nCouncil, council: $council}';
  }


}