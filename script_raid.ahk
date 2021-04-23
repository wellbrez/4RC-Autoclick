
;Open Raid
CoordMode, Pixel , Screen
CoordMode, Mouse , Screen
hideswitch:=1
global nbattles:=1
global nbattlesarena:=1
global checktime :=1
global checktimearena := 1
global Hiding := false

MenuPrincipal()

;f3::
;	reload
;	return
;f2::
;	if(hideswitch==1)
;	{
;	hideswitch:=0
;	winhide, Raid
;	winhide, Plarium
;	}
;	else
;	{
;	hideswitch:=1
;	winshow, Raid
;	winshow, Plarium
;	}
;	return

f1::
	MenuPrincipal()
	return
f4::
	MouseText()
	return
f12::
	Reload
	return

MouseText()
{
msgbox,,Attention,"Autoclick Started! Press F12 to STOP!!",5
}



	MenuPrincipal(){
	;FileRead,textito,%A_ScriptDir%/text.txt
	Gui,New, ,4RC Autoclick
	Gui,Margin,10,10
	Gui,Font,s15 cBlue Bold,Consolas
	Gui,Add,Text,,Developed by (KOA) 4RC 
	Gui,Add,Text,,Use it with wisdom =)

	
	Gui,Font,s12 cBlack Bold,Consolas
	Gui,Add,Text,,Play again (N times)
	Gui,Font,s10 cBlack,Consolas
	Gui,Add,Text,,N                    verification time(seconds)
	Gui,Font,s20 cBlack Bold,Consolas
	Gui,Add,Edit, w120 x10 y150 vnbattles
	Gui,Add,UpDown, Range1-5000 Left,1
	Gui,Add,Edit, w120 x160 y150 vchecktime
	Gui,Add,UpDown, Range1-5000 Left,1
	Gui,Font,s15 cBlack,Consolas
	Gui,Add,Button,gFightXTimes x300 y150,Fight
	
	Gui,Font,s12 cBlack Bold,Consolas
	Gui,Add,Text,x10 y215,Fight in Arena (N times) !!!EXPERIMENTAL!!!
	Gui,Font,s10 cBlack,Consolas
	Gui,Add,Text,,N                    verification time(seconds)
	Gui,Font,s20 cBlack Bold,Consolas
	Gui,Add,Edit, w120 x10 y270 vnbattlesarena
	Gui,Add,UpDown, Range1-5000 Left,1
	Gui,Add,Edit, w120 x160 y270 vchecktimearena
	Gui,Add,UpDown, Range1-5000 Left,1
	Gui,Font,s15 cBlack,Consolas
	Gui,Add,Button,gFightArena x300 y270,Fight
	Gui,Add,Checkbox,vHiding x500 y270,Hide game screen
	Gui,Show,AutoSize Center
}





;Functions

;Go to main Screen
MainScreen()
{
Send {Esc}
sleep,500
Send {Esc}
sleep,500
Send {Esc}
sleep,500
Send {Esc}
sleep,500
Send {Esc}
sleep,500
Send {Esc}
sleep,500
Send {Esc}
sleep,500
Send {Esc}
sleep,500
Send {Esc}
sleep,500
Send {Esc}
sleep,500

MouseClick,LEFT,712,560
sleep,1000
}



