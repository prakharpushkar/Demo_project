import 'package:flutter_bloc/flutter_bloc.dart';
import 'favourite_state.dart';
import 'favorite_event.dart';

// Blog_favourite is a BLoC which manages the state. It takes favourite_event as input and gives favourite_state as an output
class Blog_favourite extends Bloc<favourite_event, favorite_state> {
  Blog_favourite() : super(initial()) {
    on<Togglefavourite_event>((event, emit) { //This BLoC manages the logic for toggling favorite blogs and updating the state accordingly.
      // Check if the current state is FavoriteUpdated
      if (state is FavoriteUpdated) { // state checking
        // Cast the state to FavoriteUpdated
        final favorite_State = state as FavoriteUpdated;
        final updated_Favorite_Ids = Set<String>.from(favorite_State.fav_ids);

        if (updated_Favorite_Ids.contains(event.blogId)) {
          updated_Favorite_Ids.remove(event.blogId);
        } else {
          updated_Favorite_Ids.add(event.blogId);
        }

        emit(FavoriteUpdated(fav_ids: updated_Favorite_Ids));
      } else {
        // If the state is not FavoriteUpdated, initialize it with the new blogId
        emit(FavoriteUpdated(fav_ids: {event.blogId}));
      }
    });
  }
}
