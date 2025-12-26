function PaGlobal_Guild_Arbitration:initialize()
  if PaGlobal_Guild_Arbitration._initialize == true then
    return
  end
  self._ui._stc_infoBG = UI.getChildControl(Panel_Window_Guild_Arbitration, "Static_GuildInfo_BG")
  self._ui._btn_confirm = UI.getChildControl(Panel_Window_Guild_Arbitration, "Button_Confirm")
  self._ui._btn_refuse = UI.getChildControl(Panel_Window_Guild_Arbitration, "Button_Refuse")
  self._ui._txt_myGuildSign = UI.getChildControl(Panel_Window_Guild_Arbitration, "StaticText_MyGuildName")
  self._ui._stc_enemyGuildName = UI.getChildControl(self._ui._stc_infoBG, "StaticText_EnemyGuildName")
  self._ui._stc_myGuildName = UI.getChildControl(self._ui._stc_infoBG, "StaticText_MyGuildName")
  local enemyGuildMarkBG = UI.getChildControl(self._ui._stc_infoBG, "Static_GuildmarkBG_Enemy")
  local myGuildMarkBG = UI.getChildControl(self._ui._stc_infoBG, "Static_GuildmarkBG_My")
  self._ui._stc_enemyGuildMark = UI.getChildControl(enemyGuildMarkBG, "Static_GuildMark")
  self._ui._stc_myGuildMark = UI.getChildControl(myGuildMarkBG, "Static_GuildMark")
  self._ui._stc_frame = UI.getChildControl(Panel_Window_Guild_Arbitration, "Frame_1")
  self._ui._stc_frameContent = UI.getChildControl(self._ui._stc_frame, "Frame_1_Content")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_frameContent, "StaticText_1")
  self._ui._scroll_vertical = UI.getChildControl(self._ui._stc_frame, "Frame_1_VerticalScroll")
  PaGlobal_Guild_Arbitration:registEventHandler()
  PaGlobal_Guild_Arbitration:validate()
  self._ui._btn_refuse:addInputEvent("Mouse_LUp", "PaGlobalFunc_Guild_Arbitration_Close()")
  PaGlobal_Guild_Arbitration._initialize = true
end
function PaGlobal_Guild_Arbitration:registEventHandler()
  if Panel_Window_Guild_Arbitration == nil then
    return
  end
end
function PaGlobal_Guild_Arbitration:prepareOpen(enemyGuildWarInfoIndex)
  if Panel_Window_Guild_Arbitration == nil then
    return
  end
  local enemyGuildNo = ToClient_GetDeclareGuildWarToMyGuild_s64(enemyGuildWarInfoIndex)
  local enemyGuildWrapper = ToClient_GetGuildInfoWrapperByGuildNo(enemyGuildNo)
  self._enemyGuildWarringInfoIndex = self.UNDEFINED_INDEX
  local isSet = setGuildTextureByGuildNo(enemyGuildWrapper:getGuildNo_s64(), self._ui._stc_enemyGuildMark)
  local x1, y1, x2, y2 = 0, 0, 1, 1
  if false == isSet then
    self._ui._stc_enemyGuildMark:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Buttons.dds")
    x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_enemyGuildMark, 183, 1, 188, 6)
  end
  self._ui._stc_enemyGuildMark:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._stc_enemyGuildMark:setRenderTexture(self._ui._stc_enemyGuildMark:getBaseTexture())
  self._ui._stc_enemyGuildName:SetText(enemyGuildWrapper:getName())
  local myGuildWrapper = ToClient_GetMyGuildInfoWrapper()
  isSet = setGuildTextureByGuildNo(myGuildWrapper:getGuildNo_s64(), self._ui._stc_myGuildMark)
  x1, y1, x2, y2 = 0, 0, 1, 1
  if false == isSet then
    self._ui._stc_myGuildMark:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Buttons.dds")
    x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_myGuildMark, 183, 1, 188, 6)
  end
  self._ui._stc_myGuildMark:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._stc_myGuildMark:setRenderTexture(self._ui._stc_myGuildMark:getBaseTexture())
  self._ui._stc_myGuildName:SetText(myGuildWrapper:getName())
  self._ui._txt_myGuildSign:SetText(myGuildWrapper:getName())
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_ARBITATION_MAIN_DESC"))
  UIScroll.SetButtonSize(self._ui._scroll_vertical, self._ui._stc_frame:GetSizeY(), self._ui._txt_desc:GetTextSizeY())
  self._ui._scroll_vertical:SetControlPos(0)
  self._ui._btn_confirm:addInputEvent("Mouse_LUp", "PaGlobalFunc_Guild_Arbitration_QuestListOpen(" .. enemyGuildWarInfoIndex .. ")")
  PaGlobal_Guild_Arbitration:open()
end
function PaGlobal_Guild_Arbitration:open()
  if Panel_Window_Guild_Arbitration == nil then
    return
  end
  Panel_Window_Guild_Arbitration:SetShow(true)
end
function PaGlobal_Guild_Arbitration:prepareClose()
  if Panel_Window_Guild_Arbitration == nil then
    return
  end
  PaGlobal_Guild_Arbitration:close()
end
function PaGlobal_Guild_Arbitration:close()
  if Panel_Window_Guild_Arbitration == nil then
    return
  end
  Panel_Window_Guild_Arbitration:SetShow(false)
end
function PaGlobal_Guild_Arbitration:update()
  if Panel_Window_Guild_Arbitration == nil then
    return
  end
end
function PaGlobal_Guild_Arbitration:validate()
  if Panel_Window_Guild_Arbitration == nil then
    return
  end
  self._ui._stc_infoBG:isValidate()
  self._ui._stc_enemyGuildName:isValidate()
  self._ui._stc_myGuildName:isValidate()
  self._ui._btn_confirm:isValidate()
  self._ui._btn_refuse:isValidate()
  self._ui._txt_myGuildSign:isValidate()
  self._ui._stc_enemyGuildMark:isValidate()
  self._ui._stc_myGuildMark:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._scroll_vertical:isValidate()
end
