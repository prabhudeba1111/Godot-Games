extends CharacterBody2D


const GRAVITY :int = 1000
const MAX_SPEED :int = 600
const FLAP_SPEED :int = -500
var flying :bool = false
var falling :bool = false
const START_POS :Vector2 = Vector2(100, 400)
var screen_size :Vector2

func _ready():
	screen_size = get_window().size
	reset()
	
func reset():
	falling = false
	flying = false
	position = START_POS
	set_rotation(0)

func _physics_process(delta: float) -> void:
	if flying or falling:
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, MAX_SPEED)
		if flying:
			set_rotation(deg_to_rad(velocity.y * delta))
			$AnimatedSprite2D.play()
		elif falling:
			set_rotation(PI/2)
			$AnimatedSprite2D.stop()
		move_and_collide(velocity * delta)
	else:
		$AnimatedSprite2D.stop()
	position.y = clamp(position.y, 20, screen_size.y-20)

func flap():
	velocity.y = FLAP_SPEED
