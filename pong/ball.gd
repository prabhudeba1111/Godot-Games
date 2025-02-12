extends RigidBody2D

var speed = 400
var accel = 5
var direction = Vector2.ZERO
var default_ball_pos = Vector2(640, 360)

func _ready() -> void:
	hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = direction * speed
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var normal = collision.get_normal()
		direction = direction.bounce(normal)
		velocity = direction * speed

func start():
	speed = 300
	position = default_ball_pos
	show()
	direction = Vector2([-1, 1].pick_random(), [-1, 0, 1].pick_random())
	$AccelTimer.start()
	

func _on_accel_timer_timeout() -> void:
	speed += accel
