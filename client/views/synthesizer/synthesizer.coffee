Meteor.startup ->
  window.synthesizer = new Synthesizer()
  window.effectsPipeline = new EffectsPipeline()
  synthesizer.connect effectsPipeline.input
  effectsPipeline.connect masterGainNode

  window.keyboard = new VirtualKeyboard
    noteOn: (note) ->
      synthesizer.noteOn note
      visualization.noteOn note
    noteOff: (note) ->
      synthesizer.noteOff note
      visualization.noteOff note

Template.synthesizer.rendered = ->
  $('#osc1Gain .knob').knob
    change: (value) ->
      synthesizer.amp1.gain.value = value / 100
  $('#osc2Gain .knob').knob
    change: (value) ->
      synthesizer.amp2.gain.value = value / 100
  $('.knob').val(100).trigger('change')
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

  $('#filterEnvelope .attack').slider
    orientation: 'vertical'
    range: 'min'
    animate: true
    min: 0.0
    max: 2.0
    step: 0.01
    value: synthesizer.filterEnvelope.attack
    slide: (event, ui) ->
      synthesizer.filterEnvelope.attack = ui.value
  $('#filterEnvelope .decay').slider
    orientation: 'vertical'
    range: 'min'
    animate: true
    min: 0.0
    max: 2.0
    step: 0.01
    value: synthesizer.filterEnvelope.decay
    slide: (event, ui) ->
      synthesizer.filterEnvelope.decay = ui.value
  $('#filterEnvelope .sustain').slider
    orientation: 'vertical'
    range: 'min'
    animate: true
    min: 0.0
    max: 1.0
    step: 0.01
    value: synthesizer.filterEnvelope.sustain
    slide: (event, ui) ->
      synthesizer.filterEnvelope.sustain = ui.value
  $('#filterEnvelope .release').slider
    orientation: 'vertical'
    range: 'min'
    animate: true
    min: 0.0
    max: 10.0
    step: 0.1
    value: synthesizer.filterEnvelope.release
    slide: (event, ui) ->
      synthesizer.filterEnvelope.release = ui.value

  new EnvelopeCanvas @find('#filterEnvelopeCanvas'), synthesizer.filterEnvelope
  new OscillatorKnob @find('#osc1Type'), synthesizer.osc1
  new OscillatorKnob @find('#osc2Type'), synthesizer.osc2

  new FilterKnob @find('#filterType'), synthesizer.filter

  $('#filterResonance .knob').knob
    change: (value) ->
      synthesizer.filter.Q.value = (value / 100) * 20.0
  $('#filterResonance .knob').val(50).trigger 'change'
