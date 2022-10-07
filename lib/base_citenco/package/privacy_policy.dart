 
class PrivacyPolicy {
  static PrivacyPolicy? _internal;

  PrivacyPolicy._();

  factory PrivacyPolicy() {
    if (_internal == null) _internal = PrivacyPolicy._();
    return _internal!;
  } 
}
