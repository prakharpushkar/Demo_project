import 'package:equatable/equatable.dart';

abstract class favourite_event extends Equatable {
  const favourite_event();

  @override
  //Returns an empty list, indicating that this base class does not have properties affecting equality.
  List<Object> get props {
    return [];
  }
}

class Togglefavourite_event extends favourite_event {
  final String blogId;

  const Togglefavourite_event(this.blogId);

  @override
  List<Object> get props {
    return [blogId];
  }
}
