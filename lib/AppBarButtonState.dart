class AppBarButtonState{
  String currentState = "All";

  String getCurrentState(){
    return currentState;
  }

  void setCurrentStateToAll() {
    currentState = "All";
  }

  void setCurrentStateToMusic() {
    currentState = "Music";
  }

  void setCurrentStateToPodcasts() {
    currentState = "Podcasts";
  }
}
