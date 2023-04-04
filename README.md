# Game Design Document

________________________________________
*Created on [[4-1-2023]]*.

*Last Updated on [[4-2-2023]]*.

*Created and Maintained by Jaden Hensley and the Mushroom Team.*
________________________________________

#### Game Summary Pitch.

*Unnamed 2D Magic Game* is a 2D Side-Scroller Fantasy Game involving reality-bending magic alchemy, survival elements, and action-packed combat featuring various weapons and abilities that intertwine with said magic.

## About.

This README-style Game Design Document was created for a game I originally wanted to make for the 12th Pirate Software Game Jam mentioned on https://develop.games/gamejam/

The theme of said game jam is "***Against The Rules***"!

The rest of this document goes over all the details of what I want this future game to be and how it will be made and why it will be made that way.

This Game Design Document was created on the first day of the first week of the game jam. The game jam is 2 weeks long. This document will be updated whenever I need it to be updated. 

This is a game being worked on for the game jam. Afterwards, the game will be a passion project to be worked on until the game is considered playable and enjoyable enough. The game is made under a open source license with a team of passionate developers and artists. For the time being the game is free, but we are open to commercializing the games or making some profit off it be it through selling the game or receiving donations.

## Introduction.

#### Game Summary Pitch.

*Unnamed 2D Magic Game* is a 2D Side-Scroller Fantasy Game involving reality-bending magic alchemy, survival elements, and action-packed combat featuring various weapons and abilities that intertwine with said magic.

#### Interpretation of the Theme.

Our interpretation of the theme is that creating mind-altering, reality-warping consumables would be against the rules of human society.

#### Platform.

The game is currently being developed for:
- Windows OS
- Modern Web Browsers

#### Genre.

The game's genre:
- Singleplayer, Platformer, Survival, Role-Playing-Game, Fantasy

#### Target Audience.

The target demographic of this game is both casual and serious game players alike who enjoy 2D games with fun combat, magic mechanics, survival sandbox mechanics, role playing elements, and boss fights.

#### Planned Gameplay Mechanics and Features. 

I want the core feature of this game to be its gameplay mechanics and features. "Gameplay first" is what I'd call this approach. The game will be a 2D platformer fundamentally but have lots of fun gameplay mechanics. If I don't finish the game within the game jam I will continue working on it as a personal project.

*Here is my "todo list" of gameplay ideas I have in plan to develop.*

- General Gameplay Mechanics and Features:
	- Psychedelic-like Magic
		- Crafting Magical Consumables
			- Fusion (think of SMT/persona)
			- Crafting Inventory (think of Minecraft)
		- Magic Portals
			- Magical Dimensions to be traveled across.
			- Dimensions are Procedurally Generated while others are Hand-Crafted
			- Think of the PlayStation game "LSD Dream Simulator" OR Minecraft dimensions mods
		- Magic Abilities
			- Buff/Enhance the Player
			- Debuff/Nerf the Player
			- Drug up the Player
				- Consumables have unknown side effects. It is encouraged to experiment with them to see what happens.
					- Can open up Magic Portals
				- Trippy Graphical Effects i.e. Shaders will convey a feeling of being under the influence of these magical mysterious consumables you obtain in the game.
					- "Touch Fuzzy, Get Dizzy" from Yoshi's Island.
		- Time Travelling
			- Flow of Time changes when travelling realms.
			- Flow of Time can be used in combat at times.
		- "Dream Simulator"-like
			- Magic Portals
	- Alien Species and Other Mysterious Entities
		- There will be different types of entities throughout the cosmos, dimensions, and universe.
			- Some entities are NPC's you can talk to
			- Other entities are hostile and are fun to fight using the game's combat system.
	- Boss Fights
		- There will be boss fights with certain entities. 
			- Rewards
				- You are rewarded items for fusing and crafting things remniscent of the boss you fought.
					- You can craft enhancements to your weapons or straight out weapons in general.
					- You can unlock certain types of magic
	- Gun Combat
		- You use a gun that has 360 degree rotation around the player and follows the mouse or joystick.
		- Similar controls to:
			- Super Metroid
			- Terraria
			- Enter the Gungeon
	- Additional Combat features
		- Melee Combat
			- Katana
			- Greatsword
		- Throwables
			- Grenades
			- Fireworks / Rockets
		- Magic
			- Each Element
				- Earth
				- Water
				- Air
				- Fire
				- Electricity
				- etc.
	- Survival Elements and Survival Tools
		- Can chop down trees, plants (axe)
			- Using tools you craft
		- Can mine rocks, minerals (pickaxe)
			- Using tools you craft
		- Can build structures
			- Can build houses for resting point (save point) and chests for storage

*Note: not all gameplay mechanics or features will be implemented right away. These take time and effort. Over time I may also decide to scrap some of these ideas altogether.*

#### Game Inspirations.

- *These are inspirations for the game I want to create:*
	- Randy's Arcana/Arcane
	- AdamCYounis's Insignia
	- Kingdom Two Crowns
	- 2D Metroid games
	- Dead Cells
	- Terraria
	- Minecraft
	- Yoshi's Island (Touch fuzzy, get dizzy level)

#### Development Tools Used.

- *Tools I will use for the development of this project:*
	- Game Engine
		- Godot Engine
			- Why?
				- Portable
				- Lightweight
				- Free
				- Open Source
				- Familiar Syntax
				- I've actually used the engine to make a game a few years ago
		- Why?
			- I am not yet productive in lower level tools to be productive. I think for this type of project I'll need a game engine.
	- Game Design Document, Kanban Board, Second Brain
		- Obsidian with Extensions
			- aka Markdown Files
	- Art Production
		- Libresprite
			- Why?
				- Free
				- Open Source
				- Simple to use tool.
				- Fork of Aseprite, what most indie developers use.
				- Pre-compiled version
	- Audio Production
		- Music
			- LMMS
		- Sound Effects
			- JSFXR


## Development Log.

#### (4-3-2023)

(jaden)
- Learned modular code structure for classes (components), resources, and export parameters (editor parameters).
- Made existing code more modular with Components and Resources. (classes)
- Began implementing solid jump physics.
- Implemented a basic jump using the JumpComponent I created with a JumpParametersResource. (jump needs fine-tuned and more polish so game controls fluidly)

(zneeke)
- Created spritesheet for player, enemy entities, tools, and weapons.

(kirro)
- Created spritesheet for ground tileset.

#### (4-2-2023)

(jaden)
- Created Team Mushroom.
- Created the Godot project for the game.
- Created Github repository for the game.
- Added members to the team.
- Got Tile Spawning working.
- Got Randomized Tile Colors working.
- Got 2D Player Movement working. (jump still needed, etc.)

(team)
- Team members started making some sprites.

(kirro)
- Began creating sprites for trees and bushes.

#### (4-1-2023)

(jaden)
- Created the Game Design Document.
- Brainstormed ideas for the game.
- Decided on Gameplay Mechanics and Gameplay Features.
- Installed Godot 4.
- Learned the essential syntax of Godot's gdscript with a tutorial.
- Failing to write my first shader using gdscript and gdshader.
	- Need to learn how to read documentation.



