extends Sprite2D

var fading_in: bool = false
var fading_out: bool = false

func _ready():
	set_modulate(Color(1,1,1,0))
	
func fade_in():
	set_modulate(lerp(get_modulate(), Color(1,1,1,1), 0.01))
	if get_modulate() == Color(1,1,1,1):
		fading_in = false
	
func fade_out():
	set_modulate(lerp(get_modulate(), Color(1,1,1,0), 0.1))
	if get_modulate() == Color(1,1,1,0):
		fading_out = false
	
func _process(delta):
	if fading_in:
		fade_in()
	elif fading_out:
		fade_out()
