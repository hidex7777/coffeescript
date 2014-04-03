#stopwatch coffee
'use strict'

running = false
startTime = 0.00
stopTime = 0.00
timerId = undefined

class Run
	run: ->
		if running
			return
		running = true
		if stopTime
			startTime = startTime + (new Date()).getTime() - stopTime
		if !startTime
			startTime = (new Date()).getTime()
		Timer.timer()

class Timer
	timer: ->
		$('#sec').html((((new Date()).getTime() - startTime) / 1000).toFixed(2))
		timerId = setTimeout ->
			Timer.timer()
			return
		,100
		return

class Stop
	stop: ->
		if !running
			return false
		running = false
		clearTimeout(timerId)
		stopTime = (new Date()).getTime()
		return

class Reset
	reset: ->
		if running
			return
		startTime = undefined
		$('#sec').html('0.00')

$('#run').click ->
	Run.run()
	return
$('#stop').click ->
	Stop.stop()
	return
$('#reset').click ->
	Reset.reset()
	return
