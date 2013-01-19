class ElectricStonehenge
  constructor: (@container) ->
    @loader = new THREE.ColladaLoader()
    @loader.load '/stonehenge/models/model.dae', (collada) =>
      @dae = collada.scene
      @init()
      @draw()

  init: ->
    @camera = new THREE.PerspectiveCamera 45, @container.innerWidth / @container.innerHeight, 1, 2000
    @scene = new THREE.Scene()
    @scene.add @dae
    @renderer = new THREE.WebGLRenderer()
    @renderer.setSize @container.innerWidth, @container.innerHeight
    @container.appendChild @renderer.domElement
    @container.addEventListener 'resize', @onWindowResize, false

  onWindowResize: ->
    @camera.aspect = @container.innerWidth / @container.innerHeight
    @camera.updateProjectionMatrix()
    @renderer.setSize @container.innerWidth, @container.innerHeight


  draw: =>
    requestAnimationFrame @draw
    @render()

  render: ->
    timer = Date.now() * 0.0005
    @camera.position.x = Math.cos(timer) * 10
    @camera.position.y = 2
    @camera.position.z = Math.sin(timer) * 10

    @camera.lookAt @scene.position
    @renderer.render @scene, @camera
