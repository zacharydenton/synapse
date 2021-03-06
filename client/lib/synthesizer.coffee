class Synthesizer
  constructor: (params) ->
    @output = audioContext.createGainNode()

    @osc1 = audioContext.createOscillator()
    @amp1 = audioContext.createGainNode()
    @osc1.connect @amp1

    @osc2 = audioContext.createOscillator()
    @amp2 = audioContext.createGainNode()
    @osc2.connect @amp2

    @mixAmp = audioContext.createGainNode()
    @amp1.connect @mixAmp
    @amp2.connect @mixAmp
    @mixAmp.gain.value = 0.5 # to produce a maximum output of 1.0

    @filter = audioContext.createBiquadFilter()
    @mixAmp.connect @filter
    @filter.connect @output

    @output.gain.value = 0
    @osc1.start 0
    @osc2.start 0

    @oscRatio = 1.0
    @ampEnvelope =
      attack: 0.002
      decay: 0.03
      sustain: 0.9
      release: 1.1
    @filterEnvelope =
      attack: 0.01
      decay: 0.4
      sustain:0.35
      release: 0.7
    params ?=
      osc1Type: @osc1.SAWTOOTH
      osc2Type: @osc1.SAWTOOTH
      oscRatio: 1.03
      filterFrequency: 2500.0
    @setParams params

  setParams: (params) ->
    params ?= {}
    if params.osc1Type?
      @osc1.type = params.osc1Type
    if params.osc2Type?
      @osc2.type = params.osc2Type

    if params.osc1Gain?
      @amp1.gain.value = params.osc1Gain
    if params.osc2Gain?
      @amp2.gain.value = params.osc2Gain

    if params.oscRatio?
      @oscRatio = params.oscRatio

    if params.filterType?
      @filter.type = params.filterType
    if params.filterFrequency?
      @filterFrequency = params.filterFrequency
      @filter.frequency.value = params.filterFrequency
    if params.filterResonance?
      @filter.Q.value = params.filterResonance

    if params.ampEnvelope?
      @ampEnvelope = params.ampEnvelope
    if params.filterEnvelope?
      @filterEnvelope = params.filterEnvelope

  noteOn: (note) ->
    time = audioContext.currentTime

    @osc1.frequency.value = noteToFrequency note
    @osc2.frequency.value = @oscRatio * noteToFrequency note

    @output.gain.cancelScheduledValues time
    @output.gain.linearRampToValueAtTime 1.0, time + @ampEnvelope.attack
    @output.gain.linearRampToValueAtTime @ampEnvelope.sustain, time + @ampEnvelope.attack + @ampEnvelope.decay

    @filter.frequency.cancelScheduledValues time
    @filter.frequency.exponentialRampToValueAtTime @filterFrequency, time + @filterEnvelope.attack
    @filter.frequency.exponentialRampToValueAtTime @filterEnvelope.sustain * @filterFrequency, time + @filterEnvelope.attack + @filterEnvelope.decay

  noteOff: (note) ->
    time = audioContext.currentTime
    @output.gain.linearRampToValueAtTime 0.0, time + @ampEnvelope.sustain
    @filter.frequency.exponentialRampToValueAtTime 0.0, time + @filterEnvelope.sustain

  connect: (target) ->
    @output.connect target

noteToFrequency = (note) ->
  Math.pow(2, (note - 69) / 12) * 440.0

