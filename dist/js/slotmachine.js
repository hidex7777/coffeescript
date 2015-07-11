(function() {
  'use strict';
  var checkSlot, nums, runSlot, startSlot, stopCount, stopSlot, timers;

  timers = [];

  nums = [];

  stopCount = 0;

  startSlot = function() {
    runSlot(0);
    runSlot(1);
    runSlot(2);
  };

  stopSlot = function(n) {
    if (nums[n] !== void 0) {
      return;
    }
    clearTimeout(timers[n]);
    nums[n] = $('#num' + n).html();
    stopCount++;
    if (stopCount === 3) {
      return checkSlot();
    }
  };

  checkSlot = function() {
    nums.sort();
    if (nums[0] === nums[1] && nums[0] === nums[2]) {
      return $('#result').html("全部揃った！");
    } else if (nums[0] === nums[1] || nums[1] === nums[2]) {
      return $('#result').html("2つ揃った！");
    } else {
      return $('#result').html("残念");
    }
  };

  runSlot = function(n) {
    $('#num' + n).html(Math.floor(Math.random() * 10));
    timers[n] = setTimeout(function() {
      runSlot(n);
    }, 50);
  };

  $('#stop0').click(function() {
    stopSlot(0);
  });

  $('#stop1').click(function() {
    stopSlot(1);
  });

  $('#stop2').click(function() {
    stopSlot(2);
  });

  startSlot();

}).call(this);
