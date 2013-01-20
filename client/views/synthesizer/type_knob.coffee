class TypeKnob
  constructor: (@canvas, @target) ->
    @ctx = @canvas.getContext '2d'
    @index = 1
    @thickness = 5
    @functions = [Math.sin, @square, @saw, @triangle]
    @click()
    @draw()
    $(@canvas).mousedown (e) =>
      @click()
    $(@canvas).mouseenter (e) =>
      @hovering = true
    $(@canvas).mouseleave (e) =>
      @hovering = false

  click: ->
    @index = (@index + 1) % 4
    @target.type = @index

  draw: =>
    requestAnimationFrame @draw
    @ctx.clearRect 0, 0, @canvas.width, @canvas.height
    @ctx.strokeStyle = 'rgba(255, 255, 255, 0.3)'
    @ctx.lineWidth = @thickness
    @ctx.beginPath()
    @ctx.arc(@canvas.width / 2, @canvas.height / 2, @canvas.width / 2 - @thickness, 0, 2 * Math.PI, false)
    @ctx.stroke()
    @plotFunction @functions[@index]

  plotFunction: (fn) ->
    originX = @canvas.width / 2
    originY = @canvas.height / 2
    scaleX = @canvas.width / 4
    scaleY = @canvas.height / 8

    @ctx.beginPath()
    if @hovering
      t = Date.now() * 0.005
    else
      t = 0
    steps = 30
    for i in [-steps..steps]
      x = i / steps
      y = originY + fn(x * Math.PI + t) * scaleY
      @ctx.lineTo originX + x * scaleX, y
    @ctx.stroke()

  square: (x) ->
    number = Math.sin(x)
    number && number / Math.abs(number)

  saw: (x) ->
    2 * (x / (2 * Math.PI) - Math.floor(0.5 + x / (2 * Math.PI)))

  triangle: (x) =>
    -1 + 2.0 * Math.abs @saw(x)

