extends Path2D


func spawn_new_enemy():
	var enemyScene := preload("res://Enemies/enemy_mover.tscn")
	var enemy = enemyScene.instantiate()
	enemy.enemy_type = GameData.enemies.keys().pick_random()
	add_child(enemy)


func _on_timer_timeout() -> void:
	spawn_new_enemy()
