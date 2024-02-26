extends Node2D

var reloadable: bool = false

var index: int = 0
var spot_games_arr: Array
var loaded_spot_games_arr: Array
var list_of_spot_games: Array = [
	"res://scenes/mg2/minigame_2_puzzle_1.tscn",
	"res://scenes/mg2/minigame_2_puzzle_2.tscn",
	"res://scenes/mg2/minigame_2_puzzle_3.tscn",
	"res://scenes/mg2/minigame_2_puzzle_4.tscn",
	"res://scenes/mg2/minigame_2_puzzle_5.tscn",
	"res://scenes/mg2/minigame_2_puzzle_6.tscn"
	]
var current_game
@onready var win_sound = $WinSingleGameSound

signal minigame_completed()

func _ready():
	set_modulate(Color(1,1,1,0))
	restart_game()
	
func randomize_spot_games_arr():
	var available_numbers: Array = []
	for i in range(list_of_spot_games.size()):
		available_numbers.append(i)
	available_numbers.shuffle()
	var random_numbers = available_numbers.slice(0, 3)
	return [
		list_of_spot_games[random_numbers[0]],
		list_of_spot_games[random_numbers[1]],
		list_of_spot_games[random_numbers[2]]
		]
	
func generate_spot_the_diff_arr():
	var spot_games = randomize_spot_games_arr()
	var _one = load(spot_games[0])
	var _two = load(spot_games[1])
	var _three = load(spot_games[2])
	
	loaded_spot_games_arr = [_one, _two, _three]
	
func start_puzzle():
	print_debug("Starting puzzle")
	current_game = loaded_spot_games_arr[index].instantiate()
	add_child(current_game)
	current_game.connect("puzzle_completed", _on_puzzle_complete)
	
func restart_game():
	if $Timer.time_left > 0:
		$Timer.stop()
	$Timer.start()
	index = 0
	$BlankOutOfThree/NumberOutOf.text = str(index)
	generate_spot_the_diff_arr()
	start_puzzle()

func _on_puzzle_complete():
	win_single_game()
	current_game.queue_free()
	if index >= loaded_spot_games_arr.size():
		win()
	else:
		start_puzzle()
	
func win_single_game():
	index = index + 1
	$BlankOutOfThree/NumberOutOf.text = str(index)
	win_sound.play()

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
