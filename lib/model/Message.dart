class Message {
  late final String _senderName;
  late final String _recipientName;
  late final String _text;
  late final DateTime _CreatedAT;

  Message(this._senderName, this._recipientName, this._text, this._CreatedAT);

  String get senderName => _senderName;

  set senderName(String value) {
    _senderName = value;
  }

  String get recipientName => _recipientName;

  DateTime get CreatedAT => _CreatedAT;

  set CreatedAT(DateTime value) {
    _CreatedAT = value;
  }

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  set recipientName(String value) {
    _recipientName = value;
  }
}
