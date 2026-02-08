Scriptname SLTTTMAPI

Function setExpression(Actor act, string type, string category, int id, int strong) global
	if(type == "mfg")
		if(category == "e")
			act.SetExpressionOverride(id, strong)
		endif
		if(category == "m")
			MfgConsoleFunc.SetModifier(act, id, strong)
		endif
		if(category == "p")
			MfgConsoleFunc.SetPhoneme(act, id, strong)
		endif
	endif
EndFunction

Function setFaceExpression(Actor act, int normalIndex, int ahegaoIndex) global
	GlobalVariable SLTTTMAhegaoMale = Game.GetFormFromFile(0x000805, "SLTooTiredToMove.esp") as GlobalVariable
	GlobalVariable SLTTTMAhegaoFemale = Game.GetFormFromFile(0x000834, "SLTooTiredToMove.esp") as GlobalVariable
	GlobalVariable SLTTTMAhegaoPlayer = Game.GetFormFromFile(0x000835, "SLTooTiredToMove.esp") as GlobalVariable

	if(act == game.getPlayer())
		if(SLTTTMAhegaoPlayer.getValue() == 1)
			SLTTTMCoreData.setAhegaoExpression(act, ahegaoIndex)
		else
			SLTTTMCoreData.setNormalExpression(act, normalIndex)
		endif
	else
		if((SLTTTMAhegaoMale.getValue() == 1 && isFemale(act) == false) || (SLTTTMAhegaoFemale.getValue() == 1 && isFemale(act) == true))
			SLTTTMCoreData.setAhegaoExpression(act, ahegaoIndex)
		else
			SLTTTMCoreData.setNormalExpression(act, normalIndex)
		endif
	endif
endFunction

Function clearExpression(Actor act) global
	act.ClearExpressionOverride()
	MfgConsoleFunc.ResetPhonemeModifier(act)
	showTongue(act, false)
EndFunction


Function handlePose(Actor act, Armor[] armorsForActor, Weapon weaponRightHand, Weapon weaponLeftHand) global
	if (act == Game.GetPlayer())
		Game.ForceThirdPerson()
	endif
	act.SetAnimationVariableBool("bHumanoidFootIKDisable", true)
	SLTTTMCoreData.runPose(act)

	int i = 0
	while i < armorsForActor.length
		if(!act.IsEquipped(armorsForActor[i]))
			act.EquipItem(armorsForActor[i], false, true)
		endif
		i+=1
	endWhile
	if(weaponLeftHand)
		act.EquipItem(weaponLeftHand, false, true)
	endif
	if(weaponRightHand)
		act.EquipItem(weaponRightHand, false, true)
	endif
endFunction

bool Function isFemale(Actor act) global
	if(act.GetLeveledActorBase().getSex() == 1 || act.GetActorBase().getSex() == 1)
			return true
	endif
	return false
EndFunction

Function showTongue(Actor act, bool enable) global
	bool isHalosTonguesInstalled = Game.GetModByName("Tongues.esp") != 255
	if(isHalosTonguesInstalled)	
		Armor[] tongues = new Armor[10]
		tongues[0] = Game.GetFormFromFile(0x000D6C, "Tongues.esp") as Armor
		tongues[1] = Game.GetFormFromFile(0x000D6D, "Tongues.esp") as Armor
		tongues[2] = Game.GetFormFromFile(0x000D6E, "Tongues.esp") as Armor
		tongues[3] = Game.GetFormFromFile(0x000D6F, "Tongues.esp") as Armor
		tongues[4] = Game.GetFormFromFile(0x000D70, "Tongues.esp") as Armor
		tongues[5] = Game.GetFormFromFile(0x000D71, "Tongues.esp") as Armor
		tongues[6] = Game.GetFormFromFile(0x000D72, "Tongues.esp") as Armor
		tongues[7] = Game.GetFormFromFile(0x000D73, "Tongues.esp") as Armor
		tongues[8] = Game.GetFormFromFile(0x000D74, "Tongues.esp") as Armor
		tongues[9] = Game.GetFormFromFile(0x000D75, "Tongues.esp") as Armor

		if(enable)
			GlobalVariable SLTTTMTongArgonian = Game.GetFormFromFile(0x000810, "SLTooTiredToMove.esp") as GlobalVariable	
			GlobalVariable SLTTTMTongBreton = Game.GetFormFromFile(0x000811, "SLTooTiredToMove.esp") as GlobalVariable	
			GlobalVariable SLTTTMTongDarkElf = Game.GetFormFromFile(0x000812, "SLTooTiredToMove.esp") as GlobalVariable	
			GlobalVariable SLTTTMTongHighElf = Game.GetFormFromFile(0x000813, "SLTooTiredToMove.esp") as GlobalVariable	
			GlobalVariable SLTTTMTongImperial = Game.GetFormFromFile(0x000814, "SLTooTiredToMove.esp") as GlobalVariable	
			GlobalVariable SLTTTMTongKhajiit = Game.GetFormFromFile(0x000815, "SLTooTiredToMove.esp") as GlobalVariable	
			GlobalVariable SLTTTMTongNord = Game.GetFormFromFile(0x000816, "SLTooTiredToMove.esp") as GlobalVariable	
			GlobalVariable SLTTTMTongOrc = Game.GetFormFromFile(0x000817, "SLTooTiredToMove.esp") as GlobalVariable	
			GlobalVariable SLTTTMTongRedguard = Game.GetFormFromFile(0x000818, "SLTooTiredToMove.esp") as GlobalVariable	
			GlobalVariable SLTTTMTongWoodElf = Game.GetFormFromFile(0x000819, "SLTooTiredToMove.esp") as GlobalVariable	
			GlobalVariable SLTTTMTongDefault = Game.GetFormFromFile(0x00081A, "SLTooTiredToMove.esp") as GlobalVariable	
			
			string actorRace = act.getRace().getName()
			if(actorRace == "Argonian")
				act.EquipItem(tongues[SLTTTMTongArgonian.getValue() as int], false, true)
			elseif (actorRace == "Breton")
				act.EquipItem(tongues[SLTTTMTongBreton.getValue() as int], false, true)
			elseif (actorRace == "Dark Elf")
				act.EquipItem(tongues[SLTTTMTongDarkElf.getValue() as int], false, true)
			elseif (actorRace == "High Elf")
				act.EquipItem(tongues[SLTTTMTongHighElf.getValue() as int], false, true)
			elseif (actorRace == "Imperial")
				act.EquipItem(tongues[SLTTTMTongImperial.getValue() as int], false, true)
			elseif (actorRace == "Khajiit")
				act.EquipItem(tongues[SLTTTMTongKhajiit.getValue() as int], false, true)
			elseif (actorRace == "Nord")
				act.EquipItem(tongues[SLTTTMTongNord.getValue() as int], false, true)
			elseif (actorRace == "Orc")
				act.EquipItem(tongues[SLTTTMTongOrc.getValue() as int], false, true)
			elseif (actorRace == "Redguard")
				act.EquipItem(tongues[SLTTTMTongRedguard.getValue() as int], false, true)
			elseif (actorRace == "Wood Elf")
				act.EquipItem(tongues[SLTTTMTongWoodElf.getValue() as int], false, true)
			else
				act.EquipItem(tongues[SLTTTMTongDefault.getValue() as int], false, true)
			endif
		else
			int j = 0
			while j < tongues.Length
				act.RemoveItem(tongues[j], 99, true)
				j += 1
			endwhile
		endif
	endif
EndFunction