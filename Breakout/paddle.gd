extends CharacterBody2D

@export var speed = 750
var screen_size = Vector2.ZERO

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func get_input(left, right):
	var direction = Vector2.ZERO
	if Input.is_action_pressed(left):
		direction.x -=1
	elif Input.is_action_pressed(right):
		direction.x +=1
	return direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = get_input("move_left", "move_right")
	velocity = direction * speed * delta
	position += velocity
	position.x = clamp(position.x, 80, screen_size.x-80)
