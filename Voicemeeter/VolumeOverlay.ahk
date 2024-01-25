class VolumeOverlay
{
    __New()
    {
        this._cBlue := "c0076d7"
        this._cRed := "cff0001"
        this._hide := ObjBindMethod(this, "Hide")

        this._trans := 200
        this._visible := 0
  
        this._gui := Gui()
        this._gui.Opt("+AlwaysOnTop -Caption +ToolWindow")
        this._gui.BackColor := "Black"
        WinSetTransparent(this._trans, this._gui)
        this._position := Format("xCenter y{1} NoActivate", A_ScreenHeight - 200)
        this._gui.SetFont("s16")
        
        this._text := this._gui.Add("Text", "w200 Center", "-0.0 dB")
        this._progressBar := this._gui.Add("Progress", "w200 h12 BackgroundBlack")
    }
    
    SetValue(aValue)
    {
        if aValue is number {        
            if aValue > 0 {
                this._text.Opt(this._cRed)
                this._progressBar.Opt(this._cRed)
            } else {
                this._text.Opt("cWhite")
                this._progressBar.Opt(this._cBlue)
            }

            percent := Round((aValue + 60) * 1.39)
            this._progressBar.Value := percent
            this._text.Value := aValue . " dB"
        } else {
            this._text.Opt("cGray")
            this._progressBar.Opt("cGray")
            this._text.Value := aValue
        }
    }
    
    Show()
    { 
        if this._visible
            return

        WinSetTransparent(trans := 0, this._gui)
        this._gui.Show(this._position)
        
        this._visible := true

        while trans < this._trans {
            trans += 10
            WinSetTransparent(trans, this._gui)
            Sleep 1
        }
    }
    
    Hide()
    {
        trans := this._trans
        while trans {
            trans -= 10
            WinSetTransparent(trans, this._gui)
            Sleep 1
        }

        this._visible := false
        this._gui.Hide()
    }
    
    Play(aTimeout := 0)
    {
        this.Show()
                
        if aTimeout
            SetTimer(this._hide, -aTimeout)
    }
}
