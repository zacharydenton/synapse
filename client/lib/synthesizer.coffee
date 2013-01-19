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
    @osc1.connect @mixAmp
    @osc2.connect @mixAmp
    @mixAmp.gain.value = 0.5 # to produce a maximum output of 1.0

    @filter = audioContext.createBiquadFilter()
    @mixAmp.connect @filter
    @filter.connect @output

    @osc1.start 0
    @osc2.start 0

    @oscRatio = 1.0
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
      @filter.frequency.value = params.filterFrequency
    if params.filterResonance?
      @filter.Q.value = params.filterResonance

  connect: (target) ->
    @output.connect target
