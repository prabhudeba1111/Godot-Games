extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_boundary_body_entered(body: Node2D) -> void:
	body.queue_free()
	$GameOver.text ="GAME OVER"
	pass
