import 'package:models/models.dart';

abstract class MembershipEvent {}

class MembershipRequested extends MembershipEvent {}

class MembershipSubscribeRequested extends MembershipEvent {
  final String plan;
  MembershipSubscribeRequested(this.plan);
}
