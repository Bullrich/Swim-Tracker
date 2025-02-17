import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:swimm_tracker/models/swim_record.dart';

const String _databaseName = "records";

class Persistence {
  Future<Database> getDatabase() async {
    return openDatabase(
      // Set the path to the database.
      join(await getDatabasesPath(), 'swim_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE $_databaseName(id INTEGER PRIMARY KEY AUTOINCREMENT, time INTEGER, length INTEGER, laps INTEGER)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<void> insertRecord(SwimRecord record) async {
    // Get a reference to the database.
    final Database db = await getDatabase();

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      _databaseName,
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SwimRecord>> records() async {
    // Get a reference to the database.
    final Database db = await getDatabase();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(_databaseName);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return SwimRecord(
        time: maps[i]['time'],
        laps: maps[i]['laps'],
        length: maps[i]['length'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> deleteTrack(SwimRecord record) async {
    // Get a reference to the database.
    final db = await getDatabase();

    // Remove the record from the Database.
    await db.delete(
      _databaseName,
      // Use a `where` clause to delete a specific record.
      where: "id = ?",
      // Pass the record's id as a whereArg to prevent SQL injection.
      whereArgs: [record.id],
    );
  }

  Future<void> updateTrack(SwimRecord record) async {
    // Get a reference to the database.
    final db = await getDatabase();

    final recordMap = record.toMap();
    recordMap["id"] = record.id;

    await db.update(
      _databaseName,
      recordMap,
      where: "id = ?",
      whereArgs: [record.id],
    );
  }
}
