extends CharacterBody3D

@export var min_speed: float = 10.0
@export var max_speed: float = 18.0

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func initialize(start_pos, player_pos):
	position = start_pos
	look_at(player_pos)
	rotate_y(randf_range(-PI/4, PI/4))
	var speed = randf_range(min_speed, max_speed)
	
	velocity = Vector3.FORWARD * speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
