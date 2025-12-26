function PaGlobal_MorningLandSuccessMsg_Open()
  local self = PaGlobal_MorningLandSuccessMsg
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobal_MorningLandSuccessMsg_Close()
  local self = PaGlobal_MorningLandSuccessMsg
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobal_ShowMorningLandSuccessMsg(time)
  if _ContentsGroup_MorningLandTierGo == false then
    return
  end
  local self = PaGlobal_MorningLandSuccessMsg
  if self == nil then
    return
  end
  self._clearTime = time
  self._elementalMonsterKey = ToClient_GetSeletedElementalMonsterKey()
  if PaGlobal_MorningLandSuccessMsg_Open == nil then
    return
  end
  PaGlobal_MorningLandSuccessMsg_Open()
end
function PaGlobal_MorningLandSuccessMsg_ShowAni()
  local panelAni1 = Panel_MorningLandSuccessMsg_All:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  panelAni1:SetStartColor(Defines.Color.C_00FFFFFF)
  panelAni1:SetEndColor(Defines.Color.C_FFFFFFFF)
  panelAni1.IsChangeChild = true
  local panelAni2 = Panel_MorningLandSuccessMsg_All:addColorAnimation(0.5, 0.7, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  panelAni2:SetStartColor(Defines.Color.C_FFFFFFFF)
  panelAni2:SetEndColor(Defines.Color.C_FFFFFFFF)
  panelAni2:SetStartIntensity(3)
  panelAni2:SetEndIntensity(1)
end
function FromClient_StopSequence_MorningLandBoss()
  if _ContentsGroup_MorningLandTierGo == false then
    return
  end
  if Panel_MorningLandSuccessMsg_All ~= nil and Panel_MorningLandSuccessMsg_All:GetShow() == true then
    PaGlobal_MorningLandSuccessMsg_Close()
  end
end
