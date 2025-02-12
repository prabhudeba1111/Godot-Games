extends Node

@export var mob_scene:PackedScene
var score = 0

func new_game():
	score = 0
	$HUD.update(score)
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition.position)
	
	$StartTimer.start()
	$HUD.show_message("Get Ready...")
	await($StartTimer.timeout)
	$ScoreTimer.start()
	$MobTimer.start()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$DeathSound.play()


func _on_mob_timer_timeout() -> void:
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var mob = mob_scene.instantiate()
	add_child(mob)
	
	mob.position = mob_spawn_location.position
	var direction = mob_spawn_location.rotation + PI / 2
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update(score)
