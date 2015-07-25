(function() {
  'use strict';
  var Clock, formatDigital, soundTick;

  formatDigital = function(digitalcount) {
    var digitaltext, h, m, s;
    s = digitalcount % 60;
    m = Math.floor(digitalcount / 60);
    h = Math.floor(m / 60);
    m = m - (h * 60);
    if (s < 10) {
      s = "0" + s;
    }
    if (h < 10) {
      h = "0" + h;
    }
    if (m < 10) {
      m = "0" + m;
    }
    digitaltext = "" + h + ":" + m + ":" + s;
    $('#digital').text(digitaltext);
  };

  soundTick = function(digitalcount) {
    var sine, tick;
    tick = $('#tick-file').get(0);
    tick.currentTime = 0;
    tick.play();
    if (digitalcount % 8 === 0) {
      sine = $('#sine-file').get(0);
      sine.currentTime = 0;
      sine.play();
    }
  };

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
      this.ctx.fillStyle = "white";
      this.ctx.lineCap = "butt";
      this.digitalcount = 0;
      formatDigital(this.digitalcount);
    }

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
      this.cursec = this.cursec < 59 ? this.cursec + 1 : 0;
      formatDigital(this.digitalcount);
      soundTick(this.digitalcount);
      this.digitalcount++;
    };

    Clock.prototype.tickStart = function() {
      var _clock;
      if (!this.timerId) {
        _clock = this;
        this.digitalcount = 0;
        _clock.tickTack();
        this.timerId = setInterval(function() {
          _clock.clearAll();
          _clock.tickTack();
        }, 1000);
      }
    };

    Clock.prototype.tickStop = function() {
      clearInterval(this.timerId);
      this.timerId = null;
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
    clock.s();
    $('#start').click(function() {
      if ($('#start').text() === "START") {
        clock.tickStart();
        $('#start').text("STOP");
      } else {
        clock.tickStop();
        clock.clearAll();
        clock.s();
        $('#start').text("START");
      }
    });
  };

}).call(this);
