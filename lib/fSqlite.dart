import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'model.dart';


class SQLHelper {

  final String ticketTable = "Ticket";
  final String ticketID = "Id";
  final String ticketCode = "TicketCode";
  final String ticketState = "TicketState";

   static Database?_db;

  Future<Database> get db async{
    if(_db != null){
      return _db!;
    }
    _db = await createDb();
    return _db!;
  }

  createDb() async{
    var path = join(await getDatabasesPath(),"Ticket.db");
    var db = await openDatabase(path,version: 1,onCreate: _onCreate );
    return db;

  }

  void _onCreate(Database db , int newVersion )async {
    String sql = 'CREATE TABLE $ticketTable ($ticketID INTEGER PRIMARY KEY AUTOINCREMENT, $ticketCode TEXT, $ticketState TEXT)';
    await db.execute(sql);
  }

  Future<int> addTicket(Ticket ticket)async => await  Future.delayed(Duration(seconds: 3)).then((value)async{
      var dbClint = await db;
      return await dbClint.insert(ticketTable, ticket.toJsonForAdd(),);
    });

  Future<int> updateTicket(Ticket ticket) async{
    var dbClint = await db;
    return await dbClint.update(ticketTable, ticket.toJson(),where: "$ticketID =?",whereArgs: [ticket.id]);
  }

  Future<List<Ticket>> getAllTicket()async{
    var dbClint = await db;
    var result = await dbClint.query(ticketTable,columns: [ticketID,ticketCode,ticketState]);

    return result.map((element) => Ticket.fromJson(element)).toList();
  }

  Future<Ticket?> getTicket(String ticketsCode)async{
    var dbClint = await db;
    var result = await dbClint.query(ticketTable,where: "$ticketCode =?",whereArgs: [ticketsCode]);
    if(result.length > 0){
      return new Ticket.fromJson(result.first);
    }
    return null;
  }

  Future<int> deleteTicket(int id)async{
    var dbClint = await db;
    return await dbClint.delete(ticketTable,where: "$ticketID =?",whereArgs: [id]);
  }

  Future closeDB ()async{
    var dbClint = await db;
    return await dbClint.close();
  }
}

