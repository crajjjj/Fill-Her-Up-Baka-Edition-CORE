Scriptname SLTTTMMCM extends SKI_ConfigBase 

GlobalVariable Property SLTTTMEnable  Auto  
GlobalVariable Property SLTTTMMale  Auto  
GlobalVariable Property SLTTTMFemale  Auto 
GlobalVariable Property SLTTTMPlayer  Auto   
GlobalVariable Property SLTTTMTiredTime  Auto  
GlobalVariable Property SLTTTMAhegaoMale  Auto  
GlobalVariable Property SLTTTMAhegaoFemale  Auto  
GlobalVariable Property SLTTTMAhegaoPlayer  Auto  
GlobalVariable Property SLTTTMPosition  Auto
GlobalVariable Property SLTTTMClimaxNum  Auto

GlobalVariable Property SLTTTMTongArgonian Auto 
GlobalVariable Property SLTTTMTongBreton Auto 
GlobalVariable Property SLTTTMTongDarkElf Auto 
GlobalVariable Property SLTTTMTongHighElf Auto 
GlobalVariable Property SLTTTMTongImperial Auto 
GlobalVariable Property SLTTTMTongKhajiit Auto 
GlobalVariable Property SLTTTMTongNord  Auto 
GlobalVariable Property SLTTTMTongOrc  Auto 
GlobalVariable Property SLTTTMTongRedguard  Auto 
GlobalVariable Property SLTTTMTongWoodElf   Auto 	
GlobalVariable Property SLTTTMTongDefault   Auto 	

GlobalVariable Property SLTTTMAnimationM1  Auto
GlobalVariable Property SLTTTMAnimationM2  Auto
GlobalVariable Property SLTTTMAnimationM3  Auto
GlobalVariable Property SLTTTMAnimationF1  Auto
GlobalVariable Property SLTTTMAnimationF2  Auto
GlobalVariable Property SLTTTMAnimationF3  Auto
GlobalVariable Property SLTTTMAnimationF4  Auto
GlobalVariable Property SLTTTMAnimationF5  Auto
GlobalVariable Property SLTTTMAnimationF6  Auto
GlobalVariable Property SLTTTMAnimationF7  Auto
GlobalVariable Property SLTTTMAnimationF8  Auto
GlobalVariable Property SLTTTMAnimationF9  Auto
GlobalVariable Property SLTTTMAnimationF10  Auto

;-- Variables ---------------------------------------
Int SLTTTMEnableCheck
Int SLTTTMPositionCheck
Int SLTTTMMaleCheck
Int SLTTTMFemaleCheck
Int SLTTTMPlayerCheck
Int SLTTTMAhegaoMaleCheck
Int SLTTTMAhegaoFemaleCheck
Int SLTTTMAhegaoPlayerCheck
Int SLTTTMTiredTimeSlicer
Int SLTTTMClimaxNumSlicer

string[] TonguesList
Int SLTTTMTongArgonianMenu
Int SLTTTMTongBretonMenu
Int SLTTTMTongDarkElfMenu
Int SLTTTMTongHighElfMenu
Int SLTTTMTongImperialMenu
Int SLTTTMTongKhajiitMenu
Int SLTTTMTongNordMenu
Int SLTTTMTongOrcMenu
Int SLTTTMTongRedguardMenu
Int SLTTTMTongWoodElfMenu
Int SLTTTMTongDefaultMenu

Int SLTTTMAnimationM1Check
Int SLTTTMAnimationM2Check
Int SLTTTMAnimationM3Check
Int SLTTTMAnimationF1Check
Int SLTTTMAnimationF2Check
Int SLTTTMAnimationF3Check
Int SLTTTMAnimationF4Check
Int SLTTTMAnimationF5Check
Int SLTTTMAnimationF6Check
Int SLTTTMAnimationF7Check
Int SLTTTMAnimationF8Check
Int SLTTTMAnimationF9Check
Int SLTTTMAnimationF10Check


;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

