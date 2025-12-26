function PaGlobal_URL_Check(param1)
  return ToClient_GetIngameURLCheck()
end
function PaGlobal_URL_OpenChCsCenter(openType)
  local url = "https://kf.qq.com/touch/kfgames/A11123/v2/PClient/conf/index.html"
  local sceneId = "scene_id="
  if openType == Defines.ChCsCenterOpenType.CsCenterOpen_Esc then
    sceneId = sceneId .. "CSCE20240716185258yaXHdgwQ"
  elseif openType == Defines.ChCsCenterOpenType.CsCenterOpen_PearlShop then
    sceneId = sceneId .. "CSCE20240731180613hbzYEQtV"
  elseif openType == Defines.ChCsCenterOpenType.CsCenterOpen_LoginFail then
    sceneId = sceneId .. "CSCE20240731180441StTixKRB"
  else
    _PA_ASSERT(false, "\236\158\152\235\170\187\235\144\156 ChCustomServiceType\236\158\133\235\139\136\235\139\164. \236\131\136\235\161\156\236\154\180 ChCsCenterOpenType \236\182\148\234\176\128 \236\139\156 \236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148.")
  end
  ToClient_OpenChinaCsServiceCenter(url, sceneId)
end
function PaGlobal_URL_OpenChCsCenterLoginFail()
  PaGlobal_URL_OpenChCsCenter(Defines.ChCsCenterOpenType.CsCenterOpen_LoginFail)
end
function PaGlobal_URL_OpenCreditPointCsCenter()
  local url = "https://gamecredit.qq.com/static/index.htm#/"
  ToClient_OpenRailBrowser(url, 0)
end
