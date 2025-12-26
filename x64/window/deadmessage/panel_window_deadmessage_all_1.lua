function PaGlobal_DeadMessage_All:initialize()
  if nil == Panel_Window_DeadMessage_All or true == PaGlobal_DeadMessage_All._initialize then
    return
  end
  PaGlobal_DeadMessage_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_DeadMessage_All:controlInit()
  PaGlobal_DeadMessage_All:controlCreate()
  PaGlobal_DeadMessage_All:setConsole()
  PaGlobal_DeadMessage_All:setData()
  PaGlobal_DeadMessage_All:registerEventHandler()
  PaGlobal_DeadMessage_All:validate()
  PaGlobal_DeadMessage_All._initialize = true
end
function PaGlobal_DeadMessage_All:controlInit()
  PaGlobal_DeadMessage_All._ui.stc_circleBG = UI.getChildControl(Panel_Window_DeadMessage_All, "Static_CircleBG")
  PaGlobal_DeadMessage_All._ui.stc_centerBG = UI.getChildControl(Panel_Window_DeadMessage_All, "Static_CenterBG")
  PaGlobal_DeadMessage_All._ui.txt_deathTitle = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_centerBG, "StaticText_DeathTitle")
  PaGlobal_DeadMessage_All._ui.txt_resurrectionTime = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_centerBG, "StaticText_CountDown")
  PaGlobal_DeadMessage_All._ui.txt_GuildSkillApply = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_centerBG, "StaticText_GuildSkillApply")
  PaGlobal_DeadMessage_All._ui.stc_lostItemBG = UI.getChildControl(Panel_Window_DeadMessage_All, "Static_LostItemListBG")
  PaGlobal_DeadMessage_All._ui.stc_lineTop = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_lostItemBG, "Static_LineTop")
  PaGlobal_DeadMessage_All._ui.stc_lineBottom = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_lostItemBG, "Static_LineBottom")
  PaGlobal_DeadMessage_All._ui.list2_lostItem = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_lostItemBG, "List2_ItemList")
  PaGlobal_DeadMessage_All._ui.list2_content = UI.getChildControl(PaGlobal_DeadMessage_All._ui.list2_lostItem, "List2_1_Content")
  if true == _ContentsGroup_ChinaFontColor then
    local redText = UI.getChildControl(PaGlobal_DeadMessage_All._ui.list2_content, "StaticText_ItemList")
    PaGlobal_DeadMessage_All._ui.txt_deathTitle:SetFontColor(Defines.Color.C_FFF5BA3A)
    redText:SetFontColor(Defines.Color.C_FFF5BA3A)
  end
  PaGlobal_DeadMessage_All._ui.stc_resurrectionBG = UI.getChildControl(Panel_Window_DeadMessage_All, "Static_ResurrectionBG")
  PaGlobal_DeadMessage_All._ui.btn_largeTemplate = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "Button_LargeButton")
  PaGlobal_DeadMessage_All._ui.btn_smallTemplate = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "Button_SmallButton")
  PaGlobal_DeadMessage_All._ui.btn_largeTemplate:SetShow(false)
  PaGlobal_DeadMessage_All._ui.btn_smallTemplate:SetShow(false)
  PaGlobal_DeadMessage_All._ui.btn_noticeIcon = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "Button_NoticeIcon")
  PaGlobal_DeadMessage_All._ui.btn_selectButton_console = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "Static_SelectButton_Console")
  PaGlobal_DeadMessage_All._ui.btn_useItemCheck = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "CheckButton_UseTears")
  PaGlobal_DeadMessage_All._ui.btn_useItemCheck:SetEnableArea(0, 0, PaGlobal_DeadMessage_All._ui.btn_useItemCheck:GetSizeX() + PaGlobal_DeadMessage_All._ui.btn_useItemCheck:GetTextSizeX(), PaGlobal_DeadMessage_All._ui.btn_useItemCheck:GetSizeY())
  PaGlobal_DeadMessage_All._ui.btn_useFairyCheck = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "CheckButton_UseFairy")
  PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:SetEnableArea(0, 0, PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetSizeX() + PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetTextSizeX(), PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetSizeY())
  PaGlobal_DeadMessage_All._ui.btn_specUpGuideIcon = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "Button_SmallButton_Stronger")
  PaGlobal_DeadMessage_All._ui.stc_paneltyBG = UI.getChildControl(Panel_Window_DeadMessage_All, "Static_PenaltyBG")
  PaGlobal_DeadMessage_All._ui.stc_paneltyTitle = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_paneltyBG, "StaticText_PenaltyText1")
  PaGlobal_DeadMessage_All._ui.stc_paneltyDesc = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_paneltyBG, "StaticText_PenaltyText2")
  PaGlobal_DeadMessage_All._ui.stc_paneltyBG:SetShow(false)
  PaGlobal_DeadMessage_All._ui.btn_restoreJewel = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_lostItemBG, "Button_Restoration")
  PaGlobal_DeadMessage_All._ui.btn_restoreJewelTooltip = UI.getChildControl(PaGlobal_DeadMessage_All._ui.btn_restoreJewel, "Static_RestorationTooltipIcon")
end
function PaGlobal_DeadMessage_All:controlCreate()
  FromClient_DeadMessage_All_OnScreenReSize()
  for index = 0, PaGlobal_DeadMessage_All._respawnButtonMaxCount - 1 do
    local respawnButton = UI.cloneControl(PaGlobal_DeadMessage_All._ui.btn_largeTemplate, PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "_respawn_Button_" .. index)
    respawnButton:ComputePos()
    respawnButton:SetIgnore(false)
    respawnButton:SetSize(respawnButton:GetSizeX(), PaGlobal_DeadMessage_All._ui.btn_smallTemplate:GetSizeY())
    respawnButton:SetPosY((respawnButton:GetSizeY() + 10) * index)
    respawnButton:SetShow(false)
    PaGlobal_DeadMessage_All._ui._button_Respawn[index] = respawnButton
  end
end
function PaGlobal_DeadMessage_All:setConsole()
  if true == PaGlobal_DeadMessage_All._isConsole then
    PaGlobal_DeadMessage_All._ui.btn_noticeIcon:SetShow(false)
    PaGlobal_DeadMessage_All._ui.btn_selectButton_console:SetShow(true)
    PaGlobal_DeadMessage_All._ui.stc_paneltyTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_PK_PENALTY_TOOLTIP_TITLE"))
    PaGlobal_DeadMessage_All._ui.stc_paneltyDesc:SetTextMode(__eTextMode_AutoWrap)
    if isGameTypeKorea() or isGameTypeJapan() then
      PaGlobal_DeadMessage_All._ui.stc_paneltyDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_PK_PENALTY_TOOLTIP_DESC"))
    else
      PaGlobal_DeadMessage_All._ui.stc_paneltyDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_PK_PENALTY_TOOLTIP_DESC_OTHER"))
    end
    local sizeX = PaGlobal_DeadMessage_All._ui.stc_paneltyBG:GetSizeX()
    local sizeY = PaGlobal_DeadMessage_All._ui.stc_paneltyDesc:GetPosY() + PaGlobal_DeadMessage_All._ui.stc_paneltyDesc:GetTextSizeY() + 20
    PaGlobal_DeadMessage_All._ui.stc_paneltyBG:SetPosY(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG:GetPosY())
    PaGlobal_DeadMessage_All._ui.stc_paneltyBG:SetPosX(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG:GetPosX() - sizeX - 50)
    PaGlobal_DeadMessage_All._ui.stc_paneltyBG:SetSize(sizeX, sizeY)
  else
    PaGlobal_DeadMessage_All._ui.btn_noticeIcon:SetShow(true)
    PaGlobal_DeadMessage_All._ui.btn_selectButton_console:SetShow(false)
  end
end
function PaGlobal_DeadMessage_All:setData()
  PaGlobal_DeadMessage_All:setButtonString()
  PaGlobal_DeadMessage_All:setButtonList()
  PaGlobal_DeadMessage_All:setButtonEvent()