function OnConfigInit()
	TonguesList = new string[10]
	TonguesList[0] = "Type 1"
	TonguesList[1] = "Type 2"
	TonguesList[2] = "Type 3"
	TonguesList[3] = "Type 4"
	TonguesList[4] = "Type 5"
	TonguesList[5] = "Type 6"
	TonguesList[6] = "Type 7"
	TonguesList[7] = "Type 8"
	TonguesList[8] = "Type 9"
	TonguesList[9] = "Type 10"

	ModName = "SLTooTiredToMove"
	Pages = new String[2]
	Pages[0] = "General Settings"
	Pages[1] = "Animation Settings"
endFunction

event OnOptionMenuOpen(int option)
	if (option == SLTTTMTongArgonianMenu)
		SetMenuDialogOptions(TonguesList)
		SetMenuDialogStartIndex(SLTTTMTongArgonian.getValue() as Int)
	endIf
	if (option == SLTTTMTongBretonMenu)
		SetMenuDialogOptions(TonguesList)
		SetMenuDialogStartIndex(SLTTTMTongBreton.getValue() as Int)
	endIf
	if (option == SLTTTMTongDarkElfMenu)
		SetMenuDialogOptions(TonguesList)
		SetMenuDialogStartIndex(SLTTTMTongDarkElf.getValue() as Int)
	endIf
	if (option == SLTTTMTongHighElfMenu)
		SetMenuDialogOptions(TonguesList)
		SetMenuDialogStartIndex(SLTTTMTongHighElf.getValue() as Int)
	endIf
	if (option == SLTTTMTongImperialMenu)
		SetMenuDialogOptions(TonguesList)
		SetMenuDialogStartIndex(SLTTTMTongImperial.getValue() as Int)
	endIf
	if (option == SLTTTMTongKhajiitMenu)
		SetMenuDialogOptions(TonguesList)
		SetMenuDialogStartIndex(SLTTTMTongKhajiit.getValue() as Int)
	endIf
	if (option == SLTTTMTongNordMenu)
		SetMenuDialogOptions(TonguesList)
		SetMenuDialogStartIndex(SLTTTMTongNord.getValue() as Int)
	endIf
	if (option == SLTTTMTongOrcMenu)
		SetMenuDialogOptions(TonguesList)
		SetMenuDialogStartIndex(SLTTTMTongOrc.getValue() as Int)
	endIf
	if (option == SLTTTMTongRedguardMenu)
		SetMenuDialogOptions(TonguesList)
		SetMenuDialogStartIndex(SLTTTMTongRedguard.getValue() as Int)
	endIf
	if (option == SLTTTMTongWoodElfMenu)
		SetMenuDialogOptions(TonguesList)
		SetMenuDialogStartIndex(SLTTTMTongWoodElf.getValue() as Int)
	endIf
	if (option == SLTTTMTongDefaultMenu)
		SetMenuDialogOptions(TonguesList)
		SetMenuDialogStartIndex(SLTTTMTongDefault.getValue() as Int)
	endIf
endEvent


