class BlockException implements Exception {
  String _message;

  BlockException([String message = 'Invalid Block;']) {
    this._message = message;
  }

  @override
  String toString() {
    return this._message;
  }
}
