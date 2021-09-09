// This is where you write the powers for the nanogate implant/organ. Keep in mind that the points it use are only regenerated as the beginning of the shift.
/*
The user get a limited pool of points at shift start and has no way of regenerating or getting more points.
He can use those points to either build & upgrade a robot companion similar to a shroomling, upgrade themselves, or mix and match both option.
Each power can only be buyed once.
Opifex have access to a better version with a bigger point pool and more available powers to buy.

Current Robot-Related Powers
- Create Nanobot : Self-explanatory, this allow the user to create & name a nanobot. It is underwhelming at first, but keep in mind it is meant to be upgraded.
- Upgrade Damage : Upgrade the nanobot's lower & upper damage by whatever the 'damage_boost' var is set to (currently 20).
- Upgrade Health : Upgrade the nanobot's both max health and currently health by the 'health_boost' var (200). Doesn't actually heal the bot as any damage it got will still stay. It is just so that upgrading the health doesn't reduce the bot to 50% HP.
- Upgrade Armor : Upgrade the nanobot's armor up to a specified value, unlike the two other upgrade armor, it doesn't add to its initial value, but replace it.
- Enable Self-Repait : This make the nanobot constantly heal itself, with the rate of healing determined by the 'repair_rate' variable (5).
- Enable Radio Mode : Allow the nanobot to recognize the 'Toggle Radio' voice command, which enable or disable the broadcasting of a built-in radio.
- Enable Autodoc Mode : Allow the nanobot to recognize the 'Toggle Autodoc' voice command, which basically turn it into a medibot.
- Enable Food Mode : Opifex-Only, this one allow the nanobot to spawn rations toxic to non-opifex.

Current User-Related Powers
- Regeneration : Give the user a perk that constantly heal himself at a very slow rate defined in the perk itself.
- Speed Booster : Give the user a perk that make him move faster, the speed increase being defined in the perk itself.
- Armor Upgrade : Give the user a perk that reduce damage, again the precise number is defined in the perk given.
- Spawn Knife : Allow the user to create Nanite Knifes at will. The knives disapear once they leave the user's hand.
- Spawn Omnitool : Opifex-only. The same as 'Spawn Knife', except with an omnitool rather than a knife.
- Chemical Injection : Allow the user to choose a type of nanite chem to inject himself, then give him a perk that will do the injection when the user want.

Current Rig-Related Powers
- Install Rig : Spawn a Nanite Rig, defined in nanogate_items.dm, on your back if there isn't anything there.
- Upgrade Rig Storage : Install a Storage Module in the rig.
- Install Laser Cannon : Install a Laser Cannon Module in the rig.
- Install Autodoc : Install an Autodoc Module in the rig.

*/

// Nanobot powers and upgrades.
/obj/item/organ/internal/nanogate/proc/create_nanobot()
	set category = "Nanogate Powers"
	set name = "Create Nanobot (2)"
	set desc = "Spend some of your nanites to create a loyal companion."
	nano_point_cost = 2

	if(!Stand) // Do they already have the bot?
		var/bot_name = input(owner, "Choose your nanobot's name : ", "Nanobot Name", "Nanobot") as null|text
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to creating a nanobot.")
			Stand = new /mob/living/carbon/superior_animal/nanobot(owner.loc)
			Stand.name = bot_name
			Stand.creator += owner
			verbs -= /obj/item/organ/internal/nanogate/proc/create_nanobot
	else
		to_chat(owner, "Your nanogate is already as its limit controlling one Nanobot. Making more would end badly.")

// Boost the nanobot's damage
/obj/item/organ/internal/nanogate/proc/stand_damage()
	set category = "Nanogate Powers"
	set name = "Upgrade Nanobot - Damage (1)"
	set desc = "Spend some of your nanites to upgrade your nanobot."
	nano_point_cost = 1
	var/damage_boost = 20 // How much bonus damage does the nanobot get?

	if(Stand) // Do they have the bot?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to boost your nanobot's damage output.")
			Stand.melee_damage_lower += damage_boost
			Stand.melee_damage_upper += damage_boost
			verbs -= /obj/item/organ/internal/nanogate/proc/stand_damage
	else
		to_chat(owner, "You do not have a nanobot to upgrade!")

