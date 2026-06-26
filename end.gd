extends Control

var is_scanning = false
var barcode_data = ""
var bardata = ""
var last_input_time:int = 0
var TIMEOUT: int = 50

@onready var barcode8= 4717711111111

func _ready() -> void:
	$Label2.text = str(Global.hitpoint)
	pass
	
func _unhandled_input(event):
	
	if event is InputEventKey and event.pressed:
		var current_time = Time.get_ticks_msec()
		
		if current_time - last_input_time > TIMEOUT and bardata !="":
			bardata = ""
		last_input_time = current_time
		
		if event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER:
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
		print(barcode_data)

	if barcode_data == str(barcode8):	
		_reset()

func _data_reset():
	bardata = ""
	barcode_data = ""	
	pass

func _on_button_button_down() -> void:
	_reset()
	pass # Replace with function body.

func _reset():
	get_tree().change_scene_to_file("res://start.tscn")