end
function PaGlobal_DeadMessage_All:registerEventHandler()
  if nil == Panel_Window_DeadMessage_All then
    return
  end
  PaGlobal_DeadMessage_All._ui.btn_noticeIcon:addInputEvent("Mouse_On", "HandleEventOnOut_DeadMessage_All_ShowPKTooltip(true)")
  PaGlobal_DeadMessage_All._ui.btn_noticeIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_DeadMessage_All_ShowPKTooltip(false)")
  PaGlobal_DeadMessage_All._ui.btn_specUpGuideIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_EnchantGuide()")
  PaGlobal_DeadMessage_All._ui.btn_useItemCheck:addInputEvent("Mouse_LUp", "HandleEventLUp_DeadMessage_All_SetCheckBox(true)")
  PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:addInputEvent("Mouse_LUp", "HandleEventLUp_DeadMessage_All_SetCheckBox(false)")
  PaGlobal_DeadMessage_All._ui.btn_useItemCheck:addInputEvent("Mouse_On", "HandleEventOnOut_DeadMessage_All_UseItemTooltip(true, 0)")
  PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:addInputEvent("Mouse_On", "HandleEventOnOut_DeadMessage_All_UseItemTooltip(true, 1)")
  PaGlobal_DeadMessage_All._ui.btn_useItemCheck:addInputEvent("Mouse_Out", "HandleEventOnOut_DeadMessage_All_UseItemTooltip(false)")
  PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:addInputEvent("Mouse_Out", "HandleEventOnOut_DeadMessage_All_UseItemTooltip(false)")
  PaGlobal_DeadMessage_All._ui.btn_restoreJewel:addInputEvent("Mouse_LUp", "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_RestoreJewel()")
  PaGlobal_DeadMessage_All._ui.btn_restoreJewelTooltip:addInputEvent("Mouse_On", "HandleEventOnOut_DeadMessage_All_ShowRestoreJewelTooltip(true)")
  PaGlobal_DeadMessage_All._ui.btn_restoreJewelTooltip:addInputEvent("Mouse_Out", "HandleEventOnOut_DeadMessage_All_ShowRestoreJewelTooltip(false)")
  if self._isConsole == true then
    PaGlobal_DeadMessage_All._ui.btn_restoreJewel:addInputEvent("Mouse_On", "HandleEventOn_DeadMessage_All_RestoreButtonMouseOn()")
  end
  PaGlobal_DeadMessage_All._ui.list2_lostItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_DeadMessage_All_ListControlCreate")
  PaGlobal_DeadMessage_All._ui.list2_lostItem:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("onScreenResize", "FromClient_DeadMessage_All_OnScreenReSize")
  registerEvent("EventSelfPlayerDead", "FromClient_DeadMessage_All_SetDeadMessage")
  registerEvent("EventSelfPlayerRevive", "PaGlobalFunc_DeadMessage_All_Close")
  registerEvent("Event_DeadMessage_AddDropItem", "FromClient_DeadMessage_All_AddDropItem")
  registerEvent("Event_DeadMessage_WeakEquip", "FromClient_DeadMessage_All_WeakEquip")
  registerEvent("Event_DeadMessage_WeakEquipCantPushInventory", "FromClient_DeadMessage_All_WeakEquipCantPushInventory")
  registerEvent("Event_DeadMessage_DestroyJewel", "FromClient_DeadMessage_All_DestroyJewel")
  registerEvent("FromClient_NotifySiegeShowWatchPanel", "FromClient_DeadMessage_All_NotifySiegeShowWatchPanel")
  registerEvent("FromClient_VaryRespawnTime", "FromClient_VaryRespawnTime")
  registerEvent("FromClient_RestoreJewelInDead", "FromClient_RestoreJewelInDead")
  registerEvent("FromClient_SolareFindTargetForObserverAck", "FromClient_SolareFindTargetForObserverAck")
end
function PaGlobal_DeadMessage_All:prepareOpen()
  if true == ToClient_IsPlayingReplay() or true == ToClient_IsReplayStreamingMode() then
    return
  end
  if nil == Panel_Window_DeadMessage_All then
    return
  end
  SetUIMode(Defines.UIMode.eUIMode_DeadMessage)
  FromClient_DeadMessage_All_OnScreenReSize()
  local isShowSpecUpGuide = false
  if false == self._isConsole and false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) and ToClient_isHardCoreCharacter() == false and ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Edania) == false then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil ~= temporaryWrapper then
      local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
      if 1 == userType or 2 == userType then
        isShowSpecUpGuide = true
      end
    end
  end
  self._ui.btn_specUpGuideIcon:SetShow(isShowSpecUpGuide)
  PaGlobalFunc_SolareReEnterAck()
  if false == _ContentsGroup_RenewUI then
    PaGlobal_DeadMessage_All:actionGuideOnOff(true)
  end
  PaGlobal_DeadMessage_All._isObserverMode = false
  PaGlobal_DeadMessage_All:open()
end
function PaGlobal_DeadMessage_All:open()
  if nil == Panel_Window_DeadMessage_All or true == Panel_Window_DeadMessage_All:GetShow() then
    return
  end
  Panel_Window_DeadMessage_All:SetShow(true)
end
function PaGlobal_DeadMessage_All:prepareClose()
  if nil == Panel_Window_DeadMessage_All or false == Panel_Window_DeadMessage_All:GetShow() then
    return
  end
  self._ui.txt_GuildSkillApply:SetShow(false)
  SetUIMode(Defines.UIMode.eUIMode_Default)
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  self._currentPaneltyStringCount = 0
  self._ui.list2_lostItem:getElementManager():clearKey()
  HandleEventOnOut_DeadMessage_All_ShowPKTooltip()
  self._destoryJewelCount = 0
  self:close()
end
function PaGlobal_DeadMessage_All:close()
  if nil == Panel_Window_DeadMessage_All or false == Panel_Window_DeadMessage_All:GetShow() then
    return
  end
  Panel_Window_DeadMessage_All:SetShow(false)
end
function PaGlobal_DeadMessage_All:setButtonString()
  local button = PaGlobal_DeadMessage_All._eButtonType
  local buttonString = PaGlobal_DeadMessage_All._ButtonString
  buttonString[button.Immediate] = "<PAColor0xFFB5FF6D>" .. PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_IMMEDIATE") .. "<PAOldColor>"
  buttonString[button.Exploration] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_MOVEEXPLORATION")
  buttonString[button.InSiegeingFortress] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_SIEGEING")
  buttonString[button.NearTown] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_MOVETOWN")
  buttonString[button.LocalWar] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_LOCALWAR")
  buttonString[button.AdvancedBase] = "<PAColor0xFF6DC6FF>" .. PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_ADVANCEDBASE") .. "<PAOldColor>"
  buttonString[button.GuildSpawn] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_GUILDSPAWN")
  buttonString[button.Competition] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMPETITIONGAME_PVP_EXIT")
  buttonString[button.SavageDefence] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_WAVE_OUT")
  buttonString[button.OutsideGate] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_OUTSIDEGATE_BUTTON")
  buttonString[button.InsideGate] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_INSIDEGATE_BUTTON")
  buttonString[button.Observer] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DEADMESSAGE_WATCHINGMODE")
  buttonString[button.GuildObServerMode] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDWATCH_BUTTON")
  buttonString[button.ExitBloodAltar] = PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_EXIT_TITLE")
  buttonString[button.Atoraxion] = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_RESPAWN")
  buttonString[button.SolareObserver] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DEADMESSAGE_WATCHINGMODE")
  buttonString[button.AbyssOneExit] = "\235\167\136\236\157\132\235\161\156 \235\143\140\236\149\132\234\176\128\234\184\176"
  buttonString[button.AbyssOneBase] = "\235\167\136\234\183\184\235\136\132\236\138\164\235\161\156 \236\157\180\235\143\153"
  buttonString[button.AbyssOne] = "\236\158\172\235\143\132\236\160\132"
  buttonString[button.GuildMatch] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMPETITIONGAME_USERRESURRECTION")
  buttonString[button.MinorSiegeOccupyModeRevivePosition0] = "\235\182\128\237\153\156\237\143\172\236\157\184\237\138\1840_LUASTRING"
  buttonString[button.MinorSiegeOccupyModeRevivePosition1] = "\235\182\128\237\153\156\237\143\172\236\157\184\237\138\1841_LUASTRING"
  buttonString[button.MinorSiegeOccupyModeRevivePosition2] = "\235\182\128\237\153\156\237\143\172\236\157\184\237\138\1842_LUASTRING"
  buttonString[button.MinorSiegeOccupyModeRevivePosition3] = "\235\182\128\237\153\156\237\143\172\236\157\184\237\138\1843_LUASTRING"
  buttonString[button.HardCoreChannel] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMPETITIONGAME_USERRESURRECTION")
  buttonString[button.Edana] = PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_REVIVAL_EDANA_BUTTON")
  buttonString[button.EdaniaInstanceFieldExit] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_PVP_LEAVE")
