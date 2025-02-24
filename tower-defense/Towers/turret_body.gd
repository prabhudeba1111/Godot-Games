extends TurretBase

@onready var fire_point = $FirePoint

@export var bullet_scene :PackedScene= preload("res://Towers/Bullets/sniper_bullet.tscn")

var enemies_in_range = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AttackCD.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		enemies_in_range.append(body)
		update_target()

func _on_range_body_exited(body: Node2D) -> void:
	if body in enemies_in_range:
		enemies_in_range.erase(body)
	update_target()


func update_target():
	if enemies_in_range.is_empty():
		get_parent().target = null
		return
	get_parent().target = enemies_in_range[0]


func _on_attack_cd_timeout() -> void:
	if get_parent().target and is_instance_valid(get_parent().target):
		fire_bullet()


func fire_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.position = fire_point.position
	bullet.target = get_parent().target
	get_node("Projectiles").add_child(bullet)
