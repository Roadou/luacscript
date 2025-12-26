registerEvent("FromClient_luaLoadComplete", "FromClient_InitSequenceSkipPopUp")
local _btn_skip, _btn_close
local _sequenceNo = toUint64(0, 0)
local _skipDataID = toUint64(0, 0)
function FromClient_InitSequenceSkipPopUp()
  _btn_skip = UI.getChildControl(Panel_SequenceSkipPopUp, "Button_Skip")
  _btn_close = UI.getChildControl(Panel_SequenceSkipPopUp, "Button_Close")
  _btn_skip:addInputEvent("Mouse_LUp", "doSequenceSkip()")
  _btn_close:addInputEvent("Mouse_LUp", "cancelSequenceSkip()")
  registerEvent("FromClient_StopSequence", "closeSequenceSkipPopUp")
  resizeScreenSequenceSkipPopUp()
  Panel_SequenceSkipPopUp:SetFadeOverRender()
end
function doSequenceSkip()
  ToClient_SequenceSkip(_sequenceNo, _skipDataID)
  Panel_SequenceSkipPopUp:SetShow(false)
end
function cancelSequenceSkip()
  Panel_SequenceSkipPopUp:SetShow(false)
end
function oepnSequenceSkipPopUp(sequenceNo, dataID)
  if Panel_SequenceSkipPopUp == nil then
    return
  end
  _sequenceNo = sequenceNo
  _skipDataID = dataID
  resizeScreenSequenceSkipPopUp()
  Panel_SequenceSkipPopUp:SetShow(true)
end
function closeSequenceSkipPopUp()
  if Panel_SequenceSkipPopUp == nil then
    return
  end
  _sequenceNo = toUint64(0, 0)
  _skipDataID = toUint64(0, 0)
  Panel_SequenceSkipPopUp:SetShow(false)
end
function resizeScreenSequenceSkipPopUp()
  local screenX = getScreenSizeX()
  Panel_SequenceSkipPopUp:SetSize(screenX, Panel_SequenceSkipPopUp:GetSizeY())
  Panel_SequenceSkipPopUp:ComputePosAllChild()
end
