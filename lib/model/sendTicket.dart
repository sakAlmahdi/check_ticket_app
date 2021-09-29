class SendTicket {
  late List<String> qrCode;
  late bool isUsed;

  SendTicket({required this.qrCode, required this.isUsed});

  SendTicket.fromJson(Map<String, dynamic> json) {
    qrCode = json['qrCode'].cast<String>();
    isUsed = json['isUsed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qrCode'] = this.qrCode;
    data['isUsed'] = this.isUsed;
    return data;
  }
}
