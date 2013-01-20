class RainbowParticles
  constructor: (@container) ->
    @renderer = new THREE.WebGLRenderer()
    @camera = new THREE.PerspectiveCamera 70, @container.innerWidth / @container.innerHeight, 1, 2000
    @scene = new THREE.Scene()
    @scene.add @camera
    @camera.position.z = 300
    @renderer.setSize(@container.innerWidth, @container.innerHeight)
    @container.append(renderer.domElement)

    particleCount = 1800
    particles = new THREE.Geometry()
    pMaterial = new THREE.ParticleBasicMaterial
        color: 0xFFFFFF
        size: 20

    for p in [0...particleCount]
      pX = Math.random() * 500 - 250
      pY = Math.random() * 500 - 250
      pZ = Math.random() * 500 - 250
      particle = new THREE.Vertex(new THREE.Vector3(pX, pY, pZ))
      particles.vertices.push(particle)

    particleSystem = new THREE.ParticleSystem(particles, pMaterial)
    @scene.addChild(particleSystem)

