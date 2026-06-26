extends CharacterBody3D

var point = [Vector3(0.0,0.0,0.0),Vector3(-0.45,0.8,0.2),Vector3(0.05,0.8,0.2),Vector3(0.6,0.8,0.2),Vector3(-0.65,0.8,-0.35),Vector3(-0.15,0.8,-0.35),Vector3(0.35,0.8,-0.35),
			Vector3(0.85,0.8,-0.35)]
var is_up = [false,false,false,false,false,false,false,false]
var up_mogura_pre : int = 0

var is_scanning = false
var barcode_data = ""
var bardata = ""

@onready var barcode1= 1923055028005
@onready var barcode2= 2111111111771
@onready var barcode3= 1923055026001
@onready var barcode4= 4514603444810
@onready var barcode5= 4574603461873
#@onready var barcode5= 4574602461873
@onready var barcode6= 4901351012925
@onready var barcode7= 4901351001721

@onready var barcode8= 4717711111111

var markerpoint : int = 1
var mogura_top = 0.0
var mogura_defaulty = -0.35
var mogura_count = 0
var timer = 90
var mogura_speedratio = 0.5
var last_input_time:int = 0
var TIMEOUT: int = 50

@onready var hanmer = $"."
@onready var forward_button = $"../Button2"
@onready var back_button = $"../Button"
@onready var attack_button = $"../Button3"
@onready var buttonlabel = $Label3D
@onready var hanmeranimation = $AnimationPlayer
@onready var hit = $"../Label"
@onready var Timerset = $"../Timer"
@onready var Timertotal = $"../Timer2"
@onready var mogura_animation_path = $"."
@onready var lesttimer = $"../Label2"

func _ready() -> void:
	hanmer.global_position = point[1]
	Timerset.start()
	Timertotal.start()
	lesttimer.text =str(timer)

func _unhandled_input(event):
	
	if event is InputEventKey and event.pressed:
		var current_time = Time.get_ticks_msec()
		
		if current_time - last_input_time > TIMEOUT and bardata !="":
			bardata = ""
		last_input_time = current_time
	
		if event.phygical_keycode == KEY_ENTER or event.phygical.keycode == KEY_KP_ENTER:
			return
				
		# Enterキーが押された時の処理
		if not is_scanning:
			# 最初に1回だけ手動でEnterを押して開始
			is_scanning = true
			_data_reset()
			#print("--- 連続スキャンモード開始 ---")
		elif is_scanning:
			if event.unicode >0:
				var char_in = char(event.unicode)
				if char_in != "":
					bardata += char_in
				else:
					pass
				if bardata.length() == 13:
					barcode_data = bardata
					bardata = ""
				else:
					pass
		else:
			pass		
	else:
		pass					
		print(barcode_data)

	if barcode_data == str(barcode1):	
		hanmer.global_position = point[1]
		hanmeranimation.play("new_animation")
		markerpoint = 1		
	elif barcode_data == str(barcode2):	
		hanmer.global_position = point[2]
		hanmeranimation.play("new_animation")
		markerpoint = 2		
	elif barcode_data == str(barcode3):	
		hanmer.global_position = point[3]
		hanmeranimation.play("new_animation")
		markerpoint = 3		
	elif barcode_data == str(barcode4):	
		hanmer.global_position = point[4]
		hanmeranimation.play("new_animation")
		markerpoint = 4		
	elif barcode_data == str(barcode5):	
		hanmer.global_position = point[5]
		hanmeranimation.play("new_animation")
		markerpoint = 5		
	elif barcode_data == str(barcode6):	
		hanmer.global_position = point[6]
		hanmeranimation.play("new_animation")
		markerpoint = 6		
	elif barcode_data == str(barcode7):	
		hanmer.global_position = point[7]
		hanmeranimation.play("new_animation")
		markerpoint = 7		
	elif barcode_data == str(barcode8):	
		get_tree().change_scene_to_file("res://start.tscn")

func _physics_process(delta: float) -> void:
	buttonlabel.text = str(markerpoint)
		
	if Input.is_action_just_pressed("selectA"):
		forward()	
	
	if Input.is_action_just_pressed("reset"):
		hanmer.global_position = point[0]	
	
	if Input.is_action_just_pressed("attack"):
		attack()
	
	if Input.is_action_just_pressed("selectZ"):
		back()

	move_and_slide()		

