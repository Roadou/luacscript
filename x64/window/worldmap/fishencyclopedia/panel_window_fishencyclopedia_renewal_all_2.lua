function PaGlobalFunc_FishEncyclopedia_Renewal_All_Open()
  if Panel_Window_FishEncyclopedia_Renewal_All == nil then
    return
  end
  PaGlobal_FishEncyclopedia_Renewal_All:prepareOpen()
end
function PaGlobalFunc_FishEncyclopedia_Renewal_All_Close()
  if Panel_Window_FishEncyclopedia_Renewal_All == nil or Panel_Window_FishEncyclopedia_Renewal_All:GetShow() == false then
    return
  end
  PaGlobal_FishEncyclopedia_Renewal_All:prepareClose()
end
function PaGlobalFunc_FishEncyclopedia_Renewal_All_ChangeCategory(index)
  if Panel_Window_FishEncyclopedia_Renewal_All == nil then
    return
  end
  PaGlobal_FishEncyclopedia_Renewal_All:changeCategory(index)
end
function PaGlobalFunc_FishEncyclopedia_Renewal_All_SearchFishListByKeyword()
  if Panel_Window_FishEncyclopedia_Renewal_All == nil then
    return
  end
  PaGlobal_FishEncyclopedia_Renewal_All:searchFishListByKeyword(true)
end
function PaGlobalFunc_FishEncyclopedia_Renewal_All_CreateContent(content, key)
  if content == nil or key == nil then
    return
  end
  PaGlobal_FishEncyclopedia_Renewal_All:createContent(content, key)
end
function PaGlobalFunc_FishEncyclopedia_Renewal_All_SelectSlot(index)
  PaGlobal_FishEncyclopedia_Renewal_All:selectSlot(index)
end
function PaGlobalFunc_FishEncyclopedia_Renewal_All_DescTooltip(isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local fishEncyclopedia = ToClient_GetFishEncyclopedia(PaGlobal_FishEncyclopedia_Renewal_All._selectedFishIndex)
  if fishEncyclopedia == nil then
    return
  end
  if PaGlobal_FishEncyclopedia_Renewal_All._ui.txt_fishDescription:IsLimitText() == false then
    return
  end
  TooltipSimple_Show(PaGlobal_FishEncyclopedia_Renewal_All._ui.txt_fishDescription, fishEncyclopedia:getName(), fishEncyclopedia:getDesc())
end
function PaGlobalFunc_FishEncyclopedia_Renewal_All_FishNameTooltip(isShow, index)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local txt_fishName = UI.getChildControl(PaGlobal_FishEncyclopedia_Renewal_All._ui.fishSlotList[index], "StaticText_FishName")
  if txt_fishName:IsLimitText() == false then
    return
  end
  local fishEncyclopedia = ToClient_GetFishEncyclopedia(index)
  if fishEncyclopedia == nil then
    return
  end
  TooltipSimple_Show(txt_fishName, txt_fishName:GetText())
end
function PaGlobalFunc_FishEncyclopedia_Renewal_All_UpdateRankInformation()
  PaGlobal_FishEncyclopedia_Renewal_All:updateRankInformation()
end
function PaGlobalFunc_FishEncyclopedia_GetShow()
  if nil == Panel_Window_FishEncyclopedia_Renewal_All then
    return false
  end
  return Panel_Window_FishEncyclopedia_Renewal_All:GetShow()
end
function PaGlobalFunc_FishEncyclopedia_Renewal_SetFocusEdit()
  if PaGlobalFunc_FishEncyclopedia_GetShow() == false then
    return
  end
  SetFocusEdit(PaGlobal_FishEncyclopedia_Renewal_All._ui.edit_fishKeyword)
end
function PaGlobalFunc_FishEncyclopedia_Renewal_KeyboardEnd(str)
  local self = PaGlobal_FishEncyclopedia_Renewal_All
  if self == nil then
    return
  end
  self._ui.edit_fishKeyword:SetEditText(str)
  ClearFocusEdit()
  self:searchFishListByKeyword(true)
end
function FromClient_FishEncyclopedia_Renewal_All_OnScreenSize()
end
function FromClient_UpdateFishEncyclopediaRenewal()
  PaGlobal_FishEncyclopedia_Renewal_All:updateWholePage()
end
