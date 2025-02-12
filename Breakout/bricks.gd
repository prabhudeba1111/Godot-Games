extends StaticBody2D

@export var health: int = 4  # Brick starts with 4 HP
var colors = {1: Color.RED, 2: Color.ORANGE_RED, 3: Color.ORANGE, 4: Color.YELLOW, 5: Color.GREEN}

func _ready() -> void:
	update_color()

func take_damage():
	health -= 1
	if health > 0:
		update_color()
	else:
		queue_free()

func update_color():
	if health in colors:
		$Sprite2D.self_modulate = colors[health]  # Change color
