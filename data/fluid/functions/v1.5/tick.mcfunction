
schedule function fluid:v1.5/tick 1t

scoreboard players add #progress fluid.data 1
execute if score #progress fluid.data matches 20.. run function fluid:v1.5/network/init_queue

execute as @e[type=#fluid:valid_tank_entities,tag=fluid.tank,predicate=fluid:v1.5/equals_queue_progress,predicate=fluid:v1.5/can_send] at @s run function fluid:v1.5/network/process