end
function PaGlobal_DeadMessage_All:setButtonList()
  local buttonList = PaGlobal_DeadMessage_All._ButtonListByDeadType
  local button = PaGlobal_DeadMessage_All._eButtonType
  local deadType = PaGlobal_DeadMessage_All._eDeadType
  buttonList[deadType.Dead_Normal] = {
    [0] = button.Edana,
    [1] = button.Immediate,
    [2] = button.Exploration,
    [3] = button.NearTown,
    [4] = button.GuildSpawn,
    [5] = button.AdvancedBase
  }
  buttonList[deadType.DeadLocate_InBattleGround] = {
    [0] = button.Immediate
  }
  buttonList[deadType.DeadLocate_InCompetition] = {
    [0] = button.Immediate,
    [1] = button.Observer
  }
  buttonList[deadType.DeadLocate_InSavageDefence] = {
    [0] = button.Observer,
    [1] = button.SavageDefence
  }
  buttonList[deadType.DeadLocate_InGuildBattle] = {
    [0] = button.Immediate,
    [1] = button.Observer
  }
  buttonList[deadType.DeadLocate_InPVP] = {
    [0] = button.Immediate
  }
  buttonList[deadType.DeadLocate_InLocarWar] = {
    [0] = button.LocalWar
  }
  buttonList[deadType.DeadLocate_InPrision] = {}
  buttonList[deadType.DeadLocate_InSiegeBeingChannel] = {
    [0] = button.NearTown,
    [1] = button.GuildSpawn,
    [2] = button.AvancedBase,
    [3] = button.Observer,
    [4] = button.GuildObServerMode
  }
  buttonList[deadType.DeadLocate_InSiegeBeingInCurrentPos] = {
    [0] = button.NearTown,
    [1] = button.GuildSpawn,
    [2] = button.AdvancedBase,
    [3] = button.Observer,
    [4] = button.GuildObServerMode
  }
  buttonList[deadType.DeadLocate_InSiegeBattle] = {
    [0] = button.NearTown,
    [1] = button.AdvancedBase,
    [2] = button.MinorSiegeOccupyModeRevivePosition0,
    [3] = button.MinorSiegeOccupyModeRevivePosition1,
    [4] = button.MinorSiegeOccupyModeRevivePosition2,
    [5] = button.MinorSiegeOccupyModeRevivePosition3,
    [6] = button.InSiegeingFortress,
    [7] = button.GuildSpawn,
    [8] = button.Observer,
    [9] = button.GuildObServerMode
  }
  buttonList[deadType.DeadLocate_InMajorSiegeBattle] = {
    [0] = button.NearTown,
    [1] = button.AdvancedBase,
    [2] = button.OutsideGate,
    [3] = button.InsideGate,
    [4] = button.InSiegeingFortress,
    [5] = button.GuildSpawn,
    [6] = button.Observer,
    [7] = button.GuildObServerMode
  }
  buttonList[deadType.DeadLocate_InNoAccessArea] = {
    [0] = button.Exploration,
    [1] = button.NearTown,
    [2] = button.GuildSpawn,
    [3] = button.AdvancedBase
  }
  buttonList[deadType.IsPremiumCharacter] = {
    [0] = button.Immediate
  }
  if true == PaGlobal_DeadMessage_All._isConsole then
    buttonList[deadType.DeadLocate_InBloodAltar] = {
      [0] = button.Observer,
      [1] = button.ExitBloodAltar
    }
  else
    buttonList[deadType.DeadLocate_InBloodAltar] = {
      [0] = button.Observer
    }
  end
  buttonList[deadType.DeadLocate_InAtoraxion] = {
    [0] = button.Observer,
    [1] = button.Atoraxion
  }
  buttonList[deadType.DeadLocate_InSolare] = {
    [0] = button.SolareObserver
  }
  buttonList[deadType.DeadLocate_InAbyssOne] = {
    [0] = button.AbyssOne,
    [1] = button.AbyssOneBase,
    [2] = button.AbyssOneExit
  }
  buttonList[deadType.DeadLocate_InGuildMatch] = {
    [0] = button.GuildMatch
  }
  buttonList[deadType.DeadLocate_InHardCoreChannel] = {
    [0] = button.HardCoreChannel
  }
  buttonList[deadType.DeadLocate_Edania] = {
    [0] = button.Observer,
    [1] = button.EdaniaInstanceFieldExit
  }
end
function PaGlobal_DeadMessage_All:setButtonEvent()
  local buttonEvent = PaGlobal_DeadMessage_All._ButtonEvent
  local button = PaGlobal_DeadMessage_All._eButtonType
  buttonEvent[button.Immediate] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Immediate"
  buttonEvent[button.Exploration] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Exploration"
  buttonEvent[button.NearTown] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_NearTown"
  buttonEvent[button.InSiegeingFortress] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_InSiegeingFortress"
  buttonEvent[button.LocalWar] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_LocalWar"
  buttonEvent[button.AdvancedBase] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_AdvancedBase"
  buttonEvent[button.GuildSpawn] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_GuildSpawn"
  buttonEvent[button.SavageDefence] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_SavageDefence"
  buttonEvent[button.OutsideGate] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_OutsideGate"
  buttonEvent[button.InsideGate] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_InsideGate"
  buttonEvent[button.Observer] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Observer"
  buttonEvent[button.GuildObServerMode] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_GuildObserverMode"
  buttonEvent[button.ExitBloodAltar] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_ExitBloodAltar"
  buttonEvent[button.Atoraxion] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Atoraxion"
  buttonEvent[button.SolareObserver] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_SolareObserver"
  buttonEvent[button.AbyssOneExit] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_AbyssOneExit"
  buttonEvent[button.AbyssOneBase] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_AbyssOneBase"
  buttonEvent[button.AbyssOne] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_AbyssOne"
  buttonEvent[button.GuildMatch] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_GuildMatch"
  buttonEvent[button.MinorSiegeOccupyModeRevivePosition0] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_MinorSiegeOccupyModeRevivePosition0"
  buttonEvent[button.MinorSiegeOccupyModeRevivePosition1] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_MinorSiegeOccupyModeRevivePosition1"
  buttonEvent[button.MinorSiegeOccupyModeRevivePosition2] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_MinorSiegeOccupyModeRevivePosition2"
  buttonEvent[button.MinorSiegeOccupyModeRevivePosition3] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_MinorSiegeOccupyModeRevivePosition3"
  buttonEvent[button.HardCoreChannel] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_HardCoreChannel"
  buttonEvent[button.Edana] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Edana"
  buttonEvent[button.EdaniaInstanceFieldExit] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_EdaniaInstanceFieldExit"
end
function PaGlobal_DeadMessage_All:resetData()
  PaGlobal_DeadMessage_All._isHasResotreExp = false
  PaGlobal_DeadMessage_All._isAblePvPMatchRevive = false
  PaGlobal_DeadMessage_All._currentDeadType = nil
  PaGlobal_DeadMessage_All._isObserverMode = false
  PaGlobal_DeadMessage_All._deadCheckTime = 0
  PaGlobal_DeadMessage_All._isSkipDeathPenalty = false
  PaGlobal_DeadMessage_All._buttonTypeArray = nil
  PaGlobal_DeadMessage_All._buttonWaitTime = 0
  PaGlobal_DeadMessage_All._isButtonWaitTimeEnd = false
  PaGlobal_DeadMessage_All._isUseButtonAbleTime = false
  PaGlobal_DeadMessage_All._resurrectionTime = 600
  PaGlobal_DeadMessage_All._lastUpdateTime = 0
  PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver = nil
  PaGlobal_DeadMessage_All._startTimeForGuildObserver = nil
  for index = 0, PaGlobal_DeadMessage_All._respawnButtonMaxCount - 1 do
    PaGlobal_DeadMessage_All._ui._button_Respawn[index]:SetSize(PaGlobal_DeadMessage_All._ui._button_Respawn[index]:GetSizeX(), PaGlobal_DeadMessage_All._ui.btn_smallTemplate:GetSizeY())
    PaGlobal_DeadMessage_All._ui._button_Respawn[index]:SetPosY((PaGlobal_DeadMessage_All._ui._button_Respawn[index]:GetSizeY() + 10) * index)
  end
  PaGlobal_DeadMessage_All._ui.list2_lostItem:getElementManager():clearKey()
