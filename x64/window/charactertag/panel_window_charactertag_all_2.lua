function PaGlobalFunc_CharacterTag_All_Open()
  PaGlobal_CharacterTag_All:prepareOpen()
end
function PaGlobalFunc_CharacterTag_All_Close()
  PaGlobal_CharacterTag_All:prepareClose()
end
function PaGlobalFunc_CharacterTag_All_IsTagChange()
  local retBool = PaGlobal_CharacterTag_All._doTag
  if true == PaGlobal_CharacterTag_All._doTag then
    PaGlobal_CharacterTag_All._doTag = false
  end
  return retBool
end
function PaGlobalFunc_CharacterTag_All_DeleteTagCharacter(characterKey)
  ToClient_RequestDeleteDuelCharacter(characterKey)
end
function PaGlobalFunc_CharacterTag_All_RequestTagCharacter(characterKey)
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local reqData = LuaCharacterNoData()
  reqData:push_back(selfPlayerWrapper:getCharacterNo_64())
  reqData:push_back(characterKey)
  ToClient_RequestDuelCharacter(reqData)
end
function PaGlobalFunc_CharacterTag_All_UpdateCurrentRegionText()
  if Panel_CharacterTag_All:GetShow() == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local selfPlayerChar_No_s64 = selfPlayer:getCharacterNo_64()
  if ToClient_IsDuelCharacterByCharacterNo(selfPlayerChar_No_s64) == true then
    local selfCharIndex = ToClient_GetMyCharacterIndex()
    PaGlobal_CharacterTag_All:loadMainFace()
  end
end
function PaGlobalFunc_CharacterTag_All_Change()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local index = PaGlobalFunc_CharacterTag_All_GetDuelCharcterIndex()
  if PaGlobal_CharacterTag_All.LOCAL_DEFINE.NODUEL == index then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CURRENT_NOT_TAGGING"))
    return
  end
  if false == ToClient_CheckCharacterTagReusable() then
    return
  end
  if true == ToClient_getJoinGuildBattle() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CANTDO_GUILDBATTLE"))
    return
  end
  local regionInfo = getRegionInfoByPosition(selfPlayer:getPosition())
  if nil ~= regionInfo and true == regionInfo:isPrison() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERTAG_PRISON_CANT_TAG"))
    return
  end
  if true == ToClient_IsInstanceField() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
    return
  end
  if (true == _ContentsGroup_isOepnImmortalHell or true == _ContentsGroup_isOpenImmortalHellForConsole) and nil ~= regionInfo and nil ~= regionInfo:get() and true == regionInfo:get():isPVEArenaZone() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
    return
  end
  if true == selfPlayer:isCompetitionDefined() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterCompetitionStart"))
    return
  end
  PaGlobal_CharacterTag_All._doTag = true
  PaGlobal_GameExit_All_ChangeCharacter(index)
end
function HandleEventLUp_CharacterTag_All_Close()
  PaGlobalFunc_CharacterTag_All_Close()
