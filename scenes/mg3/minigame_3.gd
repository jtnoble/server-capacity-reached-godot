extends Node2D

var reloadable: bool = true

@onready var player = $player

var timer_time: float = 30
var pipes: Array = [
	"res://scenes/mg3/pipes_1.tscn",
	"res://scenes/mg3/pipes_2.tscn",
	"res://scenes/mg3/pipes_3.tscn",
	"res://scenes/mg3/pipes_4.tscn",
	"res://scenes/mg3/pipes_5.tscn"
]

var game_started: bool = false

signal minigame_completed()
signal minigame_reload()

func _ready():
	set_modulate(Color(1,1,1,0))
	player.position = Vector2(2400, 1200)

func _physics_process(delta):
	set_modulate(lerp(get_modulate(), Color(1,1,1,1), 0.2))
	if not game_started and Input.is_action_just_pressed("action"):
		$Timer.start()
		spawn_pipe()
		$PipeSpawnTimer.start()
		game_started = true
	if game_started:
		var time_left = $Timer.time_left + 1
		var text_string = "%d"
		$TimerLabel.text = text_string % time_left

func spawn_pipe():
	var random_number = randi_range(0, pipes.size() - 1)
	var pipe = load(pipes[random_number])
	var pipe_loaded = pipe.instantiate()
	pipe_loaded.position = $SpawnPos.position
	add_child(pipe_loaded)

func restart():
	if get_tree().current_scene.name == "minigame_3":
		get_tree().reload_current_scene()
	else:
		minigame_reload.emit()
	
func _on_pipe_spawn_timer_timeout():
	spawn_pipe()
	$PipeSpawnTimer.stop()
	$PipeSpawnTimer.start()

func _on_timer_timeout():
	minigame_completed.emit()
	queue_free()
