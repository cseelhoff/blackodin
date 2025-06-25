# class_name Game
extends Node3D

@export var mobs: Array[Creature]
@export var players: Array[Creature]
@export var main: Node3D
@export var blood_emitter_pool: BloodEmitterPool
@export var camera: Camera3D
var zombie_scene = load("res://creatures/scourgemale_hd/scene.tscn")
var max_mob_count = 1
var dead_mobs_count = 0
# var humanmale_hd_scene := preload("res://creatures/humanmale_hd/scene.tscn")
func _ready() -> void:
    main = get_parent()
    players.clear()
    mobs.clear()

    for child in get_children():
        if child is not Creature:
            continue
        if child.is_mob:
            mobs.append(child)
        else:
            players.append(child)

    refresh_wave()

func on_player_died(creature: Creature) -> void:
    players.erase(creature)
    creature.queue_free()
    if players.size() == 0:
        print("Game Over")

func on_mob_died() -> void:
    dead_mobs_count += 1
    if dead_mobs_count >= mobs.size():
        for mob in mobs:
            mob.queue_free()
        mobs.clear()
        dead_mobs_count = 0
        max_mob_count *= 2
        refresh_wave()

func refresh_wave() -> void:
    for i in range(max_mob_count):
        add_mob()

func add_mob() -> void:
    var mob = zombie_scene.instantiate()
    # set random position
    mob.transform.origin = Vector3(randf() * 16 - 8, 0, randf() * 16 - 8)
    mobs.append(mob)
    main.add_child.call_deferred(mob)

func update_camera():
    if players.size() == 0:
        return
    
    var min_x = players[0].ragdoll.root_bone.global_position.x
    var max_x = players[0].ragdoll.root_bone.global_position.x
    var min_z = players[0].ragdoll.root_bone.global_position.z
    var max_z = players[0].ragdoll.root_bone.global_position.z
    
    for player in players:
        min_x = min(min_x, player.ragdoll.root_bone.global_position.x)
        max_x = max(max_x, player.ragdoll.root_bone.global_position.x)
        min_z = min(min_z, player.ragdoll.root_bone.global_position.z)
        max_z = max(max_z, player.ragdoll.root_bone.global_position.z)
    
    var center_x = (min_x + max_x) / 2.0
    var center_z = (min_z + max_z) / 2.0
    var width = max_x - min_x
    var height = max_z - min_z
    var size = max(max(width, height) +5, 10.0)  # Add 20% padding
    
    camera.transform.origin = Vector3(center_x, 30.0, center_z+ 29)
    camera.size = size * 1  # Adjust based on your scene scale

func _physics_process(_delta: float) -> void:
    #update_camera()
    # var total_x: float = 0
    # var total_z: float = 0
    # for player in players:
    #     total_x += player.ragdoll.root_bone.global_position.x
    #     total_z += player.ragdoll.root_bone.global_position.z
    # total_x /= players.size()
    # total_z /= players.size()
    # camera.transform.origin = Vector3(total_x, 6.0, total_z+5)
    pass
