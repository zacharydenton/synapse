class Clavilux
  constructor: (@canvas) ->
    @ctx = @canvas.getContext '2d'
    @ctx.canvas.width = $('#visualization').width()
    @ctx.canvas.height = $('#visualization').height()
    @notes = []
    @allNotes = []
    @draw()

  draw: =>
    requestAnimationFrame @draw
    @ctx.clearRect 0, 0, @canvas.width, @canvas.height
    for note in @allNotes
      note.draw @ctx

  noteOn: (note) ->
    @notes[note] = new Clavinote(@canvas, note)
    @allNotes.push @notes[note]

  noteOff: (note) ->
    @notes[note].off()

class Clavinote
  constructor: (@canvas, note) ->
    @width = 1 + 0.5 * (1 - 2 * Math.random()) * (@canvas.width / 12)
    @height = 1
    @x = note % 12 * (@canvas.width / 12) + @width / 2
    @y = @canvas.height
    @dest = @canvas.height / 2 + (1 - 2 * Math.random()) * (@canvas.height / 4)
    @born = Date.now()
    @r = Math.round Math.random() * 20
    @g = Math.round Math.random() * 200
    @b = Math.round Math.random() * 200
    @a = 0.4
    @growing = true

  draw: (ctx) ->
    @center = 
      x: @x + @width / 2
      y: @y + @height / 2
    if @growing
      @height += 1
    if @center.y > @dest
      @y -= 1

    @a = 0.05 * Math.sin(Date.now() - @born) + @a
    ctx.fillStyle = "rgba(#{@r}, #{@g}, #{@b}, #{@a})"
    ctx.fillRect @x, @y, @width, @height

  off: ->
    @growing = false

