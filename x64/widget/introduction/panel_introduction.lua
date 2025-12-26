local UI_Color = Defines.Color
local UI_PP = CppEnums.PAUIMB_PRIORITY
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local tooltip = {
  _bg = UI.getChildControl(Panel_Introduction, "Static_TooltipBG"),
  _pic = UI.getChildControl(Panel_Introduction, "Static_CharacterPic"),
  _name = UI.getChildControl(Panel_Introduction, "StaticText_FamilyName"),
  _level = UI.getChildControl(Panel_Introduction, "StaticText_CharacterLv"),
  _desc = UI.getChildControl(Panel_Introduction, "StaticText_SelfIntro"),
  _close = UI.getChildControl(Panel_Introduction, "Button_Close")
}
tooltip._desc:SetTextMode(__eTextMode_AutoWrap)
tooltip._close:addInputEvent("Mouse_LUp", "FGlobal_Introcution_TooltipHide()")
function FGlobal_Introcution_TooltipHide()
  Panel_Introduction:SetShow(false)
end
local replaceClassType = function(classNo)
  local returnValue = ""
  if nil == classNo then
    return
  end
  return NewClassData.newClass_String[classNo]._classType2String
end
local panelSizeY = Panel_Introduction:GetSizeY()
function FGlobal_Introduction_TooltipShow(uiControl, name, desc, isClose, actorKey)
  FGlobal_Introcution_TooltipHide()
  Panel_Introduction:SetShow(true)
  local self = tooltip
  self._bg:SetShow(true)
  self._name:SetShow(true)
  self._desc:SetShow(true)
  self._close:SetShow(isClose)
  self._name:SetText(name)
  local nameLength = math.max(135, self._name:GetTextSizeX() + 15) + 15
  if nil == desc or "" == desc then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_RECRUITMENT_PLAYERINTRO_NODATA")
  end
  self._desc:SetText(desc)
  if 70 < self._desc:GetTextSizeY() then
    local plusSizeY = self._desc:GetTextSizeY() - 68
    Panel_Introduction:SetSize(Panel_Introduction:GetSizeX(), panelSizeY + plusSizeY)
    tooltip._bg:SetSize(Panel_Introduction:GetSizeX(), panelSizeY + plusSizeY)
  else
    Panel_Introduction:SetSize(Panel_Introduction:GetSizeX(), panelSizeY)
    tooltip._bg:SetSize(Panel_Introduction:GetSizeX(), panelSizeY)
  end
  local playerActorProxyWrapper = getPlayerActor(actorKey)
  local charLevel = playerActorProxyWrapper:get():getLevel()
  local classType = playerActorProxyWrapper:getClassType()
  tooltip._level:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INTRODUCTIONMYSELF_SUBINFO", "class", replaceClassType(classType), "level", charLevel))
  PaGlobalFunc_Util_SetCharacterCreateClassIcon(tooltip._pic, classType)
  local posX, posY
  if nil ~= uiControl then
    posX = uiControl:GetPosX() + 130
    posY = uiControl:GetPosY() + 25
  else
    posX = getScreenSizeX() / 3
    posY = getScreenSizeY() / 3
  end
  Panel_Introduction:SetPosX(posX)
  Panel_Introduction:SetPosY(posY)
  self._close:ComputePos()
end
function FromClient_InterActionUserIntroduction(actorKey)
  local name, desc, uiControl
  local playerActorProxyWrapper = getPlayerActor(actorKey)
  local name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTRODUCTIONMYSELF_TITLE", "name", playerActorProxyWrapper:getOriginalName())
  local desc = playerActorProxyWrapper:getUserIntroduction()
  FGlobal_Introduction_TooltipShow(uiControl, name, desc, true, actorKey)
end
registerEvent("FromClient_InterActionUserIntroduction", "FromClient_InterActionUserIntroduction")
