PaGlobal_Journal_Select_All = {
  _ui = {
    _txt_journalSelectTitle = nil,
    _stc_journalSelectGroup = nil,
    _rdo_selectTemplete = nil,
    _btn_cancel = nil,
    _btn_select = nil,
    _txt_keyguideA = nil,
    _txt_keyguideB = nil,
    _stc_keyguideLB = nil,
    _stc_keyguideRB = nil,
    _txt_selectBottomDesc = nil
  },
  _journalUIList = {},
  _currentJournalListType = nil,
  _isPadSnapping = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Journal_Select_All_luaLoadeComplete")
function FromClient_PaGlobal_Journal_Select_All_luaLoadeComplete()
  PaGlobal_Journal_Select_All:initialize()
end
function PaGlobal_Journal_Select_All:initialize()
  if self._initialize then
    return
  end
  self._ui._txt_journalSelectTitle = UI.getChildControl(Panel_Window_Journal_Select_All, "StaticText_JournalSelectTitle")
  self._ui._stc_journalSelectGroup = UI.getChildControl(Panel_Window_Journal_Select_All, "Static_JournalSelectMiddleGroup")
  self._ui._rdo_selectTemplete = UI.getChildControl(self._ui._stc_journalSelectGroup, "Radiobutton_Select_Templete")
  local stc_journalSelectBottom = UI.getChildControl(Panel_Window_Journal_Select_All, "Static_JournalSelectBottomGroup")
  self._ui._btn_cancel = UI.getChildControl(stc_journalSelectBottom, "Button_Cancel")
  self._ui._btn_select = UI.getChildControl(stc_journalSelectBottom, "Button_Select")
  self._ui._txt_keyguideA = UI.getChildControl(stc_journalSelectBottom, "StaticText_KeyGuideA")
  self._ui._txt_keyguideB = UI.getChildControl(stc_journalSelectBottom, "StaticText_KeyGuideB")
  self._ui._stc_keyguideLB = UI.getChildControl(stc_journalSelectBottom, "Static_KeyGuideLB")
  self._ui._stc_keyguideRB = UI.getChildControl(stc_journalSelectBottom, "Static_KeyGuideRB")
  self._ui._txt_selectBottomDesc = UI.getChildControl(Panel_Window_Journal_Select_All, "StaticText_SelectBottomDesc")
  self._ui._stc_blackBG = UI.getChildControl(Panel_Window_Journal_Select_All, "StaticText_BlackBG")
  self._isPadSnapping = ToClient_isUsePadSnapping()
  self._initialize = true
  self:registEventHandler()
  self:checkPlatform()
  self:validate()
end
function PaGlobal_Journal_Select_All:registEventHandler()
  if Panel_Window_Journal_Select_All == nil then
    return
  end
  if self._isPadSnapping == true then
    Panel_Window_Journal_Select_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Journal_Select_All_ClickSelect()")
    Panel_Window_Journal_Select_All:registerPadEvent(__eConsoleUIPadEvent_B, "PaGlobal_Journal_Select_All_Close()")
    Panel_Window_Journal_Select_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "PaGlobal_Journal_Select_All_ChangeJournal(-1)")
    Panel_Window_Journal_Select_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "PaGlobal_Journal_Select_All_ChangeJournal(1)")
  else
    self._ui._btn_select:addInputEvent("Mouse_LUp", "PaGlobal_Journal_Select_All_ClickSelect()")
    self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_Journal_Select_All_Close()")
  end
end
function PaGlobal_Journal_Select_All:checkPlatform()
  if Panel_Window_Journal_Select_All == nil then
    return
  end
  if self._isPadSnapping == true then
    self._ui._btn_select:SetShow(false)
    self._ui._btn_cancel:SetShow(false)
    self._ui._txt_keyguideA:SetShow(true)
    self._ui._txt_keyguideB:SetShow(true)
    self._ui._stc_keyguideLB:SetShow(true)
    self._ui._stc_keyguideRB:SetShow(true)
  else
    self._ui._btn_select:SetShow(true)
    self._ui._btn_cancel:SetShow(true)
    self._ui._txt_keyguideA:SetShow(false)
    self._ui._txt_keyguideB:SetShow(false)
    self._ui._stc_keyguideLB:SetShow(false)
    self._ui._stc_keyguideRB:SetShow(false)
  end
end
function PaGlobal_Journal_Select_All:prepareOpen()
  if Panel_Window_Journal_Select_All == nil then
    return
  end
  self._ui._stc_blackBG:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui._stc_blackBG:ComputePos()
  local journalCount = ToClient_getJournalTotalCount()
  local startSpanX = self._ui._rdo_selectTemplete:GetSizeX() / 2 * -1 * (journalCount - 1)
  for journalIndex = 0, journalCount - 1 do
    local journalUI = UI.cloneControl(self._ui._rdo_selectTemplete, self._ui._stc_journalSelectGroup, "Static_Select_Journal" .. journalIndex)
    journalUI:SetShow(true)
    if journalUI ~= nil then
      journalUI:ChangeTextureInfoTextureIDAsync(ToClient_getJournalTextureInfo(journalIndex, 0), 0)
      journalUI:ChangeTextureInfoTextureIDAsync(ToClient_getJournalTextureInfo(journalIndex, 1), 1)
      journalUI:ChangeTextureInfoTextureIDAsync(ToClient_getJournalTextureInfo(journalIndex, 2), 2)
      journalUI:setRenderTexture(journalUI:getBaseTexture())
      journalUI:SetSpanSize(startSpanX + journalIndex * self._ui._rdo_selectTemplete:GetSizeX(), 0)
      journalUI:addInputEvent("Mouse_LUp", "PaGlobal_Journal_Select_All_SelectJournal(" .. journalIndex .. ")")
      journalUI:SetCheck(false)
      local txt_title = UI.getChildControl(journalUI, "StaticText_Branch_Title_1")
      local txt_desc = UI.getChildControl(journalUI, "MultilineText_Desc_1")
      txt_title:SetText(PAGetString(Defines.StringSheet_GAME, ToClient_getJournalTextureInfo(journalIndex, 5)))
      txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, ToClient_getJournalTextureInfo(journalIndex, 6)))
      local stc_newTag = UI.getChildControl(journalUI, "Static_Tag")
      if journalIndex == 1 then
        stc_newTag:SetShow(true)
      end
    end
    table.insert(self._journalUIList, journalUI)
  end
  if self._isPadSnapping == true then
    self._currentJournalListType = 0
    if self._journalUIList[self._currentJournalListType + 1] ~= nil then
      self._journalUIList[self._currentJournalListType + 1]:SetCheck(true)
    end
  end
  self:open()
end
function PaGlobal_Journal_Select_All:open()
  if Panel_Window_Journal_Select_All == nil then
    return
  end
  Panel_Window_Journal_Select_All:SetShow(true)
end
function PaGlobal_Journal_Select_All:prepareClose()
  if Panel_Window_Journal_Select_All == nil then
    return
  end
  for journalIndex = 1, #self._journalUIList do
    local journalUI = self._journalUIList[journalIndex]
    if journalUI ~= nil then
      UI.deleteControl(journalUI)
    end
  end
  self._journalUIList = {}
  self._currentJournalListType = nil
  self:close()
end
function PaGlobal_Journal_Select_All:close()
  if Panel_Window_Journal_Select_All == nil then
    return
  end
  Panel_Window_Journal_Select_All:SetShow(false)
end
function PaGlobal_Journal_Select_All:validate()
  if Panel_Window_Journal_Select_All == nil then
    return
  end
  self._ui._txt_journalSelectTitle:isValidate()
  self._ui._stc_journalSelectGroup:isValidate()
  self._ui._rdo_selectTemplete:isValidate()
  self._ui._btn_cancel:isValidate()
  self._ui._btn_select:isValidate()
  self._ui._txt_keyguideA:isValidate()
  self._ui._txt_keyguideB:isValidate()
  self._ui._stc_keyguideLB:isValidate()
  self._ui._stc_keyguideRB:isValidate()
  self._ui._txt_selectBottomDesc:isValidate()
end
function PaGlobal_Journal_Select_All_Open()
  local self = PaGlobal_Journal_Select_All
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobal_Journal_Select_All_Close()
  local self = PaGlobal_Journal_Select_All
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobal_Journal_Select_All_ClickSelect()
  local self = PaGlobal_Journal_Select_All
  if self == nil then
    return
  end
  if self._currentJournalListType == nil then
    return
  end
  PaGlobal_Journal_All_Open(self._currentJournalListType)
  self:prepareClose()
end
function PaGlobal_Journal_Select_All_SelectJournal(journalListType)
  local self = PaGlobal_Journal_Select_All
  if self == nil then
    return
  end
  self._currentJournalListType = journalListType
end
function PaGlobal_Journal_Select_All_ChangeJournal(intValue)
  local self = PaGlobal_Journal_Select_All
  if self == nil then
    return
  end
  self._currentJournalListType = self._currentJournalListType + intValue
  if self._currentJournalListType < 0 then
    self._currentJournalListType = 0
  elseif self._currentJournalListType > #self._journalUIList - 1 then
    self._currentJournalListType = #self._journalUIList - 1
  end
  for journalIndex = 1, #self._journalUIList do
    local journalUI = self._journalUIList[journalIndex]
    if journalUI ~= nil then
      if journalIndex - 1 == self._currentJournalListType then
        journalUI:SetCheck(true)
      else
        journalUI:SetCheck(false)
      end
    end
  end
end
