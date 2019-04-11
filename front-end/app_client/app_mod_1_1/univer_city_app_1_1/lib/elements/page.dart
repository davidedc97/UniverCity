class Page{

  String _idDoc;  // id del documento al quale appartiene
  int numPage;    // numero della pagina all'interno del suo documento
  int y1;         // prima coordinata (alta) del box selezionato
  int y2;         // seconda coordinata (bassa) del box selezionato


  Page(this._idDoc, this.numPage, this.y1, this.y2);

  String get idDoc => _idDoc;



}