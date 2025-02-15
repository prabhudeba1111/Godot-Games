extends CharacterBody3D

@export var speed: float = 10.0
@export var jump_velocity: float = 15.0
@export var gravity: float = 50.0

#var velocity :Vector3 = Vector3.ZERO

func get_input():
	var direction :Vector3 = Vector3.ZERO
	if Input.is_action_pressed("move_left"):
		direction.x -=1
	if Input.is_action_pressed("move_right"):
		direction.x +=1
	if Input.is_action_pressed("move_forward"):
		direction.z -=1
	if Input.is_action_pressed("move_back"):
		direction.z +=1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction)
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if  Input.is_action_pressed("jump") and is_on_floor():
		velocity.y += jump_velocity

func _physics_process(delta: float) -> void:
	get_input()
	velocity.y -= gravity * delta
	move_and_slide()
