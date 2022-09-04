extends Node2D

var power := 200
var angle := 0.0
var rotationSpeed := 0.1
var clockwise := false
var _launched := false
var powerChangeRate := 1
export var maxPower := 500
export var minPower := 100

func rotate_counterclockwise():
	angle += rotationSpeed
	if angle >= 89.9:
		clockwise = true

func rotate_clockwise():
	angle -= rotationSpeed
	if angle <= 0.0:
		clockwise = false

func adjustAngle():
	if clockwise:
		rotate_clockwise()
	else:
		rotate_counterclockwise()
	


func _process(_delta):
	
	if not _launched:
		$PowerMeter.value = -power
		if Input.is_action_pressed("adjustPower") && power <= maxPower:
			power += powerChangeRate
		elif power > minPower:
			power -= powerChangeRate
		
		if Input.is_action_just_pressed("launch"):
			var impulse := Vector2(power,0).rotated(deg2rad(-angle))
			$LauncherSprite/Projectile.gravity_scale = 1
			$LauncherSprite/Projectile.apply_impulse(Vector2.ZERO, impulse )
			_launched = true
			$PowerMeter.value = -minPower
		adjustAngle()
		$LauncherSprite.rotation = deg2rad(-angle)
	
	
