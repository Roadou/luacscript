function PaGlobal_TrashBoxConfirm_All:initialize()
  if PaGlobal_TrashBoxConfirm_All._initialize == true then
    return
  end
  local stc_titleBg = UI.getChildControl(Panel_Window_TrashBoxConfirm_All, "Static_TitleBG")
  self._ui._btn_close = UI.getChildControl(stc_titleBg, "Button_Close")
  self._ui._btn_yes = UI.getChildControl(Panel_Window_TrashBoxConfirm_All, "Button_Yes")
  self._ui._btn_no = UI.getChildControl(Panel_Window_TrashBoxConfirm_All, "Button_No")
  local stc_mainBG = UI.getChildControl(Panel_Window_TrashBoxConfirm_All, "Static_MainBG")
  self._ui._deleteItemList = UI.getChildControl(stc_mainBG, "List2_1")
  self._ui._deleteJewelItemList = UI.getChildControl(stc_mainBG, "List2_Jewel")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_TrashBoxConfirm_All:registEventHandler()
  if Panel_Window_TrashBoxConfirm_All == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_TrashBoxConfirm_All_Close()")
  self._ui._btn_yes:addInputEvent("Mouse_LUp", "HandleEventLUp_TrashBoxConfirm_All_RequestDelete()")
  self._ui._btn_no:addInputEvent("Mouse_LUp", "PaGlobalFunc_TrashBoxConfirm_All_Close()")
  self._ui._deleteItemList:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_TrashBoxConfirm_All_UpdateItemList")
  self._ui._deleteItemList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._deleteJewelItemList:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_TrashBoxConfirm_All_UpdateJewelItemList")
  self._ui._deleteJewelItemList:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_TrashBoxConfirm_All:prepareOpen(trashBoxMode)
  if Panel_Window_TrashBoxConfirm_All == nil then
    return
  end
  self._deleteMode = trashBoxMode
  local stc_titleBg = UI.getChildControl(Panel_Window_TrashBoxConfirm_All, "Static_TitleBG")
  local stc_title = UI.getChildControl(stc_titleBg, "Static_Text_Title")
  local stc_mainBG = UI.getChildControl(Panel_Window_TrashBoxConfirm_All, "Static_MainBG")
  local stc_desc = UI.getChildControl(stc_mainBG, "MultilineText_Desc")
  if self._deleteMode == PaGlobal_TrashBoxMode.InventoryMode then
    self._ui._deleteItemList:SetShow(true)
    self._ui._deleteJewelItemList:SetShow(false)
    stc_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_TRASH_DELETE"))
    stc_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_TRASH_POPUP_DESC"))
  elseif self._deleteMode == PaGlobal_TrashBoxMode.JewelInvenMode then
    self._ui._deleteItemList:SetShow(false)
    self._ui._deleteJewelItemList:SetShow(true)
    stc_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOCKET_XBOX_REMOVE_GEM"))
    stc_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESETINVEN_TRASHMSGBOX_DESC"))
  end
  Panel_Window_TrashBoxConfirm_All:ignorePadSnapMoveToOtherPanel()
  PaGlobal_TrashBoxConfirm_All:open()
end
function PaGlobal_TrashBoxConfirm_All:open()
  if Panel_Window_TrashBoxConfirm_All == nil then
    return
  end
  Panel_Window_TrashBoxConfirm_All:SetShow(true)
end
function PaGlobal_TrashBoxConfirm_All:prepareClose()
  if Panel_Window_TrashBoxConfirm_All == nil then
    return
  end
  PaGlobal_TrashBoxConfirm_All:close()
end
function PaGlobal_TrashBoxConfirm_All:close()
  if Panel_Window_TrashBoxConfirm_All == nil then
    return
  end
  Panel_Window_TrashBoxConfirm_All:SetShow(false)
end
function PaGlobal_TrashBoxConfirm_All:update()
  if Panel_Window_TrashBoxConfirm_All == nil then
    return
  end
end
function PaGlobal_TrashBoxConfirm_All:validate()
  if Panel_Window_TrashBoxConfirm_All == nil then
    return
  end
  self._ui._btn_close:isValidate()
  self._ui._btn_yes:isValidate()
  self._ui._btn_no:isValidate()
  self._ui._deleteItemList:isValidate()
end
