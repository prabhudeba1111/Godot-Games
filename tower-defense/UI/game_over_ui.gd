extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui_animation()


func ui_animation() -> void:
	var tween :Tween = create_tween()
	tween.tween_property($CenterPanel, "pivot_offset", Vector2(100,100), 0.05)
	tween.tween_property($CenterPanel, "scale", Vector2(0.1,0.1), 0.05)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	tween.tween_property($CenterPanel, "modulate", Color.WHITE, 0.3)
	tween.tween_property($CenterPanel, "scale", Vector2(1,1), 0.5)


func _on_retry_button_pressed() -> void:
	pass


func _on_main_menu_button_pressed() -> void:
	pass