end
function PaGlobal_DeadMessage_All:closeChannelMoveWindow()
  if ToClient_isConsole() == false then
    if true == _ContentsGroup_UsePadSnapping and nil ~= Panel_Window_Inventory_Detail and true == Panel_Window_Inventory_Detail:GetShow() and nil ~= PaGlobal_InventoryEquip_Detail_Renew_Close then
      PaGlobal_InventoryEquip_Detail_Renew_Close()
    end
    if nil ~= Panel_Window_SimpleInventory and true == Panel_Window_SimpleInventory:IsShow() and nil ~= PaGlobal_SimpleInventory then
      PaGlobal_SimpleInventory:close()
    end
    if Panel_Window_GameExit_All:GetShow() then
      PaGlobal_GameExit_All_Close(true)
    end
    if nil ~= Panel_ChannelSelect_All and true == Panel_ChannelSelect_All:GetShow() then
      PaGlobalFunc_ChannelSelect_All_Close()
    end
  else
    if nil ~= Panel_Window_Inventory_Detail and true == Panel_Window_Inventory_Detail:GetShow() and nil ~= PaGlobal_InventoryEquip_Detail_Renew_Close then
      PaGlobal_InventoryEquip_Detail_Renew_Close()
    end
    if nil ~= Panel_Window_SimpleInventory and true == Panel_Window_SimpleInventory:IsShow() and nil ~= PaGlobal_SimpleInventory then
      PaGlobal_SimpleInventory:close()
    end
    if Panel_Window_GameExit_All:GetShow() then
      PaGlobal_GameExit_All_Close(true)
    end
    if nil ~= Panel_ChannelSelect_All and true == Panel_ChannelSelect_All:GetShow() then
      PaGlobalFunc_ChannelSelect_All_Close()
    end
  end
end
function PaGlobal_DeadMessage_All:setResurrectionTime(respawnTime)
  if nil == respawnTime then
    PaGlobal_DeadMessage_All._resurrectionTime = 0
    return
  end
  local deadType = PaGlobal_DeadMessage_All._eDeadType
  local curDeadType = PaGlobal_DeadMessage_All._currentDeadType
  local selfProxy = getSelfPlayer()
  PaGlobal_DeadMessage_All._isUseButtonAbleTime = false
  if curDeadType == deadType.DeadLocate_InBattleGround then
    PaGlobal_DeadMessage_All._resurrectionTime = PaGlobal_DeadMessage_All._revivalTime
  elseif curDeadType == deadType.DeadLocate_InCompetition then
    PaGlobal_DeadMessage_All._resurrectionTime = ToClient_CompetitionMatchTimeLimit() + ToClient_GetMaxWaitTime()
  elseif curDeadType == deadType.DeadLocate_InSavageDefence then
    PaGlobal_DeadMessage_All._resurrectionTime = 0
  elseif curDeadType == deadType.DeadLocate_InSolare then
    PaGlobal_DeadMessage_All._resurrectionTime = 0
  elseif curDeadType == deadType.DeadLocate_InGuildBattle then
    PaGlobal_DeadMessage_All._resurrectionTime = 0
  elseif curDeadType == deadType.DeadLocate_InPVP then
    PaGlobal_DeadMessage_All._resurrectionTime = PaGlobal_DeadMessage_All._revivalTime
  elseif curDeadType == deadType.DeadLocate_InLocarWar then
    PaGlobal_DeadMessage_All._resurrectionTime = 600
  elseif curDeadType == deadType.DeadLocate_InPrision then
    PaGlobal_DeadMessage_All._resurrectionTime = 2
  elseif curDeadType == deadType.IsPremiumCharacter then
    PaGlobal_DeadMessage_All._resurrectionTime = PaGlobal_DeadMessage_All._revivalTime
  elseif curDeadType == deadType.DeadLocate_InBloodAltar then
    PaGlobal_DeadMessage_All._resurrectionTime = 0
  elseif curDeadType == deadType.DeadLocate_InAbyssOne then
    PaGlobal_DeadMessage_All._resurrectionTime = 0
  elseif curDeadType == deadType.DeadLocate_InHardCoreChannel then
    PaGlobal_DeadMessage_All._resurrectionTime = ToClient_GetHardCoreCharacterRespawnTime()
  elseif curDeadType == deadType.DeadLocate_Edania then
    PaGlobal_DeadMessage_All._resurrectionTime = nil
  elseif curDeadType == deadType.DeadLocate_InGuildMatch then
    local guildMatchRevivalTime = ToClient_GetGuildMatchRevivalTime()
    PaGlobal_DeadMessage_All._buttonWaitTime = guildMatchRevivalTime
    PaGlobal_DeadMessage_All._isUseButtonAbleTime = true
    PaGlobal_DeadMessage_All._buttonAbleTime = guildMatchRevivalTime
    PaGlobal_DeadMessage_All._resurrectionTime = guildMatchRevivalTime
  elseif curDeadType == deadType.DeadLocate_InSiegeBeingChannel or curDeadType == deadType.DeadLocate_InSiegeBeingInCurrentPos or curDeadType == deadType.DeadLocate_InSiegeBattle or curDeadType == deadType.DeadLocate_InMajorSiegeBattle or curDeadType == deadType.DeadLocate_InNoAccessArea then
    if true == deadMessage_isSiegeBeingMyChannel() and deadMessage_isInSiegeBattle() or 0 ~= selfProxy:get():getVolunteerTeamNoForLua() then
      respawnTime = respawnTime / 1000
      PaGlobal_DeadMessage_All._buttonWaitTime = respawnTime
      if 0 <= PaGlobal_DeadMessage_All._buttonWaitTime then
        PaGlobal_DeadMessage_All._isUseButtonAbleTime = true
        PaGlobal_DeadMessage_All._buttonAbleTime = respawnTime
      end
      PaGlobal_DeadMessage_All._resurrectionTime = respawnTime
    elseif true == deadMessage_isSiegeBeingMyChannel() then
      PaGlobal_DeadMessage_All._resurrectionTime = 0
    else
      PaGlobal_DeadMessage_All._resurrectionTime = 0
    end
  elseif curDeadType == deadType.Dead_Normal then
    PaGlobal_DeadMessage_All._resurrectionTime = 0
  end
end
function PaGlobal_DeadMessage_All:getDeadType()
  local deadType = PaGlobal_DeadMessage_All._eDeadType
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return nil
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local isArenaArea = regionInfo:get():isArenaArea()
  local isMyChannelSiegeBeing = deadMessage_isSiegeBeingMyChannel()
  local isSiegeBeingInCurrentPosition = deadMessage_isSiegeBeingInCurrentPosition()
  if true == selfProxy:get():isBattleGroundDefine() then
    return deadType.DeadLocate_InBattleGround
  end
  if true == selfProxy:get():isCompetitionDefined() then
    return deadType.DeadLocate_InCompetition
  end
  if true == ToClient_getPlayNowSavageDefence() then
    return deadType.DeadLocate_InSavageDefence
  end
  if true == ToClient_getJoinGuildBattle() then
    return deadType.DeadLocate_InGuildBattle
  end
  if true == PaGlobal_DeadMessage_All._isAblePvPMatchRevive then
    return deadType.DeadLocate_InPVP
  end
  if 0 ~= ToClient_GetMyTeamNoRedBattleField() then
    return deadType.DeadLocate_InLocarWar
  end
  if true == regionInfo:isPrison() or true == goToPrison() then
    return deadType.DeadLocate_InPrision
  end
  if true == ToClient_isPremiumCharacter() and false == ToClient_getPlayNowSavageDefence() and 0 == ToClient_GetMyTeamNoRedBattleField() then
    return deadType.IsPremiumCharacter
  end
  if true == deadMessage_isInMajorSiegeBattle() then
    return deadType.DeadLocate_InMajorSiegeBattle
  end
  if true == deadMessage_isInSiegeBattle() and isMyChannelSiegeBeing == true then
    return deadType.DeadLocate_InSiegeBattle
  end
  if true == isSiegeBeingInCurrentPosition and true == isMyChannelSiegeBeing then
    return deadType.DeadLocate_InSiegeBeingInCurrentPos
  end
  if true == isMyChannelSiegeBeing then
    return deadType.DeadLocate_InSiegeBeingChannel
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    return deadType.DeadLocate_InBloodAltar
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_AtoraxionBoss) then
    return deadType.DeadLocate_InAtoraxion
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    return deadType.DeadLocate_InSolare
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_AbyssOne) then
    return deadType.DeadLocate_InAbyssOne
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) then
    return deadType.DeadLocate_InGuildMatch
  end
  if ToClient_isHardCoreCharacter() == true then
    return deadType.DeadLocate_InHardCoreChannel
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Edania) == true then
    return deadType.DeadLocate_Edania
  end
  return deadType.Dead_Normal