event OnOptionMenuAccept(int option, int index)
	if (option == SLTTTMTongArgonianMenu)
		SLTTTMTongArgonian.setValue(index)
		SetMenuOptionValue(SLTTTMTongArgonianMenu, TonguesList[index])
	endIf
	if (option == SLTTTMTongBretonMenu)
		SLTTTMTongBreton.setValue(index)
		SetMenuOptionValue(SLTTTMTongBretonMenu, TonguesList[index])
	endIf
	if (option == SLTTTMTongDarkElfMenu)
		SLTTTMTongDarkElf.setValue(index)
		SetMenuOptionValue(SLTTTMTongDarkElfMenu, TonguesList[index])
	endIf
	if (option == SLTTTMTongHighElfMenu)
		SLTTTMTongHighElf.setValue(index)
		SetMenuOptionValue(SLTTTMTongHighElfMenu, TonguesList[index])
	endIf
	if (option == SLTTTMTongImperialMenu)
		SLTTTMTongImperial.setValue(index)
		SetMenuOptionValue(SLTTTMTongImperialMenu, TonguesList[index])
	endIf
	if (option == SLTTTMTongKhajiitMenu)
		SLTTTMTongKhajiit.setValue(index)
		SetMenuOptionValue(SLTTTMTongKhajiitMenu, TonguesList[index])
	endIf
	if (option == SLTTTMTongNordMenu)
		SLTTTMTongNord.setValue(index)
		SetMenuOptionValue(SLTTTMTongNordMenu, TonguesList[index])
	endIf
	if (option == SLTTTMTongOrcMenu)
		SLTTTMTongOrc.setValue(index)
		SetMenuOptionValue(SLTTTMTongOrcMenu, TonguesList[index])
	endIf
	if (option == SLTTTMTongRedguardMenu)
		SLTTTMTongRedguard.setValue(index)
		SetMenuOptionValue(SLTTTMTongRedguardMenu, TonguesList[index])
	endIf
	if (option == SLTTTMTongWoodElfMenu)
		SLTTTMTongWoodElf.setValue(index)
		SetMenuOptionValue(SLTTTMTongWoodElfMenu, TonguesList[index])
	endIf
	if (option == SLTTTMTongDefaultMenu)
		SLTTTMTongDefault.setValue(index)
		SetMenuOptionValue(SLTTTMTongDefaultMenu, TonguesList[index])
	endIf
endEvent

