
scoreboard players add #fluid.major load.status 0
scoreboard players add #fluid.minor load.status 0

execute if score #fluid.major load.status matches ..1 run scoreboard players set #fluid.minor load.status 4
execute if score #fluid.major load.status matches ..0 run scoreboard players set #fluid.major load.status 1
execute if score #fluid.major load.status matches 1 if score #fluid.minor load.status matches ..4 run scoreboard players set #fluid.minor load.status 4
