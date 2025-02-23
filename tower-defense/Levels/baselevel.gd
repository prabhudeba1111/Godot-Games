extends Node2D

var level := "":
	set(val):
		level = val
		baseHP = GameData.levels[val]["baseHp"]
		baseMaxHp = GameData.levels[val]["baseHp"]
		gold = GameData.levels[val]["startingGold"]
		$PathSpawner.map_type = val

var gameOver :bool = false
var baseMaxHp :int = 20
var baseHP :int = baseMaxHp
var gold :int

func base_damaged(damage):
	print(str(baseHP) + "-" + str(damage))
	baseHP -= damage
	$Label.text = "Health : " + str(baseHP)