end
function HandleEventLUp_CharacterTag_All_PopUpUI()
  if true == PaGlobal_CharacterTag_All._ui_pc.chk_popup:IsCheck() then
    Panel_CharacterTag_All:OpenUISubApp()
  else
    Panel_CharacterTag_All:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function HandleEventOnOut_CharacterTag_All_PopUpTooltip(isShow)
  if isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if PaGlobal_CharacterTag_All._ui_pc.chk_popup:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(PaGlobal_CharacterTag_All._ui_pc.chk_popup, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventScroll_CharacterTag_All_ScrollEvent(isUp)
  PaGlobal_CharacterTag_All._pageIndex = UIScroll.ScrollEvent(PaGlobal_CharacterTag_All._ui.stc_scrollBg, isUp, 1, math.ceil(PaGlobal_CharacterTag_All._maxCharacterCount / 6), PaGlobal_CharacterTag_All._pageIndex, 1)
  for idx = 0, 5 do
    local targetUI = PaGlobal_CharacterTag_All._ui.characterList[idx]
    local Static_BG = UI.getChildControl(targetUI, "Static_BG")
    if PaGlobal_CharacterTag_All._pageIndex == PaGlobal_CharacterTag_All._sideImg._page and idx == PaGlobal_CharacterTag_All._sideImg._index then
      Static_BG:SetShow(true)
    else
      Static_BG:SetShow(false)
    end
  end
  PaGlobal_CharacterTag_All:loadList()
end
function HandleEventLUp_CharacterTag_All_ClickCharacterList(charIndex)
  local slotNo = PaGlobal_CharacterTag_All.LOCAL_DEFINE.CHARSLOTCOLMAX * PaGlobal_CharacterTag_All._pageIndex
  local charMaxCount = getCharacterDataCount(__ePlayerCreateNormal)
  if charIndex < 0 or charIndex > charMaxCount then
    return
  end
  PaGlobal_CharacterTag_All:setRightFace(charIndex)
  PaGlobal_CharacterTag_All._ui.mainImg2.stc_addIcon:SetShow(false)
  local characterData = getCharacterDataByIndex(charIndex, __ePlayerCreateNormal)
  PaGlobal_CharacterTag_All._requestCharacterKey = characterData._characterNo_s64
  for idx = 0, 5 do
    local targetUI = PaGlobal_CharacterTag_All._ui.characterList[idx]
    local Static_BG = UI.getChildControl(targetUI, "Static_BG")
    if idx == charIndex - slotNo then
      Static_BG:SetShow(true)
      PaGlobal_CharacterTag_All._sideImg._page = PaGlobal_CharacterTag_All._pageIndex
      PaGlobal_CharacterTag_All._sideImg._index = idx
    else
      Static_BG:SetShow(false)
    end
  end
end
function HandleEventRUp_CharacterTag_All_DeleteTagCharacter()
  PaGlobal_CharacterTag_All._ui.chk_tagState:SetCheck(PaGlobal_CharacterTag_All._currentTagState)
  PaGlobal_CharacterTag_All._ui.chk_tagStateExp:SetCheck(PaGlobal_CharacterTag_All._currentTagState)
  if false == PaGlobal_CharacterTag_All._selfCharTag then
    return
  end
  if PaGlobal_CharacterTag_All.LOCAL_DEFINE.NODUEL == PaGlobal_CharacterTag_All._requestCharacterKey then
    return
  end
  if PaGlobal_CharacterTag_All._currentTagState then
    if true == _ContentsGroup_DuelCharacterCopyEquip then
      local yesDelete = function()
        PaGlobalFunc_CharacterTag_All_DeleteTagCharacter(PaGlobal_CharacterTag_All._requestCharacterKey)
      end
      local duelCharacterString = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTER_TAG_DELETE_ITEM_ALERT")
      local messageBoxData = {
        content = duelCharacterString,
        functionYes = yesDelete,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      PaGlobalFunc_CharacterTag_All_DeleteTagCharacter(PaGlobal_CharacterTag_All._requestCharacterKey)
    end
  end
end
function HandleEventLUp_CharacterTag_All_ClickRequestTag()
  PaGlobal_CharacterTag_All._ui.chk_tagState:SetCheck(PaGlobal_CharacterTag_All._currentTagState)
  PaGlobal_CharacterTag_All._ui.chk_tagStateExp:SetCheck(PaGlobal_CharacterTag_All._currentTagState)
  if false == PaGlobal_CharacterTag_All._selfCharTag then
    return
  end
  if PaGlobal_CharacterTag_All.LOCAL_DEFINE.NODUEL == PaGlobal_CharacterTag_All._requestCharacterKey then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_NEEDSELECTCHARACTER"))
    return
  end
  if PaGlobal_CharacterTag_All._currentTagState then
    if true == _ContentsGroup_DuelCharacterCopyEquip then
      local yesDelete = function()
        PaGlobalFunc_CharacterTag_All_DeleteTagCharacter(PaGlobal_CharacterTag_All._requestCharacterKey)
      end
      local duelCharacterString = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTER_TAG_DELETE_ITEM_ALERT")
      local messageBoxData = {
        content = duelCharacterString,
        functionYes = yesDelete,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      PaGlobalFunc_CharacterTag_All_DeleteTagCharacter(PaGlobal_CharacterTag_All._requestCharacterKey)
    end
  else
    PaGlobalFunc_CharacterTag_All_RequestTagCharacter(PaGlobal_CharacterTag_All._requestCharacterKey)
  end
end
function HandleEventLUp_CharacterTag_All_CharacterTagButton()
  local selfPlayer = getSelfPlayer()
  local duelCharIndex = -1
  local selfPlayerChar_No_s64 = selfPlayer:getCharacterNo_64()
  local selfPlayerChar_No_s32 = Int64toInt32(selfPlayerChar_No_s64)
  if ToClient_IsDuelCharacterByCharacterNo(selfPlayerChar_No_s64) == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAKEEXP_WARNING2"))
    return
  end
  ToClient_updateDuelExp()
end
function FromClient_CharacterTag_All_SelfPlayerLevelUp()
  if true == _ContentsGroup_RemasterUI_Main then
    PaGlobalFunc_ServantIcon_UpdateOtherIcon(PaGlobalFunc_ServantIcon_GetTagIndex())
  end
end
function FromClient_CharacterTag_All_SuccessRequest()
  local showModeNum = 0
  local mainCharater = getCharacterDataByIndex(ToClient_GetMyCharacterIndex(), __ePlayerCreateNormal)
  local tagIndex = 0
  if ToClient_GetMyCharacterIndex() == ToClient_GetMyDuelCharacterIndex(tagIndex) then
    tagIndex = tagIndex + 1
  end
  local subCharacter = getCharacterDataByIndex(PaGlobalFunc_CharacterTag_All_GetDuelCharcterIndex(), __ePlayerCreateNormal)
  local subCharacterLV = 0
  local expUI_Show = 0
  PaGlobal_CharacterTag_All:showManager(showModeNum, subCharacterLV)
  PaGlobalFunc_CharacterTag_All_Open()
end
function FromClient_CharacterTag_All_SuccessDelete()
  local showModeNum = 0
  PaGlobal_CharacterTag_All._doTag = false
  PaGlobalFunc_CharacterTag_All_Open()
  PaGlobal_CharacterTag_All:showManager(showModeNum)
  if true == _ContentsGroup_DuelCharacterCopyEquip and nil ~= PaGlobal_Equip_CharacterTag_ItemCopy_Close then
    PaGlobal_Equip_CharacterTag_ItemCopy_Close()
  end
end
function FromClient_CharacterTag_All_NotifyUpdateDuelCharacterExp()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_TAKEEXP_SUCCESS"))
  if ToClient_doHaveDuelExp() == false then
    PaGlobal_CharacterTag_All._ui.btn_takeEXP:SetShow(false)
    PaGlobal_CharacterTag_All._ui.btn_charTAG:SetShow(true)
    PaGlobal_CharacterTag_All._ui.btn_charTAG:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_DELETEDUEL"))
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer ~= nil then
    local charLv = selfPlayer:get():getLevel()
    PaGlobal_CharacterTag_All._ui.mainImg1.txt_lv:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. charLv)
  end
end
function HandleEventLUp_CharacterTag_All_ItemCopy()
  if true == _ContentsGroup_DuelCharacterCopyEquip then
    ToClient_PrePareCopyMyEquipItems()
  end
end
function FromClient_PrePareCopyMyEquipItem()
  if _ContentsGroup_DuelCharacterCopyEquip == true and Panel_Window_Equip_CharacterTag_ItemCopy ~= nil and Panel_Window_Equip_CharacterTag_ItemCopy:GetShow() == false then
    PaGlobal_Equip_CharacterTag_ItemCopy_Open()
  end
end
function PaGlobalFunc_CharacterTag_All_GetDuelCharcterIndex()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return -1
  end
  local selfCharIndex = ToClient_GetMyCharacterIndex()
  local duelCharacterTbl = Array.new()
  local duelCount = ToClient_GetMyDuelCharacterCount()
  for idx = 0, duelCount - 1 do
    local duelIndex = ToClient_GetMyDuelCharacterIndex(idx)
    if selfCharIndex ~= duelIndex then
      duelCharacterTbl:push_back(duelIndex)
    end
  end
  if #duelCharacterTbl > 0 then
    return duelCharacterTbl[1]
  end
  return -1
end
function FromClient_CharacterTag_All_ShowDelay(sec)
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SYNCDUELPOSITION_NOPROCESSING", "time", tostring(sec))
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSGBOX_TITLE"),
    content = messageBoxMemo,
    functionApply = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_CharacterTag_All_UpdateSyncBtn(isOnlyUpdate)
  if _ContentsGroup_DuelCharacterPositionDesync == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local selfPlayerChar_No_s64 = selfPlayer:getCharacterNo_64()
  local isDuelCharacter = ToClient_IsDuelCharacterByCharacterNo(selfPlayerChar_No_s64)
  PaGlobal_CharacterTag_All._ui.btn_SyncPosition:SetIgnore(isDuelCharacter == false)
  PaGlobal_CharacterTag_All._ui.btn_SyncPosition:SetMonoTone(isDuelCharacter == false, isDuelCharacter == false)
  local result = ToClient_IsSyncDuelCharacterPosition()
  if isOnlyUpdate == nil or isOnlyUpdate == false then
    if result == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERTAG_INDIVIDUALACTION_OFF"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERTAG_INDIVIDUALACTION_ON"))
    end
  end
  local check = UI.getChildControl(PaGlobal_CharacterTag_All._ui.btn_SyncPosition, "CheckButton_PopUp")
  check:SetCheck(not result)
end
function HandleEventLUp_CharacterTag_All_SetPositionSyncState()
  if _ContentsGroup_DuelCharacterPositionDesync == false then
    return
  end
  if IsSelfPlayerWaitAction() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_NOTUSEALERT"))
    return
  end
  ToClient_ReqChangeSyncDuelCharacterPosition()
end
