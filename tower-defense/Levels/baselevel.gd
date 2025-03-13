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


func _ready() -> void:
	get_tree().paused = false
	Globals.currentMap = self
	Globals.turretsNode = $Turrets
	Globals.tileMapNode = $TileMap
	Globals.baseHpChanged.emit(baseHP)
	Globals.goldChanged.emit(gold)
	get_node("/root/Main/LevelUI/HUD").tile_map = $TileMap


func base_damaged(damage :int) -> void:
	if gameOver:
		return
	baseHP -= damage
	baseHP = max(baseHP, 0)
	Globals.baseHpChanged.emit(baseHP)
	if baseHP <= 0:
		gameOver = true
		get_tree().paused = true
		var gameOverPanelScene :PackedScene = preload("res://UI/game_over_ui.tscn")
		var gameOverPanel :CanvasLayer = gameOverPanelScene.instantiate()
		Globals.hud.add_child(gameOverPanel)


func _on_enemy_mover_dead(goldYeild: int) -> void:
	gold += goldYeild
	Globals.goldChanged.emit(gold)
