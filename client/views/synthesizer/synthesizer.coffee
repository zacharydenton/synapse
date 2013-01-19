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

Template.synthesizer.rendered = ->
  $('.knob').knob()
  $('#oscRatio').slider
    min: 0.0
    max: 2.0
    step: 0.01
    value: synthesizer.oscRatio
    slide: (event, ui) ->
      synthesizer.setParams
        oscRatio: ui.value
  $('#filterFrequency').slider
    min: 10.0
    max: 20000.0
    value: synthesizer.filter.frequency.value
    slide: (event, ui) ->
      synthesizer.filter.frequency.cancelScheduledValues 0
      synthesizer.setParams
        filterFrequency: ui.value

  $('.envelope .slider').each ->
    $(this).slider
      orientation: 'vertical'
      range: 'min'
      animate: true
