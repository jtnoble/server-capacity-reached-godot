extends Node2D

var mg1 = preload("res://scenes/mg1/minigame_1.tscn")
var mg2 = preload("res://scenes/mg2/minigame_2.tscn")
var mg3 = preload("res://scenes/mg3/minigame_3.tscn")
var mg4 = preload("res://scenes/mg4/minigame_4.tscn")
var scenes: Array = [mg1, mg2, mg3, mg4]
var scene_index: int = 0
var fading_out: bool = false
var current_mg

@onready var win_mg_noise = $Audio/WinMinigameNoise

func _ready():
	$ConnectingEndGameLabel.visible = false
	
func _process(delta):
	if fading_out:
		set_modulate(lerp(get_modulate(), Color(1,1,1,0), 0.008))

func first_load():
	$Servercapacitytext.fading_in = true
	load_game(false)
	
func next_level():
	scene_index = scene_index + 1
	if scene_index < scenes.size():
		win_mg_noise.play()
		load_game(true)
		return
	all_minigames_completed()

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
	mg.connect("minigame_completed", _on_minigame_complete)
	if mg.reloadable:
		mg.connect("minigame_reload", _on_reload_minigame)
	call_deferred("_handle_deferred_load_scene", mg)
	current_mg = mg

func _handle_deferred_load_scene(node):
	add_child(node)
	
func _on_reload_minigame():
	print_debug("MG RELOAD")
	current_mg.queue_free()
	load_scene(scenes[scene_index])
	
func _on_start_next_game_timer_timeout():
	$CompleteLabel.visible = false
	load_scene(scenes[scene_index])

func _on_minigame_complete():
	print_debug("MINIGAME COMPLETE")
	next_level()

func all_minigames_completed():
	print_debug("All minigames have been completed.")
	$Servercapacitytext.fading_out = true
	$ConnectingEndGameLabel.visible = true
	$EndGameBeforeFadeTimer.start()
	
func _on_end_game_before_fade_timer_timeout():
	fading_out = true
	$SwitchSceneTimer.start()

func _on_switch_scene_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/end_game.tscn")
