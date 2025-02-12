extends RigidBody2D

@export var min_speed = 150
@export var max_speed = 250

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
