
scoreboard players set #progress energy.data 0
scoreboard players set #position energy.data 0
execute as @e[type=#fluid:valid_tank_entities,tag=fluid.tank,predicate=fluid:v1.0/can_send] run function fluid:v1.0/network/add_to_queue

