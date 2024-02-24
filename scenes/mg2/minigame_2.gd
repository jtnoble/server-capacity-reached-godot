extends Node2D

var index: int = 0
var spot_games_arr: Array
var loaded_spot_games_arr: Array
var list_of_spot_games: Array = ["", "", ""]

signal minigame_completed()

func _ready():
	set_modulate(Color(1,1,1,0))
	restart_game()
	
func randomize_spot_games_arr():
	# TODO: Randomize an array for spot the difference
	return [list_of_spot_games[0], list_of_spot_games[1], list_of_spot_games[2]]
	#return randomize()
	
func generate_spot_the_diff_arr():
	var spot_games = randomize_spot_games_arr()
	var _one = load(spot_games[0])
	var _two = load(spot_games[1])
	var _three = load(spot_games[2])
	
	loaded_spot_games_arr = [_one, _two, _three]
	

func restart_game():
	if $Timer.time_left > 0:
		$Timer.stop()
	$Timer.start()
	index = 0
	generate_spot_the_diff_arr()
	

func win_single_game():
	index = index + 1

func win():
	minigame_completed.emit()
	queue_free()

func lose():
	restart_game()

func _on_timer_timeout():
	lose()

func _physics_process(delta):
	set_modulate(lerp(get_modulate(), Color(1,1,1,1), 0.2))
	var time_left = $Timer.time_left + 1
	var text_string = "%d"
	$TimerLabel.text = text_string % time_left
