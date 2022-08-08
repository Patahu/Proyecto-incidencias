class MessagingState {
  final bool isNewMessaging;
  final bool needRefresh;
  final String token;
  MessagingState({
    required this.isNewMessaging,
    required this.token,
    required this.needRefresh,
  });
  factory MessagingState.empty() {
    return MessagingState(
      isNewMessaging: false,
      token: "",
      needRefresh: false,
    );
  }

  factory MessagingState.isNewMessaging() {
    return MessagingState(
      isNewMessaging: true,
      token: "",
      needRefresh: true,
    );
  }

  MessagingState copyWith({
    bool? isNewMessaging,
    bool? needRefresh,
    String? token,
  }) {
    return MessagingState(
      isNewMessaging: isNewMessaging ?? this.isNewMessaging,
      token: token ?? this.token,
      needRefresh: isNewMessaging ?? this.needRefresh,
    );
  }

  MessagingState update(
      {bool? isNewMessaging, bool? needRefresh, String? token}) {
    return copyWith(
      isNewMessaging: isNewMessaging,
      token: token,
      needRefresh: needRefresh,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return ''' LoginState {
      isNewMessaging: $isNewMessaging,
      needRefresh: $needRefresh,
      isToken: $token,
    }
    ''';
  }
}
