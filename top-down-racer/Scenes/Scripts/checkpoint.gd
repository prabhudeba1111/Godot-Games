extends Area2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	add_to_group("checkpoints")
	if animation_player:
		animation_player.play("idle")

func activate() -> void:
	if sprite:
		sprite.modulate = Color(0, 1, 0, 1)  # Green for active checkpoint
	if animation_player:
		animation_player.play("active")

func deactivate() -> void:
	if sprite:
		sprite.modulate = Color(1, 1, 1, 0.5)  # Semi-transparent for inactive
	if animation_player:
		animation_player.play("idle") 