;Fight n arena battles
FightArena()
{
GuiControlGet,nbattlesarena
GuiControlGet,checktimearena
GuiControlGet,Hiding
	n_battles:=nbattlesarena
    ;Go to main screen
	adjust_screen()
    MainScreen()
	adjust_screen()
    ;Click Battle
    MouseClick,LEFT,712,560
    sleep,1000
	adjust_screen()
    ;Click Arena
    MouseClick,LEFT,630,322
    sleep,1000
    ;Click Classic Arena
	adjust_screen()
    MouseClick,LEFT,229,320
    sleep,1000
    ;Set battle counter to 0
    Battle:=0
    ;Set Enemy index to 0
    Rect:=0
    StartX:=705
    StartY:=180
    Offset:=77
    
    ;While less than 5 battles are tried
    While(Battle<n_battles)
    {
        ;Check if enemy has been beaten yet
        adjust_screen()
        MouseMove,StartX-300,StartY + Rect*Offset
        sleep,1000
		adjust_screen()
		MouseGetPos , tempx,tempy
		mousemove,0,0
        PixelGetColor, color, StartX, StartY + Rect*offset
		mousemove,tempx,tempy

        ;While enemy beaten, move to next
        While (!(color = "0x0581B9")) && (Rect<5)
        {
		adjust_screen()
            Rect:=Rect+1
			MouseGetPos , tempx,tempy
		mousemove,0,0
            MouseMove,StartX-300,StartY + Rect*Offset
			mousemove,tempx,tempy
            sleep,1000
			MouseGetPos , tempx,tempy
		mousemove,0,0
            PixelGetColor, color, StartX, StartY + Rect*offset
			mousemove,tempx,tempy
            sleep,1000
        }
        ;If Enemy index is 6 or more, time to scroll down
        If (Rect>=5)
        {
		adjust_screen()
            MouseClickDrag, LEFT, 323, 568, 343, 71 , 50,
            StartY:= 234
            MouseMove,StartX-300,StartY + (Rect-5)*Offset
            sleep,1000
			MouseGetPos , tempx,tempy
		mousemove,0,0
            PixelGetColor, color, StartX, StartY + Rect*offset
			mousemove,tempx,tempy
            While (!(color = "0x0581B9")) && (Rect<9)
            {
                Rect:=Rect+1
                MouseMove,StartX-300,StartY + (Rect-5)*Offset
                sleep,1000MouseGetPos , tempx,tempy
		mousemove,0,0
                PixelGetColor, color, StartX, StartY + (Rect-5)*offset
				mousemove,tempx,tempy
                sleep,1000
            }
            ;If all enemies have been tried, refresh page
            If (Rect>=9)
            {
                MouseClick,LEFT,700,90
                Rect:=0
                StartY:=180
            }
        }
        ;Try to beat the enemy
        sleep,1000
		adjust_screen()
        MouseClick,LEFT,StartX,StartY+Rect*offset
        sleep,2000
        MouseClick,LEFT,685,555
        sleep,2000
		
        ;Wait for pause button to appear
	WinMove,Raid,, 0, 0,800,600
	MouseGetPos , tempx,tempy
		mousemove,0,0
        PixelGetColor, color, 766, 58
		mousemove,tempx,tempy
        
        While !(color = "0x9CCED8")
        {
            sleep,%checktimearena%*1000
			MouseGetPos , tempx,tempy
		mousemove,0,0
            PixelGetColor, color, 766, 58
			mousemove,tempx,tempy
        }
        sleep,200
        ;Click on Auto
		
		adjust_screen()
        MouseClick,LEFT,50,550
        sleep,1000
		adjust_screen()
        ;Wait for clock icon on top left corner to appear
		MouseGetPos , tempx,tempy
		mousemove,0,0
        PixelGetColor, color, 26, 46
		mousemove,tempx,tempy
        While !(color = "0xFFFFFF")
        {
        sleep,1000
		adjust_screen()
		MouseGetPos , tempx,tempy
		mousemove,0,0
        PixelGetColor, color, 26,46
		mousemove,tempx,tempy
		occult_screen()
        }
		adjust_screen()
        ;Get out of battle
        MouseClick,LEFT,400,560
        sleep,1000
        MouseClick,LEFT,400,560
        Battle:=Battle+1
        BlueRectY:= BlueRectY+75
        Rect:=Rect+1

    sleep,1000
    }
}

adjust_screen()
{
    MouseGetPos , mousebeforex,mousebeforey
	;WinShow,Raid
	WinActivate,Raid
	;Resize window
	WinMove,Raid,, 0, 0,800,600
	WinActivate,Raid
	sleep,1000

}
occult_screen()
{
	sleep,300
	;WinHide,Raid
	If(Hiding)
	{
		WinMinimize, Raid
	}
    
}

FightXTimes()
{
	GuiControlGet,nbattles
	GuiControlGet,checktime
	GuiControlGet,Hiding
	Gui,destroy
	fightXtimesInRetryScreen(nbattles,checktime*1000)
	return
}

fightXtimesInRetryScreen(number,checktime1)
{
	mousebeforex:=0
	mousebeforey:=0
    sleep,1000
    counter:=0
    ;Run 10 times, for 50 Energy , 7Battle or 3BossBattle
	;MsgBox , 0, Current Campaign Running, Campaign battle number %nbattles%, 3
    While (counter<number)
    {
        adjust_screen()
		MouseGetPos , tempx,tempy
		mousemove,0,0
        PixelGetColor, color, 396, 547
		mousemove,tempx,tempy
	    
        if(color != "0x9C7B14" and counter=0)
		{
			msgbox,Invalid place for the start of the autoclick. Please go to the "Replay" screen
			msgbox,%color%
			return
		}
        While !(color = "0x9C7B14")
        {
			occult_screen()
			sleep,checktime1
            adjust_screen()
			MouseGetPos , tempx,tempy
		    mousemove,0,0
            PixelGetColor, color, 396, 547
			mousemove,tempx,tempy
        }
        counter:= counter+1
		;MsgBox , 0, Current Campaign Running, Campaign battle number %counter%, 3
        adjust_screen()
		MouseGetPos , tempx,tempy
        MouseClick,LEFT,396,547
		mousemove,tempx,tempy
		occult_screen()
        sleep,checktime1
    }
    ;Wait for last run to be over
    adjust_screen()
	MouseGetPos , tempx,tempy
		mousemove,0,0
    PixelGetColor, color, 396, 547
	mousemove,tempx,tempy
    
    While !(color = "0x9C7B14")
    {
		occult_screen()
			sleep,checktime1
            adjust_screen()
			MouseGetPos , tempx,tempy
		mousemove,0,0
            PixelGetColor, color, 396, 547
			mousemove,tempx,tempy
	}
	adjust_screen()
	winMinimize,Raid
	WinMaximize,Raid
    ;MsgBox,0, Finalizado!!
	MenuPrincipal()
	return
    ;MsgBox , 0, Current Campaign Running, Campaign challenge complete, 3
}