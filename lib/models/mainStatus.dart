enum MainStatus { initial, loading, loaded, failure }

enum CubitStatus { success, failure }

enum CubitAction { none, join, invite, rejectInvite, cancelJoin }

class CubitOperation {
  final CubitStatus status;
  final CubitAction action;
  final Map<String, dynamic>? arguments;
  CubitOperation({required this.status, required this.action, this.arguments});
}
