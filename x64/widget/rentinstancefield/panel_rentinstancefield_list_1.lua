function PaGlobal_RentInstanceField_List:initialize()
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBG, "Button_Close")
  self._ui._list2_fieldList = UI.getChildControl(self._ui._stc_mainBG, "List2_ListGroup")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_bottomBg, "StaticText_Desc")
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(self._ui._txt_desc:GetText())
  if self._ui._txt_desc:GetTextSizeY() + 10 > self._ui._txt_desc:GetSizeY() then
    local addSizeY = self._ui._txt_desc:GetTextSizeY() + 10 - self._ui._txt_desc:GetSizeY()
    self._ui._txt_desc:SetSize(self._ui._txt_desc:GetSizeX(), self._ui._txt_desc:GetSizeY() + addSizeY)
    Panel_RentInstanceField_List:SetSize(Panel_RentInstanceField_List:GetSizeX(), Panel_RentInstanceField_List:GetSizeY() + addSizeY)
  end
  self:validate()
  self:registerEvent()
  self._initialize = true
end
function PaGlobal_RentInstanceField_List:clear()
  self._fromTime = 0
  self._toTime = 0
end
function PaGlobal_RentInstanceField_List:prepareOpen()
  ToClient_requestUpdateRentInstanceFieldPlayerCount()
  self:open()
end
function PaGlobal_RentInstanceField_List:open()
  if false == self._initialize then
    return
  end
  if false == _ContentsGroup_RentInstanceField then
    return
  end
  local fieldList = ToClient_getInvitedRentInstanceFieldList()
  if nil == fieldList then
    return
  end
  self._ui._list2_fieldList:getElementManager():clearKey()
  for ii = 0, #fieldList do
    local userNo = fieldList[ii]:getUserNo()
    self._ui._list2_fieldList:getElementManager():pushKey(userNo)
  end
  Panel_RentInstanceField_List:SetShow(true)
  Panel_RentInstanceField_List:RegisterUpdateFunc("PaGlobal_RentInstanceField_UpdatePerFrame")
end
function PaGlobal_RentInstanceField_List:prepareClose()
  self:close()
end
function PaGlobal_RentInstanceField_List:close()
  Panel_RentInstanceField_List:SetShow(false)
  Panel_RentInstanceField_List:ClearUpdateLuaFunc()
end
function PaGlobal_RentInstanceField_List:validate()
  self._ui._stc_titleBG:isValidate()
  self._ui._stc_mainBG:isValidate()
  self._ui._btn_close:isValidate()
end
function PaGlobal_RentInstanceField_List:registerEvent()
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_RentInstanceField_List:prepareClose()")
  self._ui._list2_fieldList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_RentInstanceField_List_List2Update")
  self._ui._list2_fieldList:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_useRentInstanceFieldOpenItem", "FromClient_RentInstanceFieldList_useRentInstanceFieldOpenItem")
  registerEvent("FromClient_updateRentInstanceFieldList", "FromClient_RentInstanceFieldList_updateRentInstanceFieldList")
  registerEvent("FromClient_responseUpdateRentInstanceFieldPlayerCount", "FromClient_RentInstanceFieldList_responseUpdateRentInstanceFieldPlayerCount")
end
function PaGlobal_RentInstanceField_List:enterToField(hostUserNo)
  ToClient_requestEnterToRentInstanceField(hostUserNo)
end
