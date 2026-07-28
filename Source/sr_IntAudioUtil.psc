Scriptname sr_IntAudioUtil Hidden
{AudioUtil (SKSE folder-based audio player: per-actor voice packs, gag-muffled slots,
lipsync) wrappers - the only place referencing the AudioUtil script type. AudioUtil
ships no plugin file, so presence is probed via its SKSE plugin version instead of
GetModByName, and every wrapper carries its own install guard so callers may invoke
it blind. A PlayVoice that resolves nothing returns 0; callers treat false as "not
handled" and fall back to their legacy sound path (SexLab voice / Sound markers).
All calls pass blockLipSync=true: FHU owns the speaker's face through MFG
(MouthOpen / EmotionWhenLeakage / ResetMfg), so AudioUtil must not fight the jaw.}

Bool Function GetIsInstalled() Global
	; -1 when the DLL isn't loaded; any loaded build packs its version > 0.
	Return SKSE.GetPluginVersion("AudioUtil") > 0
EndFunction

; Volume/duck group per the AudioUtil convention, so the voice-pack mod's
; sliders (e.g. SLO VE pcvolume/partnervolume) apply to lines FHU plays.
String Function VoiceGroup(Actor akActor) Global
	If akActor.GetFormID() == 0x14
		Return "pc_low"
	EndIf
	Return "partner_low"
EndFunction

; One channel per actor: a new moan replaces her still-playing one instead of
; stacking, matching the cadence of the deflation tick.
String Function MoanChannel(Actor akActor) Global
	Return "FHUMoan" + akActor.GetFormID()
EndFunction

; Non-verbal moan through the actor's resolved voice pack, intensity-mapped to
; the stock category vocabulary (all packs ship or fall back on these three).
; Strength uses the same 0-100 scale the SexLab PlayMoan calls already pass.
; Returns true if AudioUtil played something; false = caller uses its fallback.
Bool Function TryMoan(Actor akActor, Int Strength) Global
	If !akActor || !GetIsInstalled()
		Return false
	EndIf
	String category = "ForeplaySoft"
	If Strength >= 75
		category = "NearOrgasmNoises"
	ElseIf Strength >= 45
		category = "PenetrativeGrunts"
	EndIf
	Return AudioUtil.PlayVoice(akActor, category, 1.0, VoiceGroup(akActor), MoanChannel(akActor), true) > 0
EndFunction

; Named SFX pool from SKSE\Plugins\AudioUtil\config\FHU_sounds.toml (FHU_*
; names), 3D at the actor, default "sfx" group. Returns true if something
; played; false = caller plays its legacy Sound marker instead.
Bool Function TrySFX(String SfxName, Actor akFollow) Global
	If !GetIsInstalled()
		Return false
	EndIf
	Return AudioUtil.PlaySFX(SfxName, akFollow) > 0
EndFunction

; FHU's own voice content (the FHU_* deflation lines), in FHU's dedicated "fhu"
; volume group ([groups] fhu in FHU_sounds.toml). Two-step: the actor's own
; voice pack first - a pack that ships the FHU_* category plays it in her voice,
; and a gagged actor resolves her muffled gag slot - then FHU's bundled FHU1
; voice slot for the stock line when no pack ships the category.
; Returns true if something played; false = caller plays its legacy Sound marker.
Bool Function TryVoice(Actor akActor, String Category) Global
	If !akActor || !GetIsInstalled()
		Return false
	EndIf
	If AudioUtil.PlayVoice(akActor, Category, 1.0, "fhu", MoanChannel(akActor), true) > 0
		Return true
	EndIf
	Return AudioUtil.PlayVoiceFromSlot("FHU1", Category, akActor, 1.0, "fhu", MoanChannel(akActor), true) > 0
EndFunction
