PaGlobal_NakMsgAbyssOne = {
  _ui = {
    _stc_bg = nil,
    _txt_title = nil,
    _txt_desc = nil
  },
  _showTime = 0,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_NakMsgAbyssOne_Init")
function FromClient_NakMsgAbyssOne_Init()
  PaGlobal_NakMsgAbyssOne:initialize()
end
function PaGlobal_NakMsgAbyssOne:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_bg = UI.getChildControl(Panel_Widget_Nak_AbyssOneSkill, "Static_Desc_BG")
  self._ui._txt_title = UI.getChildControl(self._ui._stc_bg, "StaticText_Title")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_bg, "MultilineText_Desc")
  self:registEventHandler()
  self:isValidate()
  self._initialize = true
end
function PaGlobal_NakMsgAbyssOne:registEventHandler()
  if Panel_Widget_Nak_AbyssOneSkill == nil then
    return
  end
  Panel_Widget_Nak_AbyssOneSkill:RegisterShowEventFunc(true, "Panel_NakMsgAbyssOne_ShowAni()")
  Panel_Widget_Nak_AbyssOneSkill:RegisterShowEventFunc(false, "Panel_NakMsgAbyssOne_HideAni()")
end
function PaGlobal_NakMsgAbyssOne:isValidate()
  if Panel_Widget_Nak_AbyssOneSkill == nil then
    return
  end
  self._ui._stc_bg:isValidate()
  self._ui._txt_title:isValidate()
  self._ui._txt_desc:isValidate()
end
function PaGlobal_NakMsgAbyssOne:prepareOpen(sec)
  if Panel_Widget_Nak_AbyssOneSkill == nil then
    return
  end
  self._showTime = sec
  self._ui._txt_title:AddEffect("UI_QustComplete02", false, 0, 0)
  self:open()
end
function PaGlobal_NakMsgAbyssOne:open()
  if Panel_Widget_Nak_AbyssOneSkill == nil then
    return
  end
  Panel_Widget_Nak_AbyssOneSkill:ComputePos()
  Panel_Widget_Nak_AbyssOneSkill:RegisterUpdateFunc("PaGlobalFunc_AbyssOne_Skill_Update")
  Panel_Widget_Nak_AbyssOneSkill:SetShow(true, true)
end
function PaGlobal_NakMsgAbyssOne:close()
  if Panel_Widget_Nak_AbyssOneSkill == nil then
    return
  end
  Panel_Widget_Nak_AbyssOneSkill:ClearUpdateLuaFunc()
  Panel_Widget_Nak_AbyssOneSkill:SetShow(false, true)
end
function PaGlobalFunc_AbyssOne_SkillNakMessage_Open(sec)
  local self = PaGlobal_NakMsgAbyssOne
  if self == nil or sec == nil then
    return
  end
  self:prepareOpen(sec)
end
function PaGlobalFunc_AbyssOne_Skill_Update(deltaTime)
  local self = PaGlobal_NakMsgAbyssOne
  if self == nil then
    return
  end
  self._showTime = self._showTime - deltaTime
  if self._showTime < 0 then
    self:close()
  end
end
function Panel_NakMsgAbyssOne_ShowAni()
  Panel_Widget_Nak_AbyssOneSkill:SetAlpha(0)
  local aniInfo = UIAni.AlphaAnimation(1, Panel_Widget_Nak_AbyssOneSkill, 0, 0.5)
end
function Panel_NakMsgAbyssOne_HideAni()
  Panel_Widget_Nak_AbyssOneSkill:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Widget_Nak_AbyssOneSkill, 0, 0.5)
  aniInfo:SetHideAtEnd(true)
end
