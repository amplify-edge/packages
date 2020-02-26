

import 'package:equatable/equatable.dart';

abstract class IFailure extends Equatable{

   IFailure() : super();

 

}

class Failure extends IFailure{
  final String msg;
  Failure(this.msg);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}