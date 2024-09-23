# EF
## Enemies Framework!

add "ef" to your umg_mod,json "uses"
to define an enemy, act as if its a lp.defineItem but use ef.defineEnemy
inside, add ai = ef.ai.nothing, though this does nothing, other types of AI are, ef.ai.support and ef.ai.attackthough remember, to use ai.support or ai.attack you need to have targets
for targets, its recommended to make it bad for the player, such as destroy item (you can see examples from the slime enemy)
if you want to trigger other enemies, use the trigger "ENEMY_PULSE" (you can see examples from the activator enemy)
you can see examples of how to use the ef in the efxample too!

if you have any suggestion/feedback, feel free to send them at the forum in UMG's Discord