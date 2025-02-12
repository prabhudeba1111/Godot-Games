extends RigidBody2D

var speed :int = 400
var accel :int = 2.5
var paddle_width :int = 160
var direction :Vector2 = Vector2(0, 1)
var default_ball_pos :Vector2 = Vector2(640, 360)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity :Vector2 = direction * speed
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("Paddles"):
			var paddle = collider
			var paddle_centre = paddle.position.x
			var hit_position = position.x
			
			var offset = (hit_position - paddle_centre) / (paddle_width/2)
			direction = Vector2(offset * 1.5, -1).normalized()
			
		else:
			if collider is StaticBody2D and collider.has_method("take_damage"):
				collider.take_damage()
			var normal = collision.get_normal()
			direction = direction.bounce(normal)
			velocity = direction * speed

func _on_accel_timer_timeout() -> void:
	speed += accel
