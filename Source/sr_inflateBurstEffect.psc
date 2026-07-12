Scriptname sr_inflateBurstEffect extends ActiveMagicEffect

sr_inflateQuest Property inflater auto
Faction Property slAnimatingFaction auto
ImagespaceModifier Property sr_burstFlash Auto

Actor t 
float totalMultChange = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)
	inflater.log("Starting burst effect for " + akTarget.GetLeveledActorBase().GetName())
	t = akTarget
	totalMultChange = -20.0
	akTarget.ModActorValue("SpeedMult", totalMultChange)
	RegisterForSingleUpdateGameTime(0.67)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	inflater.log("OnEffectFinish() burst effect for " + t.GetLeveledActorBase().GetName())
	t.ModActorValue("SpeedMult", (totalMultChange * -1))
	t.RemoveSpell(inflater.sr_inflateBurstSpell) ; WTF? just Dispel() seems to leave the effects on the actor
EndEvent

Event OnUpdateGameTime()
	inflater.log("OnUpdateGameTime() burst effect for " + t.GetLeveledActorBase().GetName())
	If inflater.isAnimating(t) || t.IsInCombat() || inflater.isPlugged(t) == 3
		inflater.log(t.GetLeveledActorBase().GetName() + " stays bursting.")
		If totalMultChange > -40.0
			totalMultChange -= 5.0
			t.ModActorValue("SpeedMult", -5.0)
		EndIf
		float currentHP = t.GetActorValue("Health")
		float hpPct = t.GetActorValuePercentage("Health")
		If hpPct > 0.0 ; avoid divide-by-zero -> NaN damage when the actor is already downed
			float maxHP = currentHP / hpPct
			float toDMG = maxHP * 0.13
			If currentHP - toDMG < 10
				toDMG = currentHP - 10
			EndIf
			t.DamageActorValue("Health", toDMG)
		EndIf
		if t == inflater.Player 
			If Utility.RandomInt(0, 99) < 15
				inflater.notify("$FHU_BURST_TICK")
			EndIf
			sr_burstFlash.Apply()
			Utility.Wait(2.0)
			sr_burstFlash.Remove()
		EndIf

		RegisterForSingleUpdateGameTime(0.5)
	Else
		; She is free now, so release the burst: deflate the vaginal/anal overfill back
		; down to the NORMAL pool max. (Using the *BURST_MULT cap here would never fire,
		; since Inflate() already clamps vag+anal to exactly that cap.)
		float maxInflation = inflater.config.maxInflation
		float deflateAmount = (inflater.GetTotalCum(t)) - maxInflation

		If deflateAmount > 0.0
			inflater.log("Deflating burst from " + t.GetLeveledActorBase().GetName())
			int poolmask = 0
			If inflater.isPlugged(t) < 2 && inflater.GetMostRecentInflationType(t) == 2
				poolmask = inflater.ANAL
			else
				poolmask = inflater.VAGINAL
			EndIf
			int anim = 2
			If inflater.sr_OnEventNoDeflation.getvalue() == 1
				; auto-deflation is off: the player opted out of drain interruptions,
				; so release without the forced idle - just leak (overlay + drain)
				anim = -1
			EndIf
			inflater.QueueActor(t, false, poolmask, deflateAmount, utility.RandomFloat(4.0, 8.0), animate = anim)
			inflater.InflateQueued()
			if t == inflater.Player
				inflater.Notify("$FHU_BURST_END")
			EndIf
			Dispel()
		Else
			; vaginal+anal already at/below the normal cap - nothing to release (e.g. an
			; oral-driven burst; oral drains on its own timer). The penalty just ends.
			inflater.log("Burst effect ending, vag+anal at/below cap for "+t.GetLeveledActorBase().GetName()+" (" + inflater.GetTotalCum(t) + "/" + maxInflation + ")" )
			Dispel()
		EndIf
	EndIf
EndEvent

Event OnUnload()
	inflater.log("OnUnload() burst effect for " + t.GetLeveledActorBase().GetName())
	Dispel()
EndEvent

Event OnDying(Actor akKiller)
	inflater.log("OnDying() burst effect for " + t.GetLeveledActorBase().GetName())
	Dispel()
EndEvent 
