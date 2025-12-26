PaGlobal_Journal_Page_All = {
  _ui = {
    _frame_list = nil,
    _frame_content = nil,
    _txt_desc = nil,
    _scroll_vs = nil,
    _scroll_vsCtrl = nil,
    _btn_close = nil,
    _btn_navi = nil,
    _btn_autoNavi = nil
  },
  _naviGroup = nil,
  _isAuto = nil,
  _isPadSnapping = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Journal_Page_All_luaLoadeComplete")
function FromClient_PaGlobal_Journal_Page_All_luaLoadeComplete()
  PaGlobal_Journal_Page_All:initialize()
end
function PaGlobal_Journal_Page_All:initialize()
  if self._initialize then
    return
  end
  if Panel_Window_Journal_Page_All == nil then
    return
  end
  local titleArea = UI.getChildControl(Panel_Window_Journal_Page_All, "Static_TitleArea")
  self._ui._btn_close = UI.getChildControl(titleArea, "Button_Win_Close")
  self._ui._btn_navi = UI.getChildControl(Panel_Window_Journal_Page_All, "CheckBtn_Quest_Navi")
  self._ui._btn_autoNavi = UI.getChildControl(Panel_Window_Journal_Page_All, "CheckBtn_Quest_AutoNavi")
  local subBg = UI.getChildControl(Panel_Window_Journal_Page_All, "Static_SubBg")
  self._ui._frame_list = UI.getChildControl(subBg, "Frame_ScenarioDesc")
  self._ui._frame_content = UI.getChildControl(self._ui._frame_list, "Frame_1_Content")
  self._ui._txt_desc = UI.getChildControl(self._ui._frame_content, "StaticText_Desc")
  self._ui._scroll_vs = UI.getChildControl(self._ui._frame_list, "Frame_1_VerticalScroll")
  self._ui._scroll_vsCtrl = UI.getChildControl(self._ui._scroll_vs, "Frame_1_VerticalScroll_CtrlButton")
  self._isPadSnapping = ToClient_isUsePadSnapping()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Journal_Page_All:registEventHandler()
  if Panel_Window_Journal_Page_All == nil then
    return
  end
  if self._isPadSnapping == true then
    self._ui._btn_close:SetShow(false)
    Panel_Window_Journal_Page_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_Journal_Page_All_Close()")
  else
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Journal_Page_All_Close()")
  end
end
function PaGlobal_Journal_Page_All:prepareOpen(journalListIndex, chapterIndex, uiTypeIndex, journalIndex, posX, posY)
  if Panel_Window_Journal_Page_All == nil then
    return
  end
  if Panel_Window_Journal_Book_All ~= nil and Panel_Window_Journal_Book_All:GetShow() == true then
    return
  end
  self:update(journalListIndex, chapterIndex, uiTypeIndex, journalIndex)
  if uiTypeIndex == 1 then
    posX = posX + 30
    posY = posY + 50
  else
    posY = posY + math.floor(Panel_Window_Journal_All:GetSizeY() / 2)
  end
  Panel_Window_Journal_Page_All:SetPosXY(posX, posY)
  self:open()
end
function PaGlobal_Journal_Page_All:open()
  if Panel_Window_Journal_Page_All == nil then
    return
  end
  Panel_Window_Journal_Page_All:SetShow(true)
end
function PaGlobal_Journal_Page_All:prepareClose()
  if Panel_Window_Journal_Page_All == nil then
    return
  end
  self._naviGroup = nil
  self._isAuto = nil
  self:close()
end
function PaGlobal_Journal_Page_All:close()
  if Panel_Window_Journal_Page_All == nil then
    return
  end
  Panel_Window_Journal_Page_All:SetShow(false)
end
function PaGlobal_Journal_Page_All:update(journalListIndex, chapterIndex, uiTypeIndex, journalIndex)
  if Panel_Window_Journal_Page_All == nil then
    return
  end
  local journalInfo = ToClient_getJournalInfo(journalListIndex, chapterIndex, uiTypeIndex, journalIndex)
  if journalInfo:isDefined() == false then
    return
  end
  local groupId = journalInfo._questGroupNo
  local desc = journalInfo:getScenarioDesc()
  if groupId == nil or desc == nil then
    return
  end
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, desc))
  if self:isHideNavi(journalInfo) == true then
    self._ui._btn_navi:SetShow(false)
    self._ui._btn_autoNavi:SetShow(false)
  else
    self._ui._btn_navi:SetShow(true)
    self._ui._btn_navi:SetIgnore(false)
    self._ui._btn_navi:addInputEvent("Mouse_LUp", "PaGlobal_Journal_Page_All_FindNavi(" .. tostring(groupId) .. "," .. tostring(1) .. ", false )")
    self._ui._btn_navi:SetCheck(false)
    self._ui._btn_autoNavi:SetShow(true)
    self._ui._btn_autoNavi:SetIgnore(false)
    self._ui._btn_autoNavi:addInputEvent("Mouse_LUp", "PaGlobal_Journal_Page_All_FindNavi(" .. tostring(groupId) .. "," .. tostring(1) .. ", true )")
    self._ui._btn_autoNavi:SetCheck(false)
    if self._naviGroup ~= nil and self._naviGroup == groupId then
      if self._isAuto == false then
        self._ui._btn_navi:SetCheck(true)
      else
        self._ui._btn_navi:SetCheck(true)
        self._ui._btn_autoNavi:SetCheck(true)
      end
    end
  end
  local pageBaseTextureId = ToClient_getJournalTextureInfo(journalListIndex, 7)
  local pageBtnBaseTextureId = ToClient_getJournalTextureInfo(journalListIndex, 8)
  local pageBtnOnTextureId = ToClient_getJournalTextureInfo(journalListIndex, 9)
  local pageBtnClickTextureId = ToClient_getJournalTextureInfo(journalListIndex, 10)
  Panel_Window_Journal_Page_All:ChangeTextureInfoTextureIDAsync(pageBaseTextureId)
  self._ui._btn_navi:ChangeTextureInfoTextureIDAsync(pageBtnBaseTextureId, 0)
  self._ui._btn_navi:ChangeTextureInfoTextureIDAsync(pageBtnOnTextureId, 1)
  self._ui._btn_navi:ChangeTextureInfoTextureIDAsync(pageBtnClickTextureId, 2)
  self._ui._btn_autoNavi:ChangeTextureInfoTextureIDAsync(pageBtnBaseTextureId, 0)
  self._ui._btn_autoNavi:ChangeTextureInfoTextureIDAsync(pageBtnOnTextureId, 1)
  self._ui._btn_autoNavi:ChangeTextureInfoTextureIDAsync(pageBtnClickTextureId, 2)
  Panel_Window_Journal_Page_All:setRenderTexture(Panel_Window_Journal_Page_All:getBaseTexture())
  self._ui._btn_navi:setRenderTexture(self._ui._btn_navi:getBaseTexture())
  self._ui._btn_autoNavi:setRenderTexture(self._ui._btn_autoNavi:getBaseTexture())
  self._ui._frame_content:SetSize(self._ui._frame_content:GetSizeX(), self._ui._txt_desc:GetTextSizeY())
  self._ui._frame_list:ComputePosAllChild()
  self._ui._scroll_vs:SetControlTop()
  self._ui._frame_list:ComputePos()
  self._ui._frame_list:UpdateContentPos()
  self._ui._frame_list:UpdateContentScroll()
