class Timer {
  int interval, startTime;
  boolean paused;

  Timer(int _interval, int _start) {
    interval = _interval;
    startTime = _start;
    paused = false;
  }

  boolean intervalPassed() {
    //if animation is paused don't update frame
    if (paused == true) {
      return false;
    }
    //check if ellapsed time is over interval
    else {
      if ((millis() - startTime) >= interval) {
        startTime = millis();
        return true;
      } else { 
        return false;
      }
    }
  }

  void pauseTimer() {
    paused = !paused;
  }
}
