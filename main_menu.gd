extends Control


func _on_quit_pressed() -> void:
	get_tree().quit()



func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://options_menu.tscn")



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://subject_menu.tscn")


func _on_back_2_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
