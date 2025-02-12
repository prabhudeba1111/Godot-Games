extends Node2D

@export var global_health: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for group in get_children():
		for brick in group.get_children():
			brick.health = str(group)[6]
			brick.update_color()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