end
function PaGlobal_DeadMessage_All:setRespawnButton()
  local buttonString = PaGlobal_DeadMessage_All._ButtonString
  local buttonControl = PaGlobal_DeadMessage_All._ui._button_Respawn
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  PaGlobal_DeadMessage_All._buttonTypeArray = Array.new()
  local buttonArray = PaGlobal_DeadMessage_All._buttonTypeArray
  for index = 0, PaGlobal_DeadMessage_All._respawnButtonMaxCount - 1 do
    buttonControl[index]:SetShow(false)
  end
  if self._currentDeadType == PaGlobal_DeadMessage_All._eDeadType.DeadLocate_InSolare or self._currentDeadType == PaGlobal_DeadMessage_All._eDeadType.DeadLocate_InSiegeBattle or self._currentDeadType == PaGlobal_DeadMessage_All._eDeadType.DeadLocate_InMajorSiegeBattle or self._currentDeadType == PaGlobal_DeadMessage_All._eDeadType.DeadLocate_InSiegeBeingInCurrentPos then
    self._ui.btn_useFairyCheck:SetShow(false)
    self._ui.btn_useFairyCheck:SetCheck(false)
    self._ui.btn_useItemCheck:SetShow(false)
    self._ui.btn_useItemCheck:SetCheck(false)
  end
  local buttonList = PaGlobal_DeadMessage_All._ButtonListByDeadType[deadType]
  if nil == buttonList then
    return
  end
  for idx = 0, #buttonList do
    local buttonType = buttonList[idx]
    if buttonType ~= nil and PaGlobal_DeadMessage_All:checkButtonCondition(buttonType) == true then
      buttonArray:push_back(buttonType)
    end
  end
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  local freeRevivalLevel = FromClient_getFreeRevivalLevel()
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local isFreeArea = regionInfo:get():isFreeRevivalArea()
  local isArena = regionInfo:get():isArenaArea()
  local isSolare = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare)
  local showItemCheckBox = false
  local showFairyCheckBox = false
  if freeRevivalLevel >= getSelfPlayer():get():getLevel() and isFreeArea == true or isSolare == true or _eDeadType.DeadLocate_InBattleGround == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InCompetition == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InSavageDefence == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InGuildBattle == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InPVP == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InLocarWar == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InPrision == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.IsPremiumCharacter == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InAtoraxion == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InSolare == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InAbyssOne == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InSiegeBattle == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InMajorSiegeBattle == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InSiegeBeingInCurrentPos == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InGuildMatch == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InHardCoreChannel == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_Edania == PaGlobal_DeadMessage_All._currentDeadType or isArena == true then
    showItemCheckBox = false
    showFairyCheckBox = false
  else
    showItemCheckBox = true
    if true == ToClient_Fairy_CanRespawn() and true == _ContentsGroup_isFairy then
      showFairyCheckBox = true
    end
  end
  if true == showFairyCheckBox then
    PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:SetShow(true)
    local buttonSizeY = PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetSizeY()
    for ii = 0, #buttonArray - 1 do
      buttonControl[ii]:SetPosY(buttonControl[ii]:GetPosY() + buttonSizeY + 5)
    end
  else
    PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:SetShow(false)
    PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:SetCheck(false)
  end
  if true == PaGlobal_DeadMessage_All._isConsole then
    PaGlobal_DeadMessage_All._ui.btn_selectButton_console:SetPosY(PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetPosY() - 15)
  end
  if true == showItemCheckBox then
    PaGlobal_DeadMessage_All._ui.btn_useItemCheck:SetShow(true)
    local buttonSizeY = PaGlobal_DeadMessage_All._ui.btn_useItemCheck:GetSizeY()
    if true == showFairyCheckBox then
      PaGlobal_DeadMessage_All._ui.btn_useItemCheck:SetPosY(PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetPosY() + buttonSizeY + 5)
    else
      PaGlobal_DeadMessage_All._ui.btn_useItemCheck:SetPosY(PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetPosY())
    end
    for ii = 0, #buttonArray - 1 do
      buttonControl[ii]:SetPosY(buttonControl[ii]:GetPosY() + buttonSizeY + 5)
    end
  else
    PaGlobal_DeadMessage_All._ui.btn_useItemCheck:SetShow(false)
    PaGlobal_DeadMessage_All._ui.btn_useItemCheck:SetCheck(false)
  end
  local buttonUIIndex = 0
  for buttonIndex = 1, #buttonArray do
    local buttonType = buttonArray[buttonIndex]
    local buttonString = PaGlobal_DeadMessage_All._ButtonString[buttonType]
    local buttonEvent = PaGlobal_DeadMessage_All._ButtonEvent[buttonType]
    if buttonType == self._eButtonType.MinorSiegeOccupyModeRevivePosition0 then
      buttonString = ToClient_GetRegionNameByReviveIndex(0)
    elseif buttonType == self._eButtonType.MinorSiegeOccupyModeRevivePosition1 then
      buttonString = ToClient_GetRegionNameByReviveIndex(1)
    elseif buttonType == self._eButtonType.MinorSiegeOccupyModeRevivePosition2 then
      buttonString = ToClient_GetRegionNameByReviveIndex(2)
    elseif buttonType == self._eButtonType.MinorSiegeOccupyModeRevivePosition3 then
      buttonString = ToClient_GetRegionNameByReviveIndex(3)
    end
    PaGlobal_DeadMessage_All:checkUseItemFairy(buttonType)
    buttonControl[buttonUIIndex]:addInputEvent("Mouse_LUp", buttonEvent .. "()")
    if true == PaGlobal_DeadMessage_All._isConsole then
      buttonControl[buttonUIIndex]:addInputEvent("Mouse_On", "HandleEventOn_DeadMessage_All_ButtonMouseOn(" .. buttonUIIndex .. ")")
    end
    buttonControl[buttonUIIndex]:SetSize(buttonControl[buttonUIIndex]:GetSizeX(), PaGlobal_DeadMessage_All._ui.btn_smallTemplate:GetSizeY())
    buttonControl[buttonUIIndex]:SetShow(true)
    local stringControl = UI.getChildControl(buttonControl[buttonUIIndex], "StaticText_ButtonText1")
    stringControl:SetTextMode(__eTextMode_AutoWrap)
    stringControl:SetText(buttonString)
    local diffSizeY = stringControl:GetTextSizeY() - stringControl:GetSizeY()
    if diffSizeY > 0 then
      buttonControl[buttonUIIndex]:SetSize(buttonControl[buttonUIIndex]:GetSizeX(), buttonControl[buttonUIIndex]:GetSizeY() + diffSizeY)
      for ii = buttonIndex, #buttonArray do
        buttonControl[ii]:SetPosY(buttonControl[ii]:GetPosY() + diffSizeY)
      end
    end
    local reviveStringControl = UI.getChildControl(buttonControl[buttonUIIndex], "StaticText_ButtonText2")
    if PaGlobal_DeadMessage_All._eButtonType.Immediate == buttonType then
      reviveStringControl:SetShow(true)
      reviveStringControl:SetTextMode(__eTextMode_AutoWrap)
      local revivalItemCount = ToClient_InventorySizeByProductCategory(CppEnums.ItemWhereType.eCashInventory, __eContentsType_Respawn)
      if true == _ContentsGroup_FamilyInventory then
        revivalItemCount = revivalItemCount + ToClient_InventorySizeByProductCategory(CppEnums.ItemWhereType.eFamilyInventory, __eContentsType_Respawn)
      end
      if _eDeadType.DeadLocate_InBattleGround == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InCompetition == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InGuildBattle == PaGlobal_DeadMessage_All._currentDeadType and 0 == ToClient_GuildBattle_GetCurrentState() or _eDeadType.DeadLocate_InPVP == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.IsPremiumCharacter == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InGuildMatch == PaGlobal_DeadMessage_All._currentDeadType and 0 == ToClient_getCurrentGuildMatchState() or isArena == true then
        local noPaneltyString = "(" .. PAGetString(Defines.StringSheet_GAME, "LUA_PVPBATTLE_IMMEDIATECOUNT_TEXT") .. ")"
        reviveStringControl:SetText(noPaneltyString)
      elseif isFreeArea and freeRevivalLevel >= getSelfPlayer():get():getLevel() then
        local freeRevivalString = "(" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_RESURRECTION_POSSIBLE", "freeRevivalLevel", freeRevivalLevel) .. ")"
        reviveStringControl:SetText(freeRevivalString)
      elseif revivalItemCount <= 0 then
        local purchaseItemString = "(" .. PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_ITEM_RESURRECTION") .. ")"
        reviveStringControl:SetText(purchaseItemString)
      else
        local haveItemString = "(" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_GET_ITEM_RESURRECTION", "revivalItemCount", revivalItemCount) .. ")"
        reviveStringControl:SetText(haveItemString)
      end
      buttonControl[buttonUIIndex]:SetSize(buttonControl[buttonUIIndex]:GetSizeX(), PaGlobal_DeadMessage_All._ui.btn_largeTemplate:GetSizeY())
      stringControl:SetSpanSize(0, -15)
      stringControl:ComputePos()
      for ii = buttonIndex, #buttonArray do
        buttonControl[ii]:SetPosY(buttonControl[ii]:GetPosY() + 30)
      end
    else
      reviveStringControl:SetShow(false)
      stringControl:SetSpanSize(0, 0)
      stringControl:ComputePos()
    end
    buttonUIIndex = buttonUIIndex + 1
  end
  if nil ~= buttonControl[buttonUIIndex - 1] then
    PaGlobal_DeadMessage_All._ui.btn_specUpGuideIcon:SetPosY(buttonControl[buttonUIIndex - 1]:GetPosY() + buttonControl[buttonUIIndex - 1]:GetSizeY() + PaGlobal_DeadMessage_All._ui.btn_smallTemplate:GetSizeY())
  end
