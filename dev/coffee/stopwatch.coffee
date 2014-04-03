#stopwatch coffee
'use strict'

stopTime = 0.00
startTime = 0.00
running = false
timerId = 0

run = ->
	if running
		return
	running = true
	if stopTime
		startTime = startTime + (new Date()).getTime() - stopTime
	if !startTime
		startTime = (new Date()).getTime()
	timer()

timer = ->
	$('#sec').html((((new Date()).getTime() - startTime) / 1000).toFixed(2))
	timerId = setTimeout ->
		timer()
		return
	,100
	return

stop = ->
	if !running
		return false
	running = false
	clearTimeout(timerId)
	stopTime = (new Date()).getTime()
	return

reset = ->
	if running
		return
	startTime = undefined
	$('#sec').html('0.00')

$('#run').click ->
	run()
	return
$('#stop').click ->
	stop()
	return
$('#reset').click ->
	reset()
	return
