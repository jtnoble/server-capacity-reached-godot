extends Node2D

var mg1 = preload("res://scenes/mg1/minigame_1.tscn")
var scenes: Array = [mg1]
var scene_index: int = 0

func first_load():
	$Servercapacitytext.fading_in = true
	load_game(false)
	
func next_level():
	scene_index = scene_index + 1
	load_game(true)

func load_game(level_complete):
	# Load game
	$StartNextGameTimer.start()
	if level_complete:
		$CompleteLabel.visible = true

func load_scene(scene):
	var mg = scene.instantiate()
	mg.position.x = 70
	mg.position.y = 300
	mg.scale.x = 0.2
	mg.scale.y = 0.2
	add_child(mg)
	mg.connect("minigame_completed", _on_minigame_complete)

func _on_start_next_game_timer_timeout():
	$CompleteLabel.visible = false
	load_scene(scenes[scene_index])

func _on_minigame_complete():
	print_debug("MINIGAME COMPLETE")
	next_level()
