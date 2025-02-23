extends CharacterBody2D


var speed :int
var target :CharacterBody2D = null
var turret :StaticBody2D

func _ready() -> void:
	turret = get_parent().get_parent()
	speed = turret.bulletSpeed
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target and is_instance_valid(target):
		var direction = (target.global_position - global_position).normalized()
		look_at(target.global_position)
		global_position += direction * speed * delta
		
		if global_position.distance_to(target.global_position) < 5:
			hit_target()

func hit_target():
	var damage = turret.attack_damage
	target.get_parent().take_damage(damage)
	queue_free()
