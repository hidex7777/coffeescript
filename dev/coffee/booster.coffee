#reading booster
'use strict'

#秒数をフォーマットしてdiv#digitalをアップデート
formatDigital = (digitalcount) ->
  #1:30:30 == 5430
  s = digitalcount % 60
  m = Math.floor(digitalcount / 60)
  h = Math.floor(m / 60)
  m = m - (h * 60)
  if s < 10 then s = "0" + s
  if h < 10 then h = "0" + h
  if m < 10 then m = "0" + m
  digitaltext = "#{h}:#{m}:#{s}"
  $('#digital').text(digitaltext)
  return

soundTick = (digitalcount) ->
  tick = $('#tick-file').get(0)
  tick.currentTime = 0
  tick.play()
  cycle = $('#range').val()
  if digitalcount % cycle == 0
    sine = $('#sine-file').get(0)
    sine.currentTime = 0
    sine.play()
  return

class Clock
  constructor: (@id) ->
    @timerId = null
    @canvas = document.getElementById @id
    if !@canvas || !@canvas.getContext
      return false
    @ctx = @canvas.getContext '2d'
    @width = @canvas.width
    @height = @canvas.height
    #150, 150に移動（このコンテキストが固定）
    @ctx.translate @width / 2, @height / 2
    #コンテキストを100%に伸縮
    @ctx.scale @width / 300, @height / 300
    #-90度回転（上向き）x方向だけ描画に使う。
    @ctx.rotate -Math.PI / 2
    #@ctx.strokeStyle = "black"
    @ctx.fillStyle = "white"
    @ctx.lineCap = "butt"
    #digital timer init
    @digitalcount = 0
    formatDigital(@digitalcount)
  s: (@cursec = 0) ->
    @ctx.save()
    # 秒針は6度ずつ回転。初期値は0
    @ctx.rotate Math.PI / 30 * @cursec
    @ctx.strokeStyle = "#cc0000"
    @ctx.lineWidth = 2
    @ctx.beginPath()
    # x = -10からx = 130に描画
    @ctx.moveTo -10, 0
    @ctx.lineTo 130, 0
    @ctx.stroke()
    @ctx.restore()
    return
  #秒針を回す
  tickTack: ->
    if !@canvas
      return
    @s @cursec
    @cursec = if @cursec < 59 then @cursec + 1 else 0
    formatDigital @digitalcount
    soundTick @digitalcount
    @digitalcount++
    return
  tickStart: ->
    #if !@timerId
    _clock = this
    if !@digitalcount
      @digitalcount = 0
    _clock.clearAll()
    _clock.tickTack()
    @timerId = setInterval ->
      _clock.clearAll()
      _clock.tickTack()
      return
    , 1000
    return
  tickPause: ->
    clearInterval @timerId
    return
  tickStop: ->
    clearInterval @timerId
    @timerId = null
    @s 0
    @digitalcount = 0
    formatDigital @digitalcount
    return
  clearAll: ->
    @ctx.clearRect -150, -150, 300, 300

#読み込み終了時に実行
window.onload = ->
  clock = new Clock "mycanvas"
  clock.s()
  $('#start').click ->
    if $('#start').hasClass("state_stop")
      clock.tickStart()
      $('#start').removeClass("state_stop")
      $('#start').addClass("state_play")
    else
      clock.tickPause()
      #clock.tickStop()
      #clock.clearAll()
      #clock.s()
      $('#start').removeClass("state_play")
      $('#start').addClass("state_stop")
    return
  $('#stop').click ->
    clock.tickStop()
    clock.clearAll()
    clock.s()
    if $('#start').hasClass("state_play")
      $('#start').removeClass("state_play")
      $('#start').addClass("state_stop")
    return
  return