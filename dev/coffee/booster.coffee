#reading booster
'use strict'

#読み込み終了時に実行
window.onload = ->
  drawCircle()
  drawHand()
  return

#円を描く
drawCircle = ->
  canvas = document.getElementById('mycanvas')
  if (!canvas || !canvas.getContext)
    return false
  ctx = canvas.getContext('2d')
  ctx.beginPath();
  ctx.arc(150, 150, 145, 0/180*Math.PI, 360/180*Math.PI)
  ctx.fillStyle = "#FFFFFF"
  ctx.fill()
  return

#秒針を描く
drawHand = ->
  canvas = document.getElementById('mycanvas')
  if (!canvas || !canvas.getContext)
    return false
  ctx = canvas.getContext('2d')
  #ctx.beginPath()
  #ctx.moveTo(150, 150)
  #ctx.lineTo(150, 10)
  #ctx.rotate(30 * Math.PI / 180)
  #ctx.translate(150, 150)
  #ctx.stroke()
  ctx.fillStyle = "#000000"
  ctx.fillRect(150, 0, 2, 150)
  return