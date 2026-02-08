Scriptname SLTTTMRun extends Quest  

GlobalVariable Property SLTTTMEnable  Auto  
GlobalVariable Property SLTTTMFemale  Auto  
GlobalVariable Property SLTTTMMale  Auto  
GlobalVariable Property SLTTTMPlayer  Auto  
GlobalVariable Property SLTTTMTiredTime  Auto  
GlobalVariable Property SLTTTMPosition  Auto  
GlobalVariable Property SLTTTMClimaxNum  Auto
Faction Property SLTTTMFaction  Auto

SexLabFramework Sexlab

Event OnInit()
	Sexlab = Game.GetFormFromFile(0xD62, "SexLab.esm") as SexLabFramework
	RegisterForModEvent("SexLabOrgasmSeparate", "SLTTTMActorOrgasm")
EndEvent

function SLTTTMActorOrgasm(Form ActorRef, Int Thread)
	actor OrgasmedActor = ActorRef as actor
	string argString = Thread as string
	if(SLTTTMEnable.getValue() == 1 && OrgasmedActor.IsInFaction(SLTTTMFaction) && checkGender(OrgasmedActor) != -1)
		int actorClimaxTime = OrgasmedActor.GetFactionRank(SLTTTMFaction)
		OrgasmedActor.SetFactionRank(SLTTTMFaction, actorClimaxTime + 1)
	endif
	if(SLTTTMEnable.getValue() == 1 && !OrgasmedActor.IsInFaction(SLTTTMFaction) && checkGender(OrgasmedActor) != -1)
		Armor[] armorsForActor = new Armor[50]
		int armorsForActorLength = getArmorEquip(OrgasmedActor, armorsForActor)

		int armorsArrayPointer = JArray.objectWithForms(convertArmorToFormArray(armorsForActor, armorsForActorLength))
		JDB.solveObjSetter(".daubuoiSLTTTMDatabase."+OrgasmedActor.GetFormID() as string+".armor", armorsArrayPointer, true)

		OrgasmedActor.SetFactionRank(SLTTTMFaction, 1)
		float pX = OrgasmedActor.GetPositionX()
		float pY = OrgasmedActor.GetPositionY()
		float pZ = OrgasmedActor.GetPositionZ()

		JDB.solveFltSetter(".daubuoiSLTTTMDatabase."+OrgasmedActor.GetFormID() as string+".pX", pX, true)
		JDB.solveFltSetter(".daubuoiSLTTTMDatabase."+OrgasmedActor.GetFormID() as string+".pY", pY, true)
		JDB.solveFltSetter(".daubuoiSLTTTMDatabase."+OrgasmedActor.GetFormID() as string+".pZ", pZ, true)

		SexLab.TrackActor(OrgasmedActor, "SLTTTMTrackerHook" + OrgasmedActor.GetFormID() as string)
		RegisterForModEvent("SLTTTMTrackerHook" + OrgasmedActor.GetFormID() as string + "_End", "SLTTTMTrackerHookEndHandle")
	endif
endFunction

function SLTTTMTrackerHookEndHandle(Form FormRef, int tid)
	Actor OrgasmedActor = FormRef as actor
	Utility.Wait(1)

	Armor[] allArmorsForActor = new Armor[50]
	int allArmorsForActorLength = getArmorEquip(OrgasmedActor, allArmorsForActor)
	Weapon weaponLeftHand = OrgasmedActor.GetEquippedWeapon(true)
	Weapon weaponRightHand = OrgasmedActor.GetEquippedWeapon(false)
		
	if(OrgasmedActor.GetFactionRank(SLTTTMFaction) < SLTTTMClimaxNum.getValue())
		OrgasmedActor.RemoveFromFaction(SLTTTMFaction)
		UnregisterForModEvent("SLTTTMTrackerHook" + OrgasmedActor.GetFormID() as string + "_End")
		return
	endif

	OrgasmedActor.RemoveFromFaction(SLTTTMFaction)

	int i = 0
	while i < allArmorsForActorLength
		OrgasmedActor.UnequipItem(allArmorsForActor[i], false, true)
		i+=1
	endWhile
	if(weaponLeftHand)
		OrgasmedActor.UnequipItem(weaponLeftHand, false, true)
	endif
	if(weaponRightHand)
		OrgasmedActor.UnequipItem(weaponRightHand, false, true)
	endif

	if(SLTTTMPosition.getValue() == 1)
		float pX = JDB.solveFlt(".daubuoiSLTTTMDatabase."+OrgasmedActor.GetFormID() as string+".pX")
		float pY = JDB.solveFlt(".daubuoiSLTTTMDatabase."+OrgasmedActor.GetFormID() as string+".pY")
		float pZ = JDB.solveFlt(".daubuoiSLTTTMDatabase."+OrgasmedActor.GetFormID() as string+".pZ")
		OrgasmedActor.SetPosition(pX, pY, pZ)
	endif
	
	int armorsNotWearPointer = JDB.solveObj(".daubuoiSLTTTMDatabase."+OrgasmedActor.GetFormID() as string+".armor")
	Form[] armorsNotWearFormArray = JArray.asFormArray(armorsNotWearPointer)
	Armor[] armorsNotWear = new Armor[50]
	int j = 0
	while j < armorsNotWearFormArray.length
		armorsNotWear[j] = armorsNotWearFormArray[j] as Armor
		j+=1
	endwhile
				
	i = 0
	while i < armorsNotWearFormArray.length
		OrgasmedActor.EquipItem(armorsNotWear[j], false, true)
		i+=1
	endWhile
		
	SLTTTMAPI.handlePose(OrgasmedActor, allArmorsForActor, weaponLeftHand, weaponRightHand)
	UnregisterForModEvent("SLTTTMTrackerHook" + OrgasmedActor.GetFormID() as string + "_End")
endFunction

int function checkGender(Actor act)
	int check = -1
	Int gender = Sexlab.GetGender(act)
	if(gender == 1)
		if (SLTTTMFemale.getValue() == 1 && act != game.getPlayer()) || (act == game.getPlayer() && SLTTTMPlayer.getValue() == 1)
			check = 1
		endif
	endif
	if(gender == 0)
		if (SLTTTMMale.getValue() == 1  && act != game.getPlayer()) || (act == game.getPlayer() && SLTTTMPlayer.getValue() == 1)
			check = 0
		endif
	endif
	return check
endFunction

int function getArmorEquip(Actor act, Armor[] returnArmors)
	Int allItemsHave = act.GetNumItems()
	int armorsLength = 0
	While allItemsHave > 0
		allItemsHave -= 1
		Form kForm = act.GetNthForm(allItemsHave)
		If kForm.GetType() == 26 && act.IsEquipped(kForm)
			returnArmors[armorsLength] = kForm as Armor
			armorsLength += 1
		EndIf
	EndWhile
	return armorsLength
endFunction

Form[] function convertArmorToFormArray(Armor[] inputArray, int arrayLength)
	Form[] formResult = Utility.CreateFormArray(arrayLength)
	int i = 0
	while i < arrayLength
		formResult[i] = inputArray[i] as Form
		i+=1
	endwhile
	return formResult
Endfunction
