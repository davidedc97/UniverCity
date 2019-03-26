class CronologiaEntry {
  String uuid;
  String titolo;
  String proprietario;
  DateTime stamp = DateTime.now();
  String id;

  CronologiaEntry(this.uuid, this.titolo, this.proprietario);

  /// '${e.uuid};${e.titolo};${e.proprietario};${e.stamp.microsecond};${e.stamp.millisecond};${e.stamp.second};${e.stamp.minute};${e.stamp.hour};${e.stamp.day};${e.stamp.month};${e.stamp.year}'
  CronologiaEntry.fromStored(String storedEntry) {
    List<String> cS = storedEntry.split(';');
    assert(cS.length==11);
    this.uuid = cS[0];
    this.titolo = cS[1];
    this.proprietario = cS[2];
    this.stamp = DateTime(
        int.parse(cS[10]),//anno
        int.parse(cS[9]), //mese
        int.parse(cS[8]), //giorno
        int.parse(cS[7]), //ora
        int.parse(cS[6]), //minuti
        int.parse(cS[5]), //secondi
        int.parse(cS[4]), //millisencondi
        int.parse(cS[3]));//microsecondi
  }
}
