extends Node2D

func _ready() -> void:
	Autorun.rpc_state("in the tutorial")
	$blackbg.visible = true
	$blackbg.modulate.a = 1.0
	$Wawa.position = Vector2(674, -200)
	$Wawa.visible = true
	$ScoreScreenshot.position = Vector2(674, -200)
	$ScoreScreenshot.visible = true
	$pendingWawa.visible = false
	$Rxejub.position = Vector2(1555, 1400)
	$RxejubTable.position = Vector2(2200, 916)
	$dialogbox.modulate.a = 0
	$AudioStreamPlayer2D.play()
	for i in range(25):
		$blackbg.modulate.a -= 0.04
		await get_tree().create_timer(0.01).timeout
	$blackbg.visible = false
	var tween = get_tree().create_tween()
	tween.tween_property($RxejubTable, "position", Vector2(1544, 916), 0.5).set_trans(Tween.TRANS_SINE)
	tween.tween_property($Rxejub, "position", Vector2(1555, 443), 0.5).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($Rxejub, "position", Vector2(1555, 643), 0.25).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	await get_tree().create_timer(0.5).timeout
	Autorun.playSfx(self, "res://audio/jump.wav")
	await get_tree().create_timer(0.75).timeout
	Autorun.playSfx(self, "res://audio/hammer.wav")
	var tween2 = get_tree().create_tween()
	tween2.tween_property($dialogbox, "modulate:a", 1.0, 0.15)
	for i in range(10):
		$Rxejub.position.x = 1555 + randi_range(-25, 25)
		$Rxejub.position.y = 643 + randi_range(-25, 25)
		$Rxejub.rotation_degrees = randf_range(-10.0, 10.0)
		await get_tree().create_timer(0.015).timeout
	$Rxejub.position = Vector2(1555, 643)
	$Rxejub.rotation_degrees = 0
	if Autorun.tutorialDialog == 0:
		dialog1()
	else:
		dialog2()

func dialog1():
	await dialog("Hi there!££ I'm RXEJUB.££ I'll be your guide to this tutorial on how to play\nRhythmic Wawas.")
	await get_tree().create_timer(0.5).timeout
	await dialog("Rhythmic Wawas is a rhythm game where you click wawas\nto the beat.")
	await get_tree().create_timer(0.5).timeout
	await dialog("Let's start off with the main character:")
	await get_tree().create_timer(0.5).timeout
	
	Autorun.playSfx(self, "res://audio/select.mp3")
	var tween = get_tree().create_tween()
	tween.tween_property($Wawa, "position", Vector2(674, 390), 1.0).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	
	await get_tree().create_timer(1.0).timeout
	await dialog("The wawa.")
	await get_tree().create_timer(0.5).timeout
	
	$Wawa.visible = false
	$pendingWawa.visible = true
	
	await dialog("At first, wawas come in a \"pending\" form,\nwaiting for the final wawa to be in place.")
	await get_tree().create_timer(0.5).timeout
	
	$Wawa.position = Vector2(674, -200)
	$Wawa.visible = true
	var tween2 = get_tree().create_tween()
	tween2.tween_property($Wawa, "position", Vector2(674, 390), 3.7)
	
	await dialog("Then the wawa comes down, and the moment\nit's in the same position as the pending wawa..")
	await get_tree().create_timer(0.5).timeout
	$dialogbox.visible = false
	await get_tree().create_timer(0.5).timeout
	
	$pendingWawa.visible = false
	Autorun.playSfx(self, "res://audio/clickfast.ogg")
	Autorun.playSfx(self, "res://audio/ow.wav")
	var img := Image.new()
	img = load("res://images/evilWawa.png").get_image()
	$Wawa.texture = ImageTexture.create_from_image(img)
	var tween3 = get_tree().create_tween()
	tween3.tween_property($Wawa, "scale", Vector2(2, 0.25), 0.25).set_trans(Tween.TRANS_SINE)
	
	await get_tree().create_timer(1.0).timeout
	$dialogbox.visible = true
	await dialog("..we click the wawa.")
	await get_tree().create_timer(0.5).timeout
	await dialog("Pretty simple, huh?££\nNow how about you try this stage.")
	await get_tree().create_timer(1.0).timeout
	$blackbg.visible = true
	for i in range(25):
		$blackbg.modulate.a += 0.04
		$AudioStreamPlayer2D.volume_db -= 1
		await get_tree().create_timer(0.04).timeout
	$AudioStreamPlayer2D.stop()
	get_tree().change_scene_to_file("res://scenes/tutorialstage.tscn")

func dialog2():
	Autorun.tutorialDialog = 0
	await dialog("How was it?£££ Did you have fun?")
	await get_tree().create_timer(0.75).timeout
	await dialog("Was it hard?£££ Don't worry, that's normal for a new player.")
	await get_tree().create_timer(0.5).timeout
	await dialog("Anyways, Did you notice this number in the top right?")
	await get_tree().create_timer(0.5).timeout
	
	Autorun.playSfx(self, "res://audio/select.mp3")
	var tween = get_tree().create_tween()
	tween.tween_property($ScoreScreenshot, "position", Vector2(649, 419), 1.0).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	
	await get_tree().create_timer(1.0).timeout
	await dialog("That's your score. It keeps track of how many wawas you clicked.")
	await get_tree().create_timer(0.5).timeout
	await dialog("It starts at 0, and if you click every wawa, you will get\na score of 1000000, which is the maximum.")
	await get_tree().create_timer(1.0).timeout
	await dialog("Anyways, That's pretty much all you need to know.")
	await get_tree().create_timer(0.5).timeout
	await dialog("Have fun playing Rhythmic Wawas!")
	await get_tree().create_timer(1.0).timeout
	$blackbg.visible = true
	for i in range(25):
		$blackbg.modulate.a += 0.04
		$AudioStreamPlayer2D.volume_db -= 1
		await get_tree().create_timer(0.04).timeout
	$AudioStreamPlayer2D.stop()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _process(_delta: float) -> void:
	pass

func dialog(text: String) -> void:
	$dialogbox/text.text = ""
	for character in text:
		if character == "£": # wonderful wait symbol
			await get_tree().create_timer(0.25).timeout
		else:
			$dialogbox/text.text += character
			$AudioStreamPlayer2D3.play()
			await get_tree().create_timer(0.025).timeout
