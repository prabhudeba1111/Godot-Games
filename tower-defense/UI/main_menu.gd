extends Control


func _on_new_game_button_pressed() -> void:
		var lvlScene := preload("res://UI/level_select.tscn")
		var lvl := lvlScene.instantiate()
		add_child(lvl)
		$Panel.hide()


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_game_button_pressed() -> void:
	get_tree().quit()
