extends Node

@export var mob_scene: PackedScene = preload("res://mob.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $SpawnPath/SpawnLocation
	mob_spawn_location.progress_ratio = randf()
	var player_pos = $Player.transform.origin
	
	add_child(mob)
	mob.initialize(mob_spawn_location.position, player_pos)
