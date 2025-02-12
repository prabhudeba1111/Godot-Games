extends Node2D

@export var pipe_scene :PackedScene

var game_running :bool
var game_over :bool
var scroll
var score
const SCROLL_SPEED :int = 2
var screen_size :Vector2
var ground_height :int
var pipes :Array
const PIPE_DELAY :int = 100
const PIPE_RANGE :int = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()

func new_game():
	game_over = false
	game_running = false
	score = 0
	scroll = 0
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

func start_game():
	game_running = true
	$Bird.flying = true
	$Bird.flap()
	$PipeTimer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_running:
		scroll += SCROLL_SPEED
		if scroll >= screen_size.x:
			scroll = 0
		$Ground.position.x = -scroll
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED

func _on_pipe_timer_timeout() -> void:
	generate_pipes()
	print("now")

func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height)/2 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	add_child(pipe)
	pipe.hit.connect(bird_hit)
	pipes.append(pipe)

func bird_hit():
	pass
