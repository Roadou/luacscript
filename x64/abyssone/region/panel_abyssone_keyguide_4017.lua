PaGlobal_AbyssOne_4017_KeyGuide = {
  _ui = {
    _stc_bg = nil,
    _stc_pc_tab = nil,
    _stc_pc_q = nil,
    _txt_weapon = nil,
    _txt_seat = nil
  },
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_AbyssOne_4017_KeyGuide_Init")
function FromClient_AbyssOne_4017_KeyGuide_Init()
  PaGlobal_AbyssOne_4017_KeyGuide:initialize()
end
function PaGlobal_AbyssOne_4017_KeyGuide:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_bg = UI.getChildControl(Panel_AbyssOne_4017_KeyGuide, "Static_CommandBG")
  self._ui._stc_pc_tab = UI.getChildControl(self._ui._stc_bg, "StaticText_Key_Tab")
  self._ui._stc_pc_q = UI.getChildControl(self._ui._stc_bg, "StaticText_Key_Q")
  self._ui._txt_weapon = UI.getChildControl(self._ui._stc_bg, "StaticText_Weapon")
  self._ui._txt_seat = UI.getChildControl(self._ui._stc_bg, "StaticText_Seat")
  self._ui._stc_bg:SetShow(true)
  self._ui._stc_pc_tab:SetShow(true)
  self._ui._stc_pc_q:SetShow(true)
  self._ui._txt_weapon:SetShow(true)
  self._ui._txt_seat:SetShow(true)
  self:registEventHandler()
  self:validate()
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_AbyssOne) == true then
    FromClient_AbyssOne_4017_KeyGuide_ShowCheck(__eInstanceContentsType_AbyssOne)
  end
  self._initialize = true
end
function PaGlobal_AbyssOne_4017_KeyGuide:registEventHandler()
  if Panel_AbyssOne_4017_KeyGuide == nil then
    return
  end
  registerEvent("FromClient_EnterToInstanceField", "FromClient_AbyssOne_4017_KeyGuide_ShowCheck")
end
function PaGlobal_AbyssOne_4017_KeyGuide:validate()
  if Panel_AbyssOne_4017_KeyGuide == nil then
    return
  end
  self._ui._stc_bg:isValidate()
  self._ui._stc_pc_tab:isValidate()
  self._ui._stc_pc_q:isValidate()
  self._ui._txt_weapon:isValidate()
  self._ui._txt_seat:isValidate()
end
function PaGlobal_AbyssOne_4017_KeyGuide:prepareOpen()
  if Panel_AbyssOne_4017_KeyGuide == nil then
    return
  end
  self:recalcPanelPosition()
  self:open()
end
function PaGlobal_AbyssOne_4017_KeyGuide:recalcPanelPosition()
  if Panel_AbyssOne_4017_KeyGuide == nil then
    return
  end
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  Panel_AbyssOne_4017_KeyGuide:SetPosX(screenX / 3 * 2 - 100)
  Panel_AbyssOne_4017_KeyGuide:SetPosY(screenY / 2 - Panel_AbyssOne_4017_KeyGuide:GetSizeY() / 2)
end
function PaGlobal_AbyssOne_4017_KeyGuide:open()
  if Panel_AbyssOne_4017_KeyGuide == nil then
    return
  end
  Panel_AbyssOne_4017_KeyGuide:SetShow(true)
end
function PaGlobal_AbyssOne_4017_KeyGuide:prepareClose()
  if Panel_AbyssOne_4017_KeyGuide == nil then
    return
  end
  self:close()
end
function PaGlobal_AbyssOne_4017_KeyGuide:close()
  if Panel_AbyssOne_4017_KeyGuide == nil then
    return
  end
  Panel_AbyssOne_4017_KeyGuide:SetShow(false)
end
function FromClient_AbyssOne_4017_KeyGuide_ShowCheck(contentsType)
  local self = PaGlobal_AbyssOne_4017_KeyGuide
  if self == nil then
    return
  end
  if contentsType ~= __eInstanceContentsType_AbyssOne then
    self:prepareClose()
    return
  end
  local currentMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  local instanceMapSSW = ToClient_GetInstanceMapStaticStatusWrapper(currentMapKey)
  if instanceMapSSW == nil then
    self:prepareClose()
    return
  end
  if currentMapKey ~= 4017 then
    self:prepareClose()
    return
  end
  self:prepareOpen()
end