function OnOptionSelect(Int option)
	if option == SLTTTMEnableCheck
		SetToggleOptionValue(SLTTTMEnableCheck, 1-SLTTTMEnable.GetValue())
		SLTTTMEnable.SetValue(1-SLTTTMEnable.GetValue())
	endIf
	if option == SLTTTMMaleCheck
		SetToggleOptionValue(SLTTTMMaleCheck, 1-SLTTTMMale.GetValue())
		SLTTTMMale.SetValue(1-SLTTTMMale.GetValue())
	endIf
	if option == SLTTTMFemaleCheck
		SetToggleOptionValue(SLTTTMFemaleCheck, 1-SLTTTMFemale.GetValue())
		SLTTTMFemale.SetValue(1-SLTTTMFemale.GetValue())
	endIf
	if option == SLTTTMPlayerCheck
		SetToggleOptionValue(SLTTTMPlayerCheck, 1-SLTTTMPlayer.GetValue())
		SLTTTMPlayer.SetValue(1-SLTTTMPlayer.GetValue())
	endIf
	if option == SLTTTMAhegaoMaleCheck
		SetToggleOptionValue(SLTTTMAhegaoMaleCheck, 1-SLTTTMAhegaoMale.GetValue())
		SLTTTMAhegaoMale.SetValue(1-SLTTTMAhegaoMale.GetValue())
	endIf
	if option == SLTTTMAhegaoFemaleCheck
		SetToggleOptionValue(SLTTTMAhegaoFemaleCheck, 1-SLTTTMAhegaoFemale.GetValue())
		SLTTTMAhegaoFemale.SetValue(1-SLTTTMAhegaoFemale.GetValue())
	endIf
	if option == SLTTTMAhegaoPlayerCheck
		SetToggleOptionValue(SLTTTMAhegaoPlayerCheck, 1-SLTTTMAhegaoPlayer.GetValue())
		SLTTTMAhegaoPlayer.SetValue(1-SLTTTMAhegaoPlayer.GetValue())
	endIf
	if option == SLTTTMPositionCheck
		SetToggleOptionValue(SLTTTMPositionCheck, 1-SLTTTMPosition.GetValue())
		SLTTTMPosition.SetValue(1-SLTTTMPosition.GetValue())
	endIf
	if option == SLTTTMAnimationM1Check
		SetToggleOptionValue(SLTTTMAnimationM1Check, 1-SLTTTMAnimationM1.GetValue())
		SLTTTMAnimationM1.SetValue(1-SLTTTMAnimationM1.GetValue())
	endIf
	if option == SLTTTMAnimationM2Check
		SetToggleOptionValue(SLTTTMAnimationM2Check, 1-SLTTTMAnimationM2.GetValue())
		SLTTTMAnimationM2.SetValue(1-SLTTTMAnimationM2.GetValue())
	endIf
	if option == SLTTTMAnimationM3Check
		SetToggleOptionValue(SLTTTMAnimationM3Check, 1-SLTTTMAnimationM3.GetValue())
		SLTTTMAnimationM3.SetValue(1-SLTTTMAnimationM3.GetValue())
	endIf
	if option == SLTTTMAnimationF1Check
		SetToggleOptionValue(SLTTTMAnimationF1Check, 1-SLTTTMAnimationF1.GetValue())
		SLTTTMAnimationF1.SetValue(1-SLTTTMAnimationF1.GetValue())
	endIf
	if option == SLTTTMAnimationF2Check
		SetToggleOptionValue(SLTTTMAnimationF2Check, 1-SLTTTMAnimationF2.GetValue())
		SLTTTMAnimationF2.SetValue(1-SLTTTMAnimationF2.GetValue())
	endIf
	if option == SLTTTMAnimationF3Check
		SetToggleOptionValue(SLTTTMAnimationF3Check, 1-SLTTTMAnimationF3.GetValue())
		SLTTTMAnimationF3.SetValue(1-SLTTTMAnimationF3.GetValue())
	endIf
	if option == SLTTTMAnimationF4Check
		SetToggleOptionValue(SLTTTMAnimationF4Check, 1-SLTTTMAnimationF4.GetValue())
		SLTTTMAnimationF4.SetValue(1-SLTTTMAnimationF4.GetValue())
	endIf
	if option == SLTTTMAnimationF5Check
		SetToggleOptionValue(SLTTTMAnimationF5Check, 1-SLTTTMAnimationF5.GetValue())
		SLTTTMAnimationF5.SetValue(1-SLTTTMAnimationF5.GetValue())
	endIf
	if option == SLTTTMAnimationF6Check
		SetToggleOptionValue(SLTTTMAnimationF6Check, 1-SLTTTMAnimationF6.GetValue())
		SLTTTMAnimationF6.SetValue(1-SLTTTMAnimationF6.GetValue())
	endIf
	if option == SLTTTMAnimationF7Check
		SetToggleOptionValue(SLTTTMAnimationF7Check, 1-SLTTTMAnimationF7.GetValue())
		SLTTTMAnimationF7.SetValue(1-SLTTTMAnimationF7.GetValue())
	endIf
	if option == SLTTTMAnimationF8Check
		SetToggleOptionValue(SLTTTMAnimationF8Check, 1-SLTTTMAnimationF8.GetValue())
		SLTTTMAnimationF8.SetValue(1-SLTTTMAnimationF8.GetValue())
	endIf
	if option == SLTTTMAnimationF9Check
		SetToggleOptionValue(SLTTTMAnimationF9Check, 1-SLTTTMAnimationF9.GetValue())
		SLTTTMAnimationF9.SetValue(1-SLTTTMAnimationF9.GetValue())
	endIf
	if option == SLTTTMAnimationF10Check
		SetToggleOptionValue(SLTTTMAnimationF10Check, 1-SLTTTMAnimationF10.GetValue())
		SLTTTMAnimationF10.SetValue(1-SLTTTMAnimationF10.GetValue())
	endIf
endFunction

function OnOptionSliderOpen(Int option)
	if option == SLTTTMTiredTimeSlicer
		self.SetSliderDialogStartValue(SLTTTMTiredTime.GetValue())
		self.SetSliderDialogDefaultValue(15)
		self.SetSliderDialogRange(3, 900)
		self.SetSliderDialogInterval(1)
	endIf
	if option == SLTTTMClimaxNumSlicer
		self.SetSliderDialogStartValue(SLTTTMClimaxNum.GetValue())
		self.SetSliderDialogDefaultValue(1)
		self.SetSliderDialogRange(1, 10)
		self.SetSliderDialogInterval(1)
	endIf
endFunction

