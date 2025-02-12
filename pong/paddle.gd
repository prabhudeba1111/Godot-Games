extends CharacterBody2D

@export var left_side = true
@export var speed = 750
var screen_size = Vector2.ZERO

func _ready() -> void:
	screen_size = get_viewport_rect().size
	#print(screen_size)
	
func get_input(up, down):
	var direction = Vector2.ZERO
	if Input.is_action_pressed(up):
		direction.y -=1
	elif Input.is_action_pressed(down):
		direction.y +=1
	return direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction
	if left_side:
		direction = get_input("p1_up", "p1_down")
	else:
		direction = get_input("p2_up", "p2_down")
	
	position.y += direction.y * speed * delta
	position.y = clamp(position.y, 98, screen_size.y-98)
