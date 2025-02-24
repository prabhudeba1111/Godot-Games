extends Node


const enemies := {
	"infantry": {
		"stats": {
			"hp": 50.0,
			"speed": 100.0,
			"baseDamage": 1.0,
			"goldYield": 10.0,
			},
		"sprite": "res://Tilesheet/PNG/towerDefense_tile245.png",
	},
	"infantryArmoured": {
		"stats": {
			"hp": 105.0,
			"speed": 80.0,
			"baseDamage": 1.0,
			"goldYield": 10.0,
			},
		"sprite": "res://Tilesheet/PNG/towerDefense_tile246.png",
	},
	"infantryMecha": {
		"stats": {
			"hp": 250.0,
			"speed": 150.0,
			"baseDamage": 1.0,
			"goldYield": 10.0,
			},
		"sprite": "res://Tilesheet/PNG/towerDefense_tile247.png",
	},
	"infantryCaptain": {
		"stats": {
			"hp": 150.0,
			"speed": 90.0,
			"baseDamage": 2.0,
			"goldYield": 10.0,
			},
		"sprite": "res://Tilesheet/PNG/towerDefense_tile248.png",
	}
}

const towers := {
	"sniper": {
		"stats": {
			"attack_damage": 150,
			"attack_speed": 0.5,
			"attack_range": 10.0,
			"bulletSpeed": 1500.0,
		},
		"upgrades": {
			"damage": {"amount": 2.5, "multiplies": false},
			"attack_speed": {"amount": 1.5, "multiplies": true},
		},
		"name": "Sniper Turret",
		"cost": 90,
		"sprite": "res://Tilesheet/PNG/towerDefense_tile249.png",
	},
		"machineGun": {
		"stats": {
			"attack_damage": 350,
			"attack_speed": 1.5,
			"attack_range": 6.0,
			"bulletSpeed": 800.0,
		},
		"upgrades": {
			"damage": {"amount": 2.5, "multiplies": false},
			"attack_speed": {"amount": 1.5, "multiplies": true},
		},
		"name": "Machine Gun Turret",
		"cost": 70,
		"sprite": "res://Tilesheet/PNG/towerDefense_tile250.png",
	},
}

const tower_level := {
	"1":{
		"sprite": "res://Tilesheet/PNG/towerDefense_tile183.png"
	},
	"2":{
		"sprite": "res://Tilesheet/PNG/towerDefense_tile182.png"
	},
	"3":{
		"sprite": "res://Tilesheet/PNG/towerDefense_tile181.png"
	},
	"4":{
		"sprite": "res://Tilesheet/PNG/towerDefense_tile180.png"
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
