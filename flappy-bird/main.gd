extends Node2D

@export var pipe_scene :PackedScene

var game_running :bool
var game_over :bool
var scroll
var score
const SCROLL_SPEED :float = 250
var screen_size :Vector2
var ground_height :int
var pipes :Array
const PIPE_DELAY :int = 100
const PIPE_RANGE :int = 200

func _ready() -> void:
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()

func new_game():
	game_over = false
	game_running = false
	score = 0
	scroll = 0
	$GameOver.hide()
	$ScoreLabel.text = "SCORE : " + str(score)
	get_tree().call_group("pipes", "queue_free")
	pipes.clear()
	generate_pipes()
	$Bird.reset()

func _input(event: InputEvent) -> void:
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				elif $Bird.flying:
					$Bird.flap()
					check_top()

func start_game():
	game_running = true
	$Bird.flying = true
	$Bird.flap()
	$PipeTimer.start()
	
func _process(delta: float) -> void:
	if game_running:
		scroll += SCROLL_SPEED * delta
		if scroll >= screen_size.x:
			scroll = 0
		$Ground.position.x = -scroll
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED * delta

func _on_pipe_timer_timeout() -> void:
	generate_pipes()

func check_top():
	if $Bird.position.y <= 21:
		$Bird.falling = true
		stop_game()

func stop_game():
	$PipeTimer.stop()
	$GameOver.show()
	$Bird.flying = false
	game_over = true
	game_running = false

func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height)/2 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	add_child(pipe)
	pipe.hit.connect(bird_hit)
	pipe.scored.connect(scored)
	pipes.append(pipe)

func bird_hit():
	$Bird.falling = true
	stop_game()

func _on_ground_hit() -> void:
	$Bird.falling = false
	stop_game()

func scored():
	score += 1
	$ScoreLabel.text = "SCORE : " + str(score)

func _on_game_over_restart() -> void:
	new_game()