function OnOptionSliderAccept(Int option, Float value)
	if option == SLTTTMTiredTimeSlicer
		self.SetSliderOptionValue(SLTTTMTiredTimeSlicer, value, "{0} seconds", false)
		SLTTTMTiredTime.SetValue(value)
	endIf
	if option == SLTTTMClimaxNumSlicer
		self.SetSliderOptionValue(SLTTTMClimaxNumSlicer, value, "{0}", false)
		SLTTTMClimaxNum.SetValue(value)
	endIf
endFunction

function OnOptionHighlight(Int option)
	if option == SLTTTMEnableCheck
		self.SetInfoText("Enable / Disabled SLTooTiredToMove.")
	elseif option == SLTTTMMaleCheck
		self.SetInfoText("Allows activation on male actors.")
	elseif option == SLTTTMFemaleCheck
		self.SetInfoText("Allows activation on female actors.")
	elseif option == SLTTTMPlayerCheck
		self.SetInfoText("Allows activation on the player character.")
	elseif option == SLTTTMAhegaoMaleCheck
		self.SetInfoText("Plays ahegao face when Male NPC is tired. \nNote: Only available if you have the HALOS tongue mod installed.")
	elseif option == SLTTTMAhegaoFemaleCheck
		self.SetInfoText("Plays ahegao face when Female NPC is tired. \nNote: Only available if you have the HALOS tongue mod installed.")
	elseif option == SLTTTMAhegaoPlayerCheck
		self.SetInfoText("Plays ahegao face when Player is tired. \nNote: Only available if you have the HALOS tongue mod installed.")
	elseif option == SLTTTMTiredTimeSlicer
		self.SetInfoText("Duration (in seconds) the actor stays tired after the scene.")
	elseif option == SLTTTMClimaxNumSlicer
		self.SetInfoText("Sets the minimum number of orgasms required before triggering exhaustion.")
	elseif option == SLTTTMPositionCheck
		self.SetInfoText("After Sexlab scenes, the character's exhaustion position will match the scene's final position instead of returning to their pre-scene location.")
	elseif option == SLTTTMTongDefaultMenu
		self.SetInfoText("Select tongue type for actors not belonging to the default races. \nNote: Only available if you have the HALOS tongue mod installed.")
	elseif (option == SLTTTMAnimationM1Check || option == SLTTTMAnimationM2Check || option == SLTTTMAnimationM3Check || option == SLTTTMAnimationF1Check || option == SLTTTMAnimationF2Check || option == SLTTTMAnimationF3Check || option == SLTTTMAnimationF4Check || option == SLTTTMAnimationF5Check || option == SLTTTMAnimationF6Check || option == SLTTTMAnimationF7Check || option == SLTTTMAnimationF8Check || option == SLTTTMAnimationF9Check || option == SLTTTMAnimationF10Check)
		self.SetInfoText("Enable / Disable this animation type.")
	else
		self.SetInfoText("Select tongue type for actors of this race. \nNote: Only available if you have the HALOS tongue mod installed.")
	endIf
endFunction

