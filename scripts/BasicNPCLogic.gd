extends CharacterBody3D

enum 
{
	Idle,
	Looking
}
var state = Idle
var target 
@onready var lz = $Area3D
@onready var anim = $AnimationPlayer

func _on_area_3d_body_entered(_body):
	if _body.is_in_group("Player"):
		state = Looking
		target = _body
		
		


func _on_area_3d_body_exited(_body):
	state = Idle

func _ready():
	pass
	
func _process(_delta):
	if lz.is_processing():
		state = Looking
	match state:
		Idle: 
			anim.play("Idle")
		Looking:
			anim.pause()
			rotate_y(deg_to_rad(target.rotation.y * 2))
