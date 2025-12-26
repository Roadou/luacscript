function HandleEventLUp_ContentsName_updateAppleList()
  if Panel_ContentsName == nil then
    return
  end
end
function FromClient_ContentsName_updateAppleList(param1)
  if Panel_ContentsName == nil then
    return
  end
end
function PaGloabl_ContentsName_ShowAni()
  if Panel_ContentsName == nil then
    return
  end
end
function PaGloabl_ContentsName_HideAni()
  if Panel_ContentsName == nil then
    return
  end
end
registerEvent("FromClient_AppleDataUpdate", "FromClient_ContentsName_updateAppleList")
