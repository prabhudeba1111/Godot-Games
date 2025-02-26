extends Node2D

var level := "":
	set(val):
		level = val
		baseHP = GameData.levels[val]["baseHp"]
		baseMaxHp = GameData.levels[val]["baseHp"]
		gold = GameData.levels[val]["startingGold"]

var gameOver :bool = false
var baseMaxHp :int = 20
var baseHP :int = baseMaxHp
var gold :int

var occupied_tiles = []

func base_damaged(damage):
	baseHP -= damage
	$Label.text = "Health : " + str(baseHP)

func _input(event):
	if event.is_action_pressed("ui_up"):
		var tilemap = get_node("TileMap")
		var mouse_pos = get_global_mouse_position()
		var tile_pos = tilemap.local_to_map(mouse_pos)
		if is_valid_pos(tile_pos):
			var turretScene := preload("res://Towers/turret_base.tscn")
			var turret = turretScene.instantiate()
			turret.position = tilemap.map_to_local(tile_pos)
			turret.turret_type = GameData.towers.keys()[0]
			get_node("Turrets").add_child(turret)
			occupied_tiles.append(tile_pos)
	if event.is_action_pressed("ui_down"):
		var tilemap = get_node("TileMap")
		var mouse_pos = get_global_mouse_position()
		var tile_pos = tilemap.local_to_map(mouse_pos)
		if is_valid_pos(tile_pos):
			var turretScene := preload("res://Towers/turret_base.tscn")
			var turret = turretScene.instantiate()
			turret.position = tilemap.map_to_local(tile_pos)
			turret.turret_type = GameData.towers.keys()[1]
			get_node("Turrets").add_child(turret)
			occupied_tiles.append(tile_pos)

func is_valid_pos(tile_pos: Vector2i) -> bool:
	var tile_map = get_node("TileMap")
	var tile_id = tile_map.get_cell_atlas_coords(tile_pos)
	var invalid_turret_tiles = [Vector2i(1, 4), Vector2i(21, 2), Vector2i(22, 2)]
	return not tile_id in invalid_turret_tiles and not tile_pos in occupied_tiles
