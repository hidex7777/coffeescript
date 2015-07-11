(function() {
  'use strict';
  var getThisyear;

  getThisyear = function() {
    var dt;
    dt = new Date();
    return dt.getFullYear().toString();
  };

  $('#thisyear').text(getThisyear());

}).call(this);
