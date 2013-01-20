class RainbowParticles
  constructor: (@canvas) ->
    @ctx = @canvas.getContext '2d'
    @ctx.canvas.width = $('#visualization').width()
    @ctx.canvas.height = $('#visualization').height()
    @particles = []
    @notes = []
    @draw()

  noteOn: (note) ->
    @notes[note] = true

  noteOff: (note) ->
    delete @notes[note]

  draw: =>
    requestAnimationFrame @draw
    @ctx.clearRect 0, 0, @canvas.width, @canvas.height
    for note of @notes
      particle = new RainbowParticle new THREE.Color().setHSV((Math.random() + note % 12) / 12, 1.0, 1.0),
        5 + 5 * Math.random(),
        {x: (note * (@canvas.width / 120)) + Math.random() * (@canvas.width / 120), y: @canvas.height},
        {x: 3.5 * (1 - 2 * Math.random()), y: -@canvas.height/85 + 2*Math.random()},
        {x: 0, y: 0.05}
      @particles.push particle

    for particle in @particles
      if 0 <= particle.position.x <= @canvas.width and 0 <= particle.position.y <= @canvas.height
        particle.update()
        particle.draw @ctx

class RainbowParticle
  constructor: (@color, @size, @position, @velocity, @acceleration) ->
    return

  update: ->
    @velocity.x += @acceleration.x
    @velocity.y += @acceleration.y
    @position.x += @velocity.x
    @position.y += @velocity.y

  draw: (ctx) ->
    r = Math.floor(@color.r * 255)
    g = Math.floor(@color.g * 255)
    b = Math.floor(@color.b * 255)
    ctx.fillStyle = "rgba(#{r}, #{g}, #{b}, 0.6)"
    ctx.beginPath()
    ctx.arc @position.x, @position.y, @size, 0, 2 * Math.PI, false
    ctx.fill()

