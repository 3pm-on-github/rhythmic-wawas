extends Node2D

func wawabeat(bpm):
	var beat_time = 60.0 / bpm
	while true:
		var tween = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		tween.tween_property($Wawa, "size", Vector2(145+50, 192+50), 0.1).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		tween2.tween_property($Wawa, "pivot_offset", Vector2(145+50, 192+50)*0.5, 0.1).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		tween.tween_property($Wawa, "size", Vector2(145, 192), beat_time - 0.1)
		tween2.tween_property($Wawa, 'pivot_offset', Vector2(145, 192)*0.5, beat_time - 0.1)
		await tween.finished

func _ready() -> void:
	$Wawa.pivot_offset = $Wawa.size * 0.5
	$Wawa.position = Vector2(605+300, 51+350)
	$Wawa.scale = Vector2(5, 5)
	$Wawa.visible = true
	$playbtn.visible = false
	$playbtn.position = Vector2(466, 408)
	$AudioStreamPlayer2D.play(1.037)
	wawabeat(180)

func _process(delta: float) -> void:
	pass

var wawastate = false
func _on_wawahitbox_pressed() -> void:
	if not wawastate:
		wawastate = true
		Autorun.playSfx(self, "res://audio/menulogo1.mp3", 4.0)
		var tween = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		tween.tween_property($Wawa, "position", Vector2(273+300, 225+175), 0.25).set_trans(Tween.TRANS_SINE)
		tween2.tween_property($Wawa, "scale", Vector2(3, 3), 0.25).set_trans(Tween.TRANS_SINE)
		await tween.finished
		var tween3 = get_tree().create_tween()
		$playbtn.visible = true
		tween3.tween_property($playbtn, "position", Vector2(825, 412), 0.25).set_trans(Tween.TRANS_SINE)

func _input(ev):
	if ev is InputEventKey and ev.keycode == KEY_ESCAPE and wawastate and not ev.echo:
		wawastate = false
		Autorun.playSfx(self, "res://audio/menulogo2.mp3", 4.0)
		var tween3 = get_tree().create_tween()
		tween3.tween_property($playbtn, "position", Vector2(466, 408), 0.25).set_trans(Tween.TRANS_SINE)
		await tween3.finished
		var tween = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		$playbtn.visible = false
		tween.tween_property($Wawa, "position", Vector2(605+300, 51+350), 0.25).set_trans(Tween.TRANS_SINE)
		tween2.tween_property($Wawa, "scale", Vector2(5, 5), 0.25).set_trans(Tween.TRANS_SINE)

func _on_playbtn_pressed() -> void:
	var tween3 = get_tree().create_tween()
	tween3.tween_property($playbtn, "position", Vector2(466, 408), 0.25).set_trans(Tween.TRANS_SINE)
	await tween3.finished
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	$playbtn.visible = false
	tween.tween_property($Wawa, "position", Vector2(-400, 400), 0.25).set_trans(Tween.TRANS_SINE)
	tween2.tween_property($Wawa, "scale", Vector2(2.5, 2.5), 0.25).set_trans(Tween.TRANS_SINE)
