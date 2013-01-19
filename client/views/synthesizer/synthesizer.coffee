Meteor.startup ->
  window.synthesizer = new Synthesizer()
  synthesizer.connect masterGainNode

  window.keyboard = new VirtualKeyboard
    noteOn: (note) ->
      synthesizer.noteOn note
      visualization.noteOn note
    noteOff: (note) ->
      synthesizer.noteOff note
      visualization.noteOff note
