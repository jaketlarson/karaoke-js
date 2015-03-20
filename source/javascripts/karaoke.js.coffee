$ ->
  # The lyrics list has to be organized like so:
  # lyrics = [
  #   [ # line
  #     [2.5, "first",], #time, first word
  #     [2.8, "second"] #time, second word
  #   ]
  # ]
  #


  settings = {
    'last-word-highlight-time': 5.5
    'scroll-animation-time': .1
    'karaoke-player-elem': $('audio#karaoke-player')
    'karaoke-lyrics-elem': $('#karaoke-lyrics')
  }

  karaoke = new Karaoke(lyrics, settings)

class window.Karaoke
  constructor: (lyrics, settings = undefined) ->
    @settings = settings
    default_settings = {
      'last-word-highlight-time': 1.0
      'scroll-animation-time': .1
      'karaoke-player-elem': $('audio#karaoke-player')
      'karaoke-lyrics-elem': $('#karaoke-lyrics')
    }

    unless typeof settings == 'undefined'
      $.each default_settings, (setting, value) =>
        @settings[setting] = if (typeof @settings[setting] != 'undefined') then @settings[setting] else default_settings[setting]
    else
      @settings = default_settings

    @lyrics = lyrics
    @initVars()
    @initPlayerBinds()
    @initLyrics()

  initVars: =>
    @player_elem = @settings['karaoke-player-elem'][0]
    @lyrics_elem = @settings['karaoke-lyrics-elem']
    @word_timers = []

  initPlayerBinds: =>
    @player_elem.addEventListener 'play', () =>
      if @word_timers.length > 0
        @cancelWordTimers()

      @initWordTimers()

    @player_elem.addEventListener 'pause', () =>
      @cancelWordTimers()

    @player_elem.addEventListener 'seeked', () =>
      @cancelWordTimers()
      @initWordTimers()

  initLyrics: =>
    $.each @lyrics, (line_index, line) =>
      build_line = "<p class='line'>"

      $.each line, (word_index, word) =>
        if word_index > 0
          build_line += " "
        build_line += "<span class='word'>#{word[1]}</span>"

      build_line += "</p>"
      @lyrics_elem.append build_line

    @moveToLine(0)

  initWordTimers: =>
    current_time = @player_elem.currentTime
    moved_to_line = false

    $.each @lyrics, (line_index, line) =>
      $.each line, (word_index, word_piece) =>
        timing = word_piece[0]
        word = word_piece[1]

        if timing > @player_elem.currentTime
          if !moved_to_line
            @moveToLine(line_index)
            moved_to_line = true

          time_offset = (timing - @player_elem.currentTime) * 1000

          if @lyrics[line_index].length > word_index + 1 # next word in current line
            get_next_time = @lyrics[line_index][word_index+1][0]

          else if @lyrics.length > line_index + 1 # next word in new line
            get_next_time = @lyrics[line_index+1][0][0]

          else # last word in lyrics
            get_next_time = timing + @settings['last-word-highlight-time']

          time_until_next = get_next_time - timing

          @word_timers.push(setTimeout(() =>
            @playWord line_index, word_index, time_until_next
          , time_offset))

  cancelWordTimers: =>
    $.each @word_timers, (timer) =>
      clearTimeout(@word_timers[timer])

    @word_timers = []

  playWord: (line_index, word_index, time_offset) =>
    line_elem = @lyrics_elem.find('.line')[line_index]
    word_elem = $(line_elem).find('.word')[word_index]
    $(word_elem).addClass('active')

    setTimeout () ->
      $(word_elem).removeClass('active')
    , time_offset*1000

    @moveToLine(line_index)

  moveToLine: (line_index) =>
    height = $(@lyrics_elem.find('.line')[line_index]).outerHeight() # all lines should be equal height for now
    @lyrics_elem.animate({scrollTop: (height * (line_index))}, @settings['scroll-animation-time']*1000)