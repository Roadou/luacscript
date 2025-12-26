eConnectUiType = {
  eConnectUi_Undefined = -1,
  eConnectUi_BlackStone = 0,
  eConnectUi_Socket = 1,
  eConnectUi_Beer = 2,
  eConnectUi_Improve = 3,
  eConnectUi_DyePalette = 4,
  eConnectUi_AchievementBook1 = 5,
  eConnectUi_AchievementBook2 = 6,
  eConnectUi_AchievementBook3 = 7,
  eConnectUi_AchievementBook4 = 8,
  eConnectUi_AchievementBook5 = 9,
  eConnectUi_AchievementBook6 = 10,
  eConnectUi_AchievementBook7 = 11,
  eConnectUi_AchievementBook8 = 12,
  eConnectUi_AchievementBook9 = 13,
  eConnectUi_AchievementBook10 = 14,
  eConnectUi_TravelBook1 = 15,
  eConnectUi_HorseBook1 = 16,
  eConnectUi_HorseBook2 = 17,
  eConnectUi_Blacksmith = 18,
  eConnectUi_LetterScroll = 19,
  eConnectUi_CrapeScroll = 20,
  eConnectUi_FairyItem = 21,
  eConnectUi_Invitation = 22,
  eConnectUi_Graduation = 23,
  eConnectUi_Season2Graduation = 24,
  eConnectUi_Invitation2 = 25,
  eConnectUi_Season3Graduation = 26,
  eConnectUi_Letter = 27,
  eConnectUi_Caphras = 28,
  eConnectUi_LightStone = 29,
  eConnectUi_DrawEvent = 30,
  eConnectUi_UnKownMail = 31,
  eConnectUi_TermianMap1 = 32,
  eConnectUi_TermianMap2 = 33,
  eConnectUi_TermianMap3 = 34,
  eConnectUi_Bromide = 35,
  eConnectUi_AdventurerNote = 36,
  eConnectUi_RepairDekia = 37,
  eConnectUi_ItemSkillOption = 38,
  eConnectUi_AlchemyCharge = 39,
  eConnectUi_AlchemyEvolve = 40,
  eConnectUi_Count = 41
}
function ConnectUI(connectUiType, itemKey)
  if eConnectUiType.eConnectUi_BlackStone == connectUiType then
    if not IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
      return
    end
    ToClient_AddBlackSpiritFlush(0, true, CppEnums.EFlush_BlackSpirit_Ui_Type.eFlush_BlackSpirit_Ui_ItemEnchant)
  elseif eConnectUiType.eConnectUi_Caphras == connectUiType then
    if not IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
      return
    end
    ToClient_AddBlackSpiritFlush(0, true, CppEnums.EFlush_BlackSpirit_Ui_Type.eFlush_BlackSpirit_Ui_Caphras)
  elseif eConnectUiType.eConnectUi_Socket == connectUiType then
    PaGlobalFunc_JewelPreset_Open()
  elseif eConnectUiType.eConnectUi_Beer == connectUiType then
    PaGlobalFunc_WorkerManager_All_ShowToggle()
  elseif eConnectUiType.eConnectUi_Improve == connectUiType then
    if not IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
      return
    end
    ToClient_AddBlackSpiritFlush(0, true, CppEnums.EFlush_BlackSpirit_Ui_Type.eFlush_BlackSpirit_Ui_Improve)
  elseif eConnectUiType.eConnectUi_DyePalette == connectUiType then
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_OpenPalette()
    else
      HandleClicked_Inventory_Palette_Open()
    end
  elseif eConnectUiType.eConnectUi_AchievementBook1 == connectUiType then
    PaGlobalFunc_Achievement_Open(1)
  elseif eConnectUiType.eConnectUi_AchievementBook2 == connectUiType then
    PaGlobalFunc_Achievement_Open(2)
  elseif eConnectUiType.eConnectUi_AchievementBook3 == connectUiType then
    PaGlobalFunc_Achievement_Open(3)
  elseif eConnectUiType.eConnectUi_AchievementBook4 == connectUiType then
    PaGlobalFunc_Achievement_Open(4)
  elseif eConnectUiType.eConnectUi_AchievementBook5 == connectUiType then
    PaGlobalFunc_Achievement_Open(5)
  elseif eConnectUiType.eConnectUi_AchievementBook6 == connectUiType then
    PaGlobalFunc_Achievement_Open(6)
  elseif eConnectUiType.eConnectUi_AchievementBook7 == connectUiType then
    PaGlobalFunc_Achievement_Open(7)
  elseif eConnectUiType.eConnectUi_AchievementBook8 == connectUiType then
    PaGlobalFunc_Achievement_Open(8)
  elseif eConnectUiType.eConnectUi_AchievementBook9 == connectUiType then
    PaGlobalFunc_Achievement_Open(9)
  elseif eConnectUiType.eConnectUi_AchievementBook10 == connectUiType then
    PaGlobalFunc_Achievement_Open(10)
  elseif eConnectUiType.eConnectUi_TravelBook1 == connectUiType then
    PaGlobalFunc_Achievement_Open(11)
  elseif eConnectUiType.eConnectUi_HorseBook1 == connectUiType then
    PaGlobalFunc_Achievement_Open(12)
  elseif eConnectUiType.eConnectUi_HorseBook2 == connectUiType then
    PaGlobalFunc_Achievement_Open(13)
  elseif eConnectUiType.eConnectUi_Blacksmith == connectUiType then
    if not IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
      return
    end
    ToClient_AddBlackSpiritFlush(0, true, CppEnums.EFlush_BlackSpirit_Ui_Type.eFlush_BlackSpirit_Ui_Blacksmith)
  elseif eConnectUiType.eConnectUi_LetterScroll == connectUiType then
    PaGlobal_LetterScroll_All_Open(PaGlobal_LetterScroll_All._eType.jLetter)
  elseif eConnectUiType.eConnectUi_CrapeScroll == connectUiType then
    PaGlobal_LetterScroll_All_Open(PaGlobal_LetterScroll_All._eType.crape)
  elseif true == _ContentsGroup_FairyChangeSkill and eConnectUiType.eConnectUi_FairyItem == connectUiType then
    PaGlobal_FairyInfo_Open_All(false)
  elseif eConnectUiType.eConnectUi_Invitation == connectUiType then
    PaGlobal_Invitation_All_Open(PaGlobal_Invitation_All._eType.invitation)
  elseif eConnectUiType.eConnectUi_Graduation == connectUiType then
    PaGlobal_LetterScroll_All_Open(PaGlobal_LetterScroll_All._eType.graduation)
  elseif eConnectUiType.eConnectUi_Season2Graduation == connectUiType then
    PaGlobal_LetterScroll_All_Open(PaGlobal_LetterScroll_All._eType.season2graduation)
  elseif eConnectUiType.eConnectUi_Invitation2 == connectUiType then
    PaGlobal_Invitation_All_Open(PaGlobal_Invitation_All._eType.invitation2)
  elseif eConnectUiType.eConnectUi_Season3Graduation == connectUiType then
    PaGlobal_LetterScroll_All_Open(PaGlobal_LetterScroll_All._eType.season3graduation)
  elseif eConnectUiType.eConnectUi_LightStone == connectUiType then
    if false == _ContentsGroup_ArtifactItem then
      return
    end
    PaGlobalFunc_Artifacts_All_Open()
  elseif eConnectUiType.eConnectUi_DrawEvent == connectUiType then
    if _ContentsGroup_drawEvent == false then
      return
    end
    ToClient_RequestOpenDrawEventList()
  elseif eConnectUiType.eConnectUi_UnKownMail == connectUiType then
    PaGlobal_LetterScroll_All_Open(PaGlobal_LetterScroll_All._eType.unkownMail)
  elseif eConnectUiType.eConnectUi_TermianMap1 == connectUiType then
    PaGlobal_Picture_Open(0)
  elseif eConnectUiType.eConnectUi_TermianMap2 == connectUiType then
    PaGlobal_Picture_Open(1)
  elseif eConnectUiType.eConnectUi_TermianMap3 == connectUiType then
    PaGlobal_Picture_Open(2)
  elseif eConnectUiType.eConnectUi_Bromide == connectUiType then
    if PaGlobalFunc_Bromide_All_Open ~= nil then
      PaGlobalFunc_Bromide_All_Open(itemKey)
    end
  elseif connectUiType == eConnectUiType.eConnectUi_AdventurerNote then
    if isGameTypeCH() == false then
      PaGlobal_ExpirienceWiki_All_Open()
    else
      local linkURL = "https://bd.qq.com/cp/a20240520act/adventurer.html?newsid=18462686"
      ToClient_OpenChargeWebPage(linkURL, false)
    end
  elseif connectUiType == eConnectUiType.eConnectUi_RepairDekia then
    if _ContentsGroup_MonsterBuffZone == true and PaGlobalFunc_MonsterBuffZoneItemRepair_IsShow() == false then
      if _ContentsGroup_NewUI_Inventory_All == true then
        HandleEventLUp_Inventory_All_BottomButtonClick(InventoryBottomOpenUIButtonIndex.RepairDekia)
      else
        PaGlobalFunc_MonsterBuffZoneItemRepair_Open()
      end
    end
  elseif connectUiType == eConnectUiType.eConnectUi_ItemSkillOption then
    if _ContentsGroup_ReforgeStonePreset == true then
      PaGlobal_ReforgeStonePreset_Open()
    else
      if not IsSelfPlayerWaitAction() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
        return
      end
      ToClient_AddBlackSpiritFlush(0, true, CppEnums.EFlush_BlackSpirit_Ui_Type.eFlush_BlackSpirit_Ui_ItemSkillOption)
    end
  elseif connectUiType == eConnectUiType.eConnectUi_AlchemyCharge then
    if _ContentsGroup_AlchemyStoneRenewal == false then
      return
    end
    PaGlobalFunc_AlchemyStone_Renewal_All_Open()
    PaGlobalFunc_AlchemyStone_Renewal_All_SelectTab(0)
  else
    if connectUiType == eConnectUiType.eConnectUi_AlchemyEvolve then
      if _ContentsGroup_AlchemyStoneRenewal == false then
        return
      end
      PaGlobalFunc_AlchemyStone_Renewal_All_Open()
      PaGlobalFunc_AlchemyStone_Renewal_All_SelectTab(1)
    else
    end
  end
end
function ConnectLetterUI(itemKey)
  if nil ~= PaGlobal_LetterScroll_All_LetterOpen then
    PaGlobal_LetterScroll_All_LetterOpen(itemKey)
  end
end
