
class Ticket{
  late int _id;
 late String _ticketBarcode;
 late String _ticketState;


  Ticket({int id=0,required String ticketBarcode,required String ticketState}) {
    this._id = id;
    this._ticketBarcode = ticketBarcode;
    this._ticketState =  ticketState;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get ticketBarcode => _ticketBarcode;
  set ticketBarcode(String ticketBarcode) => _ticketBarcode = ticketBarcode;

  String get  ticketState => _ticketState;

  set  ticketState(String  ticketState) => _ticketState =  ticketState;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    data['TicketCode'] = this._ticketBarcode;
    data['TicketState'] = this._ticketState;
    return data;
  }

  Map<String, dynamic> toJsonForAdd() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TicketCode'] = this._ticketBarcode;
    data['TicketState'] = this._ticketState;
    return data;
  }


 Ticket.fromJson(Map<String , dynamic>json){
   this._id = json["Id"];
   this._ticketBarcode = json["TicketCode"];
   this._ticketState = json["TicketState"];
 }

}


class TicketModel{
  late String ticketBarcode;
  late String ticketState;
  TicketModel({required String ticketBarcode,required String ticketState});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TicketCode'] = this.ticketBarcode;
    data['TicketState'] = this.ticketState;
    return data;
  }


  TicketModel.fromJson(Map<String , dynamic>json){
    this.ticketBarcode = json["TicketCode"];
    this.ticketState = json["TicketState"];
  }
}