extends Node


const enemies := {
	"infantry": {
		"stats": {
			"hp": 50.0,
			"speed": 100.0,
			"baseDamage": 5.0,
			"goldYield": 10.0,
			},
		"sprite": "res://Tilesheet/PNG/towerDefense_tile245.png",
	},
	"infantryArmoured": {
		"stats": {
			"hp": 75.0,
			"speed": 80.0,
			"baseDamage": 5.0,
			"goldYield": 10.0,
			},
		"sprite": "res://Tilesheet/PNG/towerDefense_tile246.png",
	},
	"infantryMecha": {
		"stats": {
			"hp": 150.0,
			"speed": 150.0,
			"baseDamage": 1.0,
			"goldYield": 10.0,
			},
		"sprite": "res://Tilesheet/PNG/towerDefense_tile247.png",
	},
	"infantryCaptain": {
		"stats": {
			"hp": 100.0,
			"speed": 90.0,
			"baseDamage": 1.0,
			"goldYield": 10.0,
			},
		"sprite": "res://Tilesheet/PNG/towerDefense_tile248.png",
	}
}

const levels := {
	"level1": {
		"scene": "res://Levels/level1.tscn",
		"baseHp": 20,
		"startingGold": 350,
	},
	"level2": {
		"scene": "res://Levels/level2.tscn",
		"baseHp": 20,
		"startingGold": 400,
	}
}
