Template.synthesizer.rendered = ->
  window.synthesizer = new Synthesizer()
  synthesizer.connect masterGainNode

  window.keyboard = new VirtualKeyboard
    noteOn: (note) ->
      synthesizer.noteOn note
    noteOff: (note) ->
      synthesizer.noteOff note