func _on_button_button_down() -> void:
	forward()

func _on_button_2_button_down() -> void:
	back()

func _on_button_3_button_down() -> void:
	attack()	

func forward():
	if markerpoint < 7:
		markerpoint += 1	
	else: markerpoint = 1
	hanmer.global_position = point[markerpoint]	

func back():
	if markerpoint > 1:
		markerpoint -= 1
	else : markerpoint = 7
	hanmer.global_position = point[markerpoint]	
		
func attack():
	hanmeranimation.play("new_animation")

func _on_mogu_1_body_entered(body: Node3D) -> void:
	if body.collision_layer & 1:
		Global.hitpoint += 1
		hit.text = str(Global.hitpoint)
		$"../Path3D1/AnimationPlayer".play("RESET")
		Timerset.stop()
		Timerset.start(1.0)

func _on_mogu_2_body_entered(body: Node3D) -> void:
	if body.collision_layer & 1:
		Global.hitpoint += 1
		hit.text = str(Global.hitpoint)
		$"../Path3D2/AnimationPlayer".play("RESET")
		Timerset.stop()
		Timerset.start(1.0)

func _on_mogu_3_body_entered(body: Node3D) -> void:
	if body.collision_layer & 1:
		Global.hitpoint += 1
		hit.text = str(Global.hitpoint)
		$"../Path3D3/AnimationPlayer".play("RESET")
		Timerset.stop()
		Timerset.start(1.0)

func _on_mogu_4_body_entered(body: Node3D) -> void:
	if body.collision_layer & 1:
		Global.hitpoint += 1
		hit.text = str(Global.hitpoint)
		$"../Path3D4/AnimationPlayer".play("RESET")
		Timerset.stop()
		Timerset.start(1.0)

func _on_mogu_5_body_entered(body: Node3D) -> void:
	if body.collision_layer & 1:
		Global.hitpoint += 1
		hit.text = str(Global.hitpoint)
		$"../Path3D5/AnimationPlayer".play("RESET")
		Timerset.stop()
		Timerset.start(1.0)

func _on_mogu_6_body_entered(body: Node3D) -> void:
	if body.collision_layer & 1:
		Global.hitpoint += 1
		hit.text = str(Global.hitpoint)
		$"../Path3D6/AnimationPlayer".play("RESET")
		Timerset.stop()
		Timerset.start(1.0)

func _on_mogu_7_body_entered(body: Node3D) -> void:
	if body.collision_layer & 1:
		Global.hitpoint += 1
		hit.text = str(Global.hitpoint)
		$"../Path3D7/AnimationPlayer".play("RESET")
		Timerset.stop()
		Timerset.start(1.0)

func random_position():
	var up_mogura = randi_range(1,7)
	
	print(up_mogura)
	
	if is_up[up_mogura] == false:
		if up_mogura == 1:
			$"../Path3D1/AnimationPlayer".play("mogu1")
		elif up_mogura == 2:
			$"../Path3D2/AnimationPlayer".play("mogu2")
		elif up_mogura == 3:
			$"../Path3D3/AnimationPlayer".play("mogu3")
		elif up_mogura == 4:
			$"../Path3D4/AnimationPlayer".play("mogu4")
		elif up_mogura == 5:
			$"../Path3D5/AnimationPlayer".play("mogu5")
		elif up_mogura == 6:
			$"../Path3D6/AnimationPlayer".play("mogu6")
		elif up_mogura == 7:
			$"../Path3D7/AnimationPlayer".play("mogu7")
	
func _on_timer_timeout() -> void:
	pass

func _on_timer_2_timeout() -> void:
	if mogura_count >= 40:
		Timertotal.wait_time = mogura_speedratio
	elif mogura_count >= 30:
		Timertotal.wait_time = mogura_speedratio * 1.5
	elif mogura_count >= 20:
		Timertotal.wait_time = mogura_speedratio * 2.0
	elif mogura_count >= 10:
		Timertotal.wait_time = mogura_speedratio * 3.0
		
	random_position()
	mogura_count += 1
	pass # Replace with function body.

func _on_timer_3_timeout() -> void:
	timer -= 1
	if timer >= 1:
		lesttimer.text =str(timer)
	else:
		get_tree().change_scene_to_file("res://end.tscn")
		pass # Replace with function body.

func _data_reset():
	bardata = ""
	barcode_data = ""	
	pass
