extends Node3D
class_name  HealthComp

@export var Hitbox : CollisionShape3D
@export var MaxHP : float = 100.0
var hp : float
var dead : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hp = MaxHP
	print(hp)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if hp <= 0 and dead != true:
		dead = true
		get_parent().death()
		await get_tree().create_timer(10).timeout
		get_parent().queue_free()
	pass
