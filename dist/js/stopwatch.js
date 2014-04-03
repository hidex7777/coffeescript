(function() {
  'use strict';
  var Reset, Run, Stop, Timer, running, startTime, stopTime, timerId;

  running = false;

  startTime = 0.00;

  stopTime = 0.00;

  timerId = void 0;

  Run = (function() {
    function Run() {}

    Run.prototype.run = function() {
      if (running) {
        return;
      }
      running = true;
      if (stopTime) {
        startTime = startTime + (new Date()).getTime() - stopTime;
      }
      if (!startTime) {
        startTime = (new Date()).getTime();
      }
      return Timer.timer();
    };

    return Run;

  })();

  Timer = (function() {
    function Timer() {}

    Timer.prototype.timer = function() {
      $('#sec').html((((new Date()).getTime() - startTime) / 1000).toFixed(2));
      timerId = setTimeout(function() {
        Timer.timer();
      }, 100);
    };

    return Timer;

  })();

  Stop = (function() {
    function Stop() {}

    Stop.prototype.stop = function() {
      if (!running) {
        return false;
      }
      running = false;
      clearTimeout(timerId);
      stopTime = (new Date()).getTime();
    };

    return Stop;

  })();

  Reset = (function() {
    function Reset() {}

    Reset.prototype.reset = function() {
      if (running) {
        return;
      }
      startTime = void 0;
      return $('#sec').html('0.00');
    };

    return Reset;

  })();

  $('#run').click(function() {
    Run.run();
  });

  $('#stop').click(function() {
    Stop.stop();
  });

  $('#reset').click(function() {
    Reset.reset();
  });

}).call(this);
