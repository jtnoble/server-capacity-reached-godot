extends Node2D

var reloadable: bool = true

signal minigame_completed()
signal minigame_reload()

func _ready():
	connect("minigame_completed", _on_minigame_completed)

func _process(_delta):
	var time_left = $Timer.time_left + 1
	var text_string = "%d"
	$TimerLabel.text = text_string % time_left

func _on_minigame_completed():
	queue_free()

func reload():
	minigame_reload.emit()

func _on_timer_timeout():
	reload()
