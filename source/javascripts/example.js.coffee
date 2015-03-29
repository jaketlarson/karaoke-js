$ ->
  # The lyrics list must be organized like so:
  # lyrics = [
  #   [ # first line
  #     [2.5, "first",], #time, first word
  #     [2.8, "second"] #time, second word
  #   ]
  # ]
  #

  lyrics = [
    [
      [1.0, "Here"]
      [1.3, "is"]
      [1.45, "the"]
      [1.55, "first"]
      [1.7, "line"]
    ]
    [
      [1.92, "And"]
      [2.08, "this"]
      [2.25, "is"]
      [2.4, "the"]
      [2.7, "second!"]
    ]
    [
      [3.1, "This"]
      [3.47, "song"]
      [3.8, "is"]
      [3.95, "not"]
      [4.15, "real"]
    ]
    [
      [4.4, "At"]
      [4.5, "I"]
      [4.6, "hope"]
      [4.7, "it's"]
      [4.9, "not!"]
    ]
  ]

  settings = {
    'last-word-highlight-time': 5.5 # how long the last word will be higlighted (seconds)
    'scroll-animation-time': .1 # speed of the scrolling (seconds)
    'karaoke-player-elem': $('audio#karaoke-player')
    'karaoke-lyrics-elem': $('#karaoke-lyrics')
  }

  window.karaoke = new window.Karaoke(lyrics, settings)