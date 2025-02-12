extends TextureProgressBar


func _on_player_health_changed(new_health: Variant) -> void:
	value = new_health
