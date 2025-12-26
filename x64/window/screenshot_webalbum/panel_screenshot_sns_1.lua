function PaGlobal_ScreenShot_SNS:initialize()
  if true == self._initialize then
    return
  end
  local title = UI.getChildControl(Panel_ScreenShot_SNS, "StaticText_Title")
  self._ui.btn_close = UI.getChildControl(title, "Button_Close")
  self._ui._web_StyleAlbum = UI.createControl(__ePAUIControl_WebControl, Panel_ScreenShot_SNS, "WebControl_StyleAlbum")
  self._ui._web_StyleAlbum:SetSize(453, 830)
  self._ui._web_StyleAlbum:SetIME(true)
  self._ui._web_StyleAlbum:SetHorizonCenter()
  self._ui._web_StyleAlbum:SetVerticalTop()
  self._ui._web_StyleAlbum:SetSpanSize(0, 50)
  self._ui._web_StyleAlbum:ComputePos()
  self._ui._web_StyleAlbum:ResetUrl()
  self._ui._web_StyleAlbum:SetShow(false, false)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ScreenShot_SNS:registEventHandler()
  if nil == Panel_ScreenShot_SNS then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ScreenShotSNS_Close()")
  registerEvent("FromClient_OpenWebAlbumUI", "FromClient_OpenWebAlbumUI")
end
function PaGlobal_ScreenShot_SNS:prepareOpen(productNoRaw)
  if nil == Panel_ScreenShot_SNS then
    return
  end
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNoRaw)
  if nil == cashProduct then
    return
  end
  local productNoList = ""
  productNoList = cashProduct:getChangeProductNoList()
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  if nil == getSelfPlayer() then
    return
  end
  local userNo = getSelfPlayer():get():getUserNo()
  local userNickName = getSelfPlayer():getUserNickname()
  local classType = getSelfPlayer():getClassType()
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local isGm = ToClient_SelfPlayerIsGM()
  local isXbox = ToClient_isConsole()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local url = PaGlobal_URL_Check(worldNo)
  if nil ~= productNoList and "" ~= productNoList then
    productNoRaw = productNoList
  end
  if true == cashProduct:isChooseCash() and nil ~= Panel_IngameCashShop then
    local validChooseCount = cashProduct:chooseCashCount()
    for ii = 0, validChooseCount - 1 do
      local chooseCashProduct = cashProduct:getChooseCashByIndex(ii)
      if nil ~= chooseCashProduct then
        local chooseCashProductNo = chooseCashProduct:getNoRaw()
        local chooseCashProductNoList = ""
        chooseCashProductNoList = chooseCashProduct:getChangeProductNoList()
        if nil ~= chooseCashProductNoList and "" ~= chooseCashProductNoList then
          productNoRaw = productNoRaw .. "," .. chooseCashProductNoList
        else
          productNoRaw = productNoRaw .. "," .. chooseCashProductNo
        end
      end
    end
  end
  url = url .. "/ScreenShot/MyGallery/ScreenShotCostumeSNS?_cashProductNoList=" .. tostring(productNoRaw) .. "&userNo=" .. tostring(userNo) .. "&userNickName=" .. tostring(userNickName) .. "&classType=" .. tostring(classType) .. "&certKey=" .. tostring(cryptKey) .. "&isGm=" .. tostring(isGm) .. "&isXbox=" .. tostring(isXbox)
  self._ui._web_StyleAlbum:ResetUrl()
  self._ui._web_StyleAlbum:SetShow(true)
  self._ui._web_StyleAlbum:SetUrl(453, 830, url, false, false)
  self._ui._web_StyleAlbum:SetIME(true)
  self:open()
end
function PaGlobal_ScreenShot_SNS:open()
  if nil == Panel_ScreenShot_SNS then
    return
  end
  Panel_ScreenShot_SNS:SetShow(true)
end
function PaGlobal_ScreenShot_SNS:prepareClose()
  if nil == Panel_ScreenShot_SNS then
    return
  end
  self._ui._web_StyleAlbum:ResetUrl()
  self:close()
end
function PaGlobal_ScreenShot_SNS:close()
  if nil == Panel_ScreenShot_SNS then
    return
  end
  Panel_ScreenShot_SNS:SetShow(false)
end
function PaGlobal_ScreenShot_SNS:validate()
  if nil == Panel_ScreenShot_SNS then
    return
  end
end
