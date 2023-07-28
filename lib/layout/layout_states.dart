abstract class LayoutStates {}

class  LayoutInitialState extends LayoutStates  {}
class  GetUserDataLoadingState extends LayoutStates  {}
class  GetUserDataSuccessState extends LayoutStates  {}
class  GetUserDataErrorState extends LayoutStates  {
  String error;
  GetUserDataErrorState({required this.error});
}

  class  ChangebottomNavIndex extends LayoutStates  {}
   


// banners
  class  GetBannersLoadingsstate extends LayoutStates  {} 
  class  GetBannersSuccessstate extends LayoutStates  {}
  class  GetBannersErrorstate extends LayoutStates  {}  


// Categoris

  class  GetCategorisSuccessstate extends LayoutStates  {}
  class  GetCategorisErrorstate extends LayoutStates  {}



  // Products

  class  GetProductsSuccessstate extends LayoutStates  {}
  class  GetProductsErrorstate extends LayoutStates  {}


    // Favourites

  class  GetFavouritesSuccessstate extends LayoutStates  {}
  class  GetFavouritesErrorstate extends LayoutStates  {}
    
  class  AddOrRemoveFromFavouritesSuccessState extends LayoutStates  {}
  class  AddOrRemoveFromFavouritesErrorState extends LayoutStates  {}