#clock
  #時計を描く
  #drawClock: ->
    #分目盛
    #@ctx.save()
    #@ctx.lineWidth = 2
    #for i in [0...60]
      #@ctx.beginPath()
      #6度回転 * 60回
      #@ctx.rotate Math.PI / 30
      # x = 130からx = 150に描画（内から外へ）
      #@ctx.moveTo 130, 0
      #@ctx.lineTo 150, 0
      #@ctx.stroke()
    #@ctx.restore()
    #時間目盛
    #@ctx.save()
    #@ctx.lineWidth = 8
    #for i in [0...12]
      #@ctx.beginPath()
      #30度回転
      #@ctx.rotate Math.PI / 6
      # x = 120からx = 150に描画
      #@ctx.moveTo 120, 0
      #@ctx.lineTo 150, 0
      #@ctx.stroke()
    #@ctx.restore()
    #秒針初期値
    #@s(0)
    #return