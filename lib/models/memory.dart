class Memory {
  static const operations = const ['%', '/', 'x', '-', '+', '='];

  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String _operation;
  String _value = '0';
  bool _wipeValue = false;
  String _lastCommand;

  void applyCommand(String command) {
    if (_isReplacingOperation(command)) {
      _operation = command;
      return;
    }
    if (command == 'AC') {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }

    _lastCommand = command;
  }

  getMemoryBufferText() {
    if (_operation != null) {
      String firstItem = _formatFloatValue(_buffer[0]);
      String secondItem = _formatFloatValue(_buffer[1]);

      if (secondItem != '0') {
        return '$firstItem' + '$_operation' + '$secondItem';
      } else {
        return '$firstItem' + '$_operation';
      }
    } else {
      return '';
    }
  }

  _formatFloatValue(double digit) {
    String floatValue = digit.toString();
    floatValue =
        floatValue.endsWith('.0') ? floatValue.split('.')[0] : floatValue;

    return floatValue;
  }

  _isReplacingOperation(String command) {
    return operations.contains(_lastCommand) &&
        operations.contains(command) &&
        _lastCommand != '=' &&
        command != '=';
  }

  _setOperation(String newOperation) {
    bool isEqualSign = newOperation == '=';

    if (_bufferIndex == 0) {
      if (!isEqualSign) {
        _operation = newOperation;
        _bufferIndex = 1;
        _wipeValue = true;
      }
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _formatFloatValue(_buffer[0]);

      _operation = isEqualSign ? null : newOperation;
      _bufferIndex = isEqualSign ? 0 : 1;
      _wipeValue = !isEqualSign;
    }
  }

  _addDigit(String digit) {
    final isDot = digit == '.';
    final wipeValue = (_value == '0' && !isDot) || _wipeValue;

    if (isDot && _value.contains('.') && !wipeValue) {
      return;
    }

    final emptyValue = isDot ? '0' : '';
    final currentValue = wipeValue ? emptyValue : _value;
    _value = currentValue + digit;
    _wipeValue = false;

    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
  }

  _allClear() {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _bufferIndex = 0;
    _operation = null;
    _wipeValue = false;
  }

  _calculate() {
    switch (_operation) {
      case '%':
        return _buffer[0] % _buffer[1];
      case '/':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      default:
        return _buffer[0];
    }
  }

  String get value {
    return _value;
  }
}
