; https://github.com/vburel2018/Voicemeeter-SDK
; https://download.vb-audio.com/Download_CABLE/VoicemeeterRemoteAPI.pdf

#DllLoad "C:\Program Files (x86)\VB\Voicemeeter\VoicemeeterRemote64.dll"

Persistent

class Voicemeeter
{
    __New(aDllName := "VoicemeeterRemote64.dll")
    {
        this._dllName := aDllName
        DllCall(this._dllName . "\VBVMR_Login")
    }
    
    __Delete()
    {
        DllCall(this._dllName . "\VBVMR_Logout")
    }
    
    Param(aValue)
    {
        if aValue is number
            return "=" . aValue
        
        return aValue
    }
    
    Sync()
    {
        DllCall(this._dllName . "\VBVMR_IsParametersDirty")
    }
    
    GetStripGain(aStripIndex)
    {
        this.Sync()
        DllCall(this._dllName . "\VBVMR_GetParameterFloat", "AStr", "Strip[" . aStripIndex . "].Gain", "Float*", &result := 0)
        return result
    }
    
    SetStripGain(aStripIndex, aValue)
    {
        DllCall(this._dllName . "\VBVMR_SetParameters", "AStr", "Strip[" . aStripIndex . "].Gain " . this.Param(aValue))
        this.Sync()
    }

    GetStripMute(aStripIndex)
    {
        this.Sync()
        DllCall(this._dllName . "\VBVMR_GetParameterFloat", "AStr", "Strip[" . aStripIndex . "].Mute", "Float*", &result := 0)
        return result != 0
    }
    
    SetStripMute(aStripIndex, aValue)
    {
        DllCall(this._dllName . "\VBVMR_SetParameterFloat", "AStr", "Strip[" . aStripIndex . "].Mute", "Float", aValue ? 1 : 0)
        this.Sync()
    }
}
