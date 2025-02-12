extends Node2D

var score = [0, 0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("in")
	game_restart()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func game_restart():
	print("inner")
	$GameTimer.start()
	$ScoreLabel.text = "{p1} - {p2}".format({"p1":score[0], "p2":score[1]})
	await($GameTimer.timeout)
	$Ball.start()

func _on_left_score_body_entered(body: Node2D) -> void:
	score[1] += 1
	print("left")
	game_restart()

func _on_right_score_body_entered(body: Node2D) -> void:
	score[0] += 1
	print("right")
	game_restart()
