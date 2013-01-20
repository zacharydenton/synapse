class FilterKnob
  constructor: (@canvas, @target) ->
    @ctx = @canvas.getContext '2d'
    @index = 0
    @thickness = 5
    @draw()
    $(@canvas).mousedown (e) =>
      @click()
    $(@canvas).mouseenter (e) =>
      @hovering = true
    $(@canvas).mouseleave (e) =>
      @hovering = false

  click: ->
    @index = (@index + 1) % 2
    @target.type = @index

  draw: =>
    requestAnimationFrame @draw
    @ctx.clearRect 0, 0, @canvas.width, @canvas.height
    @ctx.strokeStyle = 'rgba(255, 255, 255, 0.3)'
    @ctx.lineWidth = @thickness
    @ctx.beginPath()
    @ctx.arc(@canvas.width / 2, @canvas.height / 2, @canvas.width / 2 - @thickness, 0, 2 * Math.PI, false)
    @ctx.stroke()
    @showFilter @index

  showFilter: (index) ->
    if index < 2
      @ctx.fillStyle = 'rgba(255, 255, 255, 0.3)'
      @ctx.lineWidth = @thickness / 2
      @ctx.beginPath()
      @ctx.lineTo @thickness, @canvas.height / 2
      @ctx.lineTo @canvas.width - @thickness, @canvas.height / 2
      @ctx.arc(@canvas.width / 2, @canvas.height / 2, @canvas.width / 2 - @thickness, 0, Math.PI, index)
      @ctx.fill()