end
function PaGlobal_DeadMessage_All:checkUseItemFairy(buttonType)
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  local button = PaGlobal_DeadMessage_All._eButtonType
  local buttonEvent = PaGlobal_DeadMessage_All._ButtonEvent[buttonType]
  if nil == buttonEvent then
    return
  end
  local useItem = true
  local useFairy = true
  local selfProxy = getSelfPlayer()
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  if _eDeadType.DeadLocate_InBattleGround == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InCompetition == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InSavageDefence == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InGuildBattle == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InPVP == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InLocarWar == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InPrision == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.IsPremiumCharacter == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InSolare == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InSiegeBattle == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InMajorSiegeBattle == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InSiegeBeingInCurrentPos == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InGuildMatch == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_Edania == PaGlobal_DeadMessage_All._currentDeadType then
    useItem = false
    useFairy = false
  elseif true == FGlobal_IsCommercialService() then
    local freeRevivalLevel = FromClient_getFreeRevivalLevel()
    local isFreeArea = regionInfo:get():isFreeRevivalArea()
    if freeRevivalLevel >= selfProxy:get():getLevel() and true == isFreeArea then
      useItem = false
      useFairy = false
    end
  else
    useItem = false
    useFairy = false
  end
  if true == useItem then
    if button.NearTown == buttonType or button.Exploration == buttonType or button.GuildSpawn == buttonType then
      useItem = true
    else
      useItem = false
    end
  end
  if true == useFairy then
    if button.NearTown == buttonType or button.Exploration == buttonType or button.Immediate == buttonType then
      useFairy = true
    else
      useFairy = false
    end
  end
  if true == useItem then
    local prevExp = selfProxy:get():getPrevExp_s64()
    local currentExp = selfProxy:get():getExp_s64()
    local isArena = regionInfo:get():isArenaArea()
    if false == isArena and (true == PaGlobal_DeadMessage_All._isHasResotreExp or prevExp > currentExp) then
      useItem = true
    else
      useItem = false
    end
  end
  if true == useFairy then
    local canFairyRespawn = ToClient_Fairy_CanRespawn()
    if canFairyRespawn and _ContentsGroup_isFairy then
      useFairy = true
    else
      useFairy = false
    end
  end
  PaGlobal_DeadMessage_All._useItem = useItem
  PaGlobal_DeadMessage_All._useFairy = useFairy
end
function PaGlobal_DeadMessage_All:showDeadMessage(attackerActorKeyRaw, isSkipDeathPenalty)
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  local aniType = PaGlobal_DeadMessage_All._aniType
  local selfProxy = getSelfPlayer()
  local attackerActorProxyWrapper
  if nil ~= attackerActorKeyRaw then
    attackerActorProxyWrapper = getActor(attackerActorKeyRaw)
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local isMilitia = false
  local playerActorProxyWrapper
  local playerNickName = ""
  local attackerCharacterName = ""
  local needHideAttackerNameForPvpServer = true
  if attackerActorKeyRaw ~= nil then
    playerActorProxyWrapper = getPlayerActor(attackerActorKeyRaw)
  end
  if playerActorProxyWrapper ~= nil then
    isMilitia = playerActorProxyWrapper:get():isVolunteer()
    playerNickName = playerActorProxyWrapper:getUserNickname()
  end
  if attackerActorProxyWrapper ~= nil then
    attackerCharacterName = attackerActorProxyWrapper:getOriginalName()
    needHideAttackerNameForPvpServer = attackerActorProxyWrapper:IsNeedHideNameForPVPServer()
  end
  if ToClient_namelessPVPServer() == true and needHideAttackerNameForPvpServer == true then
    local name = PaGlobalFunc_getAnonymousNameString(0)
    playerNickName = name
    attackerCharacterName = name
  end
  if ToClient_HardCoreChannelWithContensOption() == true and attackerActorProxyWrapper ~= nil then
    local name = attackerActorProxyWrapper:getName()
    playerNickName = name
    attackerCharacterName = name
  end
  local deadMessageString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg")
  local deadWhoString
  if nil ~= attackerActorProxyWrapper then
    if attackerActorKeyRaw == selfProxy:getActorKey() then
      deadWhoString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg")
    elseif true == isMilitia then
      deadWhoString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA"))
    elseif true == _ContentsGroup_NameTypeEqually then
      local nameType = ToClient_getChatNameType()
      if __eChatNameType_NickName == nameType then
        if nil ~= playerActorProxyWrapper then
          deadWhoString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", playerNickName)
        end
      else
        deadWhoString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerCharacterName)
      end
    else
      deadWhoString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerCharacterName)
    end
  end
  PaGlobal_DeadMessage_All._ui.txt_deathTitle:SetText(deadMessageString)
  PaGlobal_DeadMessage_All._ui.txt_deathTitle:SetShow(true)
  if nil ~= deadWhoString then
    PaGlobal_DeadMessage_All._ui.txt_deathTitle:SetText(deadWhoString)
  end
  PaGlobal_DeadMessage_All:setDeadMessageAni()
  PaGlobal_DeadMessage_All:prepareOpen()
  if true == isSkipDeathPenalty then
    PaGlobal_DeadMessage_All._ui.list2_lostItem:getElementManager():pushKey(Defines.s64_const.s64_1)
  else
    for idx = 1, PaGlobal_DeadMessage_All._currentPaneltyStringCount do
      PaGlobal_DeadMessage_All._ui.list2_lostItem:getElementManager():pushKey(toInt64(0, idx))
    end
  end
  self._canRestoreJewel = false
  if 0 < Int64toInt32(self._ui.list2_lostItem:getElementManager():getSize()) then
    self._ui.stc_lostItemBG:SetShow(true)
    if _ContentsGroup_CrystalRestore == true and 0 < self._destoryJewelCount and self._isSkipDeathPenalty == false then
      local jewelRestorationCount = ToClient_GetJewelRestorationCount()
      local jewelRestorationMaxCount = ToClient_GetJewelRestorationMaxCount()
      self._ui.btn_restoreJewel:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_RESTORATION_BTN", "leftCount", jewelRestorationCount, "maxCount", jewelRestorationMaxCount))
      self._ui.btn_restoreJewel:SetShow(true)
      local isBadPlayer = 0 > selfProxy:get():getTendency()
      if jewelRestorationCount > 0 and isBadPlayer == false then
        self._ui.btn_restoreJewel:SetIgnore(false)
        self._ui.btn_restoreJewel:SetMonoTone(false)
        self._canRestoreJewel = true
      else
        self._ui.btn_restoreJewel:SetIgnore(true)
        self._ui.btn_restoreJewel:SetMonoTone(true)
      end
    else
      self._ui.btn_restoreJewel:SetShow(false)
    end
  else
    self._ui.stc_lostItemBG:SetShow(false)
  end
  local isArena = regionInfo:get():isArenaArea()
  if _eDeadType.DeadLocate_InBattleGround == deadType or _eDeadType.DeadLocate_InCompetition == deadType or _eDeadType.DeadLocate_InSavageDefence == deadType or _eDeadType.DeadLocate_InBloodAltar == deadType or _eDeadType.DeadLocate_InGuildBattle == deadType or _eDeadType.DeadLocate_InPVP == deadType or _eDeadType.DeadLocate_InLocarWar == deadType or _eDeadType.DeadLocate_InPrision == deadType or _eDeadType.DeadLocate_InMajorSiegeBattle == deadType or _eDeadType.DeadLocate_InSiegeBattle == deadType or _eDeadType.DeadLocate_InSiegeBeingInCurrentPos == deadType or _eDeadType.DeadLocate_InSiegeBeingChannel == deadType or _eDeadType.IsPremiumCharacter == deadType or _eDeadType.DeadLocate_InAtoraxion == deadType or _eDeadType.DeadLocate_InSolare == deadType or _eDeadType.DeadLocate_InAbyssOne == deadType or _eDeadType.DeadLocate_InGuildMatch == deadType or isArena == true or _eDeadType.DeadLocate_Edania == deadType then
    PaGlobal_DeadMessage_All._ui.btn_noticeIcon:SetShow(false)
  elseif nil ~= attackerActorProxyWrapper then
    local isAttackPlayer = attackerActorProxyWrapper:get():isPlayer()
    if true == isAttackPlayer then
      if ToClient_isDontPvPDecreaseTendency() then
        PaGlobal_DeadMessage_All._ui.btn_noticeIcon:SetShow(false)
        PaGlobal_DeadMessage_All._ui.stc_paneltyBG:SetShow(false)
      else
        PaGlobal_DeadMessage_All._ui.btn_noticeIcon:SetShow(true)
        PaGlobal_DeadMessage_All._ui.stc_paneltyBG:SetShow(PaGlobal_DeadMessage_All._isConsole)
      end
    else
      PaGlobal_DeadMessage_All._ui.btn_noticeIcon:SetShow(false)
    end
  end
