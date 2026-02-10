# AI Survivors

My son was in a school tech fair, where he made a Vampire Survivors clone in [Scratch](https://scratch.mit.edu/) called "AI Survivors".

The deeper he got into development, the more he wanted to do (which was difficult in Scratch). So we're working on making it using a "real game engine."

I'll try my best to document our progress on the project.

## Updates

### Feb 9, 2026
Got the weapons stuff in place for the most part. Starting to doubt my
file names and folder structures, but I'll get to that later.

For Weapons, I'm following the same set up for Enemies. We have a "Data"
resource that will drive the behavior of the Weapon.

I quickly realized that 'weapons' are mostly projectiles.

Once I realized that we're just launching projectiles on a timer, it
made things a little easier to grasp.

I also got the enemies taking damage from the projectiles. They flash a
little, too.

Lots of good plumbing in place. Still want to do a few more things with
Weapons and tidying up the folder structure.

### Feb 2, 2026
Got most of the systems in place. I played around with Godot a while ago, but didn't retain any of it. So I've been relearning. It's... fine.

I've never really felt comfortable in these game dev IDEs. Too much clicking around, dragging, dropping, etc.

I like things to just be where "they're supposed to be." Which is what I set up in tonight's work.

I have a few important systems in place so far. We have a the 'base' scenes for Player, Enemy, Weapon, and Projectile. Enemy, Weapon, and Projectile are all defined by [Resources](https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html)

Each Resource defines all the properties we want to define for the thing.

e.g. Zombie is an Enemy. Zombie has a base health of 10, speed of 100.

That information is easily defined as an EnemyData resource.

...but I want to define the look of the enemy: the animation, the hitbox, etc

So each Enemy also has a Scene.

Might as well assume the EnemyData's name will correspond to a Scene with the same name.

Now, when defining a new enemy, we create a EnenmyData Resource in `/Resources/Enemies/` and a New Inherited Scene from `/Scenes/Enemies/Enemy.tscn`. The `EnemyData.gd` script handles this by dynamically loading the scene based on the Resource filename.

There's also a fallback to the base `Enemy.tscn` if there is not a matching scene for the Resource.

Going to use this same pattern for Weapons, Players, Stages (whenever we get there...). I tried it out to add a new enemy. It was quick an easy. (I added a worm. It wiggles. Learned how to use the sprite slicer and animate.)

I also feel that I have a better understanding of Godot than I did a week ago.

We have the enemy spawner working (which is also Wave-based where we define Waves and which enemies should appear at which times.). We have weapons mostly working. We still need weapon projectiles to interact with the enemies and take damage (the code is there, but haven't gotten to testing that yet).

Learned a lot of fundamentals and getting a good foundation in place for this.
