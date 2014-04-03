(function() {
  'use strict';
  var reset, run, running, startTime, stop, stopTime, timer, timerId;

  stopTime = 0.00;

  startTime = 0.00;

  running = false;

  timerId = 0;

  run = function() {
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
    return timer();
  };

  timer = function() {
    $('#sec').html((((new Date()).getTime() - startTime) / 1000).toFixed(2));
    timerId = setTimeout(function() {
      timer();
    }, 100);
  };

  stop = function() {
    if (!running) {
      return false;
    }
    running = false;
    clearTimeout(timerId);
    stopTime = (new Date()).getTime();
  };

  reset = function() {
    if (running) {
      return;
    }
    startTime = void 0;
    return $('#sec').html('0.00');
  };

  $('#run').click(function() {
    run();
  });

  $('#stop').click(function() {
    stop();
  });

  $('#reset').click(function() {
    reset();
  });

}).call(this);