function OnPageReset(String page)
	if(page == "Animation Settings")
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		self.AddHeaderOption("Female Character Animations", 0)
		SLTTTMAnimationF1Check = self.AddToggleOption("Animation 1",SLTTTMAnimationF1.GetValue())
		SLTTTMAnimationF2Check = self.AddToggleOption("Animation 2",SLTTTMAnimationF2.GetValue())
		SLTTTMAnimationF3Check = self.AddToggleOption("Animation 3",SLTTTMAnimationF3.GetValue())
		SLTTTMAnimationF4Check = self.AddToggleOption("Animation 4",SLTTTMAnimationF4.GetValue())
		SLTTTMAnimationF5Check = self.AddToggleOption("Animation 5",SLTTTMAnimationF5.GetValue())
		SLTTTMAnimationF6Check = self.AddToggleOption("Animation 6",SLTTTMAnimationF6.GetValue())
		SLTTTMAnimationF7Check = self.AddToggleOption("Animation 7",SLTTTMAnimationF7.GetValue())
		SLTTTMAnimationF8Check = self.AddToggleOption("Animation 8",SLTTTMAnimationF8.GetValue())
		SLTTTMAnimationF9Check = self.AddToggleOption("Animation 9",SLTTTMAnimationF9.GetValue())
		SLTTTMAnimationF10Check = self.AddToggleOption("Animation 10",SLTTTMAnimationF10.GetValue())
		SetCursorPosition(1)
		self.AddHeaderOption("Male Character Animations", 0)
		SLTTTMAnimationM1Check = self.AddToggleOption("Animation 1",SLTTTMAnimationM1.GetValue())
		SLTTTMAnimationM2Check = self.AddToggleOption("Animation 2",SLTTTMAnimationM2.GetValue())
		SLTTTMAnimationM3Check = self.AddToggleOption("Animation 3",SLTTTMAnimationM3.GetValue())
	else
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		self.AddHeaderOption("General Settings", 0)
		SLTTTMEnableCheck = self.AddToggleOption("Enable", SLTTTMEnable.GetValue())
		AddEmptyOption()
		SLTTTMMaleCheck = self.AddToggleOption("Allow Males", SLTTTMMale.GetValue())
		SLTTTMFemaleCheck = self.AddToggleOption("Allow Females", SLTTTMFemale.GetValue())
		SLTTTMPlayerCheck = self.AddToggleOption("Allow Player", SLTTTMPlayer.GetValue())
		AddEmptyOption()
		SLTTTMPositionCheck = self.AddToggleOption("Stay at Scene Location", SLTTTMPosition.GetValue())
		AddEmptyOption()
		SLTTTMTiredTimeSlicer = self.AddSliderOption("Tired Duration", SLTTTMTiredTime.GetValue(), "{0} seconds", 0)
		SLTTTMClimaxNumSlicer = self.AddSliderOption("Minimum Orgasms", SLTTTMClimaxNum.GetValue(), "{0}", 0)
		SetCursorPosition(1)
		self.AddHeaderOption("Settings", 0)
		SLTTTMAhegaoPlayerCheck = self.AddToggleOption("Ahegao When Tired (Player)", SLTTTMAhegaoPlayer.GetValue())
		SLTTTMAhegaoFemaleCheck = self.AddToggleOption("Ahegao When Tired (Female NPC)", SLTTTMAhegaoFemale.GetValue())
		SLTTTMAhegaoMaleCheck = self.AddToggleOption("Ahegao When Tired (Male NPC)", SLTTTMAhegaoMale.GetValue())
		AddEmptyOption()
		SLTTTMTongArgonianMenu = AddMenuOption("Argonian", TonguesList[SLTTTMTongArgonian.getValue() as Int])
		SLTTTMTongBretonMenu = AddMenuOption("Breton", TonguesList[SLTTTMTongBreton.getValue() as Int])
		SLTTTMTongDarkElfMenu = AddMenuOption("Dark Elf", TonguesList[SLTTTMTongDarkElf.getValue() as Int])
		SLTTTMTongHighElfMenu = AddMenuOption("High Elf", TonguesList[SLTTTMTongHighElf.getValue() as Int])
		SLTTTMTongImperialMenu = AddMenuOption("Imperial", TonguesList[SLTTTMTongImperial.getValue() as Int])
		SLTTTMTongKhajiitMenu = AddMenuOption("Khajiit", TonguesList[SLTTTMTongKhajiit.getValue() as Int])
		SLTTTMTongNordMenu = AddMenuOption("Nord", TonguesList[SLTTTMTongNord.getValue() as Int])
		SLTTTMTongOrcMenu = AddMenuOption("Orc", TonguesList[SLTTTMTongOrc.getValue() as Int])
		SLTTTMTongRedguardMenu = AddMenuOption("Redguard", TonguesList[SLTTTMTongRedguard.getValue() as Int])
		SLTTTMTongWoodElfMenu = AddMenuOption("Wood Elf", TonguesList[SLTTTMTongWoodElf.getValue() as Int])
		SLTTTMTongDefaultMenu = AddMenuOption("Default", TonguesList[SLTTTMTongDefault.getValue() as Int])
	endif
endFunction