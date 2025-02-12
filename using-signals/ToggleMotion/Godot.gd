extends Sprite2D

var speed = 400
var angular_speed = PI
var state = 1

func _ready():
	var timer = get_node("Timer")
	timer.timeout.connect(self._on_Timer_timeout)

func _on_Timer_timeout():
	visible = not visible

func _process(delta):
	rotation += angular_speed * delta
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta


func _on_button_pressed() -> void:
	state = 1 - state
	set_process(not is_processing())
