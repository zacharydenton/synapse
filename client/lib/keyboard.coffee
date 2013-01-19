class VirtualKeyboard
  constructor: (params) ->
    params = params or {}
    @lowestNote = params.lowestNote or 60
    @noteOn = params.noteOn or (note) -> console.log "noteOn: #{note}"
    @noteOff = params.noteOff or (note) -> console.log "noteOff: #{note}"
    @letters = (params.letters or "awsedrfgyhujkolp;['").split ''
    @keysPressed = {}

    for letter, i in @letters
      do (letter, i) =>
        Mousetrap.bind letter, (=>
          note = @lowestNote + i
          unless note of @keysPressed
            @keysPressed[note] = true
            @noteOn note
        ), 'keydown'
        Mousetrap.bind letter, (=>
          note = @lowestNote + i
          if note of @keysPressed
            delete @keysPressed[note]
            @noteOff note
        ), 'keyup'

    Mousetrap.bind 'z', =>
      # shift one octave down
      @lowestNote -= 12
  
    Mousetrap.bind 'x', =>
      # shift one octave up
      @lowestNote += 12

