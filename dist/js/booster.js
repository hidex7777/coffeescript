(function() {
  'use strict';
  var drawCircle, drawHand;

  window.onload = function() {
    drawCircle();
    drawHand();
  };

  drawCircle = function() {
    var canvas, ctx;
    canvas = document.getElementById('mycanvas');
    if (!canvas || !canvas.getContext) {
      return false;
    }
    ctx = canvas.getContext('2d');
    ctx.beginPath();
    ctx.arc(150, 150, 145, 0 / 180 * Math.PI, 360 / 180 * Math.PI);
    ctx.fillStyle = "#FFFFFF";
    ctx.fill();
  };

  drawHand = function() {
    var canvas, ctx;
    canvas = document.getElementById('mycanvas');
    if (!canvas || !canvas.getContext) {
      return false;
    }
    ctx = canvas.getContext('2d');
    ctx.fillStyle = "#000000";
    ctx.fillRect(150, 0, 2, 150);
  };

}).call(this);
