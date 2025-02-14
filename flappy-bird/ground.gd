extends Area2D

signal hit

func _on_body_entered(_body: Node2D) -> void:
	hit.emit()
