extends Path2D


func spawn_new_enemy() -> void:
	var enemyScene :PackedScene = preload("res://Enemies/enemy_mover.tscn")
	var enemy :PathFollow2D = enemyScene.instantiate()
	enemy.enemy_type = GameData.enemies.keys().pick_random()
	add_child(enemy)
	enemy.dead.connect(get_parent()._on_enemy_mover_dead)


func _on_timer_timeout() -> void:
	spawn_new_enemy()
