extends CharacterBody2D

@onready var engine_sound: AudioStreamPlayer2D = $EngineSound

# Car properties
var wheel_base: int = 56  # Distance between front/rear wheels
var steering_angle: float = 15.0  # Maximum steering angle in degrees
var engine_power: int = 950
var friction: float = -0.9
var drag: float = -0.001
var braking: int = -450
var max_speed: int = 1500  # Added max speed limit
var max_reverse_speed: int = 200
var slip_speed: int = 400
var traction_fast: float = 0.3
var traction_slow: float = 0.8
var acceleration: Vector2 = Vector2.ZERO
var steer_direction: float

func _ready() -> void:
	# Ensure engine sound loops
	if engine_sound:
		engine_sound.stream.loop = true

func _physics_process(delta: float) -> void:
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	
	# Apply acceleration
	velocity += acceleration * delta
	
	# Limit speed
	var speed = velocity.length()
	if speed > max_speed:
		velocity = velocity.normalized() * max_speed
	elif speed > max_reverse_speed and velocity.dot(transform.x) < 0:
		velocity = velocity.normalized() * max_reverse_speed
	
	move_and_slide()
	_update_engine_sound()

func get_input() -> void:
	var turn = Input.get_action_strength("steer_right") - Input.get_action_strength("steer_left")
	steer_direction = turn * deg_to_rad(steering_angle)
	
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * engine_power
	if Input.is_action_pressed("brake"):
		acceleration = transform.x * braking

func apply_friction() -> void:
	# Stop the car if it's moving very slowly
	if velocity.length_squared() < 25:
		velocity = Vector2.ZERO
		return
		
	# Apply friction and drag forces
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	acceleration += friction_force + drag_force

func calculate_steering(delta: float) -> void:
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	
	var new_heading = (front_wheel - rear_wheel).normalized()
	
	# Apply traction based on speed
	var traction = lerp(traction_slow, traction_fast, velocity.length() / slip_speed)
	var d = new_heading.dot(velocity.normalized())
	
	if d > 0:
		velocity = lerp(velocity, new_heading * velocity.length(), traction)
	elif d < 0:
		velocity = lerp(velocity, -new_heading * velocity.length(), traction)
	
	rotation = new_heading.angle()

func _update_engine_sound() -> void:
	if not engine_sound:
		return
		
	if not engine_sound.playing:
		engine_sound.play()
	
	var speed_ratio = clamp(velocity.length() / max_speed, 0.0, 1.0)
	engine_sound.pitch_scale = lerp(0.8, 2.2, speed_ratio)
