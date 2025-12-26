function PaGlobal_Bromide_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_blackBG = UI.getChildControl(Panel_Window_Bromide_All, "Static_BlackBG")
  self._ui._stc_smallPicture = UI.getChildControl(Panel_Window_Bromide_All, "Static_SmallPicture")
  self._ui._btn_confirm = UI.getChildControl(self._ui._stc_smallPicture, "Button_1")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_smallPicture, "Button_Close")
  self._ui._stc_bigPicture = UI.getChildControl(Panel_Window_Bromide_All, "Static_BigPicture")
  self._ui._btn_bigPictureOff = UI.getChildControl(self._ui._stc_bigPicture, "Button_Off")
  self._ui._stc_keyGuideBG = UI.getChildControl(Panel_Window_Bromide_All, "Static_KeyGuideBG")
  self._ui._stc_keyGuideY = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuideY")
  self._ui._stc_keyGuideB = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuideB")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Bromide_All:registEventHandler()
  if Panel_Window_Bromide_All == nil then
    return
  end
  Panel_Window_Bromide_All:RegisterShowEventFunc(true, "PaGlobalFunc_Bromide_All_ShowAni()")
  Panel_Window_Bromide_All:RegisterShowEventFunc(false, "PaGlobalFunc_Bromide_All_HideAni()")
  registerEvent("onScreenResize", "FromClient_Bromide_All_ResizePanel")
  self._ui._btn_close:SetShow(not self._isConsole)
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Bromide_All_Close()")
  self._ui._btn_bigPictureOff:SetShow(not self._isConsole)
  self._ui._btn_bigPictureOff:addInputEvent("Mouse_LUp", "PaGlobalFunc_Bromide_All_Close()")
  self._ui._btn_confirm:SetShow(not self._isConsole)
  self._ui._btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_Bromide_All_ToggleShowMode()")
  self._ui._stc_bigPicture:addInputEvent("Mouse_LUp", "HandleEventLUp_Bromide_All_ToggleShowMode()")
  self._ui._stc_keyGuideY:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_DEFINE_CPP_ENUM_ETYPE_MAGNIFYINGLENS"))
  Panel_Window_Bromide_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Bromide_All_ToggleShowMode()")
  PaGlobal_Bromide_All:allignKeyGuide()
end
function PaGlobal_Bromide_All:validate()
  if Panel_Window_Bromide_All == nil then
    return
  end
  self._ui._stc_smallPicture:isValidate()
  self._ui._btn_confirm:isValidate()
  self._ui._stc_bigPicture:isValidate()
  self._ui._btn_bigPictureOff:isValidate()
  self._ui._stc_keyGuideBG:isValidate()
  self._ui._stc_keyGuideY:isValidate()
  self._ui._stc_keyGuideB:isValidate()
end
function PaGlobal_Bromide_All:prepareOpen(itemKey)
  if Panel_Window_Bromide_All == nil then
    return
  end
  if PaGlobal_Bromide_All:setTexture(itemKey) == false then
    PaGlobal_Bromide_All:prepareClose()
    return
  end
  self._ui._stc_blackBG:SetShow(false)
  self._ui._stc_bigPicture:SetShow(false)
  FromClient_Bromide_All_ResizePanel()
  if self._isConsole == true then
    Panel_Window_Bromide_All:ignorePadSnapMoveToOtherPanel()
  end
  PaGlobal_Bromide_All:open()
end
function PaGlobal_Bromide_All:open()
  if Panel_Window_Bromide_All == nil then
    return
  end
  Panel_Window_Bromide_All:SetShow(true, true)
end
function PaGlobal_Bromide_All:prepareClose()
  if Panel_Window_Bromide_All == nil then
    return
  end
  PaGlobal_Bromide_All:close()
end
function PaGlobal_Bromide_All:close()
  if Panel_Window_Bromide_All == nil then
    return
  end
  Panel_Window_Bromide_All:SetShow(false, false)
end
function PaGlobal_Bromide_All:setTexture(itemKey)
  if Panel_Window_Bromide_All == nil then
    return false
  end
  local pannelTexturePath = ""
  local pannelUV = {}
  local smallTexturePath = ""
  local smallUV = {}
  local bigTexturePath = ""
  local bigUV = {}
  if itemKey == 768889 then
    pannelTexturePath = "Combine/Etc/Combine_Etc_ClassPoster.dds"
    pannelUV = {
      x1 = 1,
      y1 = 1,
      x2 = 657,
      y2 = 849
    }
    smallTexturePath = "Combine/Etc/Combine_Etc_ClassPoster_Maegu.dds"
    smallUV = {
      x1 = 0,
      y1 = 0,
      x2 = 486,
      y2 = 634
    }
    bigTexturePath = "Combine/Etc/Combine_Etc_ClassPoster_Wallpaper_Maegu.dds"
    bigUV = {
      x1 = 0,
      y1 = 0,
      x2 = 1920,
      y2 = 1080
    }
  else
    return false
  end
  Panel_Window_Bromide_All:ChangeTextureInfoNameAsync(pannelTexturePath)
  local x1, y1, x2, y2 = setTextureUV_Func(Panel_Window_Bromide_All, pannelUV.x1, pannelUV.y1, pannelUV.x2, pannelUV.y2)
  Panel_Window_Bromide_All:getBaseTexture():setUV(x1, y1, x2, y2)
  Panel_Window_Bromide_All:setRenderTexture(Panel_Window_Bromide_All:getBaseTexture())
  Panel_Window_Bromide_All:SetSize(pannelUV.x2 - pannelUV.x1, pannelUV.y2 - pannelUV.y1)
  self._ui._stc_smallPicture:ChangeTextureInfoNameAsync(smallTexturePath)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_smallPicture, smallUV.x1, smallUV.y1, smallUV.x2, smallUV.y2)
  self._ui._stc_smallPicture:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._stc_smallPicture:setRenderTexture(self._ui._stc_smallPicture:getBaseTexture())
  self._ui._stc_smallPicture:SetSize(smallUV.x2 - smallUV.x1, smallUV.y2 - smallUV.y1)
  self._ui._stc_bigPicture:ChangeTextureInfoNameAsync(bigTexturePath)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_bigPicture, bigUV.x1, bigUV.y1, bigUV.x2, bigUV.y2)
  self._ui._stc_bigPicture:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._stc_bigPicture:setRenderTexture(self._ui._stc_bigPicture:getBaseTexture())
  return true
end
function PaGlobal_Bromide_All:allignKeyGuide()
  if Panel_Window_Bromide_All == nil then
    return
  end
  if self._isConsole == false then
    self._ui._stc_keyGuideBG:SetShow(false)
    return
  end
  if self._ui._stc_bigPicture:GetShow() == true then
    self._ui._stc_keyGuideBG:SetShow(false)
    return
  end
  self._ui._stc_keyGuideBG:SetShow(true)
end
