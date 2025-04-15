extends Node2D

signal lap_completed(lap_time: float)
signal race_completed(total_time: float)
signal checkpoint_reached(checkpoint_number: int)

var checkpoints: Array[Node] = []
var current_checkpoint: int = 0
var current_lap: int = 0
var total_laps: int = 3
var lap_times: Array[float] = []
var race_time: float = 0.0
var race_started: bool = false
var best_lap_time: float = 999999.0

func _ready() -> void:
	setup_checkpoints()

func _process(delta: float) -> void:
	if race_started:
		race_time += delta

func setup_checkpoints() -> void:
	checkpoints = get_tree().get_nodes_in_group("checkpoints")
	for checkpoint in checkpoints:
		checkpoint.connect("body_entered", Callable(self, "_on_checkpoint_reached"))

func start_race() -> void:
	race_started = true
	race_time = 0.0
	current_lap = 0
	current_checkpoint = 0
	lap_times.clear()

func _on_checkpoint_reached(body: Node2D) -> void:
	if not body.is_in_group("player") or not race_started:
		return
		
	var checkpoint_index = checkpoints.find(body)
	if checkpoint_index == current_checkpoint:
		current_checkpoint += 1
		emit_signal("checkpoint_reached", current_checkpoint)
		
		# Check if lap is completed
		if current_checkpoint >= checkpoints.size():
			complete_lap()

func complete_lap() -> void:
	current_checkpoint = 0
	var lap_time = race_time
	if current_lap > 0:  # Don't count first crossing as a lap time
		lap_time -= lap_times.reduce(func(accum, number): return accum + number, 0.0)
		lap_times.append(lap_time)
		best_lap_time = min(best_lap_time, lap_time)
		emit_signal("lap_completed", lap_time)
	
	current_lap += 1
	if current_lap >= total_laps:
		complete_race()

func complete_race() -> void:
	race_started = false
	emit_signal("race_completed", race_time)

func get_formatted_time(time: float) -> String:
	var minutes = int(time / 60.0)
	var seconds = int(time) % 60
	var milliseconds = int((time - int(time)) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, milliseconds] 