// Boost the nanobot's health
/obj/item/organ/internal/nanogate/proc/stand_health()
	set category = "Nanogate Powers"
	set name = "Upgrade Nanobot - Health (1)"
	set desc = "Spend some of your nanites to upgrade your nanobot."
	nano_point_cost = 1
	var/health_boost = 200 // How much bonus health does the nanobot get?

	if(Stand) // Do they have the bot?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to reinforce your nanobot's durability.")
			Stand.health += health_boost
			Stand.maxHealth += health_boost
			verbs -= /obj/item/organ/internal/nanogate/proc/stand_health
	else
		to_chat(owner, "You do not have a nanobot to upgrade!")

// Boost the nanobot's armor
/obj/item/organ/internal/nanogate/proc/stand_armor()
	set category = "Nanogate Powers"
	set name = "Upgrade Nanobot - Armor (1)"
	set desc = "Spend some of your nanites to upgrade your nanobot."
	nano_point_cost = 1
	var/armor_boost = list(melee = 60, bullet = 60, energy = 60, bomb = 75, bio = 100, rad = 100) // How much armor does the nanobot get?

	if(Stand) // Do they have the bot?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to reinforce your nanobot's armor.")
			Stand.armor = armor_boost
			verbs -= /obj/item/organ/internal/nanogate/proc/stand_armor
	else
		to_chat(owner, "You do not have a nanobot to upgrade!")

// Boost the nanobot's armor
/obj/item/organ/internal/nanogate/proc/stand_repair()
	set category = "Nanogate Powers"
	set name = "Upgrade Nanobot - Self-Repair (1)"
	set desc = "Spend some of your nanites to upgrade your nanobot."
	nano_point_cost = 1
	var/repair_rate = 5 // How fast does the nanobot repair itself?

	if(Stand) // Do they have the bot?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to reinforce your nanobot's armor.")
			Stand.repair_rate += repair_rate
			verbs -= /obj/item/organ/internal/nanogate/proc/stand_repair
	else
		to_chat(owner, "You do not have a nanobot to upgrade!")

// Powers that activate various modes for the bot.
/obj/item/organ/internal/nanogate/proc/autodoc_mode()
	set category = "Nanogate Powers"
	set name = "Activate Nanobot Protocol - Autodoc (1)"
	set desc = "Spend some of your nanites to activate a protocol in your bot.."
	nano_point_cost = 1

	if(Stand) // Do they have the bot?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to activate a mode in your bot.")
			Stand.ai_flag |= AUTODOC_MODE
			verbs -= /obj/item/organ/internal/nanogate/proc/autodoc_mode
	else
		to_chat(owner, "You do not have a nanobot to upgrade!")

/obj/item/organ/internal/nanogate/proc/radio_mode()
	set category = "Nanogate Powers"
	set name = "Activate Nanobot Protocol - Radio (1)"
	set desc = "Spend some of your nanites to activate a protocol in your bot."
	nano_point_cost = 1

	if(Stand) // Do they have the bot?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to activate a mode in your bot.")
			Stand.ai_flag |= RADIO_MODE
			verbs -= /obj/item/organ/internal/nanogate/proc/radio_mode
	else
		to_chat(owner, "You do not have a nanobot to upgrade!")

/obj/item/organ/internal/nanogate/proc/console_mode()
	set category = "Nanogate Powers"
	set name = "Activate Nanobot Protocol - Console (1)"
	set desc = "Spend some of your nanites to activate a protocol in your bot."
	nano_point_cost = 1

	if(Stand) // Do they have the bot?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to activate a mode in your bot.")
			Stand.ai_flag |= CONSOLE_MODE
			verbs -= /obj/item/organ/internal/nanogate/proc/console_mode
	else
		to_chat(owner, "You do not have a nanobot to upgrade!")

/obj/item/organ/internal/nanogate/proc/food_mode()
	set category = "Nanogate Powers"
	set name = "Activate Nanobot Protocol - Food (1)"
	set desc = "Spend some of your nanites to activate a protocol in your bot."
	nano_point_cost = 1

	if(Stand) // Do they have the bot?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to activate a mode in your bot.")
			Stand.ai_flag |= FOOD_MODE
			verbs -= /obj/item/organ/internal/nanogate/proc/food_mode
	else
		to_chat(owner, "You do not have a nanobot to upgrade!")