end
function PaGlobal_Journal_Page_All:isHideNavi(journalInfo)
  if ToClient_isCompleteJournal(journalInfo) == true then
    return true
  end
  if PaGlobal_Journal_All_isAnotherQuestProgressing(journalInfo) == true then
    return true
  end
  if ToClient_isFindWayPossibleQuest(journalInfo._questGroupNo, 1) == false then
    return true
  end
  return false
end
function PaGlobal_Journal_Page_All:validate()
  if Panel_Window_Journal_Page_All == nil then
    return
  end
  self._ui._frame_list:isValidate()
  self._ui._frame_content:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._scroll_vs:isValidate()
  self._ui._scroll_vsCtrl:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._btn_navi:isValidate()
  self._ui._btn_autoNavi:isValidate()
end
function PaGlobal_Journal_Page_All_Open(journalListIndex, chapterIndex, uiTypeIndex, journalIndex, posX, posY)
  local self = PaGlobal_Journal_Page_All
  if self == nil then
    return
  end
  if journalListIndex == nil or chapterIndex == nil or uiTypeIndex == nil or journalIndex == nil then
    return
  end
  self:prepareOpen(journalListIndex, chapterIndex, uiTypeIndex, journalIndex, posX, posY)
end
function PaGlobal_Journal_Page_All_Close()
  local self = PaGlobal_Journal_Page_All
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobal_Journal_Page_All_FindNavi(groupId, questNo, isAuto)
  local self = PaGlobal_Journal_Page_All
  if self == nil then
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  if isAuto == true then
    if self._ui._btn_autoNavi:IsCheck() == false then
      self._naviGroup = nil
      self._ui._btn_navi:SetCheck(false)
      self._ui._btn_autoNavi:SetCheck(false)
      return
    end
    self._ui._btn_navi:SetCheck(true)
    self._ui._btn_autoNavi:SetCheck(true)
  else
    if self._ui._btn_navi:IsCheck() == false then
      self._naviGroup = nil
      return
    end
    self._ui._btn_navi:SetCheck(true)
  end
  local questInfo = questList_getQuestStatic(groupId, questNo)
  if questInfo == nil then
    return
  end
  local navigationGuideParam = NavigationGuideParam()
  navigationGuideParam._questGroupNo = groupId
  navigationGuideParam._questNo = questNo
  navigationGuideParam._isAutoErase = questInfo:isGuideAutoErase()
  if questInfo:getAccecptNpc():get() == 0 then
    HandleClicked_CallBlackSpirit()
  end
  local npcData = npcByCharacterKey_getNpcInfo(questInfo:getAccecptNpc(), questInfo:getAccecptDialogIndex())
  if npcData == nil then
    return
  end
  local posX = npcData:getPosition().x
  local posY = npcData:getPosition().y
  local posZ = npcData:getPosition().z
  local naviPathKey = worldmapNavigatorStart(float3(posX, posY, posZ), navigationGuideParam, isAuto, false, false)
  if naviPathKey == -1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PROCMESSAGE_QUEST_NO_FINDWAY"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PROCMESSAGE_QUEST_ALEADY_FINDWAY"))
    audioPostEvent_SystemUi(0, 14)
  end
  self._naviGroup = groupId
  self._isAuto = isAuto
end
