extends Path2D


func spawn_new_enemy() -> void:
	var enemyScene :PackedScene = preload("res://Enemies/enemy_mover.tscn")
	var enemy :PathFollow2D = enemyScene.instantiate()
	enemy.enemy_type = GameData.enemies.keys().pick_random()
	add_child(enemy)


func _on_timer_timeout() -> void:
	spawn_new_enemy()
