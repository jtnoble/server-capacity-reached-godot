extends CharacterBody2D

@export var speed: float = 200
var can_shoot: bool = true
var bullet = preload("res://scenes/mg4/player_bullet.tscn")

func _ready():
	$AnimatedSprite2D.play("default")
	
func _physics_process(_delta):
	movement()
	shoot()

func movement():
	var move_x = Input.get_axis("left", "right")
	velocity.x = move_x * speed
	move_and_slide()

func shoot():
	if Input.is_action_pressed("action") and can_shoot:
		var new_bullet = bullet.instantiate()
		add_child(new_bullet)
		can_shoot = false
		$ShootTimeout.start()

func _on_shoot_timeout_timeout():
	can_shoot = true