/obj/item/organ/internal/nanogate/proc/control_bot()
	set category = "Nanogate Powers"
	set name = "Activate Nanobot Remote Control (1)"
	set desc = "Spend some of your nanites to remotely control your nanobot at will."
	nano_point_cost = 1

	if(Stand) // Do they have the bot?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to create a remote control setup in your bot.")
			verbs -= /obj/item/organ/internal/nanogate/proc/control_bot
			verbs += /obj/item/organ/internal/nanogate/proc/control
	else
		to_chat(owner, "You do not have a nanobot to upgrade!")

/obj/item/organ/internal/nanogate/proc/control()
	set category = "Nanogate Powers"
	set name = "Remote Control"
	set desc = "Remotely control your nanobot. Don't die while controlling it though!"
	nano_point_cost = 0

	if(Stand) // Do they have the bot?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You remotely control your bot.")
			Stand.controller = owner
			owner.mind.transfer_to(Stand)
	else
		to_chat(owner, "You do not have a nanobot to control!")

// Personnal powers
/obj/item/organ/internal/nanogate/proc/nanite_regen()
	set category = "Nanogate Powers"
	set name = "Nanite Regeneration (1)"
	set desc = "Spend some of your nanites to constantly repair your body."
	nano_point_cost = 1

	if(!owner.stats.getPerk(PERK_NANITE_REGEN)) // Do they already have the bot?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to repairing your body.")
			owner.stats.addPerk(PERK_NANITE_REGEN)
			verbs -= /obj/item/organ/internal/nanogate/proc/nanite_regen
	else
		to_chat(owner, "Assigning more nanites to repairing your body wouldn't give you a boost in regeneration rate.")

// Personnal Augment Powers.
/obj/item/organ/internal/nanogate/proc/nanite_muscle()
	set category = "Nanogate Powers"
	set name = "Nanite Augment - Muscle (1)"
	set desc = "Spend some of your nanites to create nanites muscle to allow you to walk faster."
	nano_point_cost = 2 // Install two augments on both legs

	if(!owner.stats.getPerk(PERK_NANITE_MUSCLE)) // Do they already have the perk?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to repairing your body.")
			owner.stats.addPerk(PERK_NANITE_MUSCLE)
			verbs -= /obj/item/organ/internal/nanogate/proc/nanite_muscle
	else
		to_chat(owner, "Assigning more nanites to repairing your body wouldn't give you a boost in regeneration rate.")

/obj/item/organ/internal/nanogate/proc/nanite_armor()
	set category = "Nanogate Powers"
	set name = "Nanite Augment - Armor (1)"
	set desc = "Spend some of your nanites to create nanite armor to protect your body."
	nano_point_cost = 1

	if(!owner.stats.getPerk(PERK_NANITE_ARMOR)) // Do they already have the perk?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to repairing your body.")
			owner.stats.addPerk(PERK_NANITE_ARMOR)
			verbs -= /obj/item/organ/internal/nanogate/proc/nanite_armor
	else
		to_chat(owner, "Assigning more nanites to repairing your body wouldn't give you a boost in regeneration rate.")

/obj/item/organ/internal/nanogate/proc/nanite_blade()
	set category = "Nanogate Powers"
	set name = "Nanite Augment - Blade (1)"
	set desc = "Spend some of your nanites to create nanites blades to harm your foes."
	nano_point_cost = 1

	if(!owner.stats.getPerk(PERK_NANITE_KNIFE)) // Do they already have the perk?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to repairing your body.")
			owner.stats.addPerk(PERK_NANITE_KNIFE)
			verbs -= /obj/item/organ/internal/nanogate/proc/nanite_blade
	else
		to_chat(owner, "Assigning more nanites to repairing your body wouldn't give you a boost in regeneration rate.")

/obj/item/organ/internal/nanogate/proc/nanite_tool()
	set category = "Nanogate Powers"
	set name = "Nanite Augment - Omnitool (1)"
	set desc = "Spend some of your nanites to create nanites blades to harm your foes."
	nano_point_cost = 1

	if(!owner.stats.getPerk(PERK_NANITE_TOOL)) // Do they already have the perk?
		if(pay_power_cost(nano_point_cost))
			to_chat(owner, "You permanently assign some of your nanites to repairing your body.")
			owner.stats.addPerk(PERK_NANITE_TOOL)
			verbs -= /obj/item/organ/internal/nanogate/proc/nanite_tool
	else
		to_chat(owner, "Assigning more nanites to repairing your body wouldn't give you a boost in regeneration rate.")

