(function() {
  'use strict';
  var Clock;

  Clock = (function() {
    function Clock(id) {
      this.id = id;
      this.timerId = null;
      this.canvas = document.getElementById(this.id);
      if (!this.canvas || !this.canvas.getContext) {
        return false;
      }
      this.ctx = this.canvas.getContext('2d');
      this.width = this.canvas.width;
      this.height = this.canvas.height;
      this.ctx.translate(this.width / 2, this.height / 2);
      this.ctx.scale(this.width / 300, this.height / 300);
      this.ctx.rotate(-Math.PI / 2);
      this.ctx.strokeStyle = "black";
      this.ctx.fillStyle = "white";
      this.ctx.lineCap = "butt";
    }

    Clock.prototype.drawClock = function() {
      var i, _i, _j;
      this.ctx.save();
      this.ctx.lineWidth = 2;
      for (i = _i = 0; _i < 60; i = ++_i) {
        this.ctx.beginPath();
        this.ctx.rotate(Math.PI / 30);
        this.ctx.moveTo(130, 0);
        this.ctx.lineTo(150, 0);
        this.ctx.stroke();
      }
      this.ctx.restore();
      this.ctx.save();
      this.ctx.lineWidth = 8;
      for (i = _j = 0; _j < 12; i = ++_j) {
        this.ctx.beginPath();
        this.ctx.rotate(Math.PI / 6);
        this.ctx.moveTo(120, 0);
        this.ctx.lineTo(150, 0);
        this.ctx.stroke();
      }
      this.ctx.restore();
    };

    Clock.prototype.s = function(cursec) {
      this.cursec = cursec != null ? cursec : 0;
      this.ctx.save();
      this.ctx.rotate(Math.PI / 30 * this.cursec);
      this.ctx.strokeStyle = "#cc0000";
      this.ctx.lineWidth = 2;
      this.ctx.beginPath();
      this.ctx.moveTo(-10, 0);
      this.ctx.lineTo(130, 0);
      this.ctx.stroke();
      this.ctx.restore();
    };

    Clock.prototype.tickTack = function() {
      if (!this.canvas) {
        return;
      }
      this.s(this.cursec);
      this.cursec = this.cursec < 60 ? this.cursec + 1 : 0;
    };

    Clock.prototype.tickStart = function() {
      var _clock;
      if (!this.timerId) {
        _clock = this;
        _clock.tickTack();
        this.timerId = setInterval(function() {
          _clock.clearAll();
          _clock.drawClock();
          _clock.tickTack();
        }, 1000);
      }
    };

    Clock.prototype.tickStop = function() {
      clearInterval(this.timerId);
      this.s(0);
    };

    Clock.prototype.clearAll = function() {
      return this.ctx.clearRect(-150, -150, 300, 300);
    };

    return Clock;

  })();

  window.onload = function() {
    var clock;
    clock = new Clock("mycanvas");
    clock.drawClock();
    clock.s();
    $('#start').click(function() {
      if ($('#start').text() === "START") {
        clock.tickStart();
        $('#start').text("STOP");
      } else {
        clock.tickStop();
        clock.clearAll();
        clock.drawClock();
        clock.s();
        $('#start').text("START");
      }
    });
  };

}).call(this);
