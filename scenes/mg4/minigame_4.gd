extends Node2D

var reloadable: bool = false

signal minigame_completed()

func _ready():
	connect("minigame_completed", _on_minigame_completed)
	
func _on_minigame_completed():
	queue_free()
