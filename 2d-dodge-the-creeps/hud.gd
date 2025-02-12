extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$ScoreLabel.hide()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update(score):
	$ScoreLabel.text = str(score)

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	await($MessageTimer.timeout)
	$MessageLabel.text = "Dodge' em All"
	$MessageLabel.show()
	await(get_tree().create_timer(1).timeout)
	$Button.show()

func _on_button_pressed() -> void:
	$Button.hide()
	emit_signal("start_game")

func _on_message_timer_timeout() -> void:
	$MessageLabel.hide()
