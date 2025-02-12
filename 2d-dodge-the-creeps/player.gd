extends Area2D

@export var speed = 400.0
var screen_size = Vector2.ZERO
signal hit 

func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()
	print(screen_size)

func _get_input():
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		
	if direction.length():
		direction = direction.normalized()
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	return direction
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = _get_input()
	
	position += direction * speed * delta
	position.x = clamp(position.x, 27, screen_size.x-27)
	position.y = clamp(position.y, 33.75, screen_size.y-33.75)
	
	if direction.x:
		$AnimatedSprite2D.animation = "right"
		$AnimatedSprite2D.flip_h = direction.x<0
		$AnimatedSprite2D.flip_v = false
	elif direction.y:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.flip_v = direction.y>0

func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(body: Node2D) -> void:
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	emit_signal("hit")
