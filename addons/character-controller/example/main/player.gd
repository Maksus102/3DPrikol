extends FPSController3D
class_name Player

## Example script that extends [CharacterController3D] through 
## [FPSController3D].
## 
## This is just an example, and should be used as a basis for creating your 
## own version using the controller's [b]move()[/b] function.
## 
## This player contains the inputs that will be used in the function 
## [b]move()[/b] in [b]_physics_process()[/b].
## The input process only happens when mouse is in capture mode.
## This script also adds submerged and emerged signals to change the 
## [Environment] when we are in the water.

@export var input_back_action_name := "move_backward"
@export var input_forward_action_name := "move_forward"
@export var input_left_action_name := "move_left"
@export var input_right_action_name := "move_right"
@export var input_sprint_action_name := "move_sprint"
@export var input_jump_action_name := "move_jump"
@export var input_crouch_action_name := "move_crouch"
@export var input_fly_mode_action_name := "move_fly_mode"

var hit_spr : Sprite3D
@export_file var Hit_Sprite

@export var underwater_env: Environment
@onready var interactor = $"Head/Interact"
@onready var holder = $"Head/HoldPos"
@onready var Rotator = $"Head/Rotator"
@onready var joint = $"Head/Generic6DOFJoint3D"
@onready var inv = $"Inventar"

var pickobj
var locked = false


func _ready():
	hit_spr = Sprite3D.new()
	hit_spr.visible = false
	hit_spr.no_depth_test = true
	hit_spr.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	add_child(hit_spr)
	hit_spr.texture = load("res://textures/CUM.png")
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	setup()
	emerged.connect(_on_controller_emerged.bind())
	submerged.connect(_on_controller_subemerged.bind())


		
func _physics_process(delta):
	var is_valid_input := Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	
	
	if is_valid_input:
		if Input.is_action_just_pressed(input_fly_mode_action_name):
			fly_ability.set_active(not fly_ability.is_actived())
		var input_axis = Input.get_vector(input_back_action_name, input_forward_action_name, input_left_action_name, input_right_action_name)
		var input_jump = Input.is_action_just_pressed(input_jump_action_name)
		var input_crouch = Input.is_action_pressed(input_crouch_action_name)
		var input_sprint = Input.is_action_pressed(input_sprint_action_name)
		var input_swim_down = Input.is_action_pressed(input_crouch_action_name)
		var input_swim_up = Input.is_action_pressed(input_jump_action_name)
		move(delta, input_axis, input_jump, input_crouch, input_sprint, input_swim_down, input_swim_up)
	else:
		# NOTE: It is important to always call move() even if we have no inputs 
		## to process, as we still need to calculate gravity and collisions.
		move(delta)
	if pickobj != null:
		var a = pickobj.global_transform.origin
		var b = holder.global_transform.origin
		pickobj.set_linear_velocity((b-a)*10)

func _input(event: InputEvent) -> void:
	# Mouse look (only if the mouse is captured).
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and !locked:
		rotate_head(event.relative)
		
	
	if Input.is_action_just_pressed('PhysPull'):
		if pickobj == null:
			picker()
		elif pickobj !=null:
			dropper()
	
	if Input.is_action_just_pressed("Interact"):
		if pickobj == null:
			interact()
			
	if Input.is_action_pressed('rclick') and pickobj:
		locked = true
		hrotation(event)
	if Input.is_action_just_released('rclick'):
		locked = false
		
	if Input.is_action_just_pressed("lclick"):
		hit()
	

func _on_controller_emerged():
	camera.environment = null


func _on_controller_subemerged():
	camera.environment = underwater_env
	
func hrotation (event):
	if pickobj !=null:
		if event is InputEventMouseMotion:
			Rotator.rotate_x(deg_to_rad(event.relative.y * 0.5))
			Rotator.rotate_y(deg_to_rad(event.relative.x * 0.5))

func picker():
	var detected = interactor.get_collider()
	if detected != null and detected.get_class() == 'RigidBody3D':
		pickobj = detected
		joint.set_node_b(pickobj.get_path())
		
func dropper():
	if pickobj != null:
		pickobj = null
		joint.set_node_b(joint.get_path())

func death():
	print("ded")
	
func interact():
	var detectedint = interactor.get_collider()
	if detectedint != null:
		#var scre = detectedint.get_parent()
		if detectedint.collision_layer == 2 and detectedint.has_method("inter"):
			if detectedint.script != null:
				detectedint.inter()
		elif detectedint.find_child("DialogueBox") != null:
			detectedint.find_child("DialogueBox").start()
			
func hit():
	if interactor.is_colliding() and interactor.get_collider().collision_layer == 2:
		var ho = interactor.get_collider()
		ho.health_comp.hp -= 5
	if interactor.is_colliding():
		hit_spr.global_position = interactor.get_collision_point()
		hit_spr.visible = true
		await get_tree().create_timer(0.1).timeout
		hit_spr.visible = false
	pass
			
