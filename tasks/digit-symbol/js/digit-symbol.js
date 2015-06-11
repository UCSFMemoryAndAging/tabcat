// Generated by CoffeeScript 1.9.3

/*
Copyright (c) 2013, Regents of the University of California
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

  1. Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
  2. Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

(function() {
  var ASPECT_RATIO, showStartScreen;

  ASPECT_RATIO = 4 / 3;

  showStartScreen = function() {
    var $startScreen;
    $startScreen = $('#startScreen');
    $startScreen.find('button').on('mousedown touchstart', function() {
      $startScreen.hide();
      $('body').removeClass('blueBackground');
      return showComets();
    });
    return $startScreen.show();
  };

  this.initTask = function() {
    TabCAT.Task.start({
      trackViewport: true
    });
    TabCAT.UI.turnOffBounce();
    TabCAT.UI.enableFastClick();
    return $(function() {
      var $rectangle, $task;
      $task = $('#task');
      $rectangle = $('#rectangle');
      TabCAT.UI.requireLandscapeMode($task);
      $task.on('mousedown touchstart', catchStrayTouchStart);
      TabCAT.UI.fixAspectRatio($rectangle, ASPECT_RATIO);
      TabCAT.UI.linkEmToPercentOfHeight($rectangle);
      return showStartScreen();
    });
  };

}).call(this);
