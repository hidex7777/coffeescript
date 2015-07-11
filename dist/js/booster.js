(function() {
  'use strict';
  var draw;

  window.onload = function() {
    draw();
  };

  draw = function() {
    var canvas, ctx;
    canvas = document.getElementById('mycanvas');
    if (!canvas || !canvas.getContext) {
      return false;
    }
    ctx = canvas.getContext('2d');
    ctx.strokeStyle = "#ff0000";
    ctx.fillRect(10, 10, 50, 50);
    ctx.strokeRect(10, 10, 10, 10);
    ctx.clearRect(15, 15, 40, 40);
  };

}).call(this);