end
function PaGlobal_DeadMessage_All:setAniToControl(control, aniType, startTime, endTime, startValue, endValue, isDisable)
  if nil == control then
    return
  end
  local aniInfo
  if aniType == PaGlobal_DeadMessage_All._aniType._changeColor then
    aniInfo = control:addColorAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo:SetStartColor(startValue)
    aniInfo:SetEndColor(endValue)
  elseif aniType == PaGlobal_DeadMessage_All._aniType._changeScale then
    aniInfo = control:addScaleAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo:SetStartScale(startValue)
    aniInfo:SetEndScale(endValue)
  else
    return
  end
  aniInfo.IsChangeChild = true
  aniInfo:SetDisableWhileAni(true)
  control:SetDisableWhileAnimationChild(true)
  if true == isDisable then
    aniInfo:SetIgnoreUpdateSnapping(true)
  end
end
function PaGlobal_DeadMessage_All:setDeadMessageAni()
  local buttonControl = PaGlobal_DeadMessage_All._ui._button_Respawn
  local button = PaGlobal_DeadMessage_All._eButtonType
  local aniType = PaGlobal_DeadMessage_All._aniType
  local buttonUIIndex = 0
  for index = 1, #PaGlobal_DeadMessage_All._buttonTypeArray do
    local buttonType = PaGlobal_DeadMessage_All._buttonTypeArray[index]
    local control = buttonControl[buttonUIIndex]
    if nil == control then
    elseif button.Immediate == buttonType then
      PaGlobal_DeadMessage_All:setAniToControl(control, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
      PaGlobal_DeadMessage_All:setAniToControl(control, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
    elseif button.Exploration == buttonType or button.NearTown == buttonType or button.InSiegeingFortress == buttonType or button.LocalWar == buttonType or button.AdvancedBase == buttonType or button.GuildSpawn == buttonType or button.SavageDefence == buttonType or button.OutsideGate == buttonType or button.InsideGate == buttonType or button.ExitBloodAltar == buttonType or button.Atoraxion == buttonType or button.GuildMatch == buttonType or button.HardCoreChannel == buttonType or button.MinorSiegeOccupyModeRevivePosition0 == buttonType or button.MinorSiegeOccupyModeRevivePosition1 == buttonType or button.MinorSiegeOccupyModeRevivePosition2 == buttonType or button.MinorSiegeOccupyModeRevivePosition3 == buttonType or button.Edana == buttonType or button.EdaniaInstanceFieldExit == buttonType then
      PaGlobal_DeadMessage_All:setAniToControl(control, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
      PaGlobal_DeadMessage_All:setAniToControl(control, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
      PaGlobal_DeadMessage_All:setAniToControl(control, aniType._changeScale, 2.5, 3.2, 0.5, 1, true)
    elseif button.Observer == buttonType or button.GuildObServerMode == buttonType or button.SolareObserver == buttonType then
      PaGlobal_DeadMessage_All:setAniToControl(control, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
      PaGlobal_DeadMessage_All:setAniToControl(control, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
    end
    buttonUIIndex = buttonUIIndex + 1
  end
  local messageControl = PaGlobal_DeadMessage_All._ui.txt_deathTitle
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 1.5, 2.3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeScale, 0.7, 2.5, 0.5, 1)
  messageControl = PaGlobal_DeadMessage_All._ui.stc_circleBG
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  messageControl = PaGlobal_DeadMessage_All._ui.txt_resurrectionTime
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 2, 2.3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeScale, 0.7, 2.3, 0.5, 1)
  messageControl = PaGlobal_DeadMessage_All._ui.list2_content
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 2.5, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF)
  messageControl = PaGlobal_DeadMessage_All._ui.stc_lineTop
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 2.5, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  messageControl = PaGlobal_DeadMessage_All._ui.stc_lineBottom
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 2.5, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  messageControl = PaGlobal_DeadMessage_All._ui.stc_lostItemBG
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 2.5, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  messageControl = PaGlobal_DeadMessage_All._ui.btn_useItemCheck
  if true == messageControl:GetShow() then
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  end
  messageControl = PaGlobal_DeadMessage_All._ui.btn_useFairyCheck
  if true == messageControl:GetShow() then
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  end
  messageControl = PaGlobal_DeadMessage_All._ui.btn_noticeIcon
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  if true == _ContentsGroup_ChinaFontColor then
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFF5BA3A, true)
  else
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFD05D48, true)
  end
  messageControl = PaGlobal_DeadMessage_All._ui.btn_specUpGuideIcon
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  if true == PaGlobal_DeadMessage_All._isConsole then
    messageControl = PaGlobal_DeadMessage_All._ui.btn_selectButton_console
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
    messageControl = PaGlobal_DeadMessage_All._ui.stc_paneltyBG
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFD05D48, true)
  end
  if _ContentsGroup_CrystalRestore == true and 0 < self._destoryJewelCount and self._isSkipDeathPenalty == false then
    messageControl = PaGlobal_DeadMessage_All._ui.btn_restoreJewel
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 2.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 2.5, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  end
end
function PaGlobal_DeadMessage_All:useCheckFairy(respawnType)
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local isArena = regionInfo:get():isArenaArea()
  if true == isArena and respawnType == __eRespawnType_Immediately then
    deadMessage_Revival(__eRespawnType_Immediately, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), false, false, 0, __eRoseWarRespawnPositionType_Count, false, 0)
  else
    deadMessage_Revival(respawnType, 255, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), true, false, 0, __eRoseWarRespawnPositionType_Count, false, 0)
  end
end
function PaGlobal_DeadMessage_All:respawnWithCashItem(respawnType)
  local jewelRestorationCount = ToClient_GetJewelRestorationCount()
  if _ContentsGroup_CrystalRestore == true and self:checkCanRestoreJewel() == true then
    PaGlobal_DeadMessage_All._canRestoreJewel = true
  end
  local revivalItemCount = ToClient_InventorySizeByProductCategory(CppEnums.ItemWhereType.eCashInventory, __eContentsType_Respawn)
  if true == _ContentsGroup_FamilyInventory then
    revivalItemCount = revivalItemCount + ToClient_InventorySizeByProductCategory(CppEnums.ItemWhereType.eFamilyInventory, __eContentsType_Respawn)
  end
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local isArena = regionInfo:get():isArenaArea()
  if true == isArena and respawnType == __eRespawnType_Immediately then
    deadMessage_Revival(__eRespawnType_Immediately, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), false, false, 0, __eRoseWarRespawnPositionType_Count, false, 0)
  elseif 1 == revivalItemCount then
    HandleEventLUp_Cash_Revival_BuyItem_All_Apply_CashRevivalItem(respawnType)
  elseif revivalItemCount > 1 then
    PaGlobal_Cash_Revival_BuyItem_All_Open(respawnType)
  else
    HandleEventLUp_Cash_Revival_BuyItem_All_Buy_CashRevivalItem(respawnType)
  end
