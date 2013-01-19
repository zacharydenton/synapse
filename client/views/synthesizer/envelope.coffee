class EnvelopeCanvas
  constructor: (@canvas, @envelope) ->
    @ctx = @canvas.getContext '2d'
    @total = 1.3 * (2.0 + 2.0 + 10.0)
    @draw()

  draw: =>
    requestAnimationFrame @draw
    @ctx.clearRect 0, 0, @canvas.width, @canvas.height
    @ctx.strokeStyle = 'rgba(100, 200, 255, 0.4)'
    @ctx.lineWidth = 10
    @ctx.beginPath()
    @ctx.moveTo 0, @canvas.height
    @ctx.lineTo @envelope.attack / @total * @canvas.width, 0
    @ctx.lineTo (@envelope.attack + @envelope.decay) / @total * @canvas.width, (1 - @envelope.sustain) * @canvas.height
    @ctx.lineTo (@total - @envelope.release) / @total * @canvas.width, (1 - @envelope.sustain) * @canvas.height
    @ctx.lineTo @canvas.width, @canvas.height
    @ctx.stroke()

