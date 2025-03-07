extends Node2D

var level :String= "":
	set(val):
		level = val
		baseHP = GameData.levels[val]["baseHp"]
		baseMaxHp = GameData.levels[val]["baseHp"]
		gold = GameData.levels[val]["startingGold"]

var gameOver :bool = false
var baseMaxHp :int 
var baseHP :int
var gold :int :
	set(value):
		gold = value
		Globals.goldChanged.emit(value)

var occupied_tiles :Array = []


func _ready() -> void:
	Globals.currentMap = self
	Globals.turretsNode = $Turrets
	Globals.baseHpChanged.emit(baseHP)
	Globals.goldChanged.emit(gold)


func base_damaged(damage :int) -> void:
	if gameOver:
		return
	baseHP -= damage
	baseHP = max(baseHP, 0)
	Globals.baseHpChanged.emit(baseHP)
	if baseHP <= 0:
		gameOver = true
		var gameOverPanelScene :PackedScene = preload("res://UI/game_over_ui.tscn")
		var gameOverPanel :CanvasLayer = gameOverPanelScene.instantiate()
		Globals.hud.add_child(gameOverPanel)

func _input(event :InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		var tilemap :TileMapLayer = get_node("TileMap")
		var mouse_pos :Vector2 = get_global_mouse_position()
		var tile_pos :Vector2i = tilemap.local_to_map(mouse_pos)
		if is_valid_pos(tile_pos):
			var turretScene :PackedScene = preload("res://Towers/turret_base.tscn")
			var turret :Node2D = turretScene.instantiate()
			turret.position = tilemap.map_to_local(tile_pos)
			turret.turret_type = GameData.towers.keys()[0]
			get_node("Turrets").add_child(turret)
			occupied_tiles.append(tile_pos)
	if event.is_action_pressed("ui_down"):
		var tilemap :TileMapLayer = get_node("TileMap")
		var mouse_pos :Vector2 = get_global_mouse_position()
		var tile_pos :Vector2i = tilemap.local_to_map(mouse_pos)
		if is_valid_pos(tile_pos):
			var turretScene :PackedScene = preload("res://Towers/turret_base.tscn")
			var turret :Node2D = turretScene.instantiate()
			turret.position = tilemap.map_to_local(tile_pos)
			turret.turret_type = GameData.towers.keys()[1]
			get_node("Turrets").add_child(turret)
			occupied_tiles.append(tile_pos)


func is_valid_pos(tile_pos: Vector2i) -> bool:
	var tile_map :TileMapLayer = get_node("TileMap")
	var tile_id :Vector2i = tile_map.get_cell_atlas_coords(tile_pos)
	var invalid_turret_tiles :Array = [Vector2i(1, 4), Vector2i(21, 2), Vector2i(22, 2)]
	return not tile_id in invalid_turret_tiles and not tile_pos in occupied_tiles


func _on_enemy_mover_dead(goldYeild: int) -> void:
	gold += goldYeild
	Globals.goldChanged.emit(gold)
