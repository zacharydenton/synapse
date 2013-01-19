Meteor.startup ->
  window.audioContext = new webkitAudioContext()
  window.masterGainNode = audioContext.createGainNode()
  masterGainNode.gain.value = 0.7 # to avoid clipping
  masterGainNode.connect audioContext.destination

