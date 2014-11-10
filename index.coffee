navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia
window.URL = window.URL || window.webkitURL || window.msURL || window.mozURL

v = document.querySelector 'video'
d = document.querySelector '#draw'

dimensions = {}
dctx       = d.getContext '2d'
ctracker   = new clm.tracker()

navigator.getUserMedia {video: true}, (stream) ->
  v.src = window.URL.createObjectURL stream
, -> alert 'something is broke with your camera :('

v.addEventListener 'loadedmetadata', ->
  dimensions =
    w: v.videoWidth
    h: v.videoHeight

  v.setAttribute 'width', "#{v.videoWidth}px"
  v.setAttribute 'height', "#{v.videoHeight}px"
  d.setAttribute 'width', "#{v.videoWidth}px"
  d.setAttribute 'height', "#{v.videoHeight}px"

  ctracker.init pModel
  ctracker.start v
  frame()

frame = ->
  requestAnimationFrame frame
  draw()

draw = ->
  dctx.clearRect 0, 0, d.width, d.height
  ctracker.draw d if ctracker.getCurrentPosition()
