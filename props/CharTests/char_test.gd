extends Node3D
@onready var animator = $"../../../../AnimationPlayer"
@onready var mloc = $"../../BoneAttachment3D/AnimatedSprite3D"
var talk_dial_id = "cloud_talk"
var look_dial_id = null
var id = "Клод"


func _ready() -> void:
	animator.play("Idle_001")
	
	
func _process(_delta: float) -> void:
	pass
	
func use():
	GSig.testprint(self)
	mloc.play("talk")
	pass
