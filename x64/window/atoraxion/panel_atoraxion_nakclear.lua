PaGlobal_Atoraxion_NakClear = {
  _ui = {
    mainBg = nil,
    bg = nil,
    txtDesc1 = nil,
    txtDesc2 = nil,
    txtDesc3 = nil
  },
  _currentTime = 0,
  _endTime = 5,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Atoraxion_NakClear_Init")
registerEvent("FromClient_EnterToInstanceField", "FromClient_Atoraxion_NakClear_ChangeNoti")
function FromClient_Atoraxion_NakClear_Init()
  if Panel_Atoraxion_NakClear == nil then
    return
  end
  PaGlobal_Atoraxion_NakClear:initialize()
end
function FromClient_Atoraxion_NakClear_ChangeNoti()
  if Panel_Atoraxion_NakClear == nil then
    return
  end
  PaGlobal_Atoraxion_NakClear:changeNotiText()
end
function PaGlobal_Atoraxion_NakClear:initialize()
  if true == PaGlobal_Atoraxion_NakClear._initialize or nil == Panel_Atoraxion_NakClear then
    return
  end
  local boss = UI.getChildControl(Panel_Atoraxion_NakClear, "Static_BossClear")
  self._ui.mainBg = UI.getChildControl(boss, "Static_Main_BG")
  self._ui.bg = UI.getChildControl(boss, "Static_Desc_BG")
  self._ui.txtDesc1 = UI.getChildControl(self._ui.bg, "StaticText_Desc_1")
  self._ui.txtDesc2 = UI.getChildControl(self._ui.bg, "StaticText_Desc_2")
  self._ui.txtDesc3 = UI.getChildControl(self._ui.bg, "MultilineText_Desc_3")
  PaGlobal_Atoraxion_NakClear:changeNotiText()
  self._initialize = true
end
function PaGlobal_Atoraxion_NakClear:prepareOpen()
  Panel_Atoraxion_NakClear:ComputePos()
  Panel_Atoraxion_NakClear:AddEffect("fui_Ancient_Clear_01A", false, 0, 0)
  audioPostEvent_SystemUi(4, 22)
  _AudioPostEvent_SystemUiForXBOX(4, 22)
  Panel_Atoraxion_NakClear:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  Panel_Atoraxion_NakClear:ComputePosAllChild()
  self._currentTime = 0
  Panel_Atoraxion_NakClear:RegisterUpdateFunc("FromClient_Atoraxion_NakClear_UpdatePerFrame")
  PaGlobal_Atoraxion_NakClear:open()
end
function PaGlobal_Atoraxion_NakClear:open()
  Panel_Atoraxion_NakClear:SetShow(true)
end
function PaGlobal_Atoraxion_NakClear:prepareClose()
  Panel_Atoraxion_NakClear:ClearUpdateLuaFunc()
  PaGlobal_Atoraxion_NakClear:close()
end
function PaGlobal_Atoraxion_NakClear:close()
  Panel_Atoraxion_NakClear:SetShow(false)
end
function PaGlobal_Atoraxion_NakClear:changeNotiText()
  local fieldMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  if fieldMapKey == __eInstanceAtoraxion_Hadum or fieldMapKey == __eInstanceAtoraxion_Normal or fieldMapKey == __eInstancePersonalAtoraxion_Desert then
    self._ui.txtDesc1:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_TITLE"))
    self._ui.txtDesc2:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_SUBTITLE_SECTOR_1"))
    self._ui.txtDesc3:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_DESC_SECTOR_1"))
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.mainBg, 0, 0, 801, 570)
    self._ui.mainBg:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.mainBg:setRenderTexture(self._ui.mainBg:getBaseTexture())
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.bg, 1, 571, 960, 721)
    self._ui.bg:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.bg:setRenderTexture(self._ui.bg:getBaseTexture())
  elseif fieldMapKey == __eInstanceAtoraxionSea_Hadum or fieldMapKey == __eInstanceAtoraxionSea_Normal or fieldMapKey == __eInstancePersonalAtoraxion_Sea then
    self._ui.txtDesc1:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_TITLE_1"))
    self._ui.txtDesc2:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_SUBTITLE_SECTOR_2"))
    self._ui.txtDesc3:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_DESC_SECTOR_3"))
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.mainBg, 1, 723, 801, 1293)
    self._ui.mainBg:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.mainBg:setRenderTexture(self._ui.mainBg:getBaseTexture())
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.bg, 1, 1294, 959, 1444)
    self._ui.bg:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.bg:setRenderTexture(self._ui.bg:getBaseTexture())
  elseif fieldMapKey == __eInstanceAtoraxionValley_Hadum or fieldMapKey == __eInstanceAtoraxionValley_Normal or fieldMapKey == __eInstancePersonalAtoraxion_Valley then
    self._ui.txtDesc1:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_TITLE_2"))
    self._ui.txtDesc2:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_SUBTITLE_SECTOR_3"))
    self._ui.txtDesc3:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_DESC_SECTOR_4"))
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.mainBg, 960, 1, 1760, 571)
    self._ui.mainBg:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.mainBg:setRenderTexture(self._ui.mainBg:getBaseTexture())
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.bg, 960, 572, 1918, 722)
    self._ui.bg:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.bg:setRenderTexture(self._ui.bg:getBaseTexture())
  elseif fieldMapKey == __eInstanceAtoraxionThorn_Hadum or fieldMapKey == __eInstanceAtoraxionThorn_Normal or fieldMapKey == __eInstancePersonalAtoraxion_Thorn then
    self._ui.txtDesc1:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_TITLE_3"))
    self._ui.txtDesc2:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_SUBTITLE_SECTOR_4"))
    self._ui.txtDesc3:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_DESC_SECTOR_5"))
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.mainBg, 959, 723, 1760, 1293)
    self._ui.mainBg:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.mainBg:setRenderTexture(self._ui.mainBg:getBaseTexture())
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.bg, 960, 1294, 1918, 1444)
    self._ui.bg:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.bg:setRenderTexture(self._ui.bg:getBaseTexture())
  else
    return
  end
end
function PaGlobalFunc_Atoraxion_NakClearOpen()
  if nil == Panel_Atoraxion_NakClear then
    return
  end
  PaGlobal_Atoraxion_NakClear:prepareOpen()
end
function FromClient_Atoraxion_NakClear_UpdatePerFrame(deltaTime)
  if nil == Panel_Atoraxion_NakClear then
    return
  end
  PaGlobal_Atoraxion_NakClear._currentTime = PaGlobal_Atoraxion_NakClear._currentTime + deltaTime
  if PaGlobal_Atoraxion_NakClear._endTime < PaGlobal_Atoraxion_NakClear._currentTime then
    PaGlobal_Atoraxion_NakClear:prepareClose()
  end
end