/obj/item/organ/internal/nanogate/proc/nanite_chem()
	set category = "Nanogate Powers"
	set name = "Nanite Augment - Chemical (1)"
	set desc = "Convert some of your nanites into more specialized nanites."
	nano_point_cost = 1

	var/list/choices_perk = typesof(PERK_NANITE_CHEM)
	choices_perk -= PERK_NANITE_CHEM

	var/datum/perk/nanite_chem/choice = input(owner, "Which nanite chem do you want?", "Chem Choice", null) as null|anything in choices_perk

	if(choice && pay_power_cost(nano_point_cost)) // Check if the user actually made a choice, and if they did, check if they have the points.
		owner.stats.addPerk(choice)
		to_chat(owner, "You permanently convert some of your nanites into specialized variants.")
		verbs -= /obj/item/organ/internal/nanogate/proc/nanite_tool

// RIG-related powers
/obj/item/organ/internal/nanogate/proc/nanite_rig()
	set category = "Nanogate Powers"
	set name = "Nanite Rigsuit - Installation (3)"
	set desc = "Convert some of your nanites into a permanent rigsuit attached to your spine."
	nano_point_cost = 3

	if(!nanite_rig)
		nanite_rig = new /obj/item/rig/nanite(src)
		nanite_rig.seal_delay = 0 // No delay to put it on because nanites, and moving while putting it one make it disapear

	if(owner.can_equip(nanite_rig, slot_back, disable_warning = FALSE, skip_item_check = FALSE, skip_covering_check = TRUE))
		if(pay_power_cost(nano_point_cost))
			owner.visible_message("[owner.name]'s back erupt in a black goo that quickly transform into a rig.",
									"Your spine hurt like hell as it expand into a rigsuit.")
			owner.replace_in_slot(nanite_rig, slot_back, skip_covering_check = TRUE)
			nanite_rig.seal_delay = initial(nanite_rig.seal_delay) // resetting the seal delay
			verbs -= /obj/item/organ/internal/nanogate/proc/nanite_rig

/obj/item/organ/internal/nanogate/proc/nanite_rig_storage()
	set category = "Nanogate Powers"
	set name = "Nanite Rigsuit - Storage Upgrade (1)"
	set desc = "Use some of your nanites to create a storage compartment into your nanite rigsuit."
	nano_point_cost = 1

	if(!nanite_rig)
		to_chat(owner, "You need a rig to use this power you idiot.")
		return

	if(pay_power_cost(nano_point_cost))
		nanite_rig.install(new /obj/item/rig_module/storage)
		to_chat(owner, "Your spine hurt as the nanites start to work on making a storage module.")
		verbs -= /obj/item/organ/internal/nanogate/proc/nanite_rig_storage

/obj/item/organ/internal/nanogate/proc/nanite_rig_laser()
	set category = "Nanogate Powers"
	set name = "Nanite Rigsuit - Laser Upgrade (1)"
	set desc = "Use some of your nanites to create a mounted laser gun on your rigsuit."
	nano_point_cost = 1

	if(!nanite_rig)
		to_chat(owner, "You need a rig to use this power you idiot.")
		return

	if(pay_power_cost(nano_point_cost))
		nanite_rig.install(new /obj/item/rig_module/mounted)
		to_chat(owner, "Your spine hurt as the nanites start to work on making a laser canon.")
		verbs -= /obj/item/organ/internal/nanogate/proc/nanite_rig_laser

/obj/item/organ/internal/nanogate/proc/nanite_rig_autodoc()
	set category = "Nanogate Powers"
	set name = "Nanite Rigsuit - Autodoc Upgrade (1)"
	set desc = "Use some of your nanites to create a surgery module inside your hardsuit."
	nano_point_cost = 1

	if(!nanite_rig)
		to_chat(owner, "You need a rig to use this power you idiot.")
		return

	if(pay_power_cost(nano_point_cost))

		// Creating it early because we need to manually initialize some stuff
		var/obj/item/rig_module/autodoc/autodoc_module = new /obj/item/rig_module/autodoc(src)
		autodoc_module.Initialize()

		nanite_rig.install(autodoc_module)
		to_chat(owner, "Your spine hurt as the nanites start to work on making an autodoc module.")
		verbs -= /obj/item/organ/internal/nanogate/proc/nanite_rig_autodoc