# slot machine coffee
'use struct'
timers = []
nums = []
stopCount = 0

startSlot = ->
	runSlot(0)
	runSlot(1)
	runSlot(2)
	return

stopSlot = (n)->
	#if (nums[n] != undefined)
	if nums[n] isnt undefined
		return
	clearTimeout(timers[n])
	nums[n] = $('#num' + n).html()
	stopCount++
	if stopCount is 3
		checkSlot()

checkSlot = ->
	#alert("check");
	nums.sort()
	if (nums[0] == nums[1] && nums[0] == nums[2])
		$('#result').html("全部揃った！")
	else if nums[0] is nums[1] || nums[1] is nums[2]
		$('#result').html("2つ揃った！")
	else
		$('#result').html "残念"

runSlot = (n)->
	$('#num' + n).html(Math.floor(Math.random() * 10))
	timers[n] = setTimeout ->
		runSlot(n)
		return
	, 50
	return


$('#stop0').click ->
	stopSlot(0)
	return
$('#stop1').click ->
	stopSlot(1)
	return
$('#stop2').click ->
	stopSlot(2)
	return

startSlot()