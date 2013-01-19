class EffectsPipeline
  constructor: ->
    @input = audioContext.createGainNode()
    @output = audioContext.createGainNode()
    @last = @input
    @last.connect @output
    @effects = []

  addEffect: (effect) ->
    @last.disconnect @output
    @last.connect effect.input
    @effects.push effect
    effect.connect @output
    @last = effect

  connect: (target) ->
    @output.connect target
