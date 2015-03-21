(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.Karaoke = (function() {
    function Karaoke(lyrics, settings) {
      var default_settings;
      if (settings == null) {
        settings = void 0;
      }
      this.moveToLine = __bind(this.moveToLine, this);
      this.playWord = __bind(this.playWord, this);
      this.cancelWordTimers = __bind(this.cancelWordTimers, this);
      this.initWordTimers = __bind(this.initWordTimers, this);
      this.initLyrics = __bind(this.initLyrics, this);
      this.initPlayerBinds = __bind(this.initPlayerBinds, this);
      this.initVars = __bind(this.initVars, this);
      this.settings = settings;
      default_settings = {
        'last-word-highlight-time': 1.0,
        'scroll-animation-time': .1,
        'karaoke-player-elem': $('audio#karaoke-player'),
        'karaoke-lyrics-elem': $('#karaoke-lyrics')
      };
      if (typeof settings !== 'undefined') {
        $.each(default_settings, (function(_this) {
          return function(setting, value) {
            return _this.settings[setting] = typeof _this.settings[setting] !== 'undefined' ? _this.settings[setting] : default_settings[setting];
          };
        })(this));
      } else {
        this.settings = default_settings;
      }
      this.lyrics = lyrics;
      this.initVars();
      this.initPlayerBinds();
      this.initLyrics();
    }

    Karaoke.prototype.initVars = function() {
      this.player_elem = this.settings['karaoke-player-elem'][0];
      this.lyrics_elem = this.settings['karaoke-lyrics-elem'];
      return this.word_timers = [];
    };

    Karaoke.prototype.initPlayerBinds = function() {
      this.player_elem.addEventListener('play', (function(_this) {
        return function() {
          if (_this.word_timers.length > 0) {
            _this.cancelWordTimers();
          }
          return _this.initWordTimers();
        };
      })(this));
      this.player_elem.addEventListener('pause', (function(_this) {
        return function() {
          return _this.cancelWordTimers();
        };
      })(this));
      return this.player_elem.addEventListener('seeked', (function(_this) {
        return function() {
          _this.cancelWordTimers();
          return _this.initWordTimers();
        };
      })(this));
    };

    Karaoke.prototype.initLyrics = function() {
      $.each(this.lyrics, (function(_this) {
        return function(line_index, line) {
          var build_line;
          build_line = "<p class='line'>";
          $.each(line, function(word_index, word) {
            if (word_index > 0) {
              build_line += " ";
            }
            return build_line += "<span class='word'>" + word[1] + "</span>";
          });
          build_line += "</p>";
          return _this.lyrics_elem.append(build_line);
        };
      })(this));
      return this.moveToLine(0);
    };

    Karaoke.prototype.initWordTimers = function() {
      var current_time, moved_to_line;
      current_time = this.player_elem.currentTime;
      moved_to_line = false;
      return $.each(this.lyrics, (function(_this) {
        return function(line_index, line) {
          return $.each(line, function(word_index, word_piece) {
            var get_next_time, time_offset, time_until_next, timing, word;
            timing = word_piece[0];
            word = word_piece[1];
            if (timing > _this.player_elem.currentTime) {
              if (!moved_to_line) {
                _this.moveToLine(line_index);
                moved_to_line = true;
              }
              time_offset = (timing - _this.player_elem.currentTime) * 1000;
              if (_this.lyrics[line_index].length > word_index + 1) {
                get_next_time = _this.lyrics[line_index][word_index + 1][0];
              } else if (_this.lyrics.length > line_index + 1) {
                get_next_time = _this.lyrics[line_index + 1][0][0];
              } else {
                get_next_time = timing + _this.settings['last-word-highlight-time'];
              }
              time_until_next = get_next_time - timing;
              return _this.word_timers.push(setTimeout(function() {
                return _this.playWord(line_index, word_index, time_until_next);
              }, time_offset));
            }
          });
        };
      })(this));
    };

    Karaoke.prototype.cancelWordTimers = function() {
      $.each(this.word_timers, (function(_this) {
        return function(timer) {
          return clearTimeout(_this.word_timers[timer]);
        };
      })(this));
      return this.word_timers = [];
    };

    Karaoke.prototype.playWord = function(line_index, word_index, time_offset) {
      var line_elem, word_elem;
      line_elem = this.lyrics_elem.find('.line')[line_index];
      word_elem = $(line_elem).find('.word')[word_index];
      $(word_elem).addClass('active');
      setTimeout(function() {
        return $(word_elem).removeClass('active');
      }, time_offset * 1000);
      return this.moveToLine(line_index);
    };

    Karaoke.prototype.moveToLine = function(line_index) {
      var height;
      height = $(this.lyrics_elem.find('.line')[line_index]).outerHeight();
      return this.lyrics_elem.animate({
        scrollTop: height * line_index
      }, this.settings['scroll-animation-time'] * 1000);
    };

    return Karaoke;

  })();

}).call(this);
