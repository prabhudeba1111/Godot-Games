extends CharacterBody2D

const ACCELERATION := 400.0
const MAX_SPEED := 200.0
const FRICTION := 300.0
const TURN_SPEED := 2.5  # Lower values for more gradual turning
const TRACTION := 5.0     # Higher values reduce drifting

func _physics_process(delta: float) -> void:
	var throttle_input := Input.get_axis("ui_down", "ui_up")
	var forward_vector := Vector2.RIGHT.rotated(rotation)
	
	# Acceleration/Deceleration
	if throttle_input != 0.0:
		velocity += forward_vector * ACCELERATION * throttle_input * delta
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	# Steering calculation
	var speed_squared := velocity.length_squared()
	if speed_squared > 25.0:  # Equivalent to speed > 5.0 (5^2 = 25)
		var speed := sqrt(speed_squared)
		var turn_direction := Input.get_axis("ui_left", "ui_right")
		
		# Reverse steering direction when moving backward
		turn_direction *= -1.0 if throttle_input < 0.0 else 1.0
		
		# Speed-sensitive steering with traction effect
		rotation += turn_direction * TURN_SPEED * delta * (speed / MAX_SPEED)
	
	# Traction system
	var forward_velocity = velocity.project(forward_vector)
	velocity = forward_velocity + (velocity - forward_velocity) / TRACTION
	
	# Speed limiting
	velocity = velocity.limit_length(MAX_SPEED)
	
	move_and_slide()
