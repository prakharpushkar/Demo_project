import 'package:equatable/equatable.dart';

// Equatable is used to compare the values of different objects
abstract class favorite_state extends Equatable { 
  const favorite_state();

  @override
  List<Object> get props { //Overrides the props method to include favoriteBlogIds, allowing for checking based on the list of favorite IDs.
    return [];
  }
}

class initial extends favorite_state {} // inital state of favorite_state

class FavoriteUpdated extends favorite_state { // updated state which can be compared
  final Set<String> fav_ids;

  const FavoriteUpdated({
    required this.fav_ids
    });

  @override
  List<Object> get props {
    return [fav_ids];
  }
}
