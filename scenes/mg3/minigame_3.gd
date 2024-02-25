extends Node2D

@onready var player = $player

var timer_time: float = 30

signal minigame_completed()

func _ready():
	set_modulate(Color(1,1,1,0))
	$Timer.start()
	player.position = Vector2(300, 900)
	
func _physics_process(delta):
	set_modulate(lerp(get_modulate(), Color(1,1,1,1), 0.2))
	var time_left = $Timer.time_left + 1
	var text_string = "%d"
	$TimerLabel.text = text_string % time_left