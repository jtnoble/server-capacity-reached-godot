extends Node2D

var mg1 = preload("res://scenes/mg1/minigame_1.tscn")
var scenes: Array = [mg1]
var scene_index: int = 0

func first_load():
	pass
func next_level_index():
	scene_index = scene_index + 1

func load_game():
	# Load game
	$StartNextGameTimer.start()
	$CompleteLabel.visible = true

func load_scene(scene):
	var mg = scene.instantiate()
	mg.position.x = 70
	mg.position.y = 300
	mg.scale.x = 0.2
	mg.scale.y = 0.2
	add_child(mg)

func _on_start_next_game_timer_timeout():
	$CompleteLabel.visible = false
	load_scene(scenes[scene_index])
