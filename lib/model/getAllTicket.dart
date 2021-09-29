

class GetAllTicket {
 late String qrCode;
 late String tNo;
 late bool isUsed;

  GetAllTicket({required this.qrCode, required this.tNo, required this.isUsed});

  GetAllTicket.fromJson(Map<String, dynamic> json) {
    qrCode = json['qrCode'];
    tNo = json['t_No'];
    isUsed = json['isUsed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qrCode'] = this.qrCode;
    data['t_No'] = this.tNo;
    data['isUsed'] = this.isUsed;
    return data;
  }
}
