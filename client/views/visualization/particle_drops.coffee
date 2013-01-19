class ParticleDrops
  constructor: (@canvas) ->
    @ctx = @canvas.getContext '2d'
    @particles = []

  noteOn: (note) ->
    @particles.push new Particle @canvas.width / 2 + (1 - 2 * Math.random()) * @canvas.width / 4, 0, 20 + 30 * Math.random()

  noteOff: (note) ->
    return

class Particle
  constructor: (@x, @y, @width) ->
    @update()
    @dx = (1 - 2 * Math.random()) * 5
    @dy = 0
    @ay = 3

  update: ->
    @dy += @ay
    @y += @dy
    @x += @dx

  draw: ->
    return