end
function PaGlobal_DeadMessage_All:checkCanRestoreJewel()
  if self._isSkipDeathPenalty == true then
    return false
  end
  local selfProxy = getSelfPlayer()
  local isBadPlayer = selfProxy:get():getTendency() < 0
  if isBadPlayer == true then
    return false
  end
  if 0 >= self._destoryJewelCount then
    return false
  end
  local jewelRestorationCount = ToClient_GetJewelRestorationCount()
  if jewelRestorationCount <= 0 then
    return false
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition(buttonType)
  local button = PaGlobal_DeadMessage_All._eButtonType
  if button.Immediate == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_Immediate()
  elseif button.Exploration == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_Exploration()
  elseif button.Observer == buttonType or button.SolareObserver == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_Observer()
  elseif button.GuildObServerMode == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_GuildObserverMode()
  elseif button.GuildSpawn == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_GuildSpawn()
  elseif button.AdvancedBase == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_AdvancedBase()
  elseif button.OutsideGate == buttonType or button.InsideGate == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_MajorSiegeGate()
  elseif button.NearTown == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_NearTown()
  elseif button.MinorSiegeOccupyModeRevivePosition0 == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_MinorSiegeOccupyMode(0)
  elseif button.MinorSiegeOccupyModeRevivePosition1 == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_MinorSiegeOccupyMode(1)
  elseif button.MinorSiegeOccupyModeRevivePosition2 == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_MinorSiegeOccupyMode(2)
  elseif button.MinorSiegeOccupyModeRevivePosition3 == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_MinorSiegeOccupyMode(3)
  elseif button.Edana == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_Edana()
  elseif button.EdaniaInstanceFieldExit == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_EdaniaInstanceFieldExit()
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_Immediate()
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  local selfProxy = getSelfPlayer()
  if _eDeadType.DeadLocate_InGuildBattle == deadType then
    if 0 ~= ToClient_GuildBattle_GetCurrentState() then
      return false
    end
  elseif _eDeadType.DeadLocate_InCompetition == deadType then
    if false == selfProxy:get():isCompetitionHost() then
      return false
    end
  elseif _eDeadType.Dead_Normal == deadType and false == FGlobal_IsCommercialService() then
    local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
    if false == regionInfo:get():isArenaArea() then
      return false
    end
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_Exploration()
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  if _eDeadType.DeadLocate_InSiegeBattle == deadType then
    local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
    local linkedSiegeRegionInfoWrapper = ToClient_getVillageSiegeRegionInfoWrapperByPosition(getSelfPlayer():get():getPosition())
    if regionInfo:get():isMajorSiegeBeing() or linkedSiegeRegionInfoWrapper:get():isMinorSiegeBeing() or linkedSiegeRegionInfoWrapper:get():isOceanSiegeBeing() then
      return false
    end
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_Observer()
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  if _eDeadType.DeadLocate_InCompetition == deadType then
    if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == ToClient_CompetitionMatchType() then
      return false
    end
  elseif _eDeadType.DeadLocate_InGuildBattle == deadType then
    if 0 == ToClient_GuildBattle_GetCurrentState() then
      return false
    end
    if __eGuildBattleGameMode_OneOne == ToClient_GuildBattle_GetCurrentMode() then
      return false
    end
  elseif _eDeadType.DeadLocate_InSiegeBeingChannel == deadType or _eDeadType.DeadLocate_InSiegeBeingInCurrentPos == deadType or _eDeadType.DeadLocate_InSiegeBattle == deadType or _eDeadType.DeadLocate_InMajorSiegeBattle == deadType then
    local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
    if nil == myGuildInfo then
      return false
    end
    local guildNo = myGuildInfo:getGuildNo_s64()
    if false == ToClient_IsInSiegeBattle(guildNo) then
      return false
    end
  elseif _eDeadType.DeadLocate_Edania == deadType and ToClient_GetEdanaInstanceFieldMode() == __eEdaniaInstanceContentsMode_Edana then
    return false
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_GuildObserverMode()
  if true == PaGlobal_DeadMessage_All._isConsole then
    return false
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    return true
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil ~= myGuildInfo then
    local guildNo = myGuildInfo:getGuildNo_s64()
    if ToClient_IsInSiegeBattle(guildNo) then
      return true
    end
  end
  return false
end
function PaGlobal_DeadMessage_All:checkButtonCondition_GuildSpawn()
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  if _eDeadType.Dead_Normal == deadType or _eDeadType.DeadLocate_InNoAccessArea == deadType or _eDeadType.DeadLocate_InSiegeBeingChannel == deadType or _eDeadType.DeadLocate_InSiegeBeingInCurrentPos == deadType or _eDeadType.DeadLocate_InSiegeBattle == deadType or _eDeadType.DeadLocate_InMajorSiegeBattle == deadType then
    local guildUnSealCount = guildstable_getUnsealGuildServantCount()
    if 0 == guildUnSealCount then
      return false
    end
    local isGuildServant = false
    for index = 0, guildUnSealCount - 1 do
      local servantInfo = guildStable_getUnsealGuildServantAt(index)
      if nil ~= servantInfo and (CppEnums.VehicleType.Type_SailingBoat == servantInfo:getVehicleType() or CppEnums.VehicleType.Type_PersonalBattleShip == servantInfo:getVehicleType()) then
        isGuildServant = true
      end
    end
    if false == isGuildServant then
      return false
    end
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_AdvancedBase()
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  if _eDeadType.Dead_Normal == deadType or _eDeadType.DeadLocate_InNoAccessArea == deadType or _eDeadType.DeadLocate_InSiegeBeingChannel == deadType or _eDeadType.DeadLocate_InSiegeBeingInCurrentPos == deadType or _eDeadType.DeadLocate_InSiegeBattle == deadType or _eDeadType.DeadLocate_InMajorSiegeBattle == deadType then
    local selfProxy = getSelfPlayer()
    if false == selfProxy:get():isGuildMember() then
      return false
    end
    if false == selfProxy:get():isAdvancedBaseActorKey() then
      return false
    end
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_MajorSiegeGate()
  return deadMessage_isCanMajorSiegeGateRebirth()
end
function PaGlobal_DeadMessage_All:checkButtonCondition_NearTown()
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return true
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if nil == regionInfo then
    return true
  end
  local isPVEArenaZone = regionInfo:get():isPVEArenaZone()
  if true == isPVEArenaZone then
    return false
  end
  if ToClient_IsSelfParticipateInSiege2024() == true then
    return false
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_MinorSiegeOccupyMode(index)
  if index >= ToClient_GetSiege2024RevivePositionCount() then
    return false
  end
  if ToClient_IsSelfParticipateInSiege2024() == false then
    return false
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_Edana()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == false then
    return false
  end
  if selfPlayerWrapper:isInEdaniaRegion() == false then
    return false
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_EdaniaInstanceFieldExit()
  if PaGlobal_DeadMessage_All._eDeadType.DeadLocate_Edania ~= PaGlobal_DeadMessage_All._currentDeadType then
    return false
  end
  if ToClient_GetEdanaInstanceFieldMode() ~= __eEdaniaInstanceContentsMode_Challenger then
    return false
  end
  return true
end
function PaGlobal_DeadMessage_All:validate()
  if nil == Panel_Window_DeadMessage_All then
    return
  end
  PaGlobal_DeadMessage_All._ui.stc_centerBG:isValidate()
  PaGlobal_DeadMessage_All._ui.txt_deathTitle:isValidate()
  PaGlobal_DeadMessage_All._ui.txt_resurrectionTime:isValidate()
  PaGlobal_DeadMessage_All._ui.txt_GuildSkillApply:isValidate()
  PaGlobal_DeadMessage_All._ui.stc_lostItemBG:isValidate()
  PaGlobal_DeadMessage_All._ui.stc_lineTop:isValidate()
  PaGlobal_DeadMessage_All._ui.stc_lineBottom:isValidate()
  PaGlobal_DeadMessage_All._ui.list2_lostItem:isValidate()
  PaGlobal_DeadMessage_All._ui.stc_resurrectionBG:isValidate()
  PaGlobal_DeadMessage_All._ui.btn_noticeIcon:isValidate()
  PaGlobal_DeadMessage_All._ui.btn_selectButton_console:isValidate()
  PaGlobal_DeadMessage_All._ui.btn_specUpGuideIcon:isValidate()
  PaGlobal_DeadMessage_All._ui.stc_paneltyBG:isValidate()
end
function PaGlobal_DeadMessage_All:actionGuideOnOff(isOn)
  if nil == PaGlobal_UIModify then
    return
  end
  local actionGuideIndex = PaGlobal_UIModify._panelID.ActionGuide
  if PaGlobal_UIModify._panelControl == nil then
    return
  end
  local panelControl = PaGlobal_UIModify._panelControl[actionGuideIndex]
  if nil == panelControl then
    return
  end
  if false == panelControl.isShow then
    return
  end
  if nil == panelControl.control then
    return
  end
  if true == isOn then
    if true == PaGlobal_DeadMessage_All._isObserverMode then
      panelControl.control:SetShow(true)
    end
  else
    panelControl.control:SetShow(false)
  end
end
