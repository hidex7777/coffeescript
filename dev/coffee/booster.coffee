#reading booster
'use strict'

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
    #コンテキストを1pxに伸縮
    @ctx.scale @width / 300, @height / 300
    #-90度回転（上向き）x方向だけ描画に使う。
    @ctx.rotate -Math.PI / 2
    @ctx.strokeStyle = "black"
    @ctx.fillStyle = "white"
    @ctx.lineCap = "butt"
  #時計を描く
  drawClock: ->
    #分目盛
    @ctx.save()
    @ctx.lineWidth = 2
    for i in [0...60]
      @ctx.beginPath()
      #6度回転 * 60回
      @ctx.rotate Math.PI / 30
      # x = 130からx = 150に描画（内から外へ）
      @ctx.moveTo 130, 0
      @ctx.lineTo 150, 0
      @ctx.stroke()
    @ctx.restore()
    #時間目盛
    @ctx.save()
    @ctx.lineWidth = 8
    for i in [0...12]
      @ctx.beginPath()
      #30度回転
      @ctx.rotate Math.PI / 6
      # x = 120からx = 150に描画
      @ctx.moveTo 120, 0
      @ctx.lineTo 150, 0
      @ctx.stroke()
    @ctx.restore()
    #秒針初期値
    #@s(0)
    return
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
    @cursec = if @cursec < 60 then @cursec + 1 else 0
    return
  tickStart: ->
    if !@timerId
      _clock = this
      _clock.tickTack()
      @timerId = setInterval ->
        _clock.clearAll()
        _clock.drawClock()
        _clock.tickTack()
        return
      , 1000
    return
  tickStop: ->
    clearInterval @timerId
    @s 0
    return
  clearAll: ->
    @ctx.clearRect -150, -150, 300, 300

#読み込み終了時に実行
window.onload = ->
  clock = new Clock "mycanvas"
  clock.drawClock()
  clock.s()
  $('#start').click ->
    if $('#start').text() is "START"
      clock.tickStart()
      $('#start').text "STOP"
    else
      clock.tickStop()
      clock.clearAll()
      clock.drawClock()
      clock.s()
      $('#start').text "START"
    return
  return