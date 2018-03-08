;-----------------------------------ОПТИМИЗАЦИЯ
;-Console Launcher


  Procedure.s CharToOem(String.s)
  CharToOem_(@String, @String)
  ProcedureReturn String
EndProcedure
 
Procedure.s OemToChar(String.s)
  OemToChar_(@String, @String)
  ProcedureReturn String
EndProcedure


;-------НОРМАЛЬНЫЙ ЛАУНЧЕР


If InitSprite() = 0 Or InitKeyboard() = 0 Or InitMouse() = 0  Or InitSprite3D() = 0
  MessageRequester("Error", "Can't open the sprite system", 0)
  End
EndIf
  InitSound() 
  UsePNGImageDecoder()
  UseOGGSoundDecoder() 
  
  xyraz=0
  
lang=0

    
If CountProgramParameters() = 3
  Select ProgramParameter()
    Case "DEV"
     
       If OpenConsole ()
  
  
    ConsoleTitle ("DEBUG")
  
;lEnableExplicit
  ; Define the constants:
  #MAXBYTE = 255
  #MAXLONG = 2147483647
  
  
    ConsoleColor(12,0)  
    ConsoleLocate (18,12)                          ; x y position 
    PrintN ("That is debug area!")
    
    Print ("Press anykey to exit")
    
    Print("Press any key to continue...")
Input()
PrintN("pressed...")
Input()                     ; to avoid immediate close
CloseConsole()
    
  EndIf
    Default
      PrintN("Wrong parametres...")
  EndSelect
 
EndIf

If ReadFile(0, "work/mods.dat")

  MO$ =  Trim(ReadString(0))

  mods = Val(MO$)
  

Else
mods=0
cmod=0
EndIf

If mods=1

If ReadFile(0, "work/currentmod.dat")

  MORE$ = Trim(ReadString(0))

EndIf
EndIf

If ReadFile(0, "mods/"+MORE$+"/permission.dat")

  CM$ =  Trim(ReadString(0))
  UM$ =  Trim(ReadString(0))
  SM$ =  Trim(ReadString(0))

  cmods = Val(CM$)
  umods = Val(UM$)
  smods = Val(SM$)
  

Else
cmods=0
smod=0
EndIf

If ReadFile(0, "work/lang.dat")
  ZZZM$ =  Trim(ReadString(0))
  LANGUAGE$ = ZZZM$
Else
LANGUAGE$ = "EN"
EndIf  
  
;Else

If ReadFile(0, "work/videomode.dat")

  X$ =  Trim(ReadString(0))
  Y$ =  Trim(ReadString(0))
  F$ =  Trim(ReadString(0))

  ResX = Val(X$)
  ResY = Val(Y$)
  FPS = Val(F$)
  
Else

  If OpenConsole ()
  
  
    ConsoleTitle ("FirstRun/"+CharToOem("Первый запуск"))
  
;lEnableExplicit
  ; Define the constants:
  #MAXBYTE = 255
  #MAXLONG = 2147483647
  
  ;->Cyrillic support for console
  


    

    ConsoleColor(7,0)  
    ConsoleLocate (18,12)  
    
    PrintN ("===================================")           ; Ask for name
    PrintN ("SELECT LANGUAGE/"+CharToOem("ВЫБЕРИТЕ ЯЗЫК"))           ; Ask for name
    PrintN ("===================================") 
    PrintN ("") 
    PrintN ("1.English") 
    PrintN (CharToOem("2.Русский")) 
    PrintN ("") 
    PrintN ("Input number of lang/"+CharToOem("Введите номер языка")) 
    CONLANG = Val(Input())
    
    If CONLANG=2
      conru=1
      LANGUAGE$ = "RU"
    Else
      conru=0
      LANGUAGE$ = "EN"
    EndIf
    
    If CreateFile(0, "work/language.dat")
      WriteString(0, LANGUAGE$)
    EndIf
    
    ClearConsole()
    If conru=1
    PrintN ("===================================")           ; Ask for name
    PrintN (CharToOem("ШАГ 1 ИЗ 3")) 
    PrintN ("===================================")           ; Ask for name
    PrintN ("")  
    PrintN (CharToOem("Так как это первый запуск, вы должны")) 
    PrintN (CharToOem("настроить разрешения экрана, в котором"))  
    PrintN (CharToOem("будет работать игра."))  
    PrintN ("")                         ; x y position 
    PrintN (CharToOem("Этот процесс разбит на 2 этапа")) 
    PrintN (CharToOem("Введите по очерёдно ширину и высоту")) 
    PrintN ("")                         ; x y position 
    Print (CharToOem("Введите ширину (1280 к примеру):")) 
    Else
    PrintN ("===================================")           ; Ask for name
    PrintN ("STEP 1 OF 3")           ; Ask for name
    PrintN ("===================================")           ; Ask for name
    PrintN ("")  
    PrintN ("Since it's first run, you have to configure")  
    PrintN ("Resolution of game window")  
    PrintN ("")                         ; x y position 
    PrintN ("This process is split'd to 2 steps:")                         ; x y position 
    PrintN ("Entering width and height")                         ; x y position 
    PrintN ("")                         ; x y position 
    Print ("Please enter your Width (e.g 1280):  ")           ; Ask for name
    EndIf
    ResX = Val(Input())                              ; Wait for user input

    ClearConsole() 
    If conru=1
    PrintN ("===================================")           ; Ask for name
    PrintN (CharToOem("ШАГ 2 ИЗ 3")) 
    PrintN ("===================================")           ; Ask for name
    PrintN ("")  
    PrintN (CharToOem("Теперь вам нужно ввести высоту")) 
    PrintN ("")  
    Print (CharToOem("Введите высоту (720 к примеру):")) 
    Else
    PrintN ("===================================")           ; Ask for name
    PrintN ("STEP 2 OF 3") 
    PrintN ("===================================")           ; Ask for name
    PrintN ("")  
    PrintN ("Now input the height.") 
    PrintN ("")  
    Print ("Please enter your Width (e.g 720):  ") 
    EndIf
    ResY = Val(Input())
    
    ClearConsole()
    PrintN ("===================================")           ; Ask for name
    If conru=1
    PrintN (CharToOem("ШАГ 3 ИЗ 3"))         ; Ask for name
    Else
    PrintN ("STEP 3 OF 3")           ; Ask for name
  EndIf
  If conru=1
    PrintN ("===================================")           ; Ask for name
    PrintN ("")           ; Ask for name
    PrintN (CharToOem("Установите ограничение FPS")) 
    PrintN ("")          ; Ask for name
    PrintN (CharToOem("Количество кадров в секунду НАПРЯМУЮ влияет на скорость игры!!!"))           ; Ask for name
    PrintN (CharToOem("Кол-во кадров оригинальной игры 35"))           ; Ask for name
    PrintN (CharToOem("Мы рекомендуем установить это значение на 60."))        ; Ask for name 
    PrintN ("")         ; Ask for name
    Print (CharToOem("Введите значение максимального FPS (к примеру 30 или 60):")) 
    Else
    PrintN ("===================================")           ; Ask for name
    PrintN ("")           ; Ask for name
    PrintN ("Set up the maximum FPS value")  
    PrintN ("")          ; Ask for name
    PrintN ("The target Frame rate is dirrecly affects game speed!!!")           ; Ask for name
    PrintN ("The Frame Rate of Vanilia game is 35")           ; Ask for name
    PrintN ("We will recommend you set 60. ")           ; Ask for name
    PrintN ("")         ; Ask for name
    Print ("Please enter FPS limit value (e.g 30 or 60):   ")     
    EndIf; Ask for name
    FPS = Val(Input())
    
    ClearConsole() 
    If conru=1
    Print (CharToOem("Сохранить данное разрешение? [yes/no]: "))  
    Else
    Print ("Save this resolution? [yes/no]:   ")
    EndIf
    Sub123$ = Input()
    
    
    If Sub123$ = "yes"
      If CreateFile(0, "work/videomode.dat")
        WriteStringN(0, Str(ResX))
        WriteStringN(0, Str(ResY))
        WriteString(0, Str(FPS))

        ClearConsole()
    PrintN ("===================================")           ; Ask for name
    If conru=1
    PrintN (CharToOem("ГОТОВО"))  
    Else
    PrintN ("DONE")           ; Ask for name
    EndIf
    PrintN ("===================================")      
    PrintN ("")
    If conru=1
      PrintN ("Video mode "+Str(ResX)+"x"+Str(ResY)+" is saved at file work/videomode.dat" )
        PrintN (CharToOem("Видеорежим") +Str(ResX)+"x"+Str(ResY)+CharToOem("Сохранён в файл work/videomode.dat")) 
        PrintN ("")
        PrintN (CharToOem("Если вы хотите удалить это разрешение, то удалите этот файл."))
        PrintN (CharToOem("Так же, если вам потребуется, вы можете изменить разрешение и FPS напрямую, изменив"))
        PrintN (CharToOem("Значения в файле (Его можно открыть блокнотом)"))
        PrintN ("")
        PrintN ("Нажмите Enter что бы запустить игру")
      Else
        PrintN ("Video mode "+Str(ResX)+"x"+Str(ResY)+" is saved at file work/videomode.dat" )
        PrintN ("")
        PrintN ("If you wish to remove auto resolution, just remove that file.")
        PrintN ("Also, you can change resolution directly in file, via any notepad.")
        PrintN ("")
        PrintN ("Press Enter for launch game")
        
        Input()
    EndIf 
        CloseFile(0)
        Else
            MessageRequester("PureBasic", "Error: can't write the file", 0)
        End
     EndIf
    Else
    
    
      
   ; ClearConsole()  
   ; Print ("Save Changes?:   ")
   ; SaveQestion$=Input()
    
    ;If SaveQestion = y()
    
  ; Define some variables.
       ;Define.f Float
      ; Define.l Count, File
     ;  Define.s Folder, FileName, String
  
  ; Create a temporary file name.
       ;Folder = GetCurrentDirectory()
       ;FileName = Folder + "autoexec.cfg"  
    
       ;File = CreateFile(#PB_Any, FileName)
       
       ;'....to be continued'
    ClearConsole()  
    PrintN ("===================================")           ; Ask for name
    PrintN ("DONE")           ; Ask for name
    PrintN ("===================================")      
    PrintN ("")
        PrintN ("")
         PrintN ("")
        PrintN ("Press Enter for launch game")
        
        Input()
       
     CloseConsole()
    EndIf
  EndIf
  
 EndIf
  
;-..
;-If OpenWindow_START
;  If OpenWindow(0, 0, 0, 1280, 720, "Otters & Fennech", #PB_Window_SystemMenu | #PB_Window_SizeGadget | #PB_Window_ScreenCentered |#PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget)
 ; If OpenWindow(0, 0, 0, ResX, ResY, "Otters & Fennech", #PB_Window_SystemMenu | #PB_Window_SizeGadget | #PB_Window_ScreenCentered |#PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget | #Flags )
  If OpenWindow(0, 0, 0, ResX, ResY, "Otters & Fennech", #PB_Window_SystemMenu | #PB_Window_SizeGadget |#PB_Window_MinimizeGadget | #PB_Window_WindowCentered | #PB_Window_MaximizeGadget )
    
    ;If LoadLibrary(0, "lang_"+LANGUAGE$+".DLL")
    ;If OpenLibrary(0, "lang_RU.DLL")
      ;If CallFunctionFast(0, MenuNames) 
      ;  TMENU$ = MENU$  
     ; EndIf
     ; EndIf
     
If ReadFile(0, "work/localizations/"+LANGUAGE$+"/MenuNames.lang")

  MENU$ = Trim(ReadString(0))
  ZOOM$ = Trim(ReadString(0))
  PLAY$ = Trim(ReadString(0))
  LANG$ = Trim(ReadString(0))
  EXIT$ = Trim(ReadString(0))
  MODS$ = Trim(ReadString(0))
  YES$ = Trim(ReadString(0))
  NO$ = Trim(ReadString(0))
  ENDTURN$ = Trim(ReadString(0))
  STARTGAME$  = Trim(ReadString(0))
  WINCON$  = Trim(ReadString(0))
  ARTIFACTS$  = Trim(ReadString(0))
  NC$  = Trim(ReadString(0))
  COM$  = Trim(ReadString(0))
  RESET$  = Trim(ReadString(0))

EndIf

    ButtonGadget(1, 10,  10, 100, 25, MENU$)
    ;ButtonGadget(1, 10,  10, 100, 25, "Меню")
  ButtonGadget(2, 120,  10, 100, 25, ZOOM$)
  ButtonGadget(3, 230,  10, 100, 25, PLAY$)
 ; ButtonGadget(4, 340,  10, 100, 25, LANG$)
  ButtonGadget(5, 340,  10, 100, 25, EXIT$)
  ButtonGadget(6, 450,  10, 300, 25, MODS$)
  ;
  ; This is the 'event loop'. All the user actions are processed here.
  ; It's very easy to understand: when an action occurs, the EventID
  ; isn't 0 and we just have to see what have happened...
  ;

  xraz=1280
  yraz=720
  ; xraz=800
  ;yraz=600
   ; xraz=952
   ; yraz=720
   nachalo:
   OpenWindowedScreen(WindowID(0), 0, 50, xraz, yraz, 1, 0, 0)
   
   

   
sssstart:

letsgo=0
Reg_Path.s = "Control Panel\Desktop\WindowMetrics\"
hkey.l
keyvalue.l 
datasize.l = 4


If RegOpenKeyEx_(#HKEY_CURRENT_USER, Reg_Path, #Null, #KEY_ALL_ACCESS, @hkey) = 0

  RegQueryValueEx_(hkey, "Applieddpi", 0, 0, @keyvalue, @datasize)
  ;;keyvalue = Left(keyvalue, datasize - 1)
  RegCloseKey_(hkey)

 
  
EndIf 

;-.
;-..
;-.




If keyvalue>96
 LoadFont (0, "Times New Roman", 8,#PB_Font_Bold)            ; Load Courrier Font, Size 15
 LoadFont (1, "Times New Roman", 12,#PB_Font_Bold)              ; Load Arial Font, Size 30
 LoadFont (2, "Times New Roman", 7) 
 LoadFont (3, "Times New Roman", 10,#PB_Font_Bold)  
  LoadFont (4, "Times New Roman", 7,#PB_Font_Bold) 

Else
  
  LoadFont (0, "Times New Roman", 10,#PB_Font_Bold)            ; Load Courrier Font, Size 15
  LoadFont (1, "Times New Roman", 15,#PB_Font_Bold)              ; Load Arial Font, Size 30
  LoadFont (2, "Times New Roman", 8) 
  LoadFont (3, "Times New Roman", 12,#PB_Font_Bold)  
    LoadFont (4, "Times New Roman", 8,#PB_Font_Bold) 
  
EndIf 

;---OLD_F_LOAD_IS_HERE_START

If mods=1 And smods=1 And ReadFile(0, "mods/"+MORE$+"/SMoD/fireloud.wav")
 LoadSound (0,"mods/"+MORE$+"/SMoD/fireloud.ogg")
Else
 LoadSound (0,"music/fireloud.ogg")
   EndIf
   LoadSound (1,"music/ric1.ogg")
 LoadSound (2,"music/explode.ogg")
     LoadSound (3,"music/button_zap.ogg") 
       LoadSound (4,"music/hyprbf1a.ogg") 
           LoadSound (5,"music/ric2.ogg")
           LoadSound (6,"music/076.ogg")
           If mods=1 And smods=1 And ReadFile(299, "mods/"+MORE$+"/SMoD/no.wav")
           LoadSound (7, "mods/"+MORE$+"/SMoD/no.wav" )
           Else
           LoadSound (7,"music/no.ogg")
           EndIf
           LoadSound (8,"music/yes.ogg")
           If mods=1 And smods=1 And ReadFile(299, "mods/"+MORE$+"/SMoD/jump.wav")
           LoadSound (9, "mods/"+MORE$+"/SMoD/jump.wav" )
           Else
           LoadSound (9,"music/jamp.ogg")
           EndIf
           LoadSound (10,"music/teleport.ogg")
           LoadSound (11,"music/wsp.ogg")
           LoadSound (12,"music/kwa.ogg")
           LoadSound (13,"music/vol.ogg")
           
           If mods=1 And smods=1 And ReadFile(299, "mods/"+MORE$+"/SMoD/menu.wav")
             LoadSound (551,"mods/"+MORE$+"/SMoD/menu.wav")
           Else
             If ReadFile(299, "sounds/menu.wav")
              LoadSound (551,"sounds/menu.wav") 
           EndIf
           EndIf
  LoadSprite (1, "gfx/str.png" )
  LoadSprite (2, "gfx/rama.png" )
LoadSprite (3, "fon/1.png" )
 LoadSprite (4, "gfx/strl1.png" )
  LoadSprite (5, "gfx/strl2.png" )


  LoadSprite (6, "gfx/target.png" )
    LoadSprite (7, "gfx/rama1.png" )
      LoadSprite (8, "weapon/wins.png" )
      
  
;-----------------------------------непроходимые
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/1.png")
LoadSprite (9, "mods/"+MORE$+"/TMoD/1.png" )
Else
LoadSprite (9, "sprite/1.png" )
EndIf
;LoadSprite (9, "sprite/1.png" )
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/1z.png")
LoadSprite (10, "mods/"+MORE$+"/TMoD/1z.png" )
Else
LoadSprite (10, "sprite/1.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/2.png")
LoadSprite (11, "mods/"+MORE$+"/TMoD/2.png" )
Else
LoadSprite (11, "sprite/2.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/3.png")
LoadSprite (12, "mods/"+MORE$+"/TMoD/3.png" )
Else
LoadSprite (12, "sprite/3.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/4.png")
LoadSprite (13, "mods/"+MORE$+"/TMoD/4.png" )
Else
LoadSprite (13, "sprite/4.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/5.png")
LoadSprite (14, "mods/"+MORE$+"/TMoD/5.png" )
Else
LoadSprite (14, "sprite/5.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/6.png")
LoadSprite (15, "mods/"+MORE$+"/TMoD/6.png" )
Else
LoadSprite (15, "sprite/6.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/7.png")
LoadSprite (16, "mods/"+MORE$+"/TMoD/7.png" )
Else
LoadSprite (16, "sprite/7.png" )
EndIf
LoadSprite (17, "sprite/8.png" )
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/9.png")
LoadSprite (18, "mods/"+MORE$+"/TMoD/9.png" )
Else
LoadSprite (18, "sprite/9.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/10.png")
LoadSprite (19, "mods/"+MORE$+"/TMoD/10.png" )
Else
LoadSprite (19, "sprite/10.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/53.png")
LoadSprite (20, "mods/"+MORE$+"/TMoD/53.png" )
Else
LoadSprite (20, "sprite/53.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/11.png")
LoadSprite (21, "mods/"+MORE$+"/TMoD/11.png" )
Else
LoadSprite (21, "sprite/11.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/12.png")
LoadSprite (22, "mods/"+MORE$+"/TMoD/12.png" )
Else
LoadSprite (22, "sprite/12.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/13.png")
LoadSprite (23, "mods/"+MORE$+"/TMoD/12.png" )
Else
LoadSprite (23, "sprite/13.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/14.png")
LoadSprite (24, "mods/"+MORE$+"/TMoD/14.png" )
Else
LoadSprite (24, "sprite/14.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/15.bmp")
LoadSprite (25, "mods/"+MORE$+"/TMoD/15.bmp" )
Else
LoadSprite (25, "sprite/15.bmp" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/16.bmp")
LoadSprite (26, "mods/"+MORE$+"/TMoD/16.bmp" )
Else
LoadSprite (26, "sprite/16.bmp" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/chest_0000.png")
LoadSprite (27, "mods/"+MORE$+"/TMoD/chest_0000.png" )  
Else  
LoadSprite (27, "sprite/chest_0000.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/chest_0001.png")
LoadSprite (28, "mods/"+MORE$+"/TMoD/chest_0001.png" )
Else
LoadSprite (28, "sprite/chest_0001.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/duplo.png")
LoadSprite (29, "mods/"+MORE$+"/TMoD/duplo.png" )
Else
LoadSprite (29, "sprite/duplo.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/77.png")
LoadSprite (30, "mods/"+MORE$+"/TMoD/77.png" )
Else
LoadSprite (30, "sprite/77.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/8b.png")
LoadSprite (31, "mods/"+MORE$+"/TMoD/8b.png" )
Else
LoadSprite (31, "sprite/8b.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/8bb.png")
LoadSprite (32, "mods/"+MORE$+"/TMoD/8bb.png" )
Else
LoadSprite (32, "sprite/8bb.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/107.png")
LoadSprite (33, "mods/"+MORE$+"/TMoD/107.png" )
Else
LoadSprite (33, "sprite/107.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/108.png")
LoadSprite (34, "mods/"+MORE$+"/TMoD/108.png" )
Else
LoadSprite (34, "sprite/108.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/109.png")
LoadSprite (35, "mods/"+MORE$+"/TMoD/109.png" )
Else
LoadSprite (35, "sprite/109.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/110.png")
LoadSprite (36, "mods/"+MORE$+"/TMoD/110.png" )
Else
LoadSprite (36, "sprite/110.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/111.png")
LoadSprite (37, "mods/"+MORE$+"/TMoD/111.png" )
Else
LoadSprite (37, "sprite/111.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/112.png")
LoadSprite (38, "mods/"+MORE$+"/TMoD/112.png" )
Else
LoadSprite (38, "sprite/112.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/113.png")
LoadSprite (39, "mods/"+MORE$+"/TMoD/113.png" )
Else
LoadSprite (39, "sprite/113.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/114.png")
LoadSprite (40, "mods/"+MORE$+"/TMoD/114.png" )
Else
LoadSprite (40, "sprite/114.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/115.png")
LoadSprite (41, "mods/"+MORE$+"/TMoD/115.png" )
Else
LoadSprite (41, "sprite/115.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/116.png")
LoadSprite (42, "mods/"+MORE$+"/TMoD/116.png" )
Else
LoadSprite (42, "sprite/116.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/117.png")
LoadSprite (43, "mods/"+MORE$+"/TMoD/117.png" )
Else
LoadSprite (43, "sprite/117.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/bult1.png")
LoadSprite (44, "mods/"+MORE$+"/TMoD/bult1.png" )
Else
LoadSprite (44, "sprite/bult1.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/bult2.png")
LoadSprite (45, "mods/"+MORE$+"/TMoD/bult2.png" )
Else
LoadSprite (45, "sprite/bult2.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/bult3.png")
LoadSprite (46, "mods/"+MORE$+"/TMoD/bult3.png" )
Else
LoadSprite (46, "sprite/bult3.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/bult4.png")
LoadSprite (47, "mods/"+MORE$+"/TMoD/bult4.png" )
Else
LoadSprite (47, "sprite/bult4.png" )
EndIf 
;-----------------------------------проходимые

If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/50.png")
LoadSprite (50, "mods/"+MORE$+"/TMoD/50.png" )
Else
LoadSprite (50, "sprite/50.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/51.png")
LoadSprite (51, "mods/"+MORE$+"/TMoD/51.png" )
Else
LoadSprite (51, "sprite/51.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/52.png")
LoadSprite (52, "mods/"+MORE$+"/TMoD/52.png" )
Else
LoadSprite (52, "sprite/53.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/53.png")
LoadSprite (53, "mods/"+MORE$+"/TMoD/53.png" )
Else
LoadSprite (53, "sprite/53.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/54.png")
LoadSprite (54, "mods/"+MORE$+"/TMoD/54.png" )
Else
LoadSprite (54, "sprite/54.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/55.png")
LoadSprite (55, "mods/"+MORE$+"/TMoD/55.png" )
Else
LoadSprite (55, "sprite/55.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/56.png")
LoadSprite (56, "mods/"+MORE$+"/TMoD/56.png" )
Else
LoadSprite (56, "sprite/56.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/57.png")
LoadSprite (57, "mods/"+MORE$+"/TMoD/57.png" )
Else
LoadSprite (57, "sprite/57.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/top_lamp_0000.png")
LoadSprite (58, "mods/"+MORE$+"/TMoD/top_lamp_0000.png" )
Else
LoadSprite (58, "sprite/top_lamp_0000.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/top_lamp_0001.png")
LoadSprite (59, "mods/"+MORE$+"/TMoD/top_lamp_0001.png" )
Else
LoadSprite (59, "sprite/top_lamp_0001.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/top_lamp_0002.png")
LoadSprite (60, "mods/"+MORE$+"/TMoD/top_lamp_0002.png" )
Else
LoadSprite (60, "sprite/top_lamp_0001.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/top_lamp_0003.png")
LoadSprite (61, "mods/"+MORE$+"/TMoD/top_lamp_0003.png" )
Else
LoadSprite (61, "sprite/top_lamp_0003.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/top_lamp_0004.png")
LoadSprite (62, "mods/"+MORE$+"/TMoD/top_lamp_0004.png" )
Else
LoadSprite (62, "sprite/top_lamp_0004.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/top_lamp_0005.png")
LoadSprite (63, "mods/"+MORE$+"/TMoD/top_lamp_0005.png" )
Else
LoadSprite (63, "sprite/top_lamp_0005.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/top_lamp_0006.png")
LoadSprite (64, "mods/"+MORE$+"/TMoD/top_lamp_0006.png" )
Else
LoadSprite (64, "sprite/top_lamp_0006.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/top_lamp_0007.png")
LoadSprite (65, "mods/"+MORE$+"/TMoD/top_lamp_0007.png" )
Else
LoadSprite (65, "sprite/top_lamp_0007.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/top_lamp_0008.png")
LoadSprite (66, "mods/"+MORE$+"/TMoD/top_lamp_0008.png" )
Else
LoadSprite (66, "sprite/top_lamp_0007.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/gem_0000.png")
LoadSprite (67, "mods/"+MORE$+"/TMoD/gem_0000.png" )
Else
LoadSprite (67, "sprite/gem_0000.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/gem_0001.png")
LoadSprite (68, "mods/"+MORE$+"/TMoD/gem_0001.png" )
Else
LoadSprite (68, "sprite/gem_0001.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/gem_0002.png")
LoadSprite (69, "mods/"+MORE$+"/TMoD/gem_0002.png" )
Else
LoadSprite (69, "sprite/gem_0002.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/gem_0003.png")
LoadSprite (70, "mods/"+MORE$+"/TMoD/gem_0003.png" )
Else
LoadSprite (70, "sprite/gem_0003.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/gem_0004.png")
LoadSprite (71, "mods/"+MORE$+"/TMoD/gem_0004.png" )
Else
LoadSprite (71, "sprite/gem_0004.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/gem_0005.png")
LoadSprite (72, "mods/"+MORE$+"/TMoD/gem_0005.png" )
Else
LoadSprite (72, "sprite/gem_0005.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/gem_0006.png")
LoadSprite (73, "mods/"+MORE$+"/TMoD/gem_0006.png" )
Else
LoadSprite (73, "sprite/gem_0006.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/gem_0007.png")
LoadSprite (74, "mods/"+MORE$+"/TMoD/gem_0007.png" )
Else
LoadSprite (74, "sprite/gem_0007.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/gem_0008.png")
LoadSprite (75, "mods/"+MORE$+"/TMoD/gem_0008.png" )
Else
LoadSprite (75, "sprite/gem_0008.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/gem_0009.png")
LoadSprite (76, "mods/"+MORE$+"/TMoD/gem_0009.png" )
Else
LoadSprite (76, "sprite/gem_0009.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/water3_0000.png")
LoadSprite (77, "sprite/water3_0000.png" )
Else
LoadSprite (77, "sprite/water3_0000.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/water3_0001.png")
LoadSprite (78, "sprite/water3_0001.png" )
Else
LoadSprite (78, "sprite/water3_0001.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/water3_0002.png")
LoadSprite (79, "sprite/water3_0002.png" )
Else
LoadSprite (79, "sprite/water3_0002.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/water3_0003.png")
LoadSprite (80, "sprite/water3_0003.png" )
Else
LoadSprite (80, "sprite/water3_0003.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/water3_0004.png")
LoadSprite (81, "sprite/water3_0004.png" )
Else
LoadSprite (81, "sprite/water3_0004.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/water3_0005.png")
LoadSprite (82, "sprite/water3_0005.png" )
Else
LoadSprite (82, "sprite/water3_0005.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/water3_0006.png")
LoadSprite (83, "sprite/water3_0006.png" )
Else
LoadSprite (83, "sprite/water3_0006.png" )
EndIf

If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0010.png")
LoadSprite (84, "mods/"+MORE$+"/TMoD/fence_0010.png" )
Else
LoadSprite (84, "sprite/fence_0010.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0011.png")
LoadSprite (85, "mods/"+MORE$+"/TMoD/fence_0011.png" )
Else
LoadSprite (85, "sprite/fence_0011.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0012.png")
LoadSprite (86, "mods/"+MORE$+"/TMoD/fence_0012.png" )
Else
LoadSprite (86, "sprite/fence_0012.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0013.png")
LoadSprite (87, "mods/"+MORE$+"/TMoD/fence_0013.png" )
Else
LoadSprite (87, "sprite/fence_0013.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0014.png")
LoadSprite (88, "mods/"+MORE$+"/TMoD/fence_0014.png" )
Else
LoadSprite (88, "sprite/fence_0014.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0015.png")
LoadSprite (89, "mods/"+MORE$+"/TMoD/fence_0015.png" )
Else
LoadSprite (89, "sprite/fence_0015.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0016.png")
LoadSprite (90, "mods/"+MORE$+"/TMoD/fence_0016.png" )
Else
LoadSprite (90, "sprite/fence_0016.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0017.png")
LoadSprite (91, "mods/"+MORE$+"/TMoD/fence_0017.png" )
Else
LoadSprite (91, "sprite/fence_0017.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/barrell0000.png")
LoadSprite (92, "mods/"+MORE$+"/TMoD/barrell0000.png" )
Else
LoadSprite (92, "sprite/barrell0000.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/barrell0001.png")
LoadSprite (93, "mods/"+MORE$+"/TMoD/barrell0001.png" )
Else
LoadSprite (93, "sprite/barrell0001.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/barrell0002.png")
LoadSprite (94, "mods/"+MORE$+"/TMoD/barrell0002.png" )
Else
LoadSprite (94, "sprite/barrell0002.png" )
EndIf

If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/barrell0001.png")
LoadSprite (95, "mods/"+MORE$+"/TMoD/barrell0001.png" )
Else
LoadSprite (95, "sprite/barrell0001.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/pult1.png")
LoadSprite (98, "mods/"+MORE$+"/TMoD/pult1.png" )
Else
LoadSprite (98, "sprite/pult1.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0000.png")  
LoadSprite (99, "mods/"+MORE$+"/TMoD/fence_0000.png" )
Else
LoadSprite (99, "sprite/pult2.png" )
EndIf
;-----------------------------------Передний план
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0000.png")
LoadSprite (100, "mods/"+MORE$+"/TMoD/fence_0000.png" )
Else
LoadSprite (100, "sprite/fence_0000.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0001.png")
LoadSprite (101, "mods/"+MORE$+"/TMoD/fence_0001.png" )
Else
LoadSprite (101, "sprite/fence_0001.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0002.png")
LoadSprite (102, "mods/"+MORE$+"/TMoD/fence_0002.png" )
Else
LoadSprite (102, "sprite/fence_0002.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0003.png")
LoadSprite (103, "mods/"+MORE$+"/TMoD/fence_0003.png" )
Else
LoadSprite (103, "sprite/fence_0003.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0004.png")
LoadSprite (104, "mods/"+MORE$+"/TMoD/fence_0004.png" )
Else
LoadSprite (104, "sprite/fence_0004.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0005.png")
LoadSprite (105, "mods/"+MORE$+"/TMoD/fence_0005.png" )
Else
LoadSprite (105, "sprite/fence_0005.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0006.png")
LoadSprite (106, "mods/"+MORE$+"/TMoD/fence_0006.png" )
Else
LoadSprite (106, "sprite/fence_0006.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/fence_0007.png")
LoadSprite (107, "mods/"+MORE$+"/TMoD/fence_0007.png" )
Else
LoadSprite (107, "sprite/fence_0007.png" )
EndIf

;-----------------------------------задний план
LoadSprite (120, "sprite/104.png" )
LoadSprite (121, "sprite/105.png" )
LoadSprite (122, "sprite/106.png" )
LoadSprite (123, "sprite/65.png" )
LoadSprite (124, "sprite/66.png" )
LoadSprite (125, "sprite/67.png" )
LoadSprite (126, "sprite/68.png" )
LoadSprite (127, "sprite/69.png" )
LoadSprite (128, "sprite/70.png" )
LoadSprite (129, "sprite/71.png" )
LoadSprite (130, "sprite/72.png" )
LoadSprite (131, "sprite/73.png" )
LoadSprite (132, "sprite/74.png" )
LoadSprite (133, "sprite/75.png" )
LoadSprite (134, "sprite/76.png" )
LoadSprite (135, "sprite/103.png" )

LoadSprite (139, "sprite/props.png" )
LoadSprite (140, "sprite/props2.png" )
LoadSprite (141, "sprite/props3.png" )

LoadSprite (200, "sprite/58.png" )
LoadSprite (201, "sprite/59.png" )
LoadSprite (202, "sprite/60.png" )
LoadSprite (203, "sprite/61.png" )
LoadSprite (204, "sprite/1163a.png" )
LoadSprite (205, "sprite/1163b.png" )
LoadSprite (220, "sprite/78.png" );   предметы 
LoadSprite (221, "sprite/79.png" )

LoadSprite (250, "sprite/100.png" )
LoadSprite (251, "sprite/101.png" )
LoadSprite (252, "sprite/102.png" )
LoadSprite (253, "sprite/101.png" )
LoadSprite (254, "sprite/102.png" )
LoadSprite (255, "sprite/101.png" )


LoadSprite (280, "fon/1.png" )
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/63.png")
LoadSprite (281, "mods/"+MORE$+"/TMoD/63.png" )
Else
LoadSprite (281, "sprite/63.png" )
EndIf
If mods=1 And ReadFile(0, "mods/"+MORE$+"/TMoD/64.png")
LoadSprite (282, "mods/"+MORE$+"/TMoD/64.png" )
Else
LoadSprite (282, "sprite/64.png" )
EndIf
LoadSprite (283, "fon/fon1a.png" )

LoadSprite (290, "gfx/cub1.png",#PB_Sprite_Texture )
If mods=1 And umods=1 And ReadFile(0, "mods/"+MORE$+"/UMoD/start.png")
LoadSprite (299, "mods/"+MORE$+"/UMoD/start.png",#PB_Sprite_Texture )
Else
LoadSprite (299, "fon/start.bmp",#PB_Sprite_Texture )
EndIf
LoadSprite (300, "sprite/z1.png",#PB_Sprite_Texture )
LoadSprite (301, "sprite/z2.png",#PB_Sprite_Texture )
LoadSprite (302, "sprite/z3.png",#PB_Sprite_Texture )
LoadSprite (303, "sprite/z4.png",#PB_Sprite_Texture )
LoadSprite (304, "sprite/z5.png",#PB_Sprite_Texture )
LoadSprite (305, "sprite/z6.png",#PB_Sprite_Texture )
LoadSprite (306, "sprite/z7.png",#PB_Sprite_Texture )
LoadSprite (307, "sprite/z8.png",#PB_Sprite_Texture )
LoadSprite (308, "sprite/z7.png",#PB_Sprite_Texture )
LoadSprite (309, "sprite/z6.png",#PB_Sprite_Texture )
LoadSprite (310, "sprite/z5.png",#PB_Sprite_Texture )
LoadSprite (311, "sprite/z4.png",#PB_Sprite_Texture )
LoadSprite (312, "sprite/z3.png",#PB_Sprite_Texture )
LoadSprite (313, "sprite/z2.png",#PB_Sprite_Texture )
LoadSprite (314, "sprite/bah.png",#PB_Sprite_Texture )
LoadSprite (315, "sprite/bah1.png",#PB_Sprite_Texture )
LoadSprite (316, "sprite/bah2.png",#PB_Sprite_Texture )
LoadSprite (317, "sprite/bah3.png",#PB_Sprite_Texture )
LoadSprite (318, "sprite/bah4.png",#PB_Sprite_Texture )
LoadSprite (319, "sprite/bah5.png",#PB_Sprite_Texture )
LoadSprite (320, "sprite/bah6.png",#PB_Sprite_Texture )
LoadSprite (321, "sprite/bahh.png",#PB_Sprite_Texture )

;->:DD:D:D::D

LoadSprite (500, "harak/vudra_walk_0000.png",#PB_Sprite_Texture )
LoadSprite (501, "harak/vudra_walk_0001.png",#PB_Sprite_Texture )
LoadSprite (502, "harak/vudra_walk_0002.png",#PB_Sprite_Texture )
LoadSprite (503, "harak/vudra_walk_0003.png",#PB_Sprite_Texture )
LoadSprite (504, "harak/vudra_walk_0004.png",#PB_Sprite_Texture )
LoadSprite (505, "harak/vudra_walk_0005.png",#PB_Sprite_Texture )
LoadSprite (506, "harak/vudra_walk_0006.png",#PB_Sprite_Texture )
LoadSprite (507, "harak/vudra_walk_0007.png",#PB_Sprite_Texture )
LoadSprite (508, "harak/2/vudra_walk_0000.png",#PB_Sprite_Texture )
LoadSprite (509, "harak/2/vudra_walk_0001.png",#PB_Sprite_Texture )
LoadSprite (510, "harak/2/vudra_walk_0002.png",#PB_Sprite_Texture )
LoadSprite (511, "harak/2/vudra_walk_0003.png",#PB_Sprite_Texture )
LoadSprite (512, "harak/2/vudra_walk_0004.png",#PB_Sprite_Texture )
LoadSprite (513, "harak/2/vudra_walk_0005.png",#PB_Sprite_Texture )
LoadSprite (514, "harak/2/vudra_walk_0006.png",#PB_Sprite_Texture )
LoadSprite (515, "harak/2/vudra_walk_0007.png",#PB_Sprite_Texture )

LoadSprite (516, "harak/vudra_anim_2_shoot_0000.png",#PB_Sprite_Texture )
LoadSprite (517, "harak/vudra_anim_2_shoot_0001.png",#PB_Sprite_Texture )
LoadSprite (518, "harak/vudra_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (519, "harak/vudra_anim_2_shoot_0003.png",#PB_Sprite_Texture )
LoadSprite (520, "harak/vudra_anim_2_shoot_0004.png",#PB_Sprite_Texture )
LoadSprite (521, "harak/vudra_anim_2_shoot_0005.png",#PB_Sprite_Texture )
LoadSprite (522, "harak/vudra_anim_2_shoot_0006.png",#PB_Sprite_Texture )
LoadSprite (523, "harak/vudra_anim_shoot0000.png",#PB_Sprite_Texture )
LoadSprite (524, "harak/vudra_anim_shoot0001.png",#PB_Sprite_Texture )
LoadSprite (525, "harak/vudra_anim_shoot0002.png",#PB_Sprite_Texture )
LoadSprite (526, "harak/vudra_anim_2_shoot_0006.png",#PB_Sprite_Texture )
LoadSprite (527, "harak/vudra_anim_2_shoot_0005.png",#PB_Sprite_Texture )
LoadSprite (528, "harak/vudra_anim_2_shoot_0004.png",#PB_Sprite_Texture )
LoadSprite (529, "harak/vudra_anim_2_shoot_0003.png",#PB_Sprite_Texture )
LoadSprite (530, "harak/vudra_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (531, "harak/vudra_anim_2_shoot_0001.png",#PB_Sprite_Texture )
LoadSprite (532, "harak/2/vudra_anim_2_shoot_0000.png",#PB_Sprite_Texture )
LoadSprite (533, "harak/2/vudra_anim_2_shoot_0001.png",#PB_Sprite_Texture )
LoadSprite (534, "harak/2/vudra_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (535, "harak/2/vudra_anim_2_shoot_0003.png",#PB_Sprite_Texture )
LoadSprite (536, "harak/2/vudra_anim_2_shoot_0004.png",#PB_Sprite_Texture )
LoadSprite (537, "harak/2/vudra_anim_2_shoot_0005.png",#PB_Sprite_Texture )
LoadSprite (538, "harak/2/vudra_anim_2_shoot_0006.png",#PB_Sprite_Texture )
LoadSprite (539, "harak/2/vudra_anim_shoot0000.png",#PB_Sprite_Texture )
LoadSprite (540, "harak/2/vudra_anim_shoot0001.png",#PB_Sprite_Texture )
LoadSprite (541, "harak/2/vudra_anim_shoot0002.png",#PB_Sprite_Texture )
LoadSprite (542, "harak/2/vudra_anim_2_shoot_0006.png",#PB_Sprite_Texture )
LoadSprite (543, "harak/2/vudra_anim_2_shoot_0005.png",#PB_Sprite_Texture )
LoadSprite (544, "harak/2/vudra_anim_2_shoot_0004.png",#PB_Sprite_Texture )
LoadSprite (545, "harak/2/vudra_anim_2_shoot_0003.png",#PB_Sprite_Texture )
LoadSprite (546, "harak/2/vudra_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (547, "harak/2/vudra_anim_2_shoot_0001.png",#PB_Sprite_Texture )
LoadSprite (548, "harak/vudra_die_0000.png",#PB_Sprite_Texture )
LoadSprite (549, "harak/vudra_die_0001.png",#PB_Sprite_Texture )
LoadSprite (550, "harak/vudra_die_0002.png",#PB_Sprite_Texture )
LoadSprite (551, "harak/vudra_die_0002.png",#PB_Sprite_Texture )
LoadSprite (552, "harak/vudra_die_0003.png",#PB_Sprite_Texture )
LoadSprite (553, "harak/vudra_die_0003.png",#PB_Sprite_Texture )
LoadSprite (554, "harak/vudra_die_0003.png",#PB_Sprite_Texture )
LoadSprite (555, "harak/vudra_die_0003.png",#PB_Sprite_Texture )
LoadSprite (556, "harak/2/vudra_die_0000.png",#PB_Sprite_Texture )
LoadSprite (557, "harak/2/vudra_die_0001.png",#PB_Sprite_Texture )
LoadSprite (558, "harak/2/vudra_die_0002.png",#PB_Sprite_Texture )
LoadSprite (559, "harak/2/vudra_die_0002.png",#PB_Sprite_Texture )
LoadSprite (560, "harak/2/vudra_die_0003.png",#PB_Sprite_Texture )
LoadSprite (561, "harak/2/vudra_die_0003.png",#PB_Sprite_Texture )
LoadSprite (562, "harak/2/vudra_die_0003.png",#PB_Sprite_Texture )
LoadSprite (563, "harak/2/vudra_die_0003.png",#PB_Sprite_Texture )

LoadSprite (564, "harak/vudra_anim_2_shoot_0000.png",#PB_Sprite_Texture )
LoadSprite (565, "harak/vudra_anim_2_shoot_0001.png",#PB_Sprite_Texture )
LoadSprite (566, "harak/vudra_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (567, "harak/vudra_anim_2_shoot_up0001.png",#PB_Sprite_Texture )
LoadSprite (568, "harak/vudra_anim_2_shoot_up0002.png",#PB_Sprite_Texture )
LoadSprite (569, "harak/vudra_anim_2_shoot_up0003.png",#PB_Sprite_Texture )
LoadSprite (570, "harak/vudra_anim_2_shoot_up0004.png",#PB_Sprite_Texture )
LoadSprite (571, "harak/vudra_anim_2_shoot_up0003.png",#PB_Sprite_Texture )
LoadSprite (572, "harak/vudra_anim_2_shoot_up0002.png",#PB_Sprite_Texture )
LoadSprite (573, "harak/vudra_anim_2_shoot_up0001.png",#PB_Sprite_Texture )
LoadSprite (574, "harak/vudra_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (575, "harak/vudra_anim_2_shoot_0001.png",#PB_Sprite_Texture )


LoadSprite (576, "harak/2/vudra_anim_2_shoot_0000.png",#PB_Sprite_Texture )
LoadSprite (577, "harak/2/vudra_anim_2_shoot_0001.png",#PB_Sprite_Texture )
LoadSprite (578, "harak/2/vudra_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (579, "harak/2/vudra_anim_2_shoot_up0001.png",#PB_Sprite_Texture )
LoadSprite (580, "harak/2/vudra_anim_2_shoot_up0002.png",#PB_Sprite_Texture )
LoadSprite (581, "harak/2/vudra_anim_2_shoot_up0003.png",#PB_Sprite_Texture )
LoadSprite (582, "harak/2/vudra_anim_2_shoot_up0004.png",#PB_Sprite_Texture )
LoadSprite (583, "harak/2/vudra_anim_2_shoot_up0003.png",#PB_Sprite_Texture )
LoadSprite (584, "harak/2/vudra_anim_2_shoot_up0002.png",#PB_Sprite_Texture )
LoadSprite (585, "harak/2/vudra_anim_2_shoot_up0001.png",#PB_Sprite_Texture )
LoadSprite (586, "harak/2/vudra_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (587, "harak/2/vudra_anim_2_shoot_0001.png",#PB_Sprite_Texture )


LoadSprite (628, "harak/vudra_die_0003.png",#PB_Sprite_Texture )
LoadSprite (629, "harak/vudra_die_0004.png",#PB_Sprite_Texture )
LoadSprite (630, "harak/vudra_die_0005.png",#PB_Sprite_Texture )
LoadSprite (631, "harak/vudra_die_0006.png",#PB_Sprite_Texture )

LoadSprite (632, "harak/2/vudra_die_0003.png",#PB_Sprite_Texture )
LoadSprite (633, "harak/2/vudra_die_0004.png",#PB_Sprite_Texture )
LoadSprite (634, "harak/2/vudra_die_0005.png",#PB_Sprite_Texture )
LoadSprite (635, "harak/2/vudra_die_0006.png",#PB_Sprite_Texture )

LoadSprite (636, "harak/2/vudra_anim_2_jump_0000.png",#PB_Sprite_Texture )
LoadSprite (637, "harak/2/vudra_anim_2_jump_0001.png",#PB_Sprite_Texture )
LoadSprite (638, "harak/2/vudra_anim_2_jump_0002.png",#PB_Sprite_Texture )

LoadSprite (639, "harak/vudra_anim_2_jump_0000b.png",#PB_Sprite_Texture )
LoadSprite (640, "harak/vudra_anim_2_jump_0001b.png",#PB_Sprite_Texture )
LoadSprite (641, "harak/vudra_anim_2_jump_0002b.png",#PB_Sprite_Texture )

;->FUCJ NU LIFE


If cmods=1 And ReadFile(0, "mods/"+MORE$+"/CMoD/fox_walk_0000.png")
LoadSprite (500+200, "mods/"+MORE$+"/CMoD/fox_walk_0000.png",#PB_Sprite_Texture )
Else
LoadSprite (500+200, "harak/fox_walk_0000.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And ReadFile(0, "mods/"+MORE$+"/CMoD/fox_walk_0001.png")
LoadSprite (501+200, "mods/"+MORE$+"/CMoD/fox_walk_0001.png",#PB_Sprite_Texture )
Else
LoadSprite (501+200, "harak/fox_walk_0001.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And ReadFile(299, "mods/"+MORE$+"/CMoD/fox_walk_0002.png")
LoadSprite (502+200, "mods/"+MORE$+"/CMoD/fox_walk_0002.png",#PB_Sprite_Texture )
Else
LoadSprite (502+200, "harak/fox_walk_0002.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And ReadFile(299, "mods/"+MORE$+"/CMoD/fox_walk_0003.png")
LoadSprite (503+200, "mods/"+MORE$+"/CMoD/fox_walk_0003.png",#PB_Sprite_Texture )
Else
LoadSprite (503+200, "harak/fox_walk_0003.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And ReadFile(299, "mods/"+MORE$+"/CMoD/fox_walk_0004.png")
LoadSprite (504+200, "mods/"+MORE$+"/CMoD/fox_walk_0004.png",#PB_Sprite_Texture )
Else
LoadSprite (504+200, "harak/fox_walk_0004.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And ReadFile(299, "mods/"+MORE$+"/CMoD/fox_walk_0005.png")
LoadSprite (505+200, "mods/"+MORE$+"/CMoD/fox_walk_0005.png",#PB_Sprite_Texture )
Else
LoadSprite (505+200, "harak/fox_walk_0005.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (506+200, "mods/"+MORE$+"/CMoD/fox_walk_0006.png",#PB_Sprite_Texture )
Else
LoadSprite (506+200, "harak/fox_walk_0006.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (507+200, "mods/"+MORE$+"/CMoD/fox_walk_0007.png",#PB_Sprite_Texture )
Else
LoadSprite (507+200, "harak/fox_walk_0007.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (508+200, "mods/"+MORE$+"/CMoD/2/fox_walk_0000.png",#PB_Sprite_Texture )
Else
LoadSprite (508+200, "harak/2/fox_walk_0000.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (509+200, "mods/"+MORE$+"/CMoD/2/fox_walk_0001.png",#PB_Sprite_Texture )
Else
LoadSprite (509+200, "harak/2/fox_walk_0001.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (510+200, "mods/"+MORE$+"/CMoD/2/fox_walk_0002.png",#PB_Sprite_Texture )
Else
LoadSprite (510+200, "harak/2/fox_walk_0002.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (511+200, "mods/"+MORE$+"/CMoD/2/fox_walk_0003.png",#PB_Sprite_Texture )
Else
LoadSprite (511+200, "harak/2/fox_walk_0003.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (512+200, "mods/"+MORE$+"/CMoD/2/fox_walk_0004.png",#PB_Sprite_Texture )
Else
LoadSprite (512+200, "harak/2/fox_walk_0004.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (513+200, "mods/"+MORE$+"/CMoD/2/fox_walk_0005.png",#PB_Sprite_Texture )
Else
LoadSprite (513+200, "harak/2/fox_walk_0005.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (514+200, "mods/"+MORE$+"/CMoD/2/fox_walk_0006.png",#PB_Sprite_Texture )
Else
LoadSprite (514+200, "harak/2/fox_walk_0006.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (515+200, "mods/"+MORE$+"/CMoD/2/fox_walk_0007.png",#PB_Sprite_Texture )
Else
LoadSprite (515+200, "harak/2/fox_walk_0007.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (516+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0000.png",#PB_Sprite_Texture )
Else
LoadSprite (516+200, "harak/fox_anim_2_shoot_0000.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (517+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )
Else
LoadSprite (517+200, "harak/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (518+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
Else
LoadSprite (518+200, "harak/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (519+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0003.png",#PB_Sprite_Texture )
Else
LoadSprite (519+200, "harak/fox_anim_2_shoot_0003.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (520+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0004.png",#PB_Sprite_Texture )
Else
LoadSprite (520+200, "harak/fox_anim_2_shoot_0004.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (521+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0005.png",#PB_Sprite_Texture )
Else
LoadSprite (521+200, "harak/fox_anim_2_shoot_0005.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (522+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0006.png",#PB_Sprite_Texture )
Else
LoadSprite (522+200, "harak/fox_anim_2_shoot_0006.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (523+200, "mods/"+MORE$+"/CMoD/fox_anim_shoot0000.png",#PB_Sprite_Texture )
Else
LoadSprite (523+200, "harak/fox_anim_shoot0000.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (524+200, "mods/"+MORE$+"/CMoD/fox_anim_shoot0001.png",#PB_Sprite_Texture )
Else
LoadSprite (524+200, "harak/fox_anim_shoot0001.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (525+200, "mods/"+MORE$+"/CMoD/fox_anim_shoot0002.png",#PB_Sprite_Texture )
Else
LoadSprite (525+200, "harak/fox_anim_shoot0002.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (526+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0006.png",#PB_Sprite_Texture )
Else
LoadSprite (526+200, "harak/fox_anim_2_shoot_0006.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (527+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0005.png",#PB_Sprite_Texture )
Else
LoadSprite (527+200, "harak/fox_anim_2_shoot_0005.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (528+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0004.png",#PB_Sprite_Texture )
Else
LoadSprite (528+200, "harak/fox_anim_2_shoot_0004.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (529+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0003.png",#PB_Sprite_Texture )
Else
LoadSprite (529+200, "harak/fox_anim_2_shoot_0003.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (530+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
Else
LoadSprite (530+200, "harak/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (531+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )
Else
LoadSprite (531+200, "harak/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (532+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0000.png",#PB_Sprite_Texture )
Else
LoadSprite (532+200, "harak/2/fox_anim_2_shoot_0000.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (533+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )
Else
LoadSprite (533+200, "harak/2/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (534+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
Else
LoadSprite (534+200, "harak/2/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (535+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0003.png",#PB_Sprite_Texture )
Else
LoadSprite (535+200, "harak/2/fox_anim_2_shoot_0003.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (536+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0004.png",#PB_Sprite_Texture )
Else
LoadSprite (536+200, "harak/2/fox_anim_2_shoot_0004.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (537+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0005.png",#PB_Sprite_Texture )
Else
LoadSprite (537+200, "harak/2/fox_anim_2_shoot_0005.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (538+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0006.png",#PB_Sprite_Texture )
Else
LoadSprite (538+200, "harak/2/fox_anim_2_shoot_0006.png",#PB_Sprite_Texture )
EndIf
If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (539+200, "mods/"+MORE$+"/CMoD/fox_anim_shoot0000.png",#PB_Sprite_Texture )
Else
LoadSprite (539+200, "harak/2/fox_anim_shoot0000.png",#PB_Sprite_Texture )
EndIf

;->=======
;->FDFDFD
;->=======

If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (540+200, "mods/"+MORE$+"/CMoD/2/fox_anim_shoot0001.png",#PB_Sprite_Texture )
LoadSprite (541+200, "mods/"+MORE$+"/CMoD/2/fox_anim_shoot0002.png",#PB_Sprite_Texture )
LoadSprite (542+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0006.png",#PB_Sprite_Texture )
LoadSprite (543+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0005.png",#PB_Sprite_Texture )
LoadSprite (544+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0004.png",#PB_Sprite_Texture )
LoadSprite (545+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0003.png",#PB_Sprite_Texture )
LoadSprite (546+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (547+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )
LoadSprite (548+200, "mods/"+MORE$+"/CMoD/fox_die_0000.png",#PB_Sprite_Texture )
LoadSprite (549+200, "mods/"+MORE$+"/CMoD/fox_die_0001.png",#PB_Sprite_Texture )
LoadSprite (550+200, "mods/"+MORE$+"/CMoD/fox_die_0002.png",#PB_Sprite_Texture )
LoadSprite (551+200, "mods/"+MORE$+"/CMoD/fox_die_0002.png",#PB_Sprite_Texture )
LoadSprite (552+200, "mods/"+MORE$+"/CMoD/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (553+200, "mods/"+MORE$+"/CMoD/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (554+200, "mods/"+MORE$+"/CMoD/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (555+200, "mods/"+MORE$+"/CMoD/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (556+200, "mods/"+MORE$+"/CMoD/2/fox_die_0000.png",#PB_Sprite_Texture )
LoadSprite (557+200, "mods/"+MORE$+"/CMoD/2/fox_die_0001.png",#PB_Sprite_Texture )
LoadSprite (558+200, "mods/"+MORE$+"/CMoD/2/fox_die_0002.png",#PB_Sprite_Texture )
LoadSprite (559+200, "mods/"+MORE$+"/CMoD/2/fox_die_0002.png",#PB_Sprite_Texture )
LoadSprite (560+200, "mods/"+MORE$+"/CMoD/2/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (561+200, "mods/"+MORE$+"/CMoD/2/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (562+200, "mods/"+MORE$+"/CMoD/2/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (563+200, "mods/"+MORE$+"/CMoD/2/fox_die_0003.png",#PB_Sprite_Texture )

LoadSprite (564+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0000.png",#PB_Sprite_Texture )
LoadSprite (565+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )
LoadSprite (566+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (567+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_up0001.png",#PB_Sprite_Texture )
LoadSprite (568+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_up0002.png",#PB_Sprite_Texture )
LoadSprite (569+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_up0003.png",#PB_Sprite_Texture )
LoadSprite (570+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_up0004.png",#PB_Sprite_Texture )
LoadSprite (571+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_up0003.png",#PB_Sprite_Texture )
LoadSprite (572+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_up0002.png",#PB_Sprite_Texture )
LoadSprite (573+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_up0001.png",#PB_Sprite_Texture )
LoadSprite (574+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (575+200, "mods/"+MORE$+"/CMoD/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )


LoadSprite (576+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0000.png",#PB_Sprite_Texture )
LoadSprite (577+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )
LoadSprite (578+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (579+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_up0001.png",#PB_Sprite_Texture )
LoadSprite (580+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_up0002.png",#PB_Sprite_Texture )
LoadSprite (581+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_up0003.png",#PB_Sprite_Texture )
LoadSprite (582+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_up0004.png",#PB_Sprite_Texture )
LoadSprite (583+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_up0003.png",#PB_Sprite_Texture )
LoadSprite (584+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_up0002.png",#PB_Sprite_Texture )
LoadSprite (585+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_up0001.png",#PB_Sprite_Texture )
LoadSprite (586+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (587+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )
Else
LoadSprite (540+200, "harak/2/fox_anim_shoot0001.png",#PB_Sprite_Texture )
LoadSprite (541+200, "harak/2/fox_anim_shoot0002.png",#PB_Sprite_Texture )
LoadSprite (542+200, "harak/2/fox_anim_2_shoot_0006.png",#PB_Sprite_Texture )
LoadSprite (543+200, "harak/2/fox_anim_2_shoot_0005.png",#PB_Sprite_Texture )
LoadSprite (544+200, "harak/2/fox_anim_2_shoot_0004.png",#PB_Sprite_Texture )
LoadSprite (545+200, "harak/2/fox_anim_2_shoot_0003.png",#PB_Sprite_Texture )
LoadSprite (546+200, "harak/2/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (547+200, "harak/2/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )
LoadSprite (548+200, "harak/fox_die_0000.png",#PB_Sprite_Texture )
LoadSprite (549+200, "harak/fox_die_0001.png",#PB_Sprite_Texture )
LoadSprite (550+200, "harak/fox_die_0002.png",#PB_Sprite_Texture )
LoadSprite (551+200, "harak/fox_die_0002.png",#PB_Sprite_Texture )
LoadSprite (552+200, "harak/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (553+200, "harak/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (554+200, "harak/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (555+200, "harak/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (556+200, "harak/2/fox_die_0000.png",#PB_Sprite_Texture )
LoadSprite (557+200, "harak/2/fox_die_0001.png",#PB_Sprite_Texture )
LoadSprite (558+200, "harak/2/fox_die_0002.png",#PB_Sprite_Texture )
LoadSprite (559+200, "harak/2/fox_die_0002.png",#PB_Sprite_Texture )
LoadSprite (560+200, "harak/2/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (561+200, "harak/2/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (562+200, "harak/2/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (563+200, "harak/2/fox_die_0003.png",#PB_Sprite_Texture )

LoadSprite (564+200, "harak/fox_anim_2_shoot_0000.png",#PB_Sprite_Texture )
LoadSprite (565+200, "harak/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )
LoadSprite (566+200, "harak/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (567+200, "harak/fox_anim_2_shoot_up0001.png",#PB_Sprite_Texture )
LoadSprite (568+200, "harak/fox_anim_2_shoot_up0002.png",#PB_Sprite_Texture )
LoadSprite (569+200, "harak/fox_anim_2_shoot_up0003.png",#PB_Sprite_Texture )
LoadSprite (570+200, "harak/fox_anim_2_shoot_up0004.png",#PB_Sprite_Texture )
LoadSprite (571+200, "harak/fox_anim_2_shoot_up0003.png",#PB_Sprite_Texture )
LoadSprite (572+200, "harak/fox_anim_2_shoot_up0002.png",#PB_Sprite_Texture )
LoadSprite (573+200, "harak/fox_anim_2_shoot_up0001.png",#PB_Sprite_Texture )
LoadSprite (574+200, "harak/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (575+200, "harak/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )


LoadSprite (576+200, "harak/2/fox_anim_2_shoot_0000.png",#PB_Sprite_Texture )
LoadSprite (577+200, "harak/2/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )
LoadSprite (578+200, "harak/2/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (579+200, "harak/2/fox_anim_2_shoot_up0001.png",#PB_Sprite_Texture )
LoadSprite (580+200, "harak/2/fox_anim_2_shoot_up0002.png",#PB_Sprite_Texture )
LoadSprite (581+200, "harak/2/fox_anim_2_shoot_up0003.png",#PB_Sprite_Texture )
LoadSprite (582+200, "harak/2/fox_anim_2_shoot_up0004.png",#PB_Sprite_Texture )
LoadSprite (583+200, "harak/2/fox_anim_2_shoot_up0003.png",#PB_Sprite_Texture )
LoadSprite (584+200, "harak/2/fox_anim_2_shoot_up0002.png",#PB_Sprite_Texture )
LoadSprite (585+200, "harak/2/fox_anim_2_shoot_up0001.png",#PB_Sprite_Texture )
LoadSprite (586+200, "harak/2/fox_anim_2_shoot_0002.png",#PB_Sprite_Texture )
LoadSprite (587+200, "harak/2/fox_anim_2_shoot_0001.png",#PB_Sprite_Texture )
EndIf

If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (628+200, "mods/"+MORE$+"/CMoD/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (629+200, "mods/"+MORE$+"/CMoD/fox_die_0004.png",#PB_Sprite_Texture )
LoadSprite (630+200, "mods/"+MORE$+"/CMoD/fox_die_0005.png",#PB_Sprite_Texture )
LoadSprite (631+200, "mods/"+MORE$+"/CMoD/fox_die_0006.png",#PB_Sprite_Texture )
LoadSprite (632+200, "mods/"+MORE$+"/CMoD/2/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (633+200, "mods/"+MORE$+"/CMoD/2/fox_die_0004.png",#PB_Sprite_Texture )
LoadSprite (634+200, "mods/"+MORE$+"/CMoD/2/fox_die_0005.png",#PB_Sprite_Texture )
LoadSprite (635+200, "mods/"+MORE$+"/CMoD/2/fox_die_0006.png",#PB_Sprite_Texture )
Else
LoadSprite (628+200, "harak/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (629+200, "harak/fox_die_0004.png",#PB_Sprite_Texture )
LoadSprite (630+200, "harak/fox_die_0005.png",#PB_Sprite_Texture )
LoadSprite (631+200, "harak/fox_die_0006.png",#PB_Sprite_Texture )
LoadSprite (632+200, "harak/2/fox_die_0003.png",#PB_Sprite_Texture )
LoadSprite (633+200, "harak/2/fox_die_0004.png",#PB_Sprite_Texture )
LoadSprite (634+200, "harak/2/fox_die_0005.png",#PB_Sprite_Texture )
LoadSprite (635+200, "harak/2/fox_die_0006.png",#PB_Sprite_Texture )
EndIf


If cmods=1 And FileSize("mods/"+MORE$+"/CMoD")=-2
LoadSprite (636+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_jump_0000.png",#PB_Sprite_Texture )
LoadSprite (637+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_jump_0001.png",#PB_Sprite_Texture )
LoadSprite (638+200, "mods/"+MORE$+"/CMoD/2/fox_anim_2_jump_0002.png",#PB_Sprite_Texture )

LoadSprite (639+200, "mods/"+MORE$+"/CMoD/fox_anim_2_jump_0000b.png",#PB_Sprite_Texture )
LoadSprite (640+200, "mods/"+MORE$+"/CMoD/fox_anim_2_jump_0001b.png",#PB_Sprite_Texture )
LoadSprite (641+200, "mods/"+MORE$+"/CMoD/fox_anim_2_jump_0002b.png",#PB_Sprite_Texture )
Else
LoadSprite (636+200, "harak/2/fox_anim_2_jump_0000.png",#PB_Sprite_Texture )
LoadSprite (637+200, "harak/2/fox_anim_2_jump_0001.png",#PB_Sprite_Texture )
LoadSprite (638+200, "harak/2/fox_anim_2_jump_0002.png",#PB_Sprite_Texture )

LoadSprite (639+200, "harak/fox_anim_2_jump_0000b.png",#PB_Sprite_Texture )
LoadSprite (640+200, "harak/fox_anim_2_jump_0001b.png",#PB_Sprite_Texture )
LoadSprite (641+200, "harak/fox_anim_2_jump_0002b.png",#PB_Sprite_Texture )
EndIf
;->FRPG

LoadSprite (1200, "harak/frog_walk_0000.png",#PB_Sprite_Texture )
LoadSprite (1201, "harak/frog_walk_0001.png",#PB_Sprite_Texture )
LoadSprite (1202, "harak/frog_walk_0002.png",#PB_Sprite_Texture )
LoadSprite (1203, "harak/frog_walk_0003.png",#PB_Sprite_Texture )
LoadSprite (1204, "harak/frog_walk_0004.png",#PB_Sprite_Texture )
LoadSprite (1205, "harak/frog_walk_0005.png",#PB_Sprite_Texture )
LoadSprite (1206, "harak/frog_walk_0006.png",#PB_Sprite_Texture )
LoadSprite (1207, "harak/frog_walk_0007.png",#PB_Sprite_Texture )
LoadSprite (1208, "harak/2/frog_walk_0000.png",#PB_Sprite_Texture )
LoadSprite (1209, "harak/2/frog_walk_0001.png",#PB_Sprite_Texture )
LoadSprite (1210, "harak/2/frog_walk_0002.png",#PB_Sprite_Texture )
LoadSprite (1211, "harak/2/frog_walk_0003.png",#PB_Sprite_Texture )
LoadSprite (1212, "harak/2/frog_walk_0004.png",#PB_Sprite_Texture )
LoadSprite (1213, "harak/2/frog_walk_0005.png",#PB_Sprite_Texture )
LoadSprite (1214, "harak/2/frog_walk_0006.png",#PB_Sprite_Texture )
LoadSprite (1215, "harak/2/frog_walk_0007.png",#PB_Sprite_Texture )

LoadSprite (548+700, "harak/frog_die_0000.png",#PB_Sprite_Texture )
LoadSprite (549+700, "harak/frog_die_0001.png",#PB_Sprite_Texture )
LoadSprite (550+700, "harak/frog_die_0002.png",#PB_Sprite_Texture )
LoadSprite (551+700, "harak/frog_die_0003.png",#PB_Sprite_Texture )
LoadSprite (552+700, "harak/frog_die_0004.png",#PB_Sprite_Texture )
LoadSprite (553+700, "harak/frog_die_0005.png",#PB_Sprite_Texture )
LoadSprite (554+700, "harak/frog_die_0006.png",#PB_Sprite_Texture )
LoadSprite (555+700, "harak/frog_die_0006.png",#PB_Sprite_Texture )

LoadSprite (556+700, "harak/2/frog_die_0000.png",#PB_Sprite_Texture )
LoadSprite (557+700, "harak/2/frog_die_0001.png",#PB_Sprite_Texture )
LoadSprite (558+700, "harak/2/frog_die_0002.png",#PB_Sprite_Texture )
LoadSprite (559+700, "harak/2/frog_die_0003.png",#PB_Sprite_Texture )
LoadSprite (560+700, "harak/2/frog_die_0004.png",#PB_Sprite_Texture )
LoadSprite (561+700, "harak/2/frog_die_0005.png",#PB_Sprite_Texture )
LoadSprite (562+700, "harak/2/frog_die_0006.png",#PB_Sprite_Texture )
LoadSprite (563+700, "harak/2/frog_die_0006.png",#PB_Sprite_Texture )



LoadSprite (636+700, "harak/2/frog_jump_0000.png",#PB_Sprite_Texture )
LoadSprite (637+700, "harak/2/frog_jump_0001.png",#PB_Sprite_Texture )
LoadSprite (638+700, "harak/2/frog_walk_0006.png",#PB_Sprite_Texture )

LoadSprite (639+700, "harak/frog_jump_0000.png",#PB_Sprite_Texture )
LoadSprite (640+700, "harak/frog_jump_0001.png",#PB_Sprite_Texture )
LoadSprite (641+700, "harak/frog_walk_0006.png",#PB_Sprite_Texture )



 LoadSprite (900, "weapon/1.png" )
 LoadSprite (901, "weapon/2.png" )
 LoadSprite (902, "weapon/3.png" )
 LoadSprite (903, "weapon/4.png" )
 LoadSprite (904, "weapon/5.png" )
 LoadSprite (905, "weapon/6.png" )
 LoadSprite (906, "weapon/7.png" )
  LoadSprite (907, "weapon/9.png" )
    LoadSprite (908, "weapon/8.png" )
    LoadSprite (909, "weapon/10.png" )
    LoadSprite (910, "weapon/11.png" )
     LoadSprite (911, "weapon/12.png" )
        LoadSprite (912, "weapon/13.png" )
         LoadSprite (913, "weapon/heart.png",#PB_Sprite_Texture )
         LoadSprite (914, "weapon/17.png" )
           LoadSprite (920, "weapon/patron.png" )
           LoadSprite (921, "weapon/patron1.png" )
           LoadSprite (922, "weapon/patron2.png" )
           LoadSprite (923, "weapon/patron3.png" )
           LoadSprite (924, "weapon/patron4.png" )
          LoadSprite (925, "weapon/122.png" )
  LoadSprite (950, "weapon/dym0.bmp" )
  LoadSprite (950, "weapon/dym0.bmp" )
    LoadSprite (951, "weapon/dym1.bmp" )
      LoadSprite (952, "weapon/dym2.bmp" )
        LoadSprite (953, "weapon/dym3.bmp" )
        LoadSprite (954, "weapon/werh1.png" )
        LoadSprite (955, "weapon/werh2.png" )
        LoadSprite (956, "weapon/werh3.png" )
        LoadSprite (957, "weapon/werh4.png" )
        LoadSprite (958, "weapon/werh5.png" )
        LoadSprite (959, "weapon/werh6.png" )
         LoadSprite (960, "weapon/wniz.bmp" )
           LoadSprite (961, "weapon/1.bmp",#PB_Sprite_Texture )
  LoadSprite (962, "weapon/2.bmp",#PB_Sprite_Texture )
             LoadSprite (963, "weapon/1w.png",#PB_Sprite_Texture )
  LoadSprite (964, "weapon/2w.png",#PB_Sprite_Texture )
  
  
   LoadSprite (970, "weapon/1a.png" )
   LoadSprite (971, "weapon/2a.png" )
   LoadSprite (972, "weapon/3a.png" )
    LoadSprite (973, "weapon/4a.png" )
       LoadSprite (974, "weapon/5a.png" )
        LoadSprite (975, "weapon/6a.png" )
  LoadSprite (976, "weapon/7a.png" )
    LoadSprite (977, "weapon/8a.png" )
    LoadSprite (978, "weapon/9a.png" )
    LoadSprite (979, "weapon/10a.png" )
      LoadSprite (980, "weapon/11a.png" )
  LoadSprite (981, "weapon/12a.png" )
   LoadSprite (982, "weapon/13a.png" )
    LoadSprite (983, "weapon/14a.png" )
  LoadSprite (984, "weapon/15a.png" )
  LoadSprite (985, "weapon/16a.png" )
  LoadSprite (986, "weapon/17a.png" )
  LoadSprite (987, "weapon/18a.png" )
  
  
  LoadSprite (990, "harak/s1.png",#PB_Sprite_Texture )
   LoadSprite (991, "harak/s2.png",#PB_Sprite_Texture )
    LoadSprite (992, "harak/s3.png",#PB_Sprite_Texture )
     LoadSprite (993, "harak/s4.png",#PB_Sprite_Texture )

LoadSprite (1009, "gfx/doska2.png",#PB_Sprite_Texture )
LoadSprite (1010, "gfx/doska.png",#PB_Sprite_Texture )
LoadSprite (1011, "sprite/11.png",#PB_Sprite_Texture )
LoadSprite (1012, "sprite/kras.png",#PB_Sprite_Texture )
   LoadSprite (1013, "weapon/1b.png" ,#PB_Sprite_Texture)
    LoadSprite (1014, "weapon/2b.png" ,#PB_Sprite_Texture)
     LoadSprite (1015, "weapon/3b.png" ,#PB_Sprite_Texture)
      LoadSprite (1016, "weapon/4b.png" ,#PB_Sprite_Texture)
       LoadSprite (1017, "weapon/5b.png" ,#PB_Sprite_Texture)
        LoadSprite (1018, "weapon/6b.png",#PB_Sprite_Texture )
         LoadSprite (1019, "weapon/7b.png" ,#PB_Sprite_Texture)
           LoadSprite (1020, "weapon/9b.png" ,#PB_Sprite_Texture)
            LoadSprite (1021, "weapon/10b.png" ,#PB_Sprite_Texture)
             LoadSprite (1022, "weapon/11b.png" ,#PB_Sprite_Texture)
              LoadSprite (1023, "weapon/12b.png" ,#PB_Sprite_Texture)
               LoadSprite (1024, "weapon/13b.png" ,#PB_Sprite_Texture)
                LoadSprite (1025, "weapon/14b.png" ,#PB_Sprite_Texture)
                 LoadSprite (1026, "weapon/15b.png" ,#PB_Sprite_Texture)
                  LoadSprite (1027, "weapon/16b.png",#PB_Sprite_Texture )
                    LoadSprite (1100, "weapon/nav1.png" )
                      LoadSprite (1101, "weapon/nav2.png" )
                        LoadSprite (1102, "weapon/nav3.png" )
                          LoadSprite (1103, "weapon/nav4.png" )
                            LoadSprite (1104, "weapon/nav5.png" )
                              LoadSprite (1105, "weapon/nav6.png" )
                                LoadSprite (1106, "weapon/nav7.png" )
                                LoadSprite (1107, "gfx/doska2eng.png",#PB_Sprite_Texture )
                                
LoadSprite (1500, "weapon/1i.png" )
LoadSprite (1501, "weapon/2i.png" )
LoadSprite (1502, "weapon/3i.png" )
LoadSprite (1503, "weapon/4i.png" )
LoadSprite (1504, "weapon/5i.png" )
LoadSprite (1505, "weapon/6i.png" )
 LoadSprite (2000, "gfx/01.bmp" )
  LoadSprite (2001, "gfx/02.bmp" )
   LoadSprite (2002, "gfx/03.bmp" )
    LoadSprite (2003, "gfx/04.bmp" )
     LoadSprite (2004, "gfx/05.bmp" )
      LoadSprite (2005, "gfx/06.bmp" )
       LoadSprite (2006, "gfx/07.bmp" )
        LoadSprite (2007, "gfx/08.bmp" )
         LoadSprite (2008, "gfx/09.bmp" )
          LoadSprite (2009, "gfx/10.bmp" )
           LoadSprite (2010, "gfx/11.bmp" )
           LoadSprite (2010, "gfx/12.bmp" )
          


LoadSprite (96, "sprite/0.bmp",#PB_Sprite_Texture )
LoadSprite (97, "sprite/0.bmp",#PB_Sprite_Texture )
If mods=1
;LoadSprite (2011, "patch/logo.png",#PB_Sprite_Texture )
;LoadSprite (2011, MODPATH$+"/logo.png",#PB_Sprite_Texture )
LoadSprite (2011, "mods/"+MORE$+"/logo.png",#PB_Sprite_Texture )


Else
If ReadFile(0, "patch/logo.png")
LoadSprite (2011, "patch/logo.png",#PB_Sprite_Texture )
Else
LoadSprite (2011, "gfx/logo.png",#PB_Sprite_Texture )
EndIf
EndIf
LoadSprite (2012, "gfx/m1.png" )
LoadSprite (2013, "gfx/m2.png" )
LoadSprite (2014, "gfx/m3.png" )
LoadSprite (2015, "gfx/m4.png" )
LoadSprite (2016, "gfx/m5.png" )
LoadSprite (2017, "gfx/m6.png" )
LoadSprite (2018, "gfx/s1.png" )
LoadSprite (2019, "gfx/s2.png" )
LoadSprite (2020, "gfx/pods.png" )
LoadSprite (2021, "gfx/m7.png" )
;LoadSprite (2077, "neoGUI/playRU.png" )
;LoadSprite (2078, "neoGUI/playEN.png" )





;>--------

;rtheard1 = CreateThread (@Theard1_Res(), 1)
;rtheard2 = CreateThread (@Theard1_Res(), 2)
;rtheard3 = CreateThread (@Theard1_Res(), 3)
;rtheard4 = CreateThread (@Theard1_Res(), 4)

;WaitThread(rtheard1)
;WaitThread(rtheard2)
;WaitThread(rtheard3)
;WaitThread(rtheard4)
;
;
;
;LMAO, wut a fak?!
;

;--END

CreateSprite3D(2011, 2011)
;CreateSprite3D(2077, 2077)
CreateSprite3D(1, 300)
CreateSprite3D(2, 301)
CreateSprite3D(3, 302)
CreateSprite3D(4, 303)
CreateSprite3D(5, 304)
CreateSprite3D(6, 305)
CreateSprite3D(7, 306)
CreateSprite3D(8, 307)
CreateSprite3D(9, 308)
CreateSprite3D(10, 309)
CreateSprite3D(11, 310)
CreateSprite3D(12, 311)
CreateSprite3D(13, 312)
CreateSprite3D(14, 313)
CreateSprite3D(15, 314)
CreateSprite3D(16, 315)
CreateSprite3D(17, 316)
CreateSprite3D(18, 317)
CreateSprite3D(19, 318)
CreateSprite3D(20, 319)
CreateSprite3D(21, 320)
CreateSprite3D(22, 320)
CreateSprite3D(299, 299)


CreateSprite3D(500, 500)
CreateSprite3D(501, 501)
CreateSprite3D(502, 502)
CreateSprite3D(503, 503)
CreateSprite3D(504, 504)
CreateSprite3D(505, 505)
CreateSprite3D(506, 506)
CreateSprite3D(507, 507)
CreateSprite3D(508, 508)
CreateSprite3D(509, 509)
CreateSprite3D(510, 510)
CreateSprite3D(511, 511)
CreateSprite3D(512, 512)
CreateSprite3D(513, 513)
CreateSprite3D(514, 514)
CreateSprite3D(515, 515)


CreateSprite3D(500+200, 500+200)
CreateSprite3D(501+200, 501+200)
CreateSprite3D(502+200, 502+200)
CreateSprite3D(503+200, 503+200)
CreateSprite3D(504+200, 504+200)
CreateSprite3D(505+200, 505+200)
CreateSprite3D(506+200, 506+200)
CreateSprite3D(507+200, 507+200)
CreateSprite3D(508+200, 508+200)
CreateSprite3D(509+200, 509+200)
CreateSprite3D(510+200, 510+200)
CreateSprite3D(511+200, 511+200)
CreateSprite3D(512+200, 512+200)
CreateSprite3D(513+200, 513+200)
CreateSprite3D(514+200, 514+200)
CreateSprite3D(515+200, 515+200)


CreateSprite3D(913, 913)

CreateSprite3D(961, 961)
CreateSprite3D(962, 962)
CreateSprite3D(963, 963)
CreateSprite3D(964, 964)

CreateSprite3D(990, 990)
CreateSprite3D(991, 991)
CreateSprite3D(992, 992)
CreateSprite3D(993, 993)

CreateSprite3D(1009, 1009)
CreateSprite3D(1010, 1010)
CreateSprite3D(1011, 1011)
CreateSprite3D(1012, 1012)
CreateSprite3D(1107, 1107)
CreateSprite3D(1013, 1013)
CreateSprite3D(1014, 1014)
CreateSprite3D(1015, 1015)
CreateSprite3D(1016, 1016)
CreateSprite3D(1017, 1017)
CreateSprite3D(1018, 1018)
CreateSprite3D(1019, 1019)
CreateSprite3D(1020, 1020)
CreateSprite3D(1021, 1021)
CreateSprite3D(1022, 1022)
CreateSprite3D(1023, 1023)
CreateSprite3D(1024, 1024)
CreateSprite3D(1025, 1025)
CreateSprite3D(1026, 1026)
CreateSprite3D(1027, 1027)
CreateSprite3D(1200, 1200)
CreateSprite3D(1201, 1201)
CreateSprite3D(1202, 1202)
CreateSprite3D(1203, 1203)
CreateSprite3D(1204, 1204)
CreateSprite3D(1205, 1205)
CreateSprite3D(1206, 1206)
CreateSprite3D(1207, 1207)
CreateSprite3D(1208, 1208)
CreateSprite3D(1209, 1209)
CreateSprite3D(1210, 1210)
CreateSprite3D(1211, 1211)
CreateSprite3D(1212, 1212)
CreateSprite3D(1213, 1213)
CreateSprite3D(1214, 1214)
CreateSprite3D(1215, 1215)


exitm=1
Dim mass.s(200)
Dim alfa.w(32)
Dim mass2.s(200)
kol=8;-----kolwo bitw
arteflost=1;  сколько артефактов теряет при смерти
almazrea=1; реанимироват алмазы или нет
monstart=0; деньги при старте









 
Structure namee
  name$
  yes.l
  color.l
  huisit.l
EndStructure
NewList namee.namee ()

Gosub sasa:


   
      


  sobd=0

 Gosub zoof:




  Repeat
  


s1s1:


     Event = WaitWindowEvent()
   

  If Event = #PB_Event_Gadget
    Select EventGadget()
      Case 1
        DisableGadget(1, 1)
        DisableGadget(2, 0)
          DisableGadget(4, 0)
        letsgo=0
            start=0
            If zar>0:zar-1:EndIf 
            If zar=0:PlaySound(5):zar=10:EndIf 
            ClearScreen (RGB(0, 0, 0))
            
             Gosub zoof:
            
            
            
Start3D()
Sprite3DBlendingMode(2, 6)

DisplaySprite3D(2011 , xraz/2-sobd/2-290, 0,255)

Stop3D()

FlipBuffers()

;Case 4
 ; PlaySound(5)
  
;  
;------------SET-AUTORU


 ; If lang=1:lang=0:
; ; If lang=1:lang=0:
    ;SetGadgetText(1, "Меню")
   ; SetGadgetText(2, "Масштаб")  
  ;  SetGadgetText(3, "Играть")  
  ;  SetGadgetText(4, "Русский")  
  ;  SetGadgetText(5, "Выход")  
  ;  SetGadgetText(6, "Модификации (НЕ СТАБИЛЬНО, НЕ НАЖИМАТЬ!")      
  ;  SetWindowTitle(0, "Выдры и Феньки CUTSTOM BUILD v1.0.0-Alpha") 
  ;:Goto drrrr:EndIf 
  ;If lang=0:lang=1
;;  If lang=0:lang=1
 ;     SetGadgetText(1, "Menu")
 ;   SetGadgetText(2, "Field of View")  
 ;   SetGadgetText(3, "Play")  
 ;   SetGadgetText(4, "English")  
 ;   SetGadgetText(5, "Exit")  
 ;   SetGadgetText(6, "Mods (UNSTABLE, MAY CAUSE CRASH! ")  
 ;   SetWindowTitle(0, "Otters and Fennecs CUTSTOM BUILD v1.0.0-Alpha")   
 ;   
 ; :Goto drrrr:EndIf 
 ;   
drrrr:
Gosub sasa
 If letsgo=0:Gosub  zoof::EndIf 
Case 5
  
            End 
            
          Case 3
            PlaySound(5)
            StopSound(551)
 If EventType() =  #PB_EventType_LeftClick :  exitm=0: EndIf

;---OPEN WINDOW


Case 6

  If OpenConsole ()
  
  
    ConsoleTitle ("MODS, VERY UNSTABLE!")
  
;lEnableExplicit
  ; Define the constants:
  #MAXBYTE = 255
  #MAXLONG = 2147483647
  
  
    ConsoleColor(4,0)  
    ConsoleLocate (18,12)                          ; x y position 
    If mods=0
    Print ("Allow Mods?[yes/no, if you type no, programm will quit]:  ")           ; Ask for name
    amods$ = Input()
    
    
    If amods$ = "yes"
    
    mods=1
    
    If CreateFile(0, "work/mods.dat")
        WriteStringN(0, Str(mods))
       EndIf
       
    EndIf
    EndIf
       
    ClearConsole()
    
    PrintN ( "Welcome to ModManager by NewSource v.1.0" )
    PrintN ( "Be careful, mods may cause crash and unstable state" )
    PrintN ( "" )
    PrintN ( "!!Only one mod can be loaded at same time!!" )
      
    PrintN ("")
    PrintN ("1-Listmods")
    PrintN ("2-Set mod")
    PrintN ("3-Help")
    PrintN ("4-Exit")
   ; If ReadFile(0, "work/mods.dat")
   ; PrintN ("5-Unload Installed Mod (NOT ")
  ;  EndIf
    zzz=Val(Input())
    
   ; If zzz=5
    ;  If ReadFile(0, "work/currentmod.dat")
     ;     DeleteFile("work/currentmod.dat")
     ;     PrintN ("Done")
     ;   Else
       ;   PrintN ("No Mods Installed")
          
       ; EndIf
        ;EndIf
    If zzz=1
      ClearConsole()
      
      RunProgram("utilities/listmods.bat")
      
      
      ElseIf zzz=2
        ClearConsole()
        
        If ReadFile(0, "work/currentmod.dat")

            MO$ =  Trim(ReadString(0))

            cmod = Val(MO$)
            
            moe=1
            PrintN ("====================")
            PrintN ("Mod Installer v1.0")
            PrintN ("====================")
            PrintN ("")
            PrintN ("Current mod is "+MO$)
            PrintN ("The mod already is set'd")
            PrintN ("Do you want re-config mods?")
            
            re$ = Input()
    
    
            If re$ = "yes"
            
            PrintN ("If you not sure about mod name, open in explorer ")
            PrintN ("mods folder and look at name of subfolders there. ")
            PrintN (" ")
            Print ("Input mod name:")
            MODNAME$ = Input()
            
            

            If CreateFile(0, "work/currentmod.dat")
                WriteString(0, MODNAME$)
            EndIf
            
            PrintN ("The Mod is Installed.")
            PrintN ("CAUTION: DO NOT CLOSE CONSOLE WINDOW!!!.")
            PrintN ("Back to game and press Exit button, then re-launch game.")
            
            Else
              CloseConsole()
              End
            EndIf
        Else
            PrintN ("====================")
            PrintN ("Mod Installer v1.0")
            PrintN ("====================")
            PrintN ("")
            PrintN ("No mods is installed right now")
            
            Print ("Input mod name:")
            MODNAME1$ = Input()
            
            

            If CreateFile(0, "work/currentmod.dat")
                WriteString(0, MODNAME1$)
            EndIf
            
            PrintN ("The Mod is Installed.")
            PrintN ("CAUTION: DO NOT CLOSE CONSOLE WINDOW!!!.")
            PrintN ("Back to game and press Exit button, then re-launch game.")
            End
        EndIf
        
      ElseIf zzz=3
          PrintN ("No help right now...")
          PrintN ("mods/"+MORE$)
          PrintN (Str(MONA))
          MessageRequester("PureBasic", "Line read: "+MORE$, 0)
          
      Else
        CloseConsole()
        End
    EndIf
      
    Else
       CloseConsole()                  
    EndIf

Case 2
  PlaySound(5)
  If xraz=1280:
      xraz=800
      yraz=480
      fov=110
      
    Goto nachalo:EndIf 
  
    If xraz=800:
   xraz=1366
   yraz=768
   fov=90
 Goto nachalo:EndIf 
 
     If xraz=1366:
   xraz=1280
   yraz=720
   fov=100
    Goto nachalo:EndIf 


EndSelect
EndIf 

    If Event = #PB_Event_CloseWindow  ; If the user has pressed on the close button
      Quit = 1
      
    EndIf
    


  
 
;StartTime.f = ElapsedMilliseconds()  
 
If exitm=1:Goto exi:EndIf 

    WindowEvent()

If start=0:Goto start22:EndIf 


DisableGadget(2, 1)

Gosub animacija

Gosub print2

Gosub gravitacija
Gosub teleportkre
Gosub print
Gosub print4
Gosub print3
Gosub pulq
Gosub ogon
Gosub firee
Gosub babah

Gosub textl

Gosub ikon  
Gosub delor3
Goto endtur



retu:

Gosub mouse



Gosub addbot
Gosub nextplay:



Gosub bultyh



FlipBuffers()


If fon=0 Or fon=1:ClearScreen (RGB(0, 132, 255)):EndIf 
If fon=2:ClearScreen (RGB(0, 40, 80)):EndIf 
If fon=3:ClearScreen (RGB(255, 158, 158)):EndIf 


exi:



If exitm=0:ReleaseMouse(0):DisableGadget(3, 1):EndIf 
If exitm=1:ReleaseMouse(1):DisableGadget(3, 0):EndIf 


   Until Quit = 1
  


    
EndIf
;-
;-
;-If OpenWindow END
;-
;-
End 

;-------------animstr
animacija:
Return 


viktor:

  ExamineMouse() 
  If MouseButton(1):Goto viktor:EndIf 

start=0

 StopDrawing() 
 
 ClearScreen (RGB(0, 0, 0))
 
 
 oloa:
   ExamineKeyboard()
 If KeyboardPushed(#PB_Key_Escape):Goto sssstart::EndIf 
 
 If exitm=0:ReleaseMouse(0):DisableGadget(3, 1):EndIf 
If exitm=1:ReleaseMouse(1):DisableGadget(3, 0):EndIf 
  Start3D()
Sprite3DBlendingMode(2, 6)
ZoomSprite3D(299, xraz, yraz)

DisplaySprite3D(299 , 0, 0,255)

DisplaySprite3D(2011 , xraz/2-sobd/2-290, 0,255)

Stop3D()

 DisplayTransparentSprite(1010,xraz/2-98,182)
 
  DisplayTransparentSprite(290,xraz/2-125,250)

 
 StartDrawing( ScreenOutput() )
 DrawingFont(FontID(4)) 
    DrawingMode(1)
    a=TextWidth (name$)
    a/2
    
    If lang=0
    b=TextWidth ("Победитель")
    b/2
    
    DrawText(xraz/2-b/2-15,182+30, "Победитель", RGB((255),(255),(255)) )
    DrawText(xraz/2-a/2-14,182+46, name$, RGB((255),(255),(200)) )
  EndIf 
  
      If lang=1
    b=TextWidth ("Winner")
    b/2
    
    DrawText(xraz/2-b/2-15,182+30, "Winner", RGB((255),(255),(255)) )
    DrawText(xraz/2-a/2-14,182+46, name$, RGB((255),(255),(200)) )
    EndIf 
    DrawingMode(1)
 
    StopDrawing()
    ExamineMouse() 
    If MouseButton(1):Goto sssstart::EndIf 
    ExamineMouse()
xm = MouseX()                         
ym = MouseY() 
      DisplayTransparentSprite(1, xm, ym)   

   FlipBuffers()
    
    
  
    
    Goto oloa
 
 
    bultyh:
    If bult=0:Return:EndIf
    DisplayTransparentSprite(44+bul,xbu+c,ybu+d)
    If bull=1:bul+1:EndIf 
    bull+1
    If bull=2:bull=0:EndIf 
    If bul=4:bul=0:bult=0:EndIf 
    Return 
 
 
 
 
;--------------START
start22:

      
letsgo=1
 ; DisableGadget(4, 1)
 DisableGadget(1, 1)
 DisableGadget(1, 6)
Start3D()
Sprite3DBlendingMode(2, 6)

ZoomSprite3D(299, xraz, yraz)

DisplaySprite3D(299 , 0, 0,255)

DisplaySprite3D(2011 , xraz/2-sobd/2-290, 0,255)
Stop3D()
DisplayTransparentSprite(2012,xraz/2-400/2,160)



   
ExamineKeyboard()

If KeyboardPushed(#PB_Key_Escape):Gosub escc:EndIf 
   
ExamineMouse() 
  


 xm = MouseX()                         
 ym = MouseY() 
m1=0


If  inputname=0 And inputnum=0:
If xm>xraz/2-400/2+25 And xm<xraz/2-400/2+155 And ym>400 And ym<420:m1=1:DisplayTransparentSprite(2013, xraz/2-400/2+28, 402) :EndIf 
 
 
    If xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180 And ym<180+18:DisplayTransparentSprite(2017, xraz/2-400/2+11, 183) :EndIf 
 If xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180+22 And ym<180+18+22:DisplayTransparentSprite(2017, xraz/2-400/2+11, 183+22) :EndIf 
  If xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180+44 And ym<180+18+44:DisplayTransparentSprite(2017, xraz/2-400/2+11, 183+44) :EndIf 
  If xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180+66 And ym<180+18+66:DisplayTransparentSprite(2017, xraz/2-400/2+11, 183+66) :EndIf 
  If xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180+88 And ym<180+18+88:DisplayTransparentSprite(2017, xraz/2-400/2+11, 183+88) :EndIf 
  If xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180+110 And ym<180+18+110:DisplayTransparentSprite(2017, xraz/2-400/2+11, 183+110) :EndIf 
  If xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180+132 And ym<180+18+132:DisplayTransparentSprite(2017, xraz/2-400/2+11, 183+132) :EndIf 
If xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180+154 And ym<180+18+154:DisplayTransparentSprite(2017, xraz/2-400/2+11, 183+154) :EndIf 


EndIf 
ExamineMouse() 
  
  If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180 And ym<180+18:
    element=0
    inputname=1
      FullText$=""
    PlaySound(5)
  EndIf 
  
  
  If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180+22 And ym<180+18+22:
    element=1
    inputname=1
      FullText$=""
    PlaySound(5)
  EndIf 
  
    If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180+44 And ym<180+18+44:
    element=2
    inputname=1
      FullText$=""
    PlaySound(5)
  EndIf 
  
      If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180+66 And ym<180+18+66:
    element=3
    inputname=1
      FullText$=""
    PlaySound(5)
 EndIf 
 
       If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180+88 And ym<180+18+88:
    element=4
    inputname=1
      FullText$=""
    PlaySound(5)
  EndIf 
  
         If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180+110 And ym<180+18+110:
    element=5
    inputname=1
      FullText$=""
    PlaySound(5)
  EndIf 
  
    
         If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180+132 And ym<180+18+132:
    element=6
    inputname=1
      FullText$=""
    PlaySound(5)
 EndIf 
 
          If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180+154 And ym<180+18+154:
    element=7
    inputname=1
    FullText$=""
    PlaySound(5)
 EndIf
 
 
 
 DisableGadget(2, 0)
 
 
 

  
  

 

 
 
 
 
 If col=0:color.l=RGB(255,255,255):EndIf 
 If col=1:color.l=RGB(0,255,255):EndIf 
 If col=2:color.l=RGB(255,0,255):EndIf 
  If col=3:color.l=RGB(255,255,0):EndIf 
  If col=4:color.l=RGB(0,0,255):EndIf 
  If col=5:color.l=RGB(255,0,0):EndIf 
  If col=6:color.l=RGB(0,255,0):EndIf 
  If col=7:color.l=RGB(50,100,255):EndIf 
  If col=8:color.l=RGB(255,50,100):EndIf 
   If col=9:color.l=RGB(255,100,50):EndIf 
 
 If col=10:col=0:color.l=RGB(255,255,255):EndIf 
 If inputnum=0 And inputname=0 And MouseButton(1) And m1=1 :
   pliz=0
   ResetList( namee() ) 
While NextElement( namee())
   If namee()\yes=2016:pliz+1:EndIf 
   Wend 
   
   
   
   
   If pliz>6:
     plizz=100

     Goto gotogot

   :EndIf 
   
   plizz=0
      ResetList( namee() ) 
While NextElement( namee())
   If namee()\yes=2014:plizz+1:EndIf 
   Wend 
   
   If plizz=0:
     plizz=100
     Goto gotogot

   :EndIf 
   start=1
 PlaySound(5): DisableGadget(1, 0):Goto sozp:EndIf 
 
 
 
 gotogot:
 
  If inputnum=0 And inputname=0 And MouseButton(1) And xm>xraz/2-400/2+52+176-8 And xm<xraz/2-400/2+52+176+123 And ym>182 And ym<182+17:
    PlaySound(5)
    inpb:
             ExamineMouse() 
            If  MouseButton(1)=1:Goto inpb:EndIf 
    kol-1
    If kol=0: kol=99: EndIf 
  EndIf 
    If inputnum=0 And inputname=0 And MouseButton(1) And xm>xraz/2-400/2+52+176+123 And xm<xraz/2-400/2+52+176+123+20 And ym>182 And ym<182+17:
    PlaySound(5)
    inpba:
             ExamineMouse() 
            If  MouseButton(1)=1:Goto inpba:EndIf 
            
            inputnum=1
    kol=0
            EndIf 
    
            
    If  inputnum=1:        
            fulltext2$=Str(kol)
              If Len(fulltext2$)=2:inputnum=0:EndIf 
            ExamineKeyboard()
            let$ = KeyboardInkey()
            If (Asc(let$) >= 47 And Asc(let$) < 58): fulltext2$ + let$: EndIf
            
                              If KeyboardReleased(#PB_Key_Back)
        FullText2$ = Left(FullText2$, Len(FullText2$)-1)
      EndIf
            
            
            kol=Val(fulltext2$) 

                    ExamineKeyboard()
            If KeyboardPushed(#PB_Key_Return) :
            
              If kool=0:kol=1:
                EndIf 
            inputnum=0:EndIf 
          
            StartDrawing( ScreenOutput())
            DrawingFont(FontID(4)) 
             DrawingMode(#PB_2DDrawing_Transparent )
      a=TextWidth(Str(kol))
      a/2
      If asago<25:DrawText(xraz/2-400/2+52+176+129-a, 182, Str(kol)+"_", RGB((255),(255),(255)) ):EndIf 
      If asago=0:asago=50:EndIf 
      asago-1
     StopDrawing() 
  EndIf 

  
  
  
  
    If inputnum=0 And  inputname=0 And MouseButton(1) And xm>xraz/2-400/2+52+176-8 And xm<xraz/2-400/2+52+176+125+17 And ym>182+22 And ym<182+17+22:
      PlaySound(5)
      inpbb:
             ExamineMouse() 
            If  MouseButton(1)=1:Goto inpbb:EndIf 
    sizel+1
    If sizel=4: sizel=0: EndIf 
  EndIf 
  
If inputnum=0 And inputname=0 
  
    If xm>xraz/2-400/2+52+176-8 And xm<xraz/2-400/2+52+176+123 And ym>182 And ym<182+22:DisplayTransparentSprite(2013, xraz/2-400/2+52+176-14, 182-1) :EndIf
  If xm>xraz/2-400/2+52+176-8 And xm<xraz/2-400/2+52+176+125+17 And ym>182+22 And ym<182+44:DisplayTransparentSprite(2013, xraz/2-400/2+52+176-14, 182+22-1) :EndIf
  If xm>xraz/2-400/2+52+176-8 And xm<xraz/2-400/2+52+176+125+17 And ym>182+44 And ym<182+66:DisplayTransparentSprite(2013, xraz/2-400/2+52+176-14, 182+44-1) :EndIf
  If xm>xraz/2-400/2+52+176-8 And xm<xraz/2-400/2+52+176+125+17 And ym>182+66 And ym<182+88:DisplayTransparentSprite(2013, xraz/2-400/2+52+176-14, 182+66-1) :EndIf
  If xm>xraz/2-400/2+52+176-8 And xm<xraz/2-400/2+52+176+125+17 And ym>182+88 And ym<182+110:DisplayTransparentSprite(2021, xraz/2-400/2+52+176-14, 182+88-1) :EndIf
  If xm>xraz/2-400/2+52+176-8 And xm<xraz/2-400/2+52+176+125+17 And ym>182+110 And ym<182+132:DisplayTransparentSprite(2021, xraz/2-400/2+52+176-14, 182+110-1) :EndIf
  EndIf 
  
  
   If  inputnum=0 And inputname=0 And MouseButton(1) And xm>xraz/2-400/2+52+176-8 And xm<xraz/2-400/2+52+176+125+17 And ym>182+44 And ym<182+66:
     PlaySound(5)
     inpbbb:
             ExamineMouse() 
            If  MouseButton(1)=1:Goto inpbbb:EndIf 
            arteflost+1
            If arteflost=5:arteflost=0:EndIf 
          EndIf 
          
          
     If inputnum=0 And inputname=0 And  MouseButton(1) And xm>xraz/2-400/2+52+176-8 And xm<xraz/2-400/2+52+176+125+17 And ym>182+66 And ym<182+88:
       PlaySound(5)
       inpbbbb:
             ExamineMouse() 
            If  MouseButton(1)=1:Goto inpbbbb:EndIf 
    almazrea+1
            If almazrea=2:almazrea=0:EndIf 
  EndIf 
        If inputnum=0 And inputname=0 And MouseButton(1) And xm>xraz/2-400/2+52+176-8 And xm<xraz/2-400/2+52+176+125+17 And ym>182+88 And ym<182+110:
          PlaySound(5)
          inpbbbbb:
             ExamineMouse() 
            If  inputnum=0 And inputname=0 And MouseButton(1)=1:Goto inpbbbbb:EndIf 
            monstart+2
            monstart*2
            If   monstart=>10000:  monstart=0:EndIf 
  EndIf  
  

  
  If inputnum=0 And inputname=0 And MouseButton(1) And xm>xraz/2-400/2+52+176-8 And xm<xraz/2-400/2+52+176+125+17 And ym>182+110 And ym<182+132:
    PlaySound(5)
       inpbbbbbb:
             ExamineMouse() 
            If  MouseButton(1)=1:Goto inpbbbbbb:EndIf 
            
            
            
kol=8
arteflost=1;  сколько артефактов теряет при смерти
almazrea=1; реанимироват алмазы или нет
monstart=0; деньги при старте



ClearList(namee()) 
Gosub sasa:
 
            
     
      
            
            
            
            
            
  EndIf  
  
  
  StartDrawing( ScreenOutput() )
  DrawingFont(FontID(4)) 
      DrawingMode(1)
      If lang=0:
      
      DrawText(xraz/2-400/2+52, 402, STARTGAME$, RGB((255),(255),(255)) )
      DrawText(xraz/2-400/2+52+169, 182, WINCON$, RGB((255),(255),(255)) )
      DrawText(xraz/2-400/2+52+169, 182+44, ARTIFACTS$, RGB((255),(255),(255)) )
      DrawText(xraz/2-400/2+52+169, 182+66, NC$, RGB((255),(255),(255)) )
      DrawText(xraz/2-400/2+52+169, 182+88, COM$+Str(monstart), RGB((255),(255),(255)) )
      DrawText(xraz/2-400/2+52+169, 182+110, RESET$, RGB((255),(255),(255)) )
      
      a=TextWidth(Str(kol))
      a/2
      DrawText(xraz/2-400/2+52+176+129-a, 182, Str(kol), RGB((255),(255),(255)) )
      
      
          DrawText(xraz/2-400/2+52+169, 182+22, "Размер локаций", RGB((255),(255),(255)) )
If sizel=0:DrawText(xraz/2-400/2+52+176+124, 182+22, "Все", RGB((255),(255),(255)) ):EndIf 
If sizel=1:DrawText(xraz/2-400/2+52+176+124, 182+22, "Мал", RGB((255),(255),(255)) ):EndIf   
If sizel=2:DrawText(xraz/2-400/2+52+176+124, 182+22, "Сре", RGB((255),(255),(255)) ):EndIf
If sizel=3:DrawText(xraz/2-400/2+52+176+124, 182+22, "Бол", RGB((255),(255),(255)) ):EndIf
DrawText(xraz/2-400/2+52+176+124, 182+44, Str(arteflost), RGB((255),(255),(255)) )
If almazrea=1:DrawText(xraz/2-400/2+52+176+124, 182+66, YES$, RGB((255),(255),(255)) ):EndIf 
If almazrea=0:DrawText(xraz/2-400/2+52+176+124, 182+66, NO$, RGB((255),(255),(255)) ):EndIf 

EndIf 



      If lang=1:
      
      DrawText(xraz/2-400/2+52, 402, "Start game", RGB((255),(255),(255)) )
      DrawText(xraz/2-400/2+52+169, 182, "Number of wins", RGB((255),(255),(255)) )
      DrawText(xraz/2-400/2+52+169, 182+44, "Artifacts", RGB((255),(255),(255)) )
      DrawText(xraz/2-400/2+52+169, 182+66, "New crystals", RGB((255),(255),(255)) )
      DrawText(xraz/2-400/2+52+169, 182+88, "Count of money  "+Str(monstart), RGB((255),(255),(255)) )
      DrawText(xraz/2-400/2+52+169, 182+110, "Reset Settings", RGB((255),(255),(255)) )
      
      a=TextWidth(Str(kol))
      a/2
      DrawText(xraz/2-400/2+52+176+129-a, 182, Str(kol), RGB((255),(255),(255)) )
      
      
          DrawText(xraz/2-400/2+52+169, 182+22, "Size locations", RGB((255),(255),(255)) )
If sizel=0:DrawText(xraz/2-400/2+52+176+124, 182+22, "All", RGB((255),(255),(255)) ):EndIf 
If sizel=1:DrawText(xraz/2-400/2+52+176+124, 182+22, "Sma", RGB((255),(255),(255)) ):EndIf   
If sizel=2:DrawText(xraz/2-400/2+52+176+124, 182+22, "Mid", RGB((255),(255),(255)) ):EndIf
If sizel=3:DrawText(xraz/2-400/2+52+176+124, 182+22, "Big", RGB((255),(255),(255)) ):EndIf
DrawText(xraz/2-400/2+52+176+124, 182+44, Str(arteflost), RGB((255),(255),(255)) )
If almazrea=1:DrawText(xraz/2-400/2+52+176+124, 182+66, "Yes", RGB((255),(255),(255)) ):EndIf 
If almazrea=0:DrawText(xraz/2-400/2+52+176+124, 182+66, "No", RGB((255),(255),(255)) ):EndIf 

EndIf 
      ResetList( namee() ) 
      While NextElement( namee())
        
          ff=TextWidth(namee()\name$)
          ff/2
          DrawText(xraz/2-400/2+46+20-ff, 181, namee()\name$, RGB((255),(255),(255)) )
          DisplayTransparentSprite(namee()\yes,xraz/2-400/2+46+78,182)
          
          
          
         
          
          
          
          
          
          
          
          
          
          
          
           If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76 And xm<xraz/2-400/2+46+76+17 And ym>180 And ym<180+18:
             PlaySound(5)
                   inp1a:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp1a:EndIf 
            
             If namee()\yes=2014:namee()\yes=2015:Goto inp1aa:EndIf
             If namee()\yes=2015:namee()\yes=2016:Goto inp1aa:EndIf 
             If namee()\yes=2016:namee()\yes=2014:Goto inp1aa:EndIf 
            
          
             EndIf 
          inp1aa:
          
           If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+78+20 And xm<xraz/2-400/2+46+78+20+17 And ym>180 And ym<180+18:
             PlaySound(5)
             inp1:
             ExamineMouse() 
            If  MouseButton(1)=1:Goto inp1:EndIf 
            namee()\color=color
            col+1
           EndIf 
           

           If namee()\yes<>2016: Box(xraz/2-400/2+46+78+20, 181, 17, 17, namee()\color):
             
             
                        If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76+44 And xm<xraz/2-400/2+46+76+17+44 And ym>180 And ym<180+18:
             PlaySound(5)
                   inp1b:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp1b:EndIf 
             If namee()\huisit=2017:namee()\huisit=2018:Goto inp1bb:EndIf
             If namee()\huisit=2018:namee()\huisit=2017:Goto inp1bb:EndIf 

             EndIf 
        inp1bb:
             
             
           DisplayTransparentSprite(namee()\huisit+1,xraz/2-400/2+46+78+42,179)  
           EndIf 
           NextElement(namee())
          ff=TextWidth(namee()\name$)
          ff/2
          DrawText(xraz/2-400/2+46+20-ff, 181+22, namee()\name$, RGB((255),(255),(255)) )
          DisplayTransparentSprite(namee()\yes,xraz/2-400/2+46+78,182+22)
          
                     If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76 And xm<xraz/2-400/2+46+76+17 And ym>180+22 And ym<180+18+22:
             PlaySound(5)
                   inp2a:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp2a:EndIf 
             If namee()\yes=2014:namee()\yes=2015:Goto inp2aa:EndIf
             If namee()\yes=2015:namee()\yes=2016:Goto inp2aa:EndIf 
             If namee()\yes=2016:namee()\yes=2014:Goto inp2aa:EndIf 
            
          
             EndIf 
          inp2aa:
          
          
          
          If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+78+20 And xm<xraz/2-400/2+46+78+20+17 And ym>180+22 And ym<180+18+22:
            PlaySound(5)
            inp2:
             ExamineMouse() 
            If  MouseButton(1)=1:Goto inp2:EndIf 
            namee()\color=color
            col+1
           EndIf 
          
          
           If namee()\yes<>2016:  Box(xraz/2-400/2+46+78+20, 181+22, 17, 17, namee()\color)
             
                                     If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76+44 And xm<xraz/2-400/2+46+76+17+44 And ym>180+22 And ym<180+18+22:
             PlaySound(5)
                   inp2b:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp2b:EndIf 
             If namee()\huisit=2017:namee()\huisit=2018:Goto inp2bb:EndIf
             If namee()\huisit=2018:namee()\huisit=2017:Goto inp2bb:EndIf 

             EndIf 
        inp2bb:
             
             
             DisplayTransparentSprite(namee()\huisit+1,xraz/2-400/2+46+78+42,179+22)    
           :EndIf 
          
          
          
          NextElement(namee())
          ff=TextWidth(namee()\name$)
          ff/2
          DrawText(xraz/2-400/2+46+20-ff, 181+44, namee()\name$, RGB((255),(255),(255)) )
          DisplayTransparentSprite(namee()\yes,xraz/2-400/2+46+78,182+44)
          
           If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76 And xm<xraz/2-400/2+46+76+17 And ym>180+44 And ym<180+18+44:
             PlaySound(5)
                   inp3a:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp3a:EndIf 
             If namee()\yes=2014:namee()\yes=2015:Goto inp3aa:EndIf
             If namee()\yes=2015:namee()\yes=2016:Goto inp3aa:EndIf 
             If namee()\yes=2016:namee()\yes=2014:Goto inp3aa:EndIf 
            
          
             EndIf 
          inp3aa:
          
          
          
          If namee()\yes<>2016:   Box(xraz/2-400/2+46+78+20, 181+44, 17, 17, namee()\color):
            
            
            If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76+44 And xm<xraz/2-400/2+46+76+17+44 And ym>180+44 And ym<180+18+44:
             PlaySound(5)
                   inp3b:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp3b:EndIf 
             If namee()\huisit=2017:namee()\huisit=2018:Goto inp3bb:EndIf
             If namee()\huisit=2018:namee()\huisit=2017:Goto inp3bb:EndIf 

             EndIf 
        inp3bb:
            
            
            DisplayTransparentSprite(namee()\huisit+1,xraz/2-400/2+46+78+42,179+44)    
          EndIf 
          
          If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+78+20 And xm<xraz/2-400/2+46+78+20+17 And ym>180+44 And ym<180+18+44:
            PlaySound(5)
            inp3:
             ExamineMouse() 
            If  MouseButton(1)=1:Goto inp3:EndIf 
            namee()\color=color
            col+1
           EndIf 
          
          
          NextElement(namee())
             ff=TextWidth(namee()\name$)
          ff/2
          DrawText(xraz/2-400/2+46+20-ff, 181+66, namee()\name$, RGB((255),(255),(255)) )
          DisplayTransparentSprite(namee()\yes,xraz/2-400/2+46+78,182+66)
          
                     If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76 And xm<xraz/2-400/2+46+76+17 And ym>180+66 And ym<180+18+66:
             PlaySound(5)
                   inp4a:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp4a:EndIf 
             If namee()\yes=2014:namee()\yes=2015:Goto inp4aa:EndIf
             If namee()\yes=2015:namee()\yes=2016:Goto inp4aa:EndIf 
             If namee()\yes=2016:namee()\yes=2014:Goto inp4aa:EndIf 
            
          
             EndIf 
          inp4aa:
          
          If namee()\yes<>2016:   Box(xraz/2-400/2+46+78+20, 181+66, 17, 17, namee()\color)
                        If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76+44 And xm<xraz/2-400/2+46+76+17+44 And ym>180+66 And ym<180+18+66:
             PlaySound(5)
                   inp4b:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp4b:EndIf 
             If namee()\huisit=2017:namee()\huisit=2018:Goto inp4bb:EndIf
             If namee()\huisit=2018:namee()\huisit=2017:Goto inp4bb:EndIf 

             EndIf 
        inp4bb:
            
           DisplayTransparentSprite(namee()\huisit+1,xraz/2-400/2+46+78+42,179+66)    
          :EndIf 
          
                
          If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+78+20 And xm<xraz/2-400/2+46+78+20+17 And ym>180+66 And ym<180+18+66:
            PlaySound(5)
            inp4:
             ExamineMouse() 
            If  MouseButton(1)=1:Goto inp4:EndIf 
            namee()\color=color
            col+1
           EndIf 
          
          
          NextElement(namee())
                ff=TextWidth(namee()\name$)
          ff/2
          DrawText(xraz/2-400/2+46+20-ff, 181+88, namee()\name$, RGB((255),(255),(255)) )
          DisplayTransparentSprite(namee()\yes,xraz/2-400/2+46+78,182+88)
                     If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76 And xm<xraz/2-400/2+46+76+17 And ym>180+88 And ym<180+18+88:
             PlaySound(5)
                   inp5a:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp5a:EndIf 
             If namee()\yes=2014:namee()\yes=2015:Goto inp5aa:EndIf
             If namee()\yes=2015:namee()\yes=2016:Goto inp5aa:EndIf 
             If namee()\yes=2016:namee()\yes=2014:Goto inp5aa:EndIf 
            
          
             EndIf 
          inp5aa:
          
          If namee()\yes<>2016:   Box(xraz/2-400/2+46+78+20, 181+88, 17, 17, namee()\color)
                        If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76+44 And xm<xraz/2-400/2+46+76+17+44 And ym>180+88 And ym<180+18+88:
             PlaySound(5)
                   inp5b:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp5b:EndIf 
             If namee()\huisit=2017:namee()\huisit=2018:Goto inp5bb:EndIf
             If namee()\huisit=2018:namee()\huisit=2017:Goto inp5bb:EndIf 

             EndIf 
        inp5bb:
           DisplayTransparentSprite(namee()\huisit+1,xraz/2-400/2+46+78+42,179+88)    
          :EndIf 
                   If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+78+20 And xm<xraz/2-400/2+46+78+20+17 And ym>180+88 And ym<180+18+88:
                     PlaySound(5)
                     inp5:
             ExamineMouse() 
            If  MouseButton(1)=1:Goto inp5:EndIf 
            namee()\color=color
            col+1
           EndIf 
          
          NextElement(namee())
          
                  ff=TextWidth(namee()\name$)
          ff/2
          DrawText(xraz/2-400/2+46+20-ff, 181+110, namee()\name$, RGB((255),(255),(255)) ) 
          DisplayTransparentSprite(namee()\yes,xraz/2-400/2+46+78,182+110)
          
                               If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76 And xm<xraz/2-400/2+46+76+17 And ym>180+110 And ym<180+18+110:
             PlaySound(5)
                   inp7a:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp7a:EndIf 
             If namee()\yes=2014:namee()\yes=2015:Goto inp7aa:EndIf
             If namee()\yes=2015:namee()\yes=2016:Goto inp7aa:EndIf 
             If namee()\yes=2016:namee()\yes=2014:Goto inp7aa:EndIf 
            
          
             EndIf 
          inp7aa:
          
          If namee()\yes<>2016:  Box(xraz/2-400/2+46+78+20, 181+110, 17, 17, namee()\color)
                        If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76+44 And xm<xraz/2-400/2+46+76+17+44 And ym>180+110 And ym<180+18+110:
             PlaySound(5)
                   inp6b:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp6b:EndIf 
             If namee()\huisit=2017:namee()\huisit=2018:Goto inp6bb:EndIf
             If namee()\huisit=2018:namee()\huisit=2017:Goto inp6bb:EndIf 

             EndIf 
        inp6bb:
           DisplayTransparentSprite(namee()\huisit+1,xraz/2-400/2+46+78+42,179+110)    
          :EndIf 
                             If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+78+20 And xm<xraz/2-400/2+46+78+20+17 And ym>180+110 And ym<180+18+110:
                               PlaySound(5)
                               inp6:
             ExamineMouse() 
            If  MouseButton(1)=1:Goto inp6:EndIf 
            namee()\color=color
            col+1
           EndIf 
          NextElement(namee())
                    ff=TextWidth(namee()\name$)
          ff/2
          DrawText(xraz/2-400/2+46+20-ff, 181+110+22, namee()\name$, RGB((255),(255),(255)) )
          DisplayTransparentSprite(namee()\yes,xraz/2-400/2+46+78,182+132)
          
         If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76 And xm<xraz/2-400/2+46+76+17 And ym>180+132 And ym<180+18+132:
             PlaySound(5)
                   inp8a:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp8a:EndIf 
             If namee()\yes=2014:namee()\yes=2015:Goto inp8aa:EndIf
             If namee()\yes=2015:namee()\yes=2016:Goto inp8aa:EndIf 
             If namee()\yes=2016:namee()\yes=2014:Goto inp8aa:EndIf 
            
          
             EndIf 
          inp8aa:
          
          If namee()\yes<>2016:   Box(xraz/2-400/2+46+78+20, 181+132, 17, 17, namee()\color)
                        If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76+44 And xm<xraz/2-400/2+46+76+17+44 And ym>180+132 And ym<180+18+132:
             PlaySound(5)
                   inp7b:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp7b:EndIf 
             If namee()\huisit=2017:namee()\huisit=2018:Goto inp7bb:EndIf
             If namee()\huisit=2018:namee()\huisit=2017:Goto inp7bb:EndIf 

             EndIf 
        inp7bb:
           DisplayTransparentSprite(namee()\huisit+1,xraz/2-400/2+46+78+42,179+132)    
          :EndIf 
                             If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+78+20 And xm<xraz/2-400/2+46+78+20+17 And ym>180+132 And ym<180+18+132:
                               PlaySound(5)
                               inp7:
             ExamineMouse() 
            If  MouseButton(1)=1:Goto inp7:EndIf 
            namee()\color=color
            col+1
           EndIf 
          NextElement(namee())
                     ff=TextWidth(namee()\name$)
          ff/2
          DrawText(xraz/2-400/2+46+20-ff, 181+110+44, namee()\name$, RGB((255),(255),(255)) )
          DisplayTransparentSprite(namee()\yes,xraz/2-400/2+46+78,182+152)
                                         If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76 And xm<xraz/2-400/2+46+76+17 And ym>180+154 And ym<180+18+154:
             PlaySound(5)
                   inp9a:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp9a:EndIf 
             If namee()\yes=2014:namee()\yes=2015:Goto inp9aa:EndIf
             If namee()\yes=2015:namee()\yes=2016:Goto inp9aa:EndIf 
             If namee()\yes=2016:namee()\yes=2014:Goto inp9aa:EndIf 
            
          
             EndIf 
          inp9aa:
          
          If namee()\yes<>2016:   Box(xraz/2-400/2+46+78+20, 181+154, 17, 17, namee()\color):
            
                        If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+76+44 And xm<xraz/2-400/2+46+76+17+44 And ym>180+154 And ym<180+18+154:
             PlaySound(5)
                   inp8b:
             ExamineMouse() 
             If  MouseButton(1)=1:Goto inp8b:EndIf 
             If namee()\huisit=2017:namee()\huisit=2018:Goto inp8bb:EndIf
             If namee()\huisit=2018:namee()\huisit=2017:Goto inp8bb:EndIf 

             EndIf 
        inp8bb:
            DisplayTransparentSprite(namee()\huisit+1,xraz/2-400/2+46+78+42,179+154)  
          EndIf 
                             If inputnum=0 And inputname=0 And MouseButton(1)=1 And xm>xraz/2-400/2+46+78+20 And xm<xraz/2-400/2+46+78+20+17 And ym>180+154 And ym<180+18+154:
                               PlaySound(5)
                               inp8:
             ExamineMouse() 
            If  MouseButton(1)=1:Goto inp8:EndIf 
            namee()\color=color
            col+1
           EndIf 
         Wend 
   StopDrawing()

   

   
   
If xm>xraz/2-400/2+20 And xm<xraz/2-400/2+46+76 And ym>180 And ym<180+154+22:
  DisplayTransparentSprite (2020,xraz/2-400/2,140)
  
    StartDrawing( ScreenOutput())
    DrawingMode(#PB_2DDrawing_Transparent )
    DrawingFont(FontID(2)) 
    
    If lang=0: DrawText(xraz/2-400/2+13,150, "Как вас зовут?", RGB((0),(0),(0)) ):EndIf 
      If lang=1: DrawText(xraz/2-400/2+5,150, "What is your name?", RGB((0),(0),(0)) ):EndIf 
      DrawingFont(FontID(1)) 
  StopDrawing() 
EndIf 



If plizz>0:
  If plizz=99:PlaySound(7):EndIf 
  plizz-1
  DisplayTransparentSprite (2020,xraz/2-400/2,140+220)
  
    StartDrawing( ScreenOutput())
    DrawingMode(#PB_2DDrawing_Transparent )
     DrawingFont(FontID(2)) 
     If lang=0: DrawText(xraz/2-400/2+13,150+220, "Мало игроков!", RGB((0),(0),(0)) ):EndIf 
        If lang=1: DrawText(xraz/2-400/2+13,150+220, "Few players!", RGB((0),(0),(0)) ):EndIf 
      DrawingFont(FontID(1)) 
      StopDrawing() 
      
EndIf 

If xm>xraz/2-400/2+20+46+78 And xm<xraz/2-400/2+20+46+78+17 And ym>180 And ym<180+154+22:
  DisplayTransparentSprite (2020,xraz/2-400/2+76,140)
  
    StartDrawing( ScreenOutput())
    DrawingMode(#PB_2DDrawing_Transparent )
     DrawingFont(FontID(2)) 
     If lang=0:  DrawText(xraz/2-400/2+22+76,150, "Ваш цвет?", RGB((0),(0),(0)) ):EndIf 
       If lang=1:  DrawText(xraz/2-400/2+22+76,150, "Your Color?", RGB((0),(0),(0)) ):EndIf 
      DrawingFont(FontID(1)) 
  StopDrawing() 
EndIf 


If xm>xraz/2-400/2+20+46+78-22 And xm<xraz/2-400/2+20+46+78+17-22 And ym>180 And ym<180+154+22:
  DisplayTransparentSprite (2020,xraz/2-400/2+76-22,140)
  
    StartDrawing( ScreenOutput())
    DrawingMode(#PB_2DDrawing_Transparent )
    DrawingFont(FontID(2)) 
    If lang=0
     DrawText(xraz/2-400/2+22+75-22,146, "Человек или", RGB((0),(0),(0)) )
     DrawText(xraz/2-400/2+22+76-22,146+10, "компьютер?", RGB((0),(0),(0)) )
   EndIf 
       If lang=1
     DrawText(xraz/2-400/2+22+75-22,146, "Person or ", RGB((0),(0),(0)) )
     DrawText(xraz/2-400/2+22+76-22,146+10, "computer?", RGB((0),(0),(0)) )
     EndIf 
   DrawingFont(FontID(1)) 
  StopDrawing() 
EndIf 

If xm>xraz/2-400/2+20+46+78+22 And xm<xraz/2-400/2+20+46+78+17+22 And ym>180 And ym<180+154+22:
  DisplayTransparentSprite (2020,xraz/2-400/2+76+22,140)
  
    StartDrawing( ScreenOutput())
    DrawingMode(#PB_2DDrawing_Transparent )
    DrawingFont(FontID(2)) 
        If lang=0
     DrawText(xraz/2-400/2+22+75+22,146, "Выдра или", RGB((0),(0),(0)) )
     DrawText(xraz/2-400/2+22+76+22+8,146+10, "Фенек?", RGB((0),(0),(0)) )
   EndIf 
         If lang=1
     DrawText(xraz/2-400/2+33+75+22,146, "Otter or", RGB((0),(0),(0)) )
     DrawText(xraz/2-400/2+22+76+22+8,146+10, "Fenech?", RGB((0),(0),(0)) )
       EndIf 
      DrawingFont(FontID(1)) 
  StopDrawing() 
EndIf 


If xm>xraz/2-400/2+52+176 And xm<xraz/2-400/2+52+176+176 And ym>180+44 And ym<180+66
  DisplayTransparentSprite (2020,xraz/2-400/2+76+22+100,140+50)
  
    StartDrawing( ScreenOutput())
    DrawingMode(#PB_2DDrawing_Transparent )
    DrawingFont(FontID(2)) 
    If lang=0
     DrawText(xraz/2-400/2+22+75+22+80,146+50, "Кол-во потеряных", RGB((0),(0),(0)) )
     DrawText(xraz/2-400/2+22+76+22+80,146+10+50, "призов при смерти.", RGB((0),(0),(0)) )
   EndIf 
       If lang=1
     DrawText(xraz/2-400/2+26+75+22+80,146+50, "Number of prizes", RGB((0),(0),(0)) )
     DrawText(xraz/2-400/2+35+76+22+80,146+10+50, "at the death.", RGB((0),(0),(0)) )
     EndIf 
      DrawingFont(FontID(1)) 
  StopDrawing() 
EndIf 
If xm>xraz/2-400/2+52+176 And xm<xraz/2-400/2+52+176+176 And ym>180+66 And ym<180+88
  DisplayTransparentSprite (2020,xraz/2-400/2+76+22+100,140+70)
  
    StartDrawing( ScreenOutput())
    DrawingMode(#PB_2DDrawing_Transparent )
    DrawingFont(FontID(2)) 
    If lang=0
     DrawText(xraz/2-400/2+22+75+22+80,146+70, "Кристаллы растут", RGB((0),(0),(0)) )
     DrawText(xraz/2-400/2+22+76+22+80,146+10+70, "постоянно или нет.", RGB((0),(0),(0)) )
   EndIf 
   
       If lang=1
     DrawText(xraz/2-400/2+36+75+22+80,146+70, "Crystals grow", RGB((0),(0),(0)) )
     DrawText(xraz/2-400/2+22+76+22+80,146+10+70, "continuously or not.", RGB((0),(0),(0)) )
     EndIf
      DrawingFont(FontID(1)) 
  StopDrawing() 
EndIf 

  
DisplayTransparentSprite(1, xm, ym)   
   
If inputnum=0 And inputname=1:

element2=element

      ExamineKeyboard()
      FullText$ + KeyboardInkey()  ; Add the new text to the current one (if any)
 If KeyboardReleased(#PB_Key_Back)
        FullText$ = Left(FullText$, Len(FullText$)-1)
      EndIf
 
     
FirstElement( namee() )
If element2=0:Goto ele:EndIf 
 Repeat 
   NextElement(namee())
   element2-1
 Until element2=0
 ele:
 
  
   
 If asago<=25:namee()\name$=FullText$+"  ":EndIf 
  If asago>25:namee()\name$=FullText$+"_":EndIf 
 namee()\yes=2014
   If asago=0:asago=50:EndIf 
      asago-1
   
 If Len(FullText$) = 10:
   RemoveString (FullText$,"_")
   namee()\name$=FullText$
 inputname=0:EndIf  

 
     If KeyboardReleased(#PB_Key_Return)
         RemoveString (FullText$,"_")
   namee()\name$=FullText$
 inputname=0
      EndIf 
EndIf 




FlipBuffers()

ClearScreen (RGB(0, 0, 0))
Goto exi


sozp:

Gosub katalog:


cuda:

a666.f=0
X666.f=0
Y666.f=0
X23666.f=0
Y23666.f=0
xm=0:ym=0; x y mouse



bot=0

c=0:d=0
obx=10
chet=0
obx2=0
   xti=0
   yti=0
   
play=1
players=4
players2=4
Structure Person
    x.w
    y.w
    x2.w
    y2.w
    nom.w
    swo.w
    swo2.w
    spid.w
    iner.w
    iner2.w
    upal.w
    gravitator.w
    wani.w
    stor.w
    name$ ;    максимум 10 букв
    energ.w
    energ1.w
    energ2.w
    color.l
    smile.l
    smilet.l
    smilet2.l
    fox.l
    zap.f
    bot.l
    target.w
    magic.w
  EndStructure

  NewList tur.Person ()
  skok=0
  
  Structure Person2
    x.w
    y.w
    xx.w
    yy.w
    nom.w
    ani.w
        tim.w
           tim2.w
           pow.w
  EndStructure
NewList tur2.Person2 ()

  Structure Person3;     персональные данные 
    pnom.l
    opyt.l
    fox.l
    money.l
    trafic.w
    trafic2.w
    trafic3.w
    trafic4.w
    trafic5.w
    name$ ;    максимум 10 букв
    energ.w
    energ1.w
    energ2.w
    ataka.w
    reani.w
    gravi.w
    color.l
    metko.w
    slot1.w
    slot2.w
    slot3.w
    slot4.w
    slot5.w
    slot6.w
    slot7.w
    slot8.w
    slot1a.w
    slot2a.w
    slot3a.w
    slot4a.w
       slot1p.w
       slot2p.w
       slot3p.w
       slot4p.w
       slot5p.w
       slot6p.w
       slot7p.w
       slot8p.w
       slot1u.w
       slot2u.w
       slot3u.w
       slot4u.w
       slot1uu.w
       slot2uu.w
       slot3uu.w
       slot4uu.w
       kakoj.w;  какое оружие активировано
       victory.w; колво побед
       bot.w
       magic.w
    EndStructure
NewList tur3.Person3 ()


  Structure Person4
    x.w
    y.w
    xx.w
    yy.w
    nom.w
    degr.w
    life.w
  EndStructure
NewList tur4.Person4 ()

  Structure Person5
    x.w
    y.w
    xx.w
    yy.w
    nom.w
    energi.w
    met.w
    met2.w
        met3.w
        met4.w
        zap.f
        ataka.w
        life.w
        hto.w
  EndStructure
NewList tur5.Person5 ()


  Structure Person6
    x.w
    y.w
    xx.w
    yy.w
    nom.w
    degr.w
    life.w
    cwet.w
    cwet2.w
    spr.w
    kris.w
  EndStructure
NewList tur6.Person6 ()

  Structure Person7
    x.w
    y.w
    nom.w
    life.w
    life2.w
    life3.w
  EndStructure
NewList tur7.Person7 ()


  Structure Person8
    x.w
    y.w
    nom.w
    life.w
    plus.w
    rand.w
  EndStructure
NewList tur8.Person8 ()

  Structure Person9
    kto.w
       kto2.w
       kto3.s
       kto4.s
        kto5.s
         kto6.s
  EndStructure
NewList tur9.Person9 ()








If lang=0

 AddElement( tur9() )
   tur9()\kto=901
     tur9()\kto2=920
 
      
    AddElement( tur9() )
   tur9()\kto=901
    tur9()\kto2=923
     tur9()\kto3="Огнемет"
         tur9()\kto4="200 кредитов"
          tur9()\kto5="Топливо"
         tur9()\kto6="20 кредитов"
 AddElement( tur9() )
   tur9()\kto=902
    tur9()\kto2=922
         tur9()\kto3="Базука"
         tur9()\kto4="600 кредитов"
                   tur9()\kto5="Снаряд"
         tur9()\kto6="5 кредитов"
    AddElement( tur9() )
   tur9()\kto=903
    tur9()\kto2=920
            tur9()\kto3="Миниган"
         tur9()\kto4="150 кредитов"
                            tur9()\kto5="Патроны"
         tur9()\kto6="10 кредитов"
    AddElement( tur9() )
   tur9()\kto=904
    tur9()\kto2=921
            tur9()\kto3="Шаровая молния"
         tur9()\kto4="400 кредитов"
                            tur9()\kto5="Заряд"
         tur9()\kto6="10 кредитов"
       AddElement( tur9() )
   tur9()\kto=905
    tur9()\kto2=922
               tur9()\kto3="Ракетница"
         tur9()\kto4="300 кредитов"
                            tur9()\kto5="Снаряд"
         tur9()\kto6="5 кредитов"
       AddElement( tur9() )
   tur9()\kto=906
    tur9()\kto2=922
                   tur9()\kto3="Миномет"
         tur9()\kto4="300 кредитов"
                            tur9()\kto5="Снаряд"
         tur9()\kto6="5 кредитов"
       AddElement( tur9() )
   tur9()\kto=907
    tur9()\kto2=922
                   tur9()\kto3="Веерная ракетница"
         tur9()\kto4="600 кредитов"
                            tur9()\kto5="Снаряд"
         tur9()\kto6="5 кредитов"
         
       AddElement( tur9() )
   tur9()\kto=908
    tur9()\kto2=922
                      tur9()\kto3="Веерный миномет"
         tur9()\kto4="600 кредитов"
                               tur9()\kto5="Снаряд"
         tur9()\kto6="5 кредитов"
         AddElement( tur9() )
        
         
   tur9()\kto=909
    tur9()\kto2=921
         tur9()\kto3="Энергоружье"
         tur9()\kto4="250 кредитов"
        tur9()\kto5="Заряд"
         tur9()\kto6="5 кредитов"
         AddElement( tur9() )
   tur9()\kto=910
    tur9()\kto2=924
                        tur9()\kto3="Инженер"
         tur9()\kto4="500 кредитов"
                            tur9()\kto5="Кирпичи"
         tur9()\kto6="20 кредитов"
            AddElement( tur9() )
   tur9()\kto=914
    tur9()\kto2=921
    tur9()\kto3="Гравиружье"
         tur9()\kto4="800 кредитов"
          tur9()\kto5="Заряд"
          tur9()\kto6="20 кредитов"
            AddElement( tur9() )
   tur9()\kto=912
    tur9()\kto2=912
    tur9()\kto3="Аптечка"
         tur9()\kto4="200 кредитов"
          tur9()\kto5="Медикаменты"
          tur9()\kto6="20 кредитов"

        EndIf 
        
        
If lang=1

 AddElement( tur9() )
   tur9()\kto=901
     tur9()\kto2=920
 
      
    AddElement( tur9() )
   tur9()\kto=901
    tur9()\kto2=923
     tur9()\kto3="Flamethrower"
         tur9()\kto4="200 credits"
          tur9()\kto5="Fuel"
         tur9()\kto6="20 credits"
 AddElement( tur9() )
   tur9()\kto=902
    tur9()\kto2=922
         tur9()\kto3="Bazooka"
         tur9()\kto4="600 credits"
                   tur9()\kto5="Shell"
         tur9()\kto6="5 credits"
    AddElement( tur9() )
   tur9()\kto=903
    tur9()\kto2=920
            tur9()\kto3="Minigun"
         tur9()\kto4="150 credits"
                            tur9()\kto5="Ammunition"
         tur9()\kto6="10 credits"
    AddElement( tur9() )
   tur9()\kto=904
    tur9()\kto2=921
            tur9()\kto3="Fireball"
         tur9()\kto4="400 credits"
                            tur9()\kto5="Shell"
         tur9()\kto6="10 credits"
       AddElement( tur9() )
   tur9()\kto=905
    tur9()\kto2=922
               tur9()\kto3="Rocket"
         tur9()\kto4="300 credits"
                            tur9()\kto5="Shell"
         tur9()\kto6="5 credits"
       AddElement( tur9() )
   tur9()\kto=906
    tur9()\kto2=922
                   tur9()\kto3="Mortar"
         tur9()\kto4="300 credits"
                            tur9()\kto5="Shell"
         tur9()\kto6="5 credits"
       AddElement( tur9() )
   tur9()\kto=907
    tur9()\kto2=922
                   tur9()\kto3="Fan-Rocket"
         tur9()\kto4="600 credits"
                            tur9()\kto5="Shell"
         tur9()\kto6="5 credits"
         
       AddElement( tur9() )
   tur9()\kto=908
    tur9()\kto2=922
                      tur9()\kto3="Fan-mortar"
         tur9()\kto4="600 credits"
                               tur9()\kto5="Shell"
         tur9()\kto6="5 credits"
         AddElement( tur9() )
        
         
   tur9()\kto=909
    tur9()\kto2=921
         tur9()\kto3="Energoruzhe"
         tur9()\kto4="250 credits"
        tur9()\kto5="Charge"
         tur9()\kto6="5 credits"
         AddElement( tur9() )
   tur9()\kto=910
    tur9()\kto2=924
                        tur9()\kto3="Engineer"
         tur9()\kto4="500 credits"
                            tur9()\kto5="Bricks"
         tur9()\kto6="20 credits"
            AddElement( tur9() )
   tur9()\kto=914
    tur9()\kto2=921
    tur9()\kto3="Graviruzhe"
         tur9()\kto4="800 credits"
          tur9()\kto5="Charge"
          tur9()\kto6="20 credits"
            AddElement( tur9() )
   tur9()\kto=912
    tur9()\kto2=912
    tur9()\kto3="Medicine chest"
         tur9()\kto4="200 credits"
          tur9()\kto5="Medicines"
          tur9()\kto6="20 credits"

EndIf 

  iko=10

  okno=0



If obraz=0:
propor=0
  
  ResetList( namee() ) 
While NextElement( namee())
 If namee()\yes=2015 Or namee()\yes=2014:propor+1:Gosub sozpp:EndIf 
Wend 

EndIf 


a666.f=0
X666.f=0
Y666.f=0
X23666.f=0
Y23666.f=0
xm=0:ym=0; x y mouse
arteflost=1;  сколько артефактов теряет при смерти
almazrea=1; реанимироват алмазы или нет


bot=0

c=0:d=0
obx=10
chet=0
obx2=0
   xti=0
   yti=0
   
play=1


;------------------------888888888888


players=propor
players2=propor

Gosub sozper
  




delor2=0
smertxw=0
endturr=0
 Dim ss.l(32)        
     
SetFrameRate(FPS) ;->FPS Value






Gosub load:
Gosub instal:
Gosub instalp
  Goto exi:

  sozpp:
  bot=0
  p=0
  p0=0
 If  namee()\huisit=2017:p=200:EndIf 
If namee()\yes=2015:p0+500:bot=1:EndIf  
 AddElement( tur3() )
  tur3()\pnom=propor
  tur3()\money=monstart+p0
  tur3()\opyt=0
   tur3()\fox=p
    tur3()\trafic=64
  tur3()\trafic2=64
     tur3()\trafic3=1
         tur3()\trafic4=1
          tur3()\trafic5=0
           tur3()\name$=namee()\name$
        tur3()\energ=64 ;->Affects HP value
        tur3()\energ1=0
          tur3()\energ2=0
        tur3()\color=namee()\color
    tur3()\slot1=900
    tur3()\slot2=0
    tur3()\slot3=0
    tur3()\slot4=0
    tur3()\slot5=0
    tur3()\slot6=0
    tur3()\slot7=0
    tur3()\slot8=0
    tur3()\slot1a=0
    tur3()\slot2a=0
    tur3()\slot3a=0
    tur3()\slot4a=0
    
    
       tur3()\slot1p=9999
       tur3()\slot2p=0
       tur3()\slot3p=0
       tur3()\slot4p=0
       tur3()\slot5p=0
       tur3()\slot6p=0
       tur3()\slot7p=0
       tur3()\slot8p=0
       
       tur3()\slot1u=0
       tur3()\slot2u=0
       tur3()\slot3u=0
       tur3()\slot4u=0
        tur3()\slot1uu=0
       tur3()\slot2uu=0
       tur3()\slot3uu=0
       tur3()\slot4uu=0
       
        tur3()\ataka=0
        tur3()\reani=0
        tur3()\gravi=0
        tur3()\victory=0
        tur3()\bot=bot
        Return 




 sozdym:
 AddElement(tur7())

 If tur5()\nom=2 And tur5()\x >tur5()\xx :tur7()\x=tur5()\x-30-Random(10):EndIf 
  If tur5()\nom=2 And tur5()\x <tur5()\xx :tur7()\x=tur5()\x+60+Random(10):EndIf 
  
   If tur5()\nom=4 And tur5()\x >tur5()\xx :tur7()\x=tur5()\x-30-Random(10):EndIf 
  If tur5()\nom=4 And tur5()\x <tur5()\xx :tur7()\x=tur5()\x+25+Random(10):EndIf 
    If tur5()\nom=5:tur7()\x=tur5()\x-10+Random(10):tur7()\y=tur5()\y+60+Random(10):EndIf 
 If tur5()\nom<>5:tur7()\y=tur5()\y-8+Random(16):EndIf 
 tur7()\nom=950
 tur7()\life2=1+Random(4)
  tur7()\life3= tur7()\life2
 tur7()\life=Random(2)

 Return 


ogon:
ResetList( tur7() ) 
While NextElement( tur7())
If tur7()\nom>0:Gosub ogon2:EndIf 
 Wend
Return 

ogon22:
 DisplayTransparentSprite(tur7()\nom,tur7()\x+c,tur7()\y+d)
tur7()\life2-1
If tur7()\life=0:tur7()\y+2:EndIf 
If tur7()\life=1:tur7()\y-2:EndIf 
If tur7()\life2=0:tur7()\life2=tur7()\life3:Goto ogon222:EndIf 
Return 
ogon222:
tur7()\nom+1
If tur7()\nom=954:DeleteElement(tur7()):EndIf 
Return 


ogon2:
If tur7()\nom=>950 And tur7()\nom<=954:Goto ogon22:EndIf 
ResetList( tur() ) 
While NextElement( tur())
 If tur()\nom=96 And SpriteCollision(10, tur()\x-50, tur()\y-30, 10, tur7()\x, tur7()\y):
 DisplayTransparentSprite(tur7()\nom,tur7()\x+c,tur7()\y+d):EndIf 
 
 
 If Random(50)=0:

If tur()\nom=25 And SpriteCollision(10, tur()\x-50, tur()\y-30, 10, tur7()\x, tur7()\y):: 

rwzr=10
wzr=1
radi=10
xwz=tur7()\x+20
ywz=tur7()\y
Gosub wzrywww:
Goto wendd:EndIf 
EndIf 
 
If Random(500)=0:
    If tur()\nom=23 And SpriteCollision(10, tur()\x-50, tur()\y-30, 10, tur7()\x, tur7()\y):
  DeleteElement(tur())
  Goto wendd
:EndIf 
   If tur()\nom=24 And SpriteCollision(10, tur()\x-50, tur()\y-30, 10, tur7()\x, tur7()\y):
   DeleteElement(tur())
   Goto wendd
 EndIf 
 
  If tur()\nom=21 And SpriteCollision(10, tur()\x-50, tur()\y-30, 10, tur7()\x, tur7()\y):
  tur()\nom=23
:EndIf 
   If tur()\nom=22 And SpriteCollision(10, tur()\x-50, tur()\y-30, 10, tur7()\x, tur7()\y):
  tur()\nom=24
:EndIf 
EndIf 
wendd:
 Wend

tur7()\nom+1
If tur7()\nom=2011:tur7()\nom=2000:EndIf 
tur7()\life-1
If tur7()\life=0:DeleteElement(tur7()):EndIf 
Return 

;------------------всплеск
kris=1013-15:Gosub wzryw2:kris=0:








delor:
StartDrawing( ScreenOutput())
If  xm=>20 And xm<50 And ym>yraz-124+22-6 And ym<yraz-124+52 And tur3()\slot1>0:Box(20,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level26=0:a6=tur3()\slot1p:all6=tur3()\slot1:Goto oqof:EndIf 
If  xm=>50 And xm<82 And ym>yraz-124+22-6 And ym<yraz-124+52 And tur3()\slot2>0:Box(52,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level26=32:a6=tur3()\slot2p:all6=tur3()\slot2:Goto oqof:EndIf 
If  xm=>82 And xm<114 And ym>yraz-124+22-6 And ym<yraz-124+52 And tur3()\slot3>0:Box(84,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level26=64:a6=tur3()\slot3p:all6=tur3()\slot3:Goto oqof:EndIf 
If  xm=>114 And xm<146 And ym>yraz-124+22-6 And ym<yraz-124+52 And tur3()\slot4>0:Box(116,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level26=96:a6=tur3()\slot4p:all6=tur3()\slot4:Goto oqof:EndIf 
If  xm=>146 And xm<178 And ym>yraz-124+22-6 And ym<yraz-124+52 And tur3()\slot5>0:Box(148,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level26=128:a6=tur3()\slot5p:all6=tur3()\slot5:Goto oqof:EndIf 
If  xm=>178 And xm<210 And ym>yraz-124+22-6 And ym<yraz-124+52 And tur3()\slot6>0:Box(170+10,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level26=160:a6=tur3()\slot6p:all6=tur3()\slot6:Goto oqof:EndIf 
If  xm=>210 And xm<242 And ym>yraz-124+22-6 And ym<yraz-124+52 And tur3()\slot7>0:Box(200+12,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level26=192:a6=tur3()\slot7p:all6=tur3()\slot7:Goto oqof:EndIf 
If  xm=>242 And xm<244+35 And ym>yraz-124+22-6 And ym<yraz-124+52 And tur3()\slot8>0:Box(230+14,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level26=224:a6=tur3()\slot8p:all6=tur3()\slot8:Goto oqof:EndIf 
StopDrawing()

Return 
oqof:
StopDrawing()

delor2=1
Return 


delor3:
If delor2=0:Return:EndIf 

    ResetList( tur3() ) 
    While NextElement( tur3())
      If tur3()\pnom=play:Goto delor33:EndIf 
      Wend 
      Return 
  delor33:    
StartDrawing( ScreenOutput())
Box(11+level26,yraz-160, 102+30, 52, RGB(255, 255, 255))
Box(12+level26,yraz-160+1, 100+30, 50, RGB(125,125,125))
Box(12+level26,yraz-160+1, 100+30, 25, RGB(150,140,140))
ExamineMouse()
xm = MouseX()                         
ym = MouseY() 

If ym<yraz-160+1 Or ym>yraz-160+1+25 Or xm<12+level26 Or xm>12+level26+130::
 
  If MouseButton(1)=1:Goto exmm2:EndIf  
  EndIf 

 If ym>yraz-160+1 And ym<yraz-160+1+25 And xm>12+level26 And xm<12+level26+130:Box(12+level26,yraz-160+1, 100+30, 25, RGB(200,200,200)):
   If MouseButton(1)=1: delor2=0:StopDrawing():
     exmm:
     ExamineMouse()
      If MouseButton(1)=1:Goto exmm:EndIf  
   
     
     If level26=32:tur3()\slot2p=0:tur3()\slot2=0:EndIf 
       If level26=64:tur3()\slot3p=0:tur3()\slot3=0:EndIf 
       If level26=96:tur3()\slot4p=0:tur3()\slot4=0:EndIf 
       If level26=128:tur3()\slot5p=0:tur3()\slot5=0:EndIf 
       If level26=160:tur3()\slot6p=0:tur3()\slot6=0:EndIf 
       If level26=192:tur3()\slot7p=0:tur3()\slot7=0:EndIf 
       If level26=224:tur3()\slot8p=0:tur3()\slot8=0:EndIf 
       weapon=900
       weapon=tur3()\slot1:ax=tur3()\slot1p
       level=0
       level2=0
       ffff=1
       tur3()\kakoj=level2
    Gosub instor:
    ffff=0
    
  Return:EndIf 
   
  
  
 EndIf 
If ym>yraz-160+1+25 And ym<yraz-160+1+50 And xm>12+level26 And xm<12+level26+130:Box(12+level26,yraz-160+1+25, 100+30, 25, RGB(200,200,200)):
  
  If MouseButton(1)=1: 
   exmm2:
     ExamineMouse()
      If MouseButton(1)=1:Goto exmm2:EndIf    
  delor2=0:StopDrawing():Return:EndIf  
EndIf 

DrawingMode(#PB_2DDrawing_Transparent )
If lang=0
DrawText(12+level26+4,yraz-160+1+3, "Удалить предмет", RGB((20),(20),(20)) )
DrawText(12+level26+4,yraz-160+1+3+25, "Оставить в покое", RGB((20),(20),(20)) )
EndIf 
If lang=1
DrawText(12+level26+4,yraz-160+1+3, "Remove the object", RGB((20),(20),(20)) )
DrawText(12+level26+4,yraz-160+1+3+25, "Cancel", RGB((20),(20),(20)) )
EndIf 
StopDrawing()
Return 



firee:

ExamineMouse()
 xm = MouseX()                         
 ym = MouseY() 
 If MouseButton(1)=1:Return:EndIf 
 
 If ym>yraz-110 And ym<yraz-110+32 And xm>16 And xm<272: Goto erif:EndIf 
If MouseButton(2) And ax=0 And asound222=0
PlaySound(7):asound222=20:EndIf 
If asound222>0:asound222-1:EndIf 
erif:


If MouseButton(2) And wsenofire=0 And bot=0 And iko=0 And shop1=0 And nextpl=0 And displayb=0 And delor2=0 And endturr=0 And ym>yraz-110 And ym<yraz-110+32 And xm>16 And xm<272:Goto delor:EndIf :



  




If MouseButton(2) And wsenofire=0 And bot=0 And iko=0 And shop1=0 And nextpl=0 And ax>0 And displayb=0 And delor2=0 And endturr=0 :
  

    
    
    



  ;---------------fair
 xm = MouseX()                         
 ym = MouseY() 
  

fireebot:






      ResetList( tur() ) 
      While NextElement( tur())
        If play=tur()\swo And tur()\nom=97 And tur()\gravitator=0 And tur()\iner=0 And tur()\iner2=0: tur()\x2=tur()\x:
        Goto opopo:EndIf 
    Wend  
    Return
    opopo:
  If tur()\magic>0:Return:EndIf 
ResetList( tur() ) 
While NextElement( tur())
  
  *Old_Element190 = @tur()

  If tur()\swo2<>333 And  play=tur()\swo And tur()\wani=25 And tur()\nom=97:
    
    ResetList( tur3() ) 
    While NextElement( tur3())
    If play=tur3()\pnom:Gosub fire2:EndIf 
    Wend  
    :EndIf 
    
     *Old_Element190 = @tur()
      ChangeCurrentElement(tur(), *Old_Element190)
    
    If tur()\swo2<>333 And play=tur()\swo And tur()\wani<16 And tur()\nom=97:
      
        ResetList( tur3() ) 
        While NextElement( tur3())
          
    If play=tur3()\pnom:Gosub fire:EndIf 
    Wend 
      
    EndIf 
  ChangeCurrentElement(tur(), *Old_Element190)
Wend


EndIf 
Return 





fire:
If spidf>0:spidf-1:Return:EndIf 
If fyrr>0:fyrr-1:EndIf 
If plnex=1:Return:EndIf 
If weapon<>910:tur()\wani=16:EndIf 
If weapon=912:tur()\wani=0:EndIf 
If weapon=905 Or weapon=907:tur()\wani=64:EndIf
If weapon=900:wanim=6:EndIf
If weapon=901:wanim=4:EndIf 
If weapon=902:wanim=15:EndIf 
If weapon=903:wanim=10:EndIf
If weapon=904:wanim=10:EndIf
If weapon=905:wanim=12:EndIf
If weapon=906:wanim=12:EndIf
If weapon=907:wanim=12:EndIf
If weapon=908:wanim=12:EndIf
If weapon=909:wanim=10:EndIf
If weapon=914:wanim=15:EndIf
If weapon=910:wanim=0:EndIf
If weapon=912:wanim=0:EndIf



If weapon=910 And stena=0 And tur()\y>0:


  wanimx=wanim
  
trafic=tur3()\trafic*tur3()\trafic4
If wanimx>trafic+1:
  
tur()\wani=0:wanim=0
PreviousElement(tur())
tur()\smilet=255
tur()\smilet2=50
tur()\smile=990
NextElement(tur())
nosmile=1
Return:EndIf
stena=1
EndIf

If weapon=912 And play=tur()\swo And fyrr=0:
  fyrr=10
PreviousElement(tur())
a=20
spidf=4
Goto pribaw
EndIf

If weapon=912 Or weapon=910:Return:EndIf 


If Random(100)=0:
PreviousElement(tur())
tur()\smilet=255
tur()\smilet2=50
tur()\smile=992
NextElement(tur())
EndIf 

If xm33>tur()\x:tur()\stor=0:EndIf 
If xm33<tur()\x:tur()\stor=1:EndIf 





trafic=tur3()\trafic*tur3()\trafic4

If wanim>trafic+1:
tur()\wani=0:wanim=0

PreviousElement(tur())
tur()\smilet=255
tur()\smilet2=50
tur()\smile=990
nosmile=1
NextElement(tur())
Return 
EndIf 




If weapon<>910 And weapon<>912:Gosub mint :EndIf 



Return 

fire2:
If plnex=1:Return:EndIf 
If Random(200)=0:
PreviousElement(tur())
tur()\smilet=255
tur()\smilet2=50
tur()\smile=992
NextElement(tur())
EndIf 
fire3:

If spidf>0:spidf-1:Return:EndIf

If weapon<>910:tur()\wani=20:EndIf 
If weapon=905:tur()\wani=64:EndIf
If weapon=900:wanim=6:EndIf
If weapon=901:wanim=4:EndIf 
If weapon=902:wanim=15:EndIf 
If weapon=903:wanim=10:EndIf
If weapon=904:wanim=10:EndIf
If weapon=905:wanim=12:EndIf
If weapon=906:wanim=12:EndIf
If weapon=907:wanim=12:EndIf
If weapon=908:wanim=12:EndIf
If weapon=909:wanim=10:EndIf
If weapon=914:wanim=15:EndIf
 
If weapon=910 And stena=0:
 spidf=20
  wanimx=wanim
  

trafic=tur3()\trafic*tur3()\trafic4
If wanimx>trafic+1:
tur()\wani=0:wanim=0
PreviousElement(tur())
tur()\smilet=255
tur()\smilet2=50
tur()\smile=990
nosmile=1
NextElement(tur())
Return:EndIf
stena=1
EndIf
If xm33>tur()\x:tur()\stor=0:EndIf 
If xm33<tur()\x:tur()\stor=1:EndIf 
If weapon=912 Or weapon=910 :Return:EndIf 


trafic=tur3()\trafic*tur3()\trafic4
If wanim>trafic+1:
tur()\wani=0:wanim=0

PreviousElement(tur())
tur()\smilet=255
tur()\smilet2=50
tur()\smile=990
nosmile=1
NextElement(tur())
Return 
EndIf 




If weapon<>910 And weapon<>912:Gosub mint :EndIf 
Return 
 
 
minusp:
 ResetList( tur3() ) 
While NextElement( tur3())
  If play=tur3()\pnom:
If ax>0:ax-1
If tur3()\kakoj=0:tur3()\slot1p-1:EndIf 
If tur3()\kakoj=32:tur3()\slot2p-1:EndIf 
If tur3()\kakoj=64:tur3()\slot3p-1:EndIf 
If tur3()\kakoj=96:tur3()\slot4p-1:EndIf 
If tur3()\kakoj=128:tur3()\slot5p-1:EndIf 
If tur3()\kakoj=128+32:tur3()\slot6p-1:EndIf
If tur3()\kakoj=128+64:tur3()\slot7p-1:EndIf  
If tur3()\kakoj=128+96:tur3()\slot8p-1:EndIf 
EndIf 
ataka=tur3()\ataka
EndIf 
Wend

 Return 
 
  minuspp:
 ResetList( tur3() ) 
While NextElement( tur3())
If play=tur3()\pnom:
ataka=tur3()\ataka
EndIf 
Wend

 Return 
 
  pulqq3:
    metkoo=0
 Gosub metko
 If ax<=0:Return:EndIf 
  Gosub minusp:
 spidf=1
 AddElement( tur5() )
If tur()\stor=0:tur5()\x=tur()\x+76:EndIf
If tur()\stor=1:tur5()\x=tur()\x:EndIf
If tur()\stor=0:tur5()\xx=0:EndIf 
If tur()\stor=1:tur5()\xx=5000:EndIf 
tur5()\nom=3
tur5()\y=tur()\y+11
tur5()\met=Random(1)+1
tur5()\met2=Random(2)+1
tur5()\met3=tur5()\met2
tur5()\met4=Random(16)
tur5()\life=5000
tur5()\ataka=ataka
If Random(metkoo)=0:Return:EndIf 
If Random(metkoo)=0:Return:EndIf 
tur5()\met4=0
 Return 
 


 
 pulqq5:
      If ax<=0:Return:EndIf 
     Gosub minusp:
 spidf=1
 AddElement( tur5() )
 tur5()\life=5000
If tur()\stor=0:tur5()\x=tur()\x+65:EndIf 
If tur()\stor=1:tur5()\x=tur()\x+15:EndIf 
tur5()\yy=-300
tur5()\nom=5
tur5()\y=tur()\y-50
tur5()\met=1+Random(1);storona
tur5()\met2=Random(1)+1;chastota
tur5()\met3=tur5()\met2;
tur5()\met4=Random(3);pixel
tur5()\ataka=ataka
 Return 
 
 
     pulqq6:
      Gosub minusp:
 spidf=1
 AddElement( tur5() )
 tur5()\life=5000
tur5()\x=tur()\x+35
tur5()\yy=3000
tur5()\nom=6
tur5()\y=tur()\y+62
tur5()\met=0;storona
tur5()\met2=Random(1)+1;chastota
tur5()\met3=tur5()\met2;
tur5()\met4=Random(3);pixel
tur5()\ataka=ataka
 Return 
 
      pulqq66:
      If ax<=0:Return:EndIf 
       Gosub minusp:
 spidf=1
 AddElement( tur5() )
 tur5()\life=5000
tur5()\x=tur()\x+35
tur5()\yy=3000
tur5()\nom=8
tur5()\y=tur()\y+72
tur5()\met=Random(1)+1;storona
tur5()\met2=Random(2)+1;chastota
tur5()\met3=tur5()\met2;
tur5()\met4=Random(3);pixel
tur5()\ataka=ataka
 Return 
 
   pulqq4:
    Gosub minusp:
 spidf=1
 AddElement( tur5() )
 tur5()\life=5000
If tur()\stor=0:tur5()\x=tur()\x+76:EndIf
If tur()\stor=1:tur5()\x=tur()\x-10:EndIf
If tur()\stor=0:tur5()\xx=0:EndIf 
If tur()\stor=1:tur5()\xx=5000:EndIf 
tur5()\nom=4
tur5()\y=tur()\y+11
tur5()\zap.f=75+Random(50)
tur5()\ataka=ataka
 Return 
 
 
 
 
 
 

 
  pulqq09:
    metkoo=0
 Gosub metko
   Gosub minusp:
 spidf=0
 AddElement( tur5() )
 tur5()\life=5000
tur5()\ataka=ataka
If tur()\stor=0:tur5()\x=tur()\x+74:EndIf
If tur()\stor=1:tur5()\x=tur()\x:EndIf
If tur()\stor=0:tur5()\xx=0:EndIf 
If tur()\stor=1:tur5()\xx=5000:EndIf 
tur5()\y=tur()\y-12
If tur()\stor=1:tur5()\x=tur()\x-64:EndIf 
If tur()\stor=0:tur5()\x=tur()\x+64:EndIf 

tur5()\nom=10
tur5()\met=Random(1)+1
tur5()\met2=Random(2)+1
tur5()\met3=tur5()\met2
tur5()\met4=Random(2)
If Random(metkoo)=0:Return:EndIf 
If Random(metkoo)=0:Return:EndIf 
tur5()\met4=0
 Return 
 
   pulqq099:
    Gosub minusp:
 spidf=0
 AddElement( tur5() )
 tur5()\life=5000
tur5()\ataka=ataka
If tur()\stor=0:tur5()\x=tur()\x+74:EndIf
If tur()\stor=1:tur5()\x=tur()\x:EndIf
If tur()\stor=0:tur5()\xx=0:EndIf 
If tur()\stor=1:tur5()\xx=5000:EndIf 
tur5()\y=tur()\y-12
If tur()\stor=1:tur5()\x=tur()\x-64:EndIf 
If tur()\stor=0:tur5()\x=tur()\x+64:EndIf 
tur5()\nom=11
tur5()\met=Random(1)+1
tur5()\met2=Random(3)+1
tur5()\met3=tur5()\met2
tur5()\met4=Random(4)
If Random(metkoo)=0:Return:EndIf 
If Random(metkoo)=0:Return:EndIf 
tur5()\met4=0
 Return 
 
 
 
 metko:
 ResetList( tur3() ) 
While NextElement( tur3())
If tur3()\pnom=tur()\swo:
metkoo=tur3()\metko
EndIf 
Wend
 Return 
 
 
 pulqq:
 metkoo=0
 Gosub metko
  Gosub minuspp:
 spidf=0
 spidf=0
 AddElement( tur5() )
 tur5()\life=5000
tur5()\ataka=ataka
If tur()\stor=0:tur5()\x=tur()\x+74:EndIf
If tur()\stor=1:tur5()\x=tur()\x:EndIf
If tur()\stor=0:tur5()\xx=0:EndIf 
If tur()\stor=1:tur5()\xx=5000:EndIf 
tur5()\y=tur()\y+11
tur5()\nom=1
tur5()\met=Random(1)+1
tur5()\met2=Random(3)+1
tur5()\met3=tur5()\met2
tur5()\met4=Random(10)
If Random(metkoo)=0:Return:EndIf 
If Random(metkoo)=0:Return:EndIf 
tur5()\met4=0
 Return 
 
 
 
 
 razrw:
  metkoo=0
 Gosub metko
  Gosub minusp:
  spidf=2
 AddElement( tur5() )
 tur5()\life=5000
tur5()\ataka=ataka
If tur()\stor=0:tur5()\x=tur()\x+74:EndIf
If tur()\stor=1:tur5()\x=tur()\x-20:EndIf
If tur()\stor=0:tur5()\xx=0:EndIf 
If tur()\stor=1:tur5()\xx=5000:EndIf 
tur5()\y=tur()\y+11
tur5()\nom=2
tur5()\met=Random(1)+1;storona
tur5()\met2=Random(10)+1;chastota
tur5()\met3=tur5()\met2;
tur5()\met4=Random(2)+1;pixel
tur5()\zap=1
If Random(metkoo)=0:Return:EndIf 
If Random(metkoo)=0:Return:EndIf 
tur5()\met4=0
Return 

moik:
ExamineMouse() 
If MouseButton(1) :
  
iko=0
spid3=0
gravitator=1
Goto moik
EndIf 


ResetList( tur() ) 
While NextElement( tur())
  If tur()\nom=500 And play=tur()\swo And tur()\energ<64:
 
    

    
ResetList( tur3() ) 
While NextElement( tur3())
  If play=tur3()\pnom:  

       
       tur3()\energ+tur3()\reani
     tur()\energ+tur3()\reani
     If tur()\energ>64:tur3()\energ=64:tur()\energ=64:EndIf 
    a=tur3()\reani
  If a>0 And tur()\energ<64:
  AddElement(tur8())
tur8()\x=tur()\x+50
tur8()\y=tur()\y-20
tur8()\nom=a
tur8()\plus=2
tur8()\rand=Random(9)
EndIf 
EndIf 

Wend 
EndIf 

Wend 
Return 



ognem3:

If Random(10)<9:Return:EndIf 

xwz=tur()\x+48
ywz=tur()\y-30


AddElement(tur7()) 
tur7()\nom=2000
tur7()\x=xwz+Random(150)
tur7()\y=ywz
tur7()\life=1+Random(400)

Return 


ognem4:

If Random(10)<9:Return:EndIf 

xwz=tur()\x-100
ywz=tur()\y-30

AddElement(tur7()) 
tur7()\nom=2000
tur7()\x=xwz-Random(150)
tur7()\y=ywz
tur7()\life=1+Random(400)

Return 


plays:
If asound=0:asound=10:EndIf 
asound-1
If asound<9:Return:EndIf 
PlaySound(0)
Return 


ognem:
Gosub plays:
 Gosub minusp:
 spidf=0
 AddElement( tur5() )
tur5()\ataka=ataka
If tur()\stor=0:tur5()\x=tur()\x+74:EndIf
If tur()\stor=1:tur5()\x=tur()\x:EndIf
If tur()\stor=0:tur5()\xx=tur()\x-100:EndIf 
If tur()\stor=1:tur5()\xx=tur()\x+100:EndIf 
tur5()\y=tur()\y+11
tur5()\nom=20
tur5()\met=Random(2)
tur5()\met2=Random(3)+1
tur5()\met3=tur5()\met2
tur5()\met4=Random(8)
tur5()\life=18


rwzr=1
wzr=50
radi=25
If tur()\stor=0:
xwz=tur()\x+90
ywz=tur()\y
xwzz=tur()\x
ywzz=tur()\y
aaaa.f=0.79
If ym33>tur()\y+40:aaaa.f=1:EndIf 
If ym33<tur()\y-40:aaaa.f=0.6:EndIf 
Gosub instalbb
Gosub ognem3
EndIf 
If tur()\stor=1:
xwz=tur()\x-10
ywz=tur()\y
xwzz=tur()\x
ywzz=tur()\y
aaaa.f=0.79+3.2
If ym33<tur()\y-40:aaaa.f=1+3.2:EndIf 
If ym33>tur()\y+40:aaaa.f=0.6+3.2:EndIf 
Gosub instalbb
Gosub ognem4
EndIf 
Return 


pulq:

ResetList( tur5() ) 
While NextElement( tur5())
If tur5()\nom=>1:Gosub pulq2:EndIf 

Wend
Return 


pulq2:
Start3D()
Sprite3DBlendingMode(10, 7)
If tur5()\nom=1:DisplaySprite3D(1 , tur5()\x +c, tur5()\y+d,255):EndIf  
If tur5()\nom=3 :DisplaySprite3D(4 , tur5()\x +c, tur5()\y+d,255):EndIf 
Sprite3DBlendingMode(10, 7)
If tur5()\nom=10 And tur5()\x >tur5()\xx:DisplaySprite3D(961 , tur5()\x +c, tur5()\y+d,255):EndIf 
If tur5()\nom=10 And tur5()\x <tur5()\xx:DisplaySprite3D(962 , tur5()\x +c, tur5()\y+d,255):EndIf 
If tur5()\nom=11 And tur5()\x >tur5()\xx:DisplaySprite3D(963 , tur5()\x +c, tur5()\y+d-10,255):EndIf 
If tur5()\nom=11 And tur5()\x <tur5()\xx:DisplaySprite3D(964 , tur5()\x +c, tur5()\y+d-10,255):EndIf 
Sprite3DBlendingMode(2, 6)

Stop3D()
If tur5()\nom=2 And tur5()\x >tur5()\xx:DisplayTransparentSprite(954+Random(1), tur5()\x +c, tur5()\y+d):EndIf
If tur5()\nom=2 And tur5()\x <tur5()\xx:DisplayTransparentSprite(956+Random(1), tur5()\x +c, tur5()\y+d):EndIf
If tur5()\nom=4: DisplayTransparentSprite(321, tur5()\x +c, tur5()\y+d):EndIf
If tur5()\nom=5:DisplayTransparentSprite(958+Random(1), tur5()\x +c, tur5()\y+d):EndIf
If tur5()\nom=6 Or tur5()\nom=8:DisplayTransparentSprite(960, tur5()\x +c, tur5()\y+d):EndIf
If tur5()\nom<>5:
If tur5()\met=1 And tur5()\met2=0:tur5()\met2=tur5()\met3:tur5()\y-tur5()\met4:EndIf 
If tur5()\met=1:tur5()\met2-1:EndIf 
If tur5()\met=2 And tur5()\met2=0:tur5()\met2=tur5()\met3:tur5()\y+tur5()\met4:EndIf 
If tur5()\met=2:tur5()\met2-1:EndIf 
EndIf 
If tur5()\nom=5:
If tur5()\met=1 And tur5()\met2=0:tur5()\met2=tur5()\met3:tur5()\x-tur5()\met4:EndIf 
If tur5()\met=1:tur5()\met2-1:EndIf 
If tur5()\met=2 And tur5()\met2=0:tur5()\met2=tur5()\met3:tur5()\x+tur5()\met4:EndIf 
If tur5()\met=2:tur5()\met2-1:EndIf 
EndIf 

If tur5()\nom=8:
If tur5()\met=1 And tur5()\met2=0:tur5()\met2=tur5()\met3:tur5()\x-tur5()\met4:EndIf 
If tur5()\met=1:tur5()\met2-1:EndIf 
If tur5()\met=2 And tur5()\met2=0:tur5()\met2=tur5()\met3:tur5()\x+tur5()\met4:EndIf 
If tur5()\met=2:tur5()\met2-1:EndIf 
EndIf 



If tur5()\nom=1 And tur5()\x >tur5()\xx:tur5()\x+16:kuda=0:EndIf 
If tur5()\nom=1 And tur5()\x <tur5()\xx:tur5()\x-16:kuda=1:EndIf  
If tur5()\nom=20 And tur5()\x >tur5()\xx:tur5()\x+16:kuda=0:EndIf 
If tur5()\nom=20 And tur5()\x <tur5()\xx:tur5()\x-16:kuda=1:EndIf 


If tur5()\nom=10 And tur5()\x >tur5()\xx:tur5()\x+40:kuda=0:EndIf 
If tur5()\nom=10 And tur5()\x <tur5()\xx:tur5()\x-40:kuda=1:EndIf  
If tur5()\nom=11 And tur5()\x >tur5()\xx:tur5()\x+40:kuda=0:EndIf 
If tur5()\nom=11 And tur5()\x <tur5()\xx:tur5()\x-40:kuda=1:EndIf  

If tur5()\nom=3 And tur5()\x >tur5()\xx:tur5()\x+16:kuda=0:EndIf 
If tur5()\nom=3 And tur5()\x <tur5()\xx:tur5()\x-16:kuda=1:EndIf 
If tur5()\nom=5:tur5()\y-tur5()\zap:kuda=0:Gosub sozdym:EndIf 
If tur5()\nom=6:tur5()\y+tur5()\zap:kuda=0:EndIf
If tur5()\nom=8:tur5()\y+tur5()\zap:kuda=0:EndIf
If tur5()\nom=4 And tur5()\x >tur5()\xx:kuda=0:tur5()\x+8:Gosub sin:EndIf 
If tur5()\nom=4 And tur5()\x <tur5()\xx:kuda=1:tur5()\x-8:Gosub sin:EndIf 

If tur5()\nom=2 And tur5()\x >tur5()\xx:tur5()\x+tur5()\zap:kuda=0:Gosub sozdym:EndIf 
If tur5()\nom=2 And tur5()\x <tur5()\xx:tur5()\x-tur5()\zap:kuda=1:Gosub sozdym:EndIf 
If tur5()\zap<20:tur5()\zap+1:EndIf 
If tur5()\y>3000:DeleteElement( tur5() ):Return:EndIf 
If tur5()\y<-100:DeleteElement( tur5() ):Return:EndIf 
If tur5()\x<-300:DeleteElement( tur5() ):Return:EndIf 
If tur5()\x>3000:DeleteElement( tur5() ):Return:EndIf 
tur5()\life-1
If tur5()\life=0:DeleteElement( tur5() ):Return:EndIf 


ymd=tur5()\y
xmd=tur5()\x
anal=15

If tur5()\nom=10 Or tur5()\nom=11:anal=0:EndIf 

ResetList( tur() ) 
While NextElement( tur())

 If tur5()\nom=5 And SpritePixelCollision(1, xmd, ymd+20, tur()\nom, tur()\x, tur()\y):kudaa=2:Goto popal:EndIf
 If tur5()\nom=2 And SpritePixelCollision(1, xmd, ymd-anal, tur()\nom, tur()\x, tur()\y):kudaa=4:Goto popal:EndIf
 If  SpritePixelCollision(1, xmd, ymd-anal, tur()\nom, tur()\x, tur()\y):kudaa=1:Goto popal:EndIf
 If  anal=0 And SpriteCollision(1, xmd, ymd-anal, tur()\nom, tur()\x, tur()\y):kudaa=3:Goto popal:EndIf
 nn:   
Wend

Return 




sin:
X666q.f=10
Y666q.f=10
aaaaq.f=tur5()\zap.f
aaaaq.f+0.4
tur5()\zap.f=aaaaq.f

x23666q.f = X666q*Cos(aaaaq.f) + Y666q*Sin(aaaaq.f)
y23666q.f = X666q*Sin(aaaaq.f) - Y666q*Cos(aaaaq.f)
tur5()\y-y23666q.f
Gosub sozdym
Return 

popal:
*Old_Elementpopal = @tur()
ResetList( tur3() ) 
While NextElement( tur3())
If tur3()\pnom=tur()\swo:
If tur3()\slot1u=1105:
If tur3()\slot1uu=2 And Random(3)=0:Return:EndIf  
If tur3()\slot1uu=3 And Random(2)=0:Return:EndIf  
EndIf 
If tur3()\slot2u=1105:
If tur3()\slot2uu=2 And Random(3)=0:Return:EndIf  
If tur3()\slot2uu=3 And Random(2)=0:Return:EndIf  
EndIf 
If tur3()\slot3u=1105:
If tur3()\slot3uu=2 And Random(3)=0:Return:EndIf  
If tur3()\slot3uu=3 And Random(2)=0:Return:EndIf  
EndIf 
If tur3()\slot4u=1105:
If tur3()\slot4uu=2 And Random(3)=0:Return:EndIf  
If tur3()\slot4uu=3 And Random(2)=0:Return:EndIf  
EndIf 

If tur3()\slot1u=1106:
If tur3()\slot1uu=3 And Random(3)=0:Return:EndIf  
EndIf 
If tur3()\slot2u=1106: 
If tur3()\slot2uu=3 And Random(3)=0:Return:EndIf  
EndIf 
If tur3()\slot3u=1106: 
If tur3()\slot3uu=3 And Random(3)=0:Return:EndIf  
EndIf 
If tur3()\slot4u=1106: 
If tur3()\slot4uu=3 And Random(3)=0:Return:EndIf  
EndIf 
EndIf 
Wend 

ataka=tur5()\ataka
If tur5()\nom=10 Or tur5()\nom=11 Or tur5()\nom=4 Or tur5()\nom=5 Or tur5()\nom=6 Or tur5()\nom=8:Goto nnn:EndIf 
If tur()\nom=17:Gosub wzryw:DeleteElement( tur5() ):Return:EndIf 
If tur()\nom=10:Gosub wzryw:DeleteElement( tur5() ):Return:EndIf 
If tur()\nom=11:Gosub wzryw:DeleteElement( tur5() ):Return:EndIf 
If tur()\nom=12:Gosub wzryw:DeleteElement( tur5() ):Return:EndIf 
If tur()\nom=13:Gosub wzryw:DeleteElement( tur5() ):Return:EndIf 
If tur()\nom=16:Gosub wzryw:DeleteElement( tur5() ):Return:EndIf 
If tur()\nom=18:Gosub wzryw:DeleteElement( tur5() ):Return:EndIf 
If tur()\nom=19:Gosub wzryw:DeleteElement( tur5() ):Return:EndIf 
If tur()\nom=21:Gosub wzryw:DeleteElement( tur5() ):Return:EndIf 
If tur()\nom=22:Gosub wzryw:DeleteElement( tur5() ):Return:EndIf 
If tur()\nom=23:Gosub wzryw:DeleteElement( tur5() ):Return:EndIf 
If tur()\nom=24:Gosub wzryw:DeleteElement( tur5() ):Return:EndIf 
If tur()\nom=25:PlaySound(2):Gosub wzryw:DeleteElement( tur5() ):Return:EndIf 
nnn:

If tur()\nom=500 And tur5()\nom=1 And tur()\swo2=333:Goto nn:EndIf 
  
If tur()\nom=500:
NextElement(tur())
If kudaa=2:tur()\gravitator=20+Random(130):EndIf 
If kudaa=1:tur()\gravitator=5+Random(15):EndIf 
If kudaa=4:tur()\gravitator=12+Random(20):EndIf 
PreviousElement(tur())
a=0
Gosub otnqtx2
Gosub wzryw:DeleteElement( tur5() ):Return:EndIf; ------------отнял 

Goto nn:


;Сергей слободчиков владимирович серия 0801 434922
;10 10 55 др

;од хаб края хаб раона 15 01 2002 


otnqtx2:
If tur5()\nom=1:a=3+Random(3):EndIf ; простое ружье
If tur5()\nom=2:a=64:EndIf ; ракетница
If tur5()\nom=20:a=3:EndIf ; огнемет
If tur5()\nom=3:a=5+Random(2):EndIf ; миниган
If tur5()\nom=4:a=16+Random(6):EndIf ; плазма
If tur5()\nom=5:a=32+Random(2):EndIf ; ракета
If tur5()\nom=6:a=32+Random(2):EndIf ; бобма
If tur5()\nom=8:a=32:EndIf ; 4*бобма
If tur5()\nom=10:a=10+Random(2):EndIf ; энергооружие
If tur5()\nom=11:a=16+Random(4):EndIf ; энергооружие2
e=0
ResetList( tur3() ) 
While NextElement( tur3())
If tur3()\pnom=tur()\swo:e=tur3()\energ2:EndIf 
If tur3()\pnom=tur()\swo
If tur3()\slot1a=982 Or tur3()\slot2a=982 Or tur3()\slot3a=982 Or tur3()\slot4a=982:

If tur5()\nom=10:a=4:EndIf 
If tur5()\nom=11:a=5:EndIf
If tur5()\nom=4:a=8:EndIf

EndIf 
EndIf 
Wend 
Goto otnqtx

otnqtxspec:
If Random(500)=0 And tur()\swo2<333:
tur()\smilet=255
tur()\smilet2=50
tur()\smile=993
EndIf
a+Random(ataka)
AddElement(tur8())
tur8()\x=tur()\x+50
tur8()\y=tur()\y-10+Random(20)
tur8()\nom=a
tur8()\plus=0
tur8()\rand=Random(9)
ee=e/4


Repeat
eee=Random(e)+1
If tur()\energ>0 And tur()\energ1<=0:tur()\energ1=ee+eee:tur()\energ-1:EndIf 
If tur()\energ<=0:Goto smertxspec:EndIf 
tur()\energ1-1
a-1
 Until a=0 
Return 






smertxspec:
 *Old_Ele = @tur() 
If tur()\swo2=333:Return:EndIf 
plpa=0
 *Old_Element6626 = @tur() 
ResetList( tur() ) 
While NextElement( tur())
  If tur()\swo2=333 And tur()\nom=500:plpa+1:EndIf 
  If plpa=players2-1:ChangeCurrentElement(tur(), *Old_Element6626):nechja=1:Goto dalch:EndIf 
Wend 
dalch:
    ChangeCurrentElement(tur(), *Old_Element6626)
  
If tur()\swo2=333 And players2=smertxw+1:Return:EndIf 



If tur()\swo2<>333:smertxw+1:EndIf 






If players2=smertxw+1:endturr=1:EndIf 

skoka=0
yl=tur()\y



If arteflost=0:Goto ranspec:EndIf 



If tur()\swo=tur3()\pnom:

  skokaz=0
  arteflost2=arteflost
  Repeat 
    skokaz=0

     If tur3()\slot1a=0 And tur3()\slot2a=0 And tur3()\slot3a=0 And tur3()\slot4a=0:Goto ranspec:EndIf 

 If tur3()\slot1a>0:EndIf 
 If tur3()\slot2a>0:skokaz+1:EndIf 
  If tur3()\slot3a>0:skokaz+1:EndIf 
  If tur3()\slot4a>0:skokaz+1:EndIf 
 
  akam=Random(skokaz)
  If akam=0 And tur()\swo=tur3()\pnom:
or111=tur3()\slot1a:tur3()\slot1a=0
 *Old_Element6626 = @tur() 
 Gosub wykinx222
 ChangeCurrentElement(tur(), *Old_Element6626)
EndIf 

  If akam=1 And tur()\swo=tur3()\pnom:
    or111=tur3()\slot2a:tur3()\slot2a=0
     *Old_Element6626 = @tur() 
Gosub wykinx222
ChangeCurrentElement(tur(), *Old_Element6626)
EndIf 

  If akam=2 And tur()\swo=tur3()\pnom:
    or111=tur3()\slot3a:tur3()\slot3a=0
     *Old_Element6626 = @tur() 
Gosub wykinx222
ChangeCurrentElement(tur(), *Old_Element6626)
EndIf 

  If akam=3 And tur()\swo=tur3()\pnom:
    or111=tur3()\slot4a:tur3()\slot4a=0
     *Old_Element6626 = @tur() 
Gosub wykinx222
ChangeCurrentElement(tur(), *Old_Element6626)
EndIf 
arteflost2-1
Until arteflost2=0


EndIf 



ranspec:

ChangeCurrentElement(tur(), *Old_Ele)
tur()\swo2=333
tur()\energ=0
tur()\wani=128
NextElement( tur())
tur()\swo2=333
tur()\energ=0
tur()\wani=128
PreviousElement(tur())

Return 




































otnqtx:;-----------------------minus energijq

If Random(500)=0 And tur()\swo2<333:
tur()\smilet=255
tur()\smilet2=50
tur()\smile=993
EndIf
a+Random(ataka)
AddElement(tur8())
tur8()\x=tur()\x+50
tur8()\y=tur()\y-10+Random(20)
tur8()\nom=a
tur8()\plus=0
tur8()\rand=Random(9)
ee=e/4


Repeat
eee=Random(e)+1
If tur()\energ>0 And tur()\energ1<=0:tur()\energ1=ee+eee:tur()\energ-1:EndIf 
If tur()\energ<=0:Goto smertx:EndIf 
tur()\energ1-1
a-1
 Until a=0 
Return 





;---------------smertx

smertx:

If tur()\swo2=333:Return:EndIf 
plpa=0
 *Old_Element6626 = @tur() 
ResetList( tur() ) 
While NextElement( tur())
  If tur()\swo2=333 And tur()\nom=500:plpa+1:EndIf 
  If plpa=players2-1:ChangeCurrentElement(tur(), *Old_Element6626):Return:EndIf 
Wend 
    ChangeCurrentElement(tur(), *Old_Element6626)
  
If tur()\swo2=333 And players2=smertxw+1:Return:EndIf 



If tur()\swo2<>333:smertxw+1:EndIf 
tur()\energ=0
tur()\wani=128


If players2=smertxw+1:endturr=1:EndIf 

skoka=0
yl=tur()\y

ResetList( tur3() ) 
While NextElement( tur3())
  If tur()\swo=tur3()\pnom:
abq=tur3()\opyt
EndIf 


If arteflost=0:Goto ran:EndIf 



If tur()\swo=tur3()\pnom:

  skokaz=0
  arteflost2=arteflost
  Repeat 
    skokaz=0

     If tur3()\slot1a=0 And tur3()\slot2a=0 And tur3()\slot3a=0 And tur3()\slot4a=0:Goto ran:EndIf 

 If tur3()\slot1a>0:EndIf 
 If tur3()\slot2a>0:skokaz+1:EndIf 
  If tur3()\slot3a>0:skokaz+1:EndIf 
  If tur3()\slot4a>0:skokaz+1:EndIf 
 
  akam=Random(skokaz)
  If akam=0 And tur()\swo=tur3()\pnom:
or111=tur3()\slot1a:tur3()\slot1a=0
 *Old_Element6626 = @tur() 
 Gosub wykinx222
 ChangeCurrentElement(tur(), *Old_Element6626)
EndIf 

  If akam=1 And tur()\swo=tur3()\pnom:
    or111=tur3()\slot2a:tur3()\slot2a=0
     *Old_Element6626 = @tur() 
Gosub wykinx222
ChangeCurrentElement(tur(), *Old_Element6626)
EndIf 

  If akam=2 And tur()\swo=tur3()\pnom:
    or111=tur3()\slot3a:tur3()\slot3a=0
     *Old_Element6626 = @tur() 
Gosub wykinx222
ChangeCurrentElement(tur(), *Old_Element6626)
EndIf 

  If akam=3 And tur()\swo=tur3()\pnom:
    or111=tur3()\slot4a:tur3()\slot4a=0
     *Old_Element6626 = @tur() 
Gosub wykinx222
ChangeCurrentElement(tur(), *Old_Element6626)
EndIf 
arteflost2-1
Until arteflost2=0


EndIf 



ran:

ChangeCurrentElement(tur(), *Old_Elementpopal)
tur()\swo2=333
NextElement( tur())
tur()\swo2=333
PreviousElement(tur())

Wend 

If play=tur()\swo:Return:EndIf 


ResetList( tur3() ) 
While NextElement( tur3())



  If tur3()\pnom=play:

If abq>1000:abq=1000:EndIf 

tur3()\victory+1


r=20+abq/10
Repeat 
tur3()\opyt+1
If tur3()\opyt=100:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=210:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=330:tur()\x2=tur()\x:diss=1:EndIf
If tur3()\opyt=450:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=570:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=690:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=810:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=930:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=1050:tur()\x2=tur()\x:diss=1:EndIf  
r-1
Until r=0  
:EndIf 

Wend 



Return 






pribaw:
If tur()\swo=play
 If tur()\swo2=333 Or tur()\bot=1:Return:EndIf 
EndIf 

If tur()\energ=>64:
tur()\smilet=255
tur()\smilet2=50
tur()\smile=990
tur()\energ=64
PlaySound(7):
Return 
:EndIf 

Repeat
  If tur()\energ1=tur()\energ2:tur()\energ+1:tur()\energ1-1:EndIf 
tur()\energ1+1
a-1
Until a=0 

wanim=10:
Gosub minusp:
Gosub mint 

kris=913:Gosub wzryw2:kris=0

If tur()\energ=>64:tur()\energ=64:EndIf 
Return 



wzryw:
If tur5()\nom=2 Or tur5()\nom=5 Or tur5()\nom=6 Or tur5()\nom=8:Goto wzryw3:EndIf 
rwzr=10
wzr=1
radi=10
xwz=tur5()\x+20
ywz=tur5()\y
wzrywww:
Gosub instalb
If tur()\nom=21:tur()\nom=23:Return:EndIf 
If tur()\nom=22:tur()\nom=24:Return:EndIf 
If tur()\nom=23:DeleteElement( tur() ):Goto clearr:EndIf 
If tur()\nom=24:DeleteElement( tur() ):Goto clearr:EndIf 
If tur()\nom=25:Gosub wzryw2:DeleteElement( tur() ):Goto clearrr:EndIf 
If tur()\nom=500:
;a=8+ataka
;Gosub otnqtx
EndIf 
NextElement( tur())
If tur()\nom=97
  :;--------------------энерция попал
If tur()\wani<48:tur()\wani=48:EndIf 
If kuda=0:tur()\iner=4:EndIf 
If kuda=1:tur()\iner2=4:EndIf
If kuda=0 And tur5()\nom=11 :tur()\iner=Random(100)+30:tur()\gravitator=20+Random(120):EndIf 
If kuda=1 And tur5()\nom=11:tur()\iner2=Random(100)+30:tur()\gravitator=20+Random(120):EndIf
tur()\x2=tur()\x
Return:EndIf
Return 




wzryw3:
PlaySound(2)
rwzr=50
wzr=50
radi=12
xwz=tur5()\x+20
ywz=tur5()\y
Gosub instalb
If tur()\nom=21:tur()\nom=23:Return:EndIf 
If tur()\nom=22:tur()\nom=24:Return:EndIf 
If tur()\nom=23:DeleteElement( tur() ):Goto clearr:EndIf 
If tur()\nom=24:DeleteElement( tur() ):Goto clearr:EndIf 
If tur()\nom=25:Gosub wzryw2:DeleteElement( tur() ):Goto clearrr:EndIf 
If tur()\nom=500:
;a=1+ataka
;Gosub otnqtx
EndIf 
NextElement( tur())
If tur()\nom=97:;--------------------энерция попал
If tur()\wani<48:tur()\wani=48:EndIf 
If kuda=0:tur()\iner=16+Random(4):EndIf 
If kuda=1:tur()\iner2=16+Random(4):EndIf
tur()\x2=tur()\x
Return:EndIf
Return 







clearr:
NextElement( tur())
If tur()\nom=96:DeleteElement( tur() ):EndIf 
Return 
clearrr:
NextElement( tur())
If tur()\nom=96:DeleteElement( tur() ):EndIf 
 Gosub inerwzr
Return 

wzryw2:
PlaySound (8)
rwzr=25
wzr=100
radi=15
xwz=tur()\x+20
ywz=tur()\y+20
xwzz=tur()\x
ywzz=tur()\y
Gosub instalb
Return 
wzrywmagic:
PlaySound (13)
rwzr=35
wzr=150
radi=25
xwz=tur()\x+20
ywz=tur()\y+20
xwzz=tur()\x
ywzz=tur()\y
Gosub instalb
Return 
inerwzr:

ResetList( tur() ) 
While NextElement( tur())

 If SpriteCollision(tur()\nom, xwzz, ywzz-100, tur()\nom, tur()\x, tur()\y):kudaa=2:Gosub popall:EndIf  
  If SpriteCollision(tur()\nom, xwzz+48, ywzz, tur()\nom, tur()\x, tur()\y):kudaa=0:Gosub popall:EndIf 
   If SpriteCollision(tur()\nom, xwzz-48, ywzz, tur()\nom, tur()\x, tur()\y):kudaa=1:Gosub popall:EndIf 
     If SpriteCollision(tur()\nom, xwzz+96, ywzz, tur()\nom, tur()\x, tur()\y):kudaa=0:Gosub popall:EndIf 
   If SpriteCollision(tur()\nom, xwzz-96, ywzz, tur()\nom, tur()\x, tur()\y):kudaa=1:Gosub popall:EndIf 
        If SpriteCollision(tur()\nom, xwzz+96+48, ywzz, tur()\nom, tur()\x, tur()\y):kudaa=3:Gosub popall:EndIf 
   If SpriteCollision(tur()\nom, xwzz-96-48, ywzz, tur()\nom, tur()\x, tur()\y):kudaa=4:Gosub popall:EndIf 

        If SpriteCollision(tur()\nom, xwzz+48, ywzz-100, tur()\nom, tur()\x, tur()\y):kudaa=5:Gosub popall:EndIf 
   If SpriteCollision(tur()\nom, xwzz-48, ywzz-100, tur()\nom, tur()\x, tur()\y):kudaa=6:Gosub popall:EndIf 
   
           If SpriteCollision(tur()\nom, xwzz+96, ywzz-100, tur()\nom, tur()\x, tur()\y):kudaa=7:Gosub popall:EndIf 
   If SpriteCollision(tur()\nom, xwzz-96, ywzz-100, tur()\nom, tur()\x, tur()\y):kudaa=8:Gosub popall:EndIf 

nnnn:
Wend
Return 

popall: 

*Old_Elementpopal = @tur()
If tur()\nom=500:Goto popalll:EndIf 
Return 

popalll:
*Old_Element901 = @tur3()
ResetList( tur3() ) 
While NextElement( tur3())
If tur()\swo=tur3()\pnom:
If tur3()\slot1a=983 Or tur3()\slot2a=983 Or tur3()\slot3a=983 Or tur3()\slot4a=983:
e=tur()\energ2
a=1
ataka=8
Goto otn:
EndIf 
If tur3()\slot1u=1104 And tur3()\slot1uu=3:
e=tur()\energ2
a=10
ataka=8
Goto otn:
EndIf 
If tur3()\slot2u=1104 And tur3()\slot2uu=3:
e=tur()\energ2
a=10
ataka=8
Goto otn:
EndIf 
If tur3()\slot3u=1104 And tur3()\slot3uu=3:
e=tur()\energ2
a=10
ataka=8
Goto otn:
EndIf 
If tur3()\slot4u=1104 And tur3()\slot4uu=3:
e=tur()\energ2
a=10
ataka=8
Goto otn:
EndIf 
EndIf 
Wend 
e=tur()\energ2
a=64
ataka=64
otn:
ChangeCurrentElement(tur3(), *Old_Element901)

Gosub otnqtxspec
sw:
NextElement( tur())
If kudaa=0:tur()\iner=8+Random(48):tur()\gravitator=Random(20):EndIf 
If kudaa=1:tur()\iner2=8+Random(48):tur()\gravitator=Random(20):EndIf
If kudaa=3:tur()\iner=8+Random(8):EndIf 
If kudaa=4:tur()\iner2=8+Random(8):EndIf
If kudaa=2:tur()\iner=8+Random(48):tur()\gravitator=30+Random(130):EndIf
If kudaa=5:tur()\iner2=8+Random(48):tur()\gravitator=30+Random(130):EndIf
If kudaa=2:tur()\iner=8+Random(8):tur()\gravitator=20+Random(30):EndIf
If kudaa=5:tur()\iner2=8+Random(8):tur()\gravitator=20+Random(30):EndIf
tur()\x2=tur()\x

Goto nnnn
Return:






print4:

ResetList( tur() ) 

While NextElement( tur())
  ;If tur()\nom=96:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+12):Goto suu:EndIf 
If tur()\nom=77:DisplayTransparentSprite( tur()\nom+anim4 , tur()\x + c, tur()\y + d):Goto suu:EndIf 
If tur()\nom=100:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+12):Goto suu:EndIf 
If tur()\nom=101:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+12):Goto suu:EndIf 
If tur()\nom=102:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+12):Goto suu:EndIf 
If tur()\nom=103:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+12):Goto suu:EndIf 
If tur()\nom=104:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+12):Goto suu:EndIf 
If tur()\nom=105:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+12):Goto suu:EndIf 
If tur()\nom=106:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+12):Goto suu:EndIf 
If tur()\nom=107:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+12):Goto suu:EndIf 
suu:
Wend
Return 


print:
If anim22=0:anim8+1:EndIf 
If anim8=3:anim8=0:EndIf 
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=500:Gosub wydra:Goto su:EndIf 
If tur()\nom=>970 And tur()\nom<990:Gosub upastx:EndIf 
If tur()\nom=67:Gosub upastx:EndIf 
If tur()\nom=97 Or tur()\nom=96:   
  If tur()\magic>0:tur()\magic-1:EndIf  
Goto su:EndIf 
If tur()\nom=77:Goto su:EndIf 
If tur()\nom=98 Or tur()\nom=99:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+8):Goto su:EndIf 
  If tur()\nom=204:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+8):Goto su:EndIf 
  If tur()\nom=139:DisplayTransparentSprite( tur()\nom+anim8 , tur()\x + c, tur()\y + d+3):Goto su:EndIf 
If tur()\nom=92:DisplayTransparentSprite( tur()\nom+anim5 , tur()\x + c, tur()\y + d):Goto su:EndIf 
If tur()\nom=25:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+8):Goto su:EndIf 
If tur()\nom=26:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+28):Goto su:EndIf 
If tur()\nom=29:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+28):Goto su:EndIf 
If tur()\nom=27:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+4):Goto su:EndIf 
If tur()\nom=28:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+4):Goto su:EndIf 
If tur()\nom=250:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+4):Goto su:EndIf 
If tur()\nom=251:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+4):Goto su:EndIf 
If tur()\nom=252:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+4):Goto su:EndIf 
If tur()\nom=253:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+4):Goto su:EndIf 
If tur()\nom=254:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+4):Goto su:EndIf 
If tur()\nom=255:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+4):Goto su:EndIf 
If tur()\nom=21:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+1):Goto su:EndIf 
If tur()\nom=22:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+1):Goto su:EndIf 
If tur()\nom=23:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+1):Goto su:EndIf 
If tur()\nom=24:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+1):Goto su:EndIf 
If tur()\nom=67:DisplayTransparentSprite( tur()\nom+anim3 , tur()\x + c, tur()\y + d):Goto su:EndIf 
If tur()\nom=58:DisplayTransparentSprite( tur()\nom+anim , tur()\x + c, tur()\y + d):Goto su:EndIf 
 If tur()\nom=19:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+16):Goto su:EndIf 
  If tur()\nom=14:DisplayTransparentSprite( tur()\nom , tur()\x + c+25, tur()\y + d):Goto su:EndIf 
  If tur()\nom=52:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d-30):Goto su:EndIf 
      If tur()\nom=120:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+30):Goto su:EndIf 
          If tur()\nom=122:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+2):Goto su:EndIf 
 
  If tur()\nom=53 Or tur()\nom=54:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d+3):Goto su:EndIf 
  If tur()\nom<=100:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d):EndIf 
   
   
     If tur()\nom=>280 And tur()\nom<300:Goto su:EndIf 
    If tur()\nom=>123:DisplayTransparentSprite( tur()\nom , tur()\x + c, tur()\y + d):EndIf 
  su:
  If tur()\nom=251 And tur()\swo=0:tur()\nom=252:tur()\swo=3:EndIf 
  If tur()\nom=251 And  tur()\swo>0:tur()\swo-1:EndIf 
  
  If tur()\nom=252 And tur()\swo=0:tur()\nom=253:tur()\swo=3:EndIf 
  If tur()\nom=252 And  tur()\swo>0:tur()\swo-1:EndIf 
  
  If tur()\nom=253 And tur()\swo=0:tur()\nom=254:tur()\swo=1:EndIf 
  If tur()\nom=253 And  tur()\swo>0:tur()\swo-1:EndIf
  
  If tur()\nom=254 And tur()\swo=0:tur()\nom=255:tur()\swo=1:EndIf 
  If tur()\nom=254 And  tur()\swo>0:tur()\swo-1:EndIf
  
  If tur()\nom=255 And tur()\swo=0:tur()\nom=250:tur()\swo=1:EndIf 
  If tur()\nom=255 And  tur()\swo>0:tur()\swo-1:EndIf
Wend

Return 

print2:

ResetList( tur() ) 

While NextElement( tur())

      If tur()\nom=>110 And tur()\nom<120:DisplayTransparentSprite( tur()\nom , tur()\x + c/4, tur()\y + d):EndIf 
    If tur()\nom=>280 And tur()\nom<300:DisplayTransparentSprite( tur()\nom , tur()\x + c/2, tur()\y + d):EndIf 
  
Wend

Return 













escc:

exitm=1:
Return 


a222:
ResetList( tur3() ) 
 While NextElement( tur3())
If tur3()\pnom=play:
gr=tur3()\gravi
EndIf 
Wend 

ResetList( tur() ) 
 While NextElement( tur())
   If tur()\nom=97 And tur()\gravitator=0 And tur()\swo=play:
     If tur()\magic=0: tur()\gravitator=72+(gr*2):EndIf 
 If tur()\magic>0: PlaySound (12):tur()\gravitator=102+(gr*2):EndIf 
EndIf 
Wend
Return 
ece:

xtii=xti
ytii=yti
xtii/32
xtii*32
ytii/32
ytii*32
cc=c
dd=d
cc/32
cc*32
dd/32
dd*32
If cc=xtii And dd=ytii:spid3=0:EndIf  
If cc=xtii And dd-32=ytii:spid3=0:EndIf
If cc=xtii And dd+32=ytii:spid3=0:EndIf
If cc+32=xtii And dd-32=ytii:spid3=0:EndIf
If cc-32=xtii And dd+32=ytii:spid3=0:EndIf
If cc-32=xtii And dd-32=ytii:spid3=0:EndIf
If cc+32=xtii And dd+32=ytii:spid3=0:EndIf

Return 
;--------------------------mouse
mouse:


If iko=0 And shop1=0 And displayb=0 And delor2=0 And endturr=0 And bot=0:Gosub prp:EndIf 


ExamineKeyboard()
If KeyboardPushed(#PB_Key_Return) And play=tur()\swo And tur()\swo2=333 And endturr=0 And delor2=0 And iko=0 And shop1=0 And displayb=0:nextpl=0:mnm=0:
 
Goto nextplay222:EndIf 
;push=0
If KeyboardPushed(#PB_Key_Escape):Gosub escc:EndIf 
If spid3=1:Goto susus:EndIf 
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=97 And tur()\swo=play And tur()\x<>tur()\x2:Goto susus:EndIf 
Wend 

ExamineMouse() 
 
 xmm = MouseX()                         
 ymm = MouseY() 




If xyraz=31
If KeyboardPushed(#PB_Key_Left) And c<128:c+16:push=1:EndIf  
If KeyboardPushed(#PB_Key_Right) And c>-1048:c-16::push=1:EndIf  
If KeyboardPushed(#PB_Key_Up) And d<100:d+16:push=1:EndIf 
If KeyboardPushed(#PB_Key_Down) And d>-1128+500:d-16:push=1:EndIf 
If xmm<=16 And c<128:c+16:push=1:EndIf  
If xmm=>xraz-16 And c>-1048:c-16::push=1:EndIf   
If ymm<16 And d<100:d+16:push=1:EndIf 
If ymm>yraz-16 And d>-1128+500:d-16:push=1:EndIf 
EndIf 

If xyraz=32
If KeyboardPushed(#PB_Key_Left) And c<128:c+16:push=1:EndIf  
If KeyboardPushed(#PB_Key_Right) And c>-1048:c-16::push=1:EndIf  
If KeyboardPushed(#PB_Key_Up) And d<0:d+16:push=1:EndIf 
If KeyboardPushed(#PB_Key_Down) And d>-1128-100:d-16:push=1:EndIf 
If xmm<=16 And c<128:c+16:push=1:EndIf  
If xmm=>xraz-16 And c>-1048:c-16::push=1:EndIf  
If ymm<16 And d<100:d+16:push=1:EndIf 
If ymm>yraz-16 And d>-1128-100:d-16:push=1:EndIf 
EndIf 


If xyraz=48
  If xmm<=16 And c<128:c+16:push=1:EndIf  
  If ymm<16 And d<100:d+16:push=1:EndIf 
  If xmm=>xraz-16 And c>-1048-280:c-16::push=1:EndIf  
  If ymm>yraz-16 And d>-1128-290:d-16:push=1:EndIf 
If KeyboardPushed(#PB_Key_Left) And c<128:c+16:push=1:EndIf  
If KeyboardPushed(#PB_Key_Right) And c>-1048-280:c-16::push=1:EndIf  
If KeyboardPushed(#PB_Key_Up) And d<0:d+16:push=1:EndIf 
If KeyboardPushed(#PB_Key_Down) And d>-1128-290:d-16:push=1:EndIf 

EndIf 



If xyraz=65
  If xmm<=16 And c<128:c+16:push=1:EndIf  
  If ymm<16 And d<100:d+16:push=1:EndIf 
  If xmm=>xraz-16 And c>-1048-500:c-16::push=1:EndIf  
  If ymm>yraz-16 And d>-1128-100:d-16:push=1:EndIf 
If KeyboardPushed(#PB_Key_Left) And c<128:c+16:push=1:EndIf  
If KeyboardPushed(#PB_Key_Right) And c>-1048-500:c-16::push=1:EndIf  
If KeyboardPushed(#PB_Key_Up) And d<0:d+16:push=1:EndIf 
If KeyboardPushed(#PB_Key_Down) And d>-1128-100:d-16:push=1:EndIf 

EndIf 


If xyraz=64
  If xmm<=16 And c<128:c+16:push=1:EndIf  
  If ymm<16 And d<100:d+16:push=1:EndIf 
  If xmm=>xraz-16 And c>-1048-500:c-16::push=1:EndIf  
  If ymm>yraz-16 And d>-1128-700:d-16:push=1:EndIf 
If KeyboardPushed(#PB_Key_Left) And c<128:c+16:push=1:EndIf  
If KeyboardPushed(#PB_Key_Right) And c>-1048-500:c-16::push=1:EndIf  
If KeyboardPushed(#PB_Key_Up) And d<0:d+16:push=1:EndIf 
If KeyboardPushed(#PB_Key_Down) And d>-1128-700:d-16:push=1:EndIf 

EndIf 


If KeyboardPushed(#PB_Key_Return) And endturr=0 And delor2=0 And iko=0 And shop1=0 And displayb=0:nextpl=0:mnm=0:Goto nextplay222:EndIf 

If KeyboardPushed(#PB_Key_M) And delor2=0 And endturr=0 And iko=0 And shop1=0 And bot=0 And displayb=0:shop1=1:EndIf 

susus:


If spid3=1:spid2=32:spid=32:EndIf 
If push=1:Goto susu:EndIf
Gosub ece
If spid3=0:
c=xti
d=yti

Goto susu
EndIf 
If xti>c And c<128+96:c+spid2:EndIf  
If xti<c And c>-2350:c-spid2::EndIf  
If yti>d And d<0:d+spid::EndIf 
If yti<d And d>-2200:d-spid:EndIf 

susu:
WaitWindowEvent()

If prygnum>0:prygnum-1:EndIf 
If MouseButton(#PB_MouseButton_Middle) And iko=0 And shop1=0 And bot=0 And delor2=0 And endturr=0:
  c=xti
d=yti
prygnum=40
Gosub a222:space=1:EndIf 

  
  
  
  
If KeyboardPushed(#PB_Key_Space) And iko=0 And shop1=0 And bot=0 And delor2=0 And endturr=0:
c=xti
d=yti
prygnum=40
Gosub a222:space=1:EndIf 

If botdjump=1 And iko=0 And shop1=0 And bot=1 And delor2=0 And endturr=0:
c=xti
d=yti
 botdjump=0
Gosub a222:space=1:EndIf 




ExamineMouse() 
 
 xm3 = MouseX()                         
 ym3 = MouseY() 
 mnm=0
 If nextpl=1 And xm3>260 And xm3<260+30 And ym3>yraz-yraz/2+30 And ym3<yraz-yraz/2+35+25:mnm=1:EndIf 
 If nextpl=1 And xm3>260+30+10 And xm3<260+30+12+48 And ym3>yraz-yraz/2+30 And ym3<yraz-yraz/2+35+25:mnm=2:EndIf 

 ExamineMouse() 
 If MouseButton(1) And nextpl=1:Goto sss:EndIf 

 If bot=0:
 xm = MouseX()                         
 ym = MouseY() 
 EndIf 
 xm-c:ym-d
xm/48:xm*48
ym/48:ym*48
xm33=xm
ym33=ym
 If bot=0:
 xm = MouseX()                         
 ym = MouseY() 
 EndIf 

If xm3<360 And ym3>yraz-124:Gosub ikonka:EndIf

If tur3()\bot=0:DisplayTransparentSprite(1, xm, ym):EndIf 
anim2+1
anim22+1
If anim2=4:
anim+1
anim3+1
anim4+1
If anim=9:anim=0:EndIf 
If anim4=7:anim4=0:EndIf
If anim3=10:anim3=0:EndIf 
anim2=0
EndIf 
If anim22=10:
anim5+1
If anim5=3:anim5=0:EndIf 
anim22=0
EndIf 

If iko>1:iko-1:EndIf 
ExamineMouse() 
xm-c:ym-d

If tur3()\bot=1 And ikom=1:ikom=0:Goto moik:EndIf 

If MouseButton(1)  And iko=1:
Goto moik
EndIf 

If MouseButton(1)  And spid3=0 And iko=0 And shop1=0 And bot=0 And nextpl=0 And displayb=0 And delor2=0 And endturr=0

If xm3<340 And ym3>yraz-124:Return:EndIf



ResetList( tur() ) 

 While NextElement( tur())
If tur()\nom=97 And tur()\swo=play And xm>0 And xm<xyraz*48 And diss=0:
xm/tur()\spid:xm*tur()\spid
xm33=xm
tur()\x2=xm33:
Return:EndIf 

Wend

EndIf 

ExamineKeyboard()
If KeyboardPushed(#PB_Key_Tab) Or KeyboardPushed(#PB_Key_LeftShift):
 
c=xti
d=yti
:EndIf
Return 


sss:
 ExamineMouse() 
 If MouseButton(1):Goto sss:EndIf 
 If  mnm=0 And ym3<yraz-60:nextpl=0:EndIf 
 If  mnm=2:nextpl=0:EndIf 
 If  mnm=1 And nextpl=1:nextpl=0:mnm=0:nextlp=1:EndIf 
 Return 
prp:
If nextpl=1:DisplayTransparentSprite(1010, 200, yraz-yraz/2):
  StartDrawing( ScreenOutput())
  
   If lang=0
  DrawingFont(FontID(1)) 
  DrawingMode(#PB_2DDrawing_XOr )
 
If mnm=1:DrawText(260,yraz-yraz/2+35 , "Да", RGB((0),(0),(0)) ):EndIf 
If mnm=2:DrawText(260+12+30,yraz-yraz/2+35 , "Нет", RGB((0),(0),(0)) ):EndIf 
  
DrawingMode(#PB_2DDrawing_Transparent )
DrawingFont(FontID(0)) 

DrawText(250,yraz-yraz/2+5 , ENDTURN$, RGB((255),(200),(100)) )
DrawingFont(FontID(1)) 
DrawText(260,yraz-yraz/2+35 , YES$, RGB((255),(200),(100)) )
DrawText(260+30,yraz-yraz/2+35 , "/", RGB((255),(200),(100)) )
DrawText(260+12+30,yraz-yraz/2+35 , NO$, RGB((255),(200),(100)) )
EndIf 
   ;If lang=1
  ;DrawingFont(FontID(1)) 
  ;DrawingMode(#PB_2DDrawing_XOr )
 
;If mnm=1:DrawText(260,yraz-yraz/2+35 , "Yes", RGB((0),(0),(0)) ):EndIf 
;If mnm=2:DrawText(260+12+30,yraz-yraz/2+35 , "No", RGB((0),(0),(0)) ):EndIf 
  
;DrawingMode(#PB_2DDrawing_Transparent )
;DrawingFont(FontID(0)) 

;DrawText(265,yraz-yraz/2+5 , "End turn ? ", RGB((255),(200),(100)) )
;DrawingFont(FontID(1)) 
;DrawText(257,yraz-yraz/2+35 , "Yes", RGB((255),(200),(100)) )
;DrawText(260+33,yraz-yraz/2+35 , "/", RGB((255),(200),(100)) )
;DrawText(260+12+30,yraz-yraz/2+35 , "No", RGB((255),(200),(100)) )
;EndIf 

  StopDrawing() 

EndIf 


Return 



sdwig:
ResetList( tur3() ) 
While NextElement( tur3())
If tur3()\pnom=play:
If tur3()\slot1a=0:
tur3()\slot1a=or2a
tur3()\slot2a=0
EndIf 
If tur3()\slot2a=0:
tur3()\slot2a=or3a
tur3()\slot3a=0
EndIf 
If tur3()\slot3a=0:
tur3()\slot3a=or4a
tur3()\slot4a=0
EndIf 
EndIf 
Wend 
Return 

;--------------------wykinx:
wykinx:
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=500 And tur()\swo=play And tur()\gravitator<>0:Return:EndIf 
Wend 
ResetList( tur3() ) 
While NextElement( tur3())
If tur3()\pnom=play:
tur3()\slot1a=0:or111=or1a
EndIf 
Wend 
Goto wykin23:
wykinx2:
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=500 And tur()\swo=play And tur()\gravitator<>0:Return:EndIf 
Wend 
ResetList( tur3() ) 
While NextElement( tur3())
If tur3()\pnom=play:
tur3()\slot2a=0:or111=or2a
EndIf 
Wend 
Goto wykin23:
wykinx3:
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=500 And tur()\swo=play And tur()\gravitator<>0:Return:EndIf 
Wend 
ResetList( tur3() ) 
While NextElement( tur3())
If tur3()\pnom=play:or111=or3a
tur3()\slot3a=0:
EndIf 
Wend 
Goto wykin23:
wykinx4:
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=500 And tur()\swo=play And tur()\gravitator<>0:Return:EndIf 
Wend 
ResetList( tur3() ) 
While NextElement( tur3())
If tur3()\pnom=play:or111=or4a
tur3()\slot4a=0:
EndIf 
Wend 
Goto wykin23:

;---------------wzalart
wzalart:
 *Old_Element3 = @tur()
xl=tx-17
yl=ty
AddElement(tur())
tur()\x=xl+32
tur()\y=yl

If Random(2)=0:
ororor=Random(17)

tur()\y2=37
tur()\nom=ororor+970
aaaa.f=-1
tur()\zap=aaaa.f
 ChangeCurrentElement(tur(), *Old_Element3)
Return 
EndIf 
tur()\y2=35
tur()\nom=67
aaaa.f=-1
tur()\zap=aaaa.f
 ChangeCurrentElement(tur(), *Old_Element3)
Return 


wykin23:
Gosub sdwig
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=500 And tur()\swo=play:Goto wykinx22:EndIf 
Wend 
Return 


wykinx22:
If or111=970:tur()\energ2-1:EndIf 
xl=tur()\x
yl=tur()\y
NextElement(tur()) 
AddElement(tur())
tur()\x=xl+32
tur()\y=yl
tur()\y2=37
tur()\nom=or111
aaaa.f=-1
tur()\zap=aaaa.f
Gosub minusa
Return 

wykinx222:
If or111=970:tur()\energ2-1:EndIf 
xl=tur()\x-8+Random(16)
NextElement(tur()) 
AddElement(tur())
tur()\x=xl+32
tur()\y=yl
tur()\y2=37
tur()\nom=or111
aaaa.f=-1
tur()\zap=aaaa.f
Gosub minusa222
PreviousElement(tur())
Return 

upastx:
If tur()\y2>0:
X666q.f=5
Y666q.f=5
aaaaq.f=tur()\zap.f
aaaaq.f+0.1
tur()\zap.f=aaaaq.f
x23666q.f = X666q*Cos(aaaaq.f) + Y666q*Sin(aaaaq.f)
y23666q.f = X666q*Sin(aaaaq.f) - Y666q*Cos(aaaaq.f)
tur()\y2-1:tur()\y+y23666q.f:EndIf 
Return 



ikonka:


oror=0
ExamineMouse() 
If MouseButton(1) And level3=225 And delor2=0 And endturr=0 And iko=0 And shop1=0 And bot=0 And displayb=0:level3=0:nextpl=1:Return:EndIf 


If MouseButton(1) And level3=226 And delor2=0 And endturr=0 And iko=0 And shop1=0 And bot=0 And displayb=0:level3=0:
  oq:
  ExamineMouse() 
  If MouseButton(1) :Goto oq:EndIf 
shop1=1:Return:EndIf 


If MouseButton(1) And bot=0 And ym3>yraz-124+22+55 And ym3<yraz-124+50+55 And xm3<50-8+32+64+32 And xm3>12 And displayb=0:
If or1a>0 And level2=1 And naval=0:Gosub wykinx:EndIf 
If or2a>0 And level2=2 And naval=0:Gosub wykinx2:EndIf 
If or3a>0 And level2=3 And naval=0:Gosub wykinx3:EndIf 
If or4a>0 And level2=4 And naval=0:Gosub wykinx4:EndIf 
naval=1
Goto ikonkaaa:
EndIf 
If or8=0:oror=32:EndIf 
If or7=0:oror=64:EndIf 
If or6=0:oror=96:EndIf 
If or5=0:oror=128:EndIf 
If or4=0:oror=128+32:EndIf 
If or3=0:oror=128+64:EndIf 
If or2=0:oror=128+96:EndIf 

If MouseButton(1) And bot=0 And ym3>yraz-124+22-6 And ym3<yraz-124+52 And xm3<230+14+32-oror And xm3>20:

If or1>0 And level2=0:level=level2:weapon=tur3()\slot1:ax=tur3()\slot1p:EndIf 
If or2>0 And level2=32:level=level2:weapon=tur3()\slot2:ax=tur3()\slot2p:EndIf 
If or3>0 And level2=64:level=level2:weapon=tur3()\slot3:ax=tur3()\slot3p:EndIf 
If or4>0 And level2=96:level=level2:weapon=tur3()\slot4:ax=tur3()\slot4p:EndIf 
If or5>0 And level2=128:level=level2:weapon=tur3()\slot5:ax=tur3()\slot5p:EndIf 
If or6>0 And level2=160:level=level2:weapon=tur3()\slot6:ax=tur3()\slot6p:EndIf 
If or7>0 And level2=192:level=level2:weapon=tur3()\slot7:ax=tur3()\slot7p:EndIf 
If or8>0 And level2=224:level=level2:weapon=tur3()\slot8:ax=tur3()\slot8p:EndIf 

tur3()\kakoj=level2
EndIf 


naval=0
ikonkaaa:

StartDrawing( ScreenOutput())

DrawingMode(#PB_2DDrawing_XOr )
a=0
If or1>0 And xm3=>20 And xm3<50 And ym3>yraz-124+22-6 And ym3<yraz-124+52:Box(20,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level2=0:a=tur3()\slot1p:all=tur3()\slot1:Goto oqo:EndIf 
If Or2>0 And xm3=>50 And xm3<82 And ym3>yraz-124+22-6 And ym3<yraz-124+52:Box(52,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level2=32:a=tur3()\slot2p:all=tur3()\slot2:Goto oqo:EndIf 
If or3>0 And xm3=>82 And xm3<114 And ym3>yraz-124+22-6 And ym3<yraz-124+52:Box(84,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level2=64:a=tur3()\slot3p:all=tur3()\slot3:Goto oqo:EndIf 
If or4>0 And xm3=>114 And xm3<146 And ym3>yraz-124+22-6 And ym3<yraz-124+52:Box(116,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level2=96:a=tur3()\slot4p:all=tur3()\slot4:Goto oqo:EndIf 
If or5>0 And xm3=>146 And xm3<178 And ym3>yraz-124+22-6 And ym3<yraz-124+52:Box(148,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level2=128:a=tur3()\slot5p:all=tur3()\slot5:Goto oqo:EndIf 
If or6>0 And xm3=>178 And xm3<210 And ym3>yraz-124+22-6 And ym3<yraz-124+52:Box(170+10,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level2=160:a=tur3()\slot6p:all=tur3()\slot6:Goto oqo:EndIf 
If or7>0 And xm3=>210 And xm3<242 And ym3>yraz-124+22-6 And ym3<yraz-124+52:Box(200+12,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level2=192:a=tur3()\slot7p:all=tur3()\slot7:Goto oqo:EndIf 
If or8>0 And xm3=>242 And xm3<244+35 And ym3>yraz-124+22-6 And ym3<yraz-124+52:Box(230+14,yraz-124+22-6, 30, 30, RGB(0, 0, 0)):level2=224:a=tur3()\slot8p:all=tur3()\slot8:Goto oqo:EndIf 




level3=0
If xm3>244+56+23 And xm3<244+56+32+23 And ym3>yraz-124+77 And ym3<yraz-124+77+32:Box(230+14+56+23,yraz-124+77, 30, 30, RGB(0, 0, 0)):level3=225:EndIf 
If xm3>244+56-11 And xm3<244+56+32-11 And ym3>yraz-124+77 And ym3<yraz-124+77+32:Box(230+14+56-11,yraz-124+77, 30, 30, RGB(0, 0, 0)):level3=226:EndIf 


If xm3>20-8 And xm3<50-8 And ym3>yraz-124+22+55 And ym3<yraz-124+52+55:Box(12,yraz-124+22+55, 30, 30, RGB(0, 0, 0)):level2=1:Gosub prm1a:EndIf 
If xm3>20-8+32 And xm3<50-8+32 And ym3>yraz-124+22+55 And ym3<yraz-124+52+55:Box(12+32,yraz-124+22+55, 30, 30, RGB(0, 0, 0)):level2=2:Gosub prm2a:EndIf 
If xm3>20-8+64 And xm3<50-8+64 And ym3>yraz-124+22+55 And ym3<yraz-124+52+55:Box(12+64,yraz-124+22+55, 30, 30, RGB(0, 0, 0)):level2=3:Gosub prm3a:EndIf 
If xm3>20-8+32+64 And xm3<50-8+32+64 And ym3>yraz-124+22+55 And ym3<yraz-124+52+55:Box(12+32+64,yraz-124+22+55, 30, 30, RGB(0, 0, 0)):level2=4:Gosub prm4a:EndIf 
StopDrawing() 
Return 
oqo:
If ym3>yraz-124+22-6 And ym3<yraz-124+52 And xm3>20 And xm3<224+54 And all=>900

DrawingFont(FontID(2)) 
DrawingMode(#PB_2DDrawing_Transparent )
b=TextWidth("00000")
bb=TextWidth(Str(a))
bbb=b-bb
DrawText(21+1+level2+bbb, yraz-76+1 , Str(a), RGB((0),(0),(0)) )
DrawText(21+level2+bbb, yraz-76 , Str(a), RGB((180),(180),(180)) )
:EndIf 

StopDrawing() 
Return 
;----------------------артефакты
prm1a:
DrawingFont(FontID(2)) 
If or1a=0:Return:EndIf 
DrawingMode(#PB_2DDrawing_Default )
Box(11,yraz-124+22+55-101, 302, 82, RGB(255, 255, 255))
Box(12,yraz-124+22+55-100, 300, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent)
If or1a=970:Gosub prm1:EndIf  
If or1a=971:Gosub prm2:EndIf 
If or1a=972:Gosub prm3:EndIf 
If or1a=973:Gosub prm4:EndIf 
If or1a=974:Gosub prm5:EndIf 
If or1a=975:Gosub prm6:EndIf 
If or1a=976:Gosub prm7:EndIf 
If or1a=977:Gosub prm8:EndIf 
If or1a=978:Gosub prm9:EndIf 
If or1a=979:Gosub prm10:EndIf 
If or1a=980:Gosub prm11:EndIf 
If or1a=981:Gosub prm12:EndIf 
If or1a=982:Gosub prm13:EndIf 
If or1a=983:Gosub prm14:EndIf 
If or1a=984:Gosub prm15:EndIf 
If or1a=985:Gosub prm16:EndIf 
If or1a=986:Gosub prm17:EndIf 
If or1a=987:Gosub prm18:EndIf 
DrawingMode(#PB_2DDrawing_XOr )
Return 
prm2a:
DrawingFont(FontID(2)) 
If or2a=0:Return:EndIf 
DrawingMode(#PB_2DDrawing_Default )
Box(11,yraz-124+22+55-101, 302, 82, RGB(255, 255, 255))
Box(12,yraz-124+22+55-100, 300, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent)
If or2a=970:Gosub prm1:EndIf  
If or2a=971:Gosub prm2:EndIf 
If or2a=972:Gosub prm3:EndIf 
If or2a=973:Gosub prm4:EndIf 
If or2a=974:Gosub prm5:EndIf 
If or2a=975:Gosub prm6:EndIf 
If or2a=976:Gosub prm7:EndIf 
If or2a=977:Gosub prm8:EndIf 
If or2a=978:Gosub prm9:EndIf 
If or2a=979:Gosub prm10:EndIf 
If or2a=980:Gosub prm11:EndIf 
If or2a=981:Gosub prm12:EndIf 
If or2a=982:Gosub prm13:EndIf 
If or2a=983:Gosub prm14:EndIf 
If or2a=984:Gosub prm15:EndIf 
If or2a=985:Gosub prm16:EndIf 
If or2a=986:Gosub prm17:EndIf 
If or2a=987:Gosub prm18:EndIf 
DrawingMode(#PB_2DDrawing_XOr )
Return 
prm3a:
DrawingFont(FontID(2)) 
If or3a=0:Return:EndIf 
DrawingMode(#PB_2DDrawing_Default )
Box(11,yraz-124+22+55-101, 302, 82, RGB(255, 255, 255))
Box(12,yraz-124+22+55-100, 300, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent)
If or3a=970:Gosub prm1:EndIf  
If or3a=971:Gosub prm2:EndIf 
If or3a=972:Gosub prm3:EndIf
If or3a=973:Gosub prm4:EndIf 
If or3a=974:Gosub prm5:EndIf 
If or3a=975:Gosub prm6:EndIf 
If or3a=976:Gosub prm7:EndIf 
If or3a=977:Gosub prm8:EndIf 
If or3a=978:Gosub prm9:EndIf 
If or3a=979:Gosub prm10:EndIf 
If or3a=980:Gosub prm11:EndIf 
If or3a=981:Gosub prm12:EndIf 
If or3a=982:Gosub prm13:EndIf 
If or3a=983:Gosub prm14:EndIf 
If or3a=984:Gosub prm15:EndIf 
If or3a=985:Gosub prm16:EndIf 
If or3a=986:Gosub prm17:EndIf 
If or3a=987:Gosub prm18:EndIf 
DrawingMode(#PB_2DDrawing_XOr )
Return 
prm4a:
DrawingFont(FontID(2)) 
If or4a=0:Return:EndIf 
DrawingMode(#PB_2DDrawing_Default )
Box(11,yraz-124+22+55-101, 302, 82, RGB(255, 255, 255))
Box(12,yraz-124+22+55-100, 300, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent)
If or4a=970:Gosub prm1:EndIf  
If or4a=971:Gosub prm2:EndIf 
If or4a=972:Gosub prm3:EndIf 
If or4a=973:Gosub prm4:EndIf 
If or4a=974:Gosub prm5:EndIf 
If or4a=975:Gosub prm6:EndIf 
If or4a=976:Gosub prm7:EndIf 
If or4a=977:Gosub prm8:EndIf 
If or4a=978:Gosub prm9:EndIf 
If or4a=979:Gosub prm10:EndIf 
If or4a=980:Gosub prm11:EndIf 
If or4a=981:Gosub prm12:EndIf 
If or4a=982:Gosub prm13:EndIf 
If or4a=983:Gosub prm14:EndIf 
If or4a=984:Gosub prm15:EndIf 
If or4a=985:Gosub prm16:EndIf 
If or4a=986:Gosub prm17:EndIf 
If or4a=987:Gosub prm18:EndIf 
DrawingMode(#PB_2DDrawing_XOr )
Return 


prm1:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Мухомор.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Выдра становится берсерком.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Броня:", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+48, "Сила:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Amanita.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Otter is berserk.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Armor:", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+48, "Force:", RGB(0,0,0))
EndIf 
DrawText(20+50,yraz-124+22+55-95+32, "+1", RGB(100,0,0))
DrawText(20+50,yraz-124+22+55-95+48, "+1", RGB(100,0,0))
Return 
prm2:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Волшебная лампа.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Увеличивает богатство.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Добыча кристалов:", RGB(0,0,0))
EndIf 

If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Magic Lamp.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Increases the wealth.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Mining crystals:", RGB(0,0,0))
EndIf 
DrawText(75+80,yraz-124+22+55-95+32, "+4", RGB(100,0,0))
Return 
prm3:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Желтая кровь.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Восстанавливает здоровье.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Здоровье:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Yellow blood.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Recovers.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Health:", RGB(0,0,0))
EndIf 

DrawText(45+50,yraz-124+22+55-95+32, "+1", RGB(100,0,0))
Return 
prm4:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Красная кровь.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Восстанавливает здоровье.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Здоровье:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Red blood.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Recovers.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Health:", RGB(0,0,0))
EndIf 
DrawText(45+50,yraz-124+22+55-95+32, "+2", RGB(100,0,0))
Return 
prm5:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Зелье из рыбы.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Повышает прыгучесть.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Гравитация:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Potion of fish.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Increases jumping.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Gravitation:", RGB(0,0,0))
EndIf 
DrawText(45+60,yraz-124+22+55-95+32, "+3", RGB(100,0,0))
Return 
prm6:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Кошелек.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Увеличивает богатство.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Добыча кристалов:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Purse.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Increases the wealth.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Mining crystals:", RGB(0,0,0))
EndIf 
DrawText(75+80,yraz-124+22+55-95+32, "+1", RGB(100,0,0))
Return 
prm7:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Синяя кровь.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Восстанавливает здоровье.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Здоровье:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Blue blood.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Recovers.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Health:", RGB(0,0,0))
EndIf 
DrawText(45+50,yraz-124+22+55-95+32, "+3", RGB(100,0,0))
Return 
prm8:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Морковь.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Вызывает дух кролика.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Гравитация:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Carrots.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Calls the spirit of the rabbit.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Gravitation:", RGB(0,0,0))
EndIf 
DrawText(45+60,yraz-124+22+55-95+32, "+1", RGB(100,0,0))
Return 
prm9:
If lang=0
  DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Болотная жаба.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Вызывает дух жабы.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Гравитация:", RGB(0,0,0))
  EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Swamp toad.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Calls the spirit of swamp toads.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Gravitation:", RGB(0,0,0))
EndIf 
DrawText(45+60,yraz-124+22+55-95+32, "+5", RGB(100,0,0))
Return 
prm10:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Меч злого хорька.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Повышает злость.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Сила:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Sword of the evil ferret.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Raises anger.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Force:", RGB(0,0,0))
EndIf 
DrawText(40+20,yraz-124+22+55-95+32, "+3", RGB(100,0,0))
Return 
prm11:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Ящик боеприпасов.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Восстанавливает некоторые боеприпасы.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Боеприпасы:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Box of ammunition.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Restores some ammo.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Ammo:", RGB(0,0,0))
EndIf 
DrawText(40+70,yraz-124+22+55-95+32, "+1", RGB(100,0,0))
Return 
prm12:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Наливное яблочко.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Прибавляет выносливости. Освежает.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Ходьба:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Filler apple.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Adds stamina.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Walking:", RGB(0,0,0))
EndIf 
DrawText(40+40,yraz-124+22+55-95+32, "+1", RGB(100,0,0))
Return 
prm13:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Тухлая рыба.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Повышает имунитет к лучевому оружию.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Имунитет:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Rotten fish.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Increases immunity to radiation weapons.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Immunity:", RGB(0,0,0))
EndIf 
DrawText(40+50,yraz-124+22+55-95+32, "+2", RGB(100,0,0))
Return 

prm14:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Какашка лисички-фенька.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Вырабатывает имунитет к взрывам.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Имунитет:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Turd chanterelles - Fennec.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Produces immunity to explosions.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Immunity:", RGB(0,0,0))
EndIf 
DrawText(40+50,yraz-124+22+55-95+32, "+3", RGB(100,0,0))
Return 

prm15:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Корона морской выдры.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16-2, "Просветляет.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32-4, "Броня:", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+48-6, "Сила:", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+64-8, "Меткость:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Crown of the sea otter.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16-2, "Clarify.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32-4, "Armor:", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+48-6, "Force:", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+64-8, "Accuracy:", RGB(0,0,0))
EndIf 
DrawText(20+50,yraz-124+22+55-95+32-4, "+2", RGB(100,0,0))
DrawText(20+50,yraz-124+22+55-95+48-6, "+2", RGB(100,0,0))
DrawText(20+70,yraz-124+22+55-95+64-8, "+4", RGB(100,0,0))
Return 

prm16:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Древний доспех.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Делает выдру отважной.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Броня:", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+48, "Сила:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Ancient armor.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Adds bravery.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Armor:", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+48, "Force:", RGB(0,0,0))
EndIf 
DrawText(20+50,yraz-124+22+55-95+32, "+5", RGB(100,0,0))
DrawText(20+50,yraz-124+22+55-95+48, "+2", RGB(100,0,0))
Return 

prm17:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Ботинки.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Повышают выносливость.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Ходьба:", RGB(0,0,0))
DrawText(20+60,yraz-124+22+55-95+32, "+3", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+48, "Гравитация:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Boots.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Increase endurance.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Walking:", RGB(0,0,0))
DrawText(20+60,yraz-124+22+55-95+32, "+3", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+48, "Gravitation:", RGB(0,0,0))
EndIf 

DrawText(20+85,yraz-124+22+55-95+48, "+1", RGB(100,0,0))
Return 

prm18:
If lang=0
DrawText(20,yraz-124+22+55-95, "Артефакт:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Кожаный щит.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Увеличивает броню.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Броня:", RGB(0,0,0))
EndIf 
If lang=1
DrawText(20,yraz-124+22+55-95, "Artifact:", RGB(0,0,0))
DrawText(90,yraz-124+22+55-95, "Leather shield.", RGB(100,0,0))
DrawText(20,yraz-124+22+55-95+16, "Increases armor.", RGB(0,0,0))
DrawText(20,yraz-124+22+55-95+32, "Armor:", RGB(0,0,0))
EndIf 
DrawText(20+50,yraz-124+22+55-95+32, "+3", RGB(100,0,0))
Return 

mou:
 ExamineMouse() 
If MouseButton(2) :Goto mou:EndIf 
ResetList( tur() ) 
While NextElement( tur())
 If SpriteCollision(obx, xm3, ym3, tur()\nom, tur()\x, tur()\y): DeleteElement( tur() ):Return:EndIf   
Wend
Return 


sraw:
Return 

























 oknono:
 If okno=1:
 xmz= MouseX()                        
 ymz = MouseY() 
 DisplayTransparentSprite(1, xm, ym)
 
 xmz/48
ymz/48
  If MouseButton(1) 
  If xmz=16 And ymz=0:obx=10:EndIf 
    If xmz=17 And ymz=0:obx=51:EndIf 
    If xmz=18 And ymz=0:obx=50:EndIf 
    If xmz=19 And ymz=0:obx=52:EndIf 
       If xmz=16 And ymz=1:obx=53:EndIf 
            If xmz=17 And ymz=1:obx=58:EndIf 
             If xmz=18 And ymz=1:obx=67:EndIf 
                      If xmz=19 And ymz=1:obx=21:EndIf 
                      If xmz=16 And ymz=2:obx=100:EndIf 
                         If xmz=17 And ymz=2:obx=84:EndIf 
                          If xmz=18 And ymz=2:obx=120:EndIf 
                             If xmz=16 And ymz=3:obx=92:EndIf 
                               If xmz=16 And ymz=4:obx=200:EndIf 
                                 If xmz=17 And ymz=4:obx=220:EndIf 
                                   If xmz=18 And ymz=4:obx=250:EndIf 
           
           
  EndIf 
EndIf 
Return 








w1:
ExamineKeyboard()
If obx=30:obx=49:EndIf 
If KeyboardPushed(#PB_Key_W):Goto w1:EndIf 
obx+1
Return 
s1:
If obx=50:obx=31:EndIf 
ExamineKeyboard()
If KeyboardPushed(#PB_Key_S):Goto s1:EndIf 
If obx>10:obx-1:EndIf 
Return 
 











text:
StartDrawing( ScreenOutput() )
DrawingFont(FontID(4)) 
      DrawingMode(1)
      
      
  
   DrawText(xp, yp, a$, RGB((0),(0),(0)) )

      
   StopDrawing()


Return 


f1:
ExamineKeyboard()
If KeyboardPushed(#PB_Key_F1):Goto f1:EndIf 
If okno=1:okno=0:Return:EndIf 
If okno=0:okno=1:Return:EndIf 
Return 



okno:
 xmm = MouseX()                         
 ymm = MouseY() 
 xmm+48
 xmm/48:xmm*48
ymm/48:ymm*48
StartDrawing( ScreenOutput() )

      DrawingMode(1)
      Box(800-70,0,256+8,1024+8,RGB((200),(200),(200)))


  If xmm>730 :Box(xmm-48,ymm+16,48,48,RGB((255),(0),(255))):EndIf 

   StopDrawing()
   
   
  DisplayTransparentSprite(10, 768, 16)
  DisplayTransparentSprite(51, 768+48, 16)
  DisplayTransparentSprite(50, 768+48+48, 16)
  DisplayTransparentSprite(52, 768+96+48, 16)
   DisplayTransparentSprite(53, 768, 16+48)
     DisplayTransparentSprite(58, 768+48, 16+48)
          DisplayTransparentSprite(67, 768+48+48, 16+48)
           DisplayTransparentSprite(21, 768+48+48+48, 16+48)
             DisplayTransparentSprite(100, 768, 16+48+48)
                 DisplayTransparentSprite(84, 768+48, 16+48+48)
                  DisplayTransparentSprite(120, 768+48+48, 16+48+48)
                    DisplayTransparentSprite(92, 768, 16+48+48+48)
            
                       DisplayTransparentSprite(200, 768, 16+48+48+48+48)
                       DisplayTransparentSprite(220, 768+48, 16+48+48+48+48)
                        DisplayTransparentSprite(250, 768+48+48, 16+48+48+48+48)
   
   xp=730:yp=550
a$="Hомер обьекта -"
Gosub text
xp=730:yp=560
a$=Str(obx)
Gosub text
Return 






instal:


Gosub instor

ResetList( tur() ) 
While NextElement( tur())



If tur()\nom=30:Gosub instal2:EndIf 

If tur()\nom=10:Gosub instal22:EndIf 


If tur()\nom=37 Or tur()\nom=34:
x=tur()\x
y=tur()\y
 AddElement( tur() )
  tur()\x = x
  tur()\y = y
  tur()\nom = 96
   AddElement( tur() )
  tur()\x = x+43
  tur()\y = y
  tur()\nom = 96
   AddElement( tur() )
  tur()\x = x
  tur()\y = y+1
  tur()\nom = 96
   AddElement( tur() )
  tur()\x = x+43
  tur()\y = y+1
  tur()\nom = 96
     AddElement( tur() )
  tur()\x = x
  tur()\y = y+2
  tur()\nom = 96
   AddElement( tur() )
  tur()\x = x+43
  tur()\y = y+2
  tur()\nom = 96
EndIf 

If tur()\nom=42 Or tur()\nom=09 Or tur()\nom=10 Or tur()\nom=11 Or tur()\nom=19 Or tur()\nom=12 Or tur()\nom=17 Or tur()\nom=13  Or tur()\nom=16  Or tur()\nom=18  Or tur()\nom=21 Or tur()\nom=22 Or tur()\nom=23 Or tur()\nom=24  Or tur()\nom=25:
x=tur()\x
y=tur()\y
  If tur()\nom=25:y+8:EndIf 
 AddElement( tur() )
  tur()\x = x
  tur()\y = y
  tur()\nom = 96
EndIf 




Wend



Return 

instal22:
x=tur()\x
y=tur()\y
If Random(2)=0:Goto ins1:EndIf 
Return 
 ins1:
 *Old_Element3 = @tur()
 LastElement(tur())
AddElement( tur() )
tur()\x = x
tur()\y = y-48
tur()\nom = 67
If Random(3)=0:tur()\nom=27:EndIf 
 ChangeCurrentElement(tur(), *Old_Element3)
Return 


instal2:

xx=tur()\x
yy=tur()\y

aasz=32
Repeat 


  AddElement( tur2() )
  tur2()\x = tur()\x+Random(48)-8
  tur2()\y = tur()\y+16
  tur2()\xx = tur()\x-8
  tur2()\yy = tur()\y+16
  tur2()\nom = 1
  tur2()\ani = 16+Random(128)
  
  tur2()\tim = 0+Random(8)
    tur2()\tim2= tur2()\tim
    tur2()\pow = Random(3)
      If aasz>0:aasz-1:EndIf 
    Until aasz=0
Return 




print3:

Start3D()
Sprite3DBlendingMode(12, 0)
ResetList( tur2() ) 

While NextElement( tur2())

  If tur2()\nom>0:
  :DisplaySprite3D( tur2()\nom , tur2()\x + c, tur2()\y + d, tur2()\ani):EndIf 
  
  If tur2()\pow=1 And tur2()\tim/2=0: tur2()\x-1:EndIf
    If tur2()\pow=2 And tur2()\tim/2=0: tur2()\x+1:EndIf
  
If tur2()\tim>0: tur2()\tim-1:EndIf
If tur2()\tim=0: tur2()\tim=tur2()\tim2:tur2()\nom+1:EndIf
If tur2()\nom=14:tur2()\nom=1:EndIf 

  If tur2()\ani>0:tur2()\ani-1:tur2()\y-1:EndIf
     If tur2()\ani=0:xx=tur2()\xx:yy=tur2()\yy:DeleteElement( tur2() ): Gosub soz:EndIf 
Wend

ResetList( tur4() ) 

While NextElement( tur4())
If tur4()\nom>0:
If tur4()\nom>0 And tur4()\nom<9 :DisplaySprite3D( tur4()\nom , tur4()\x + c, tur4()\y + d, tur4()\life*10 ):EndIf 
If tur4()\degr=0:tur4()\x+8:tur4()\life-1:EndIf 
If tur4()\degr=1:tur4()\x+8:tur4()\y+8:tur4()\life-1:EndIf
If tur4()\degr=2:tur4()\y+8:tur4()\life-1:EndIf
If tur4()\degr=3:tur4()\x-8:tur4()\y+8:tur4()\life-1:EndIf
If tur4()\degr=4:tur4()\x-8:tur4()\life-1:EndIf
If tur4()\degr=5:tur4()\x-8:tur4()\y-8:tur4()\life-1:EndIf
If tur4()\degr=6:tur4()\y-8:tur4()\life-1:EndIf
If tur4()\degr=7:tur4()\x+8:tur4()\y-8:tur4()\life-1:EndIf
If tur4()\life=0:DeleteElement(tur4() ):EndIf 
EndIf 
Wend 

Stop3D()

Return 


plays2:

PlaySound(1)
Return 















wydra:

;--------------------wydra
If play=tur()\swo :bot=tur()\bot:EndIf 
If play=tur()\swo And tur()\swo2=333:nextlp=1:EndIf 
If tur()\wani=>48 And tur()\wani<64:Goto wydra2:EndIf 
If tur()\wani=>128 :Goto wydra2:EndIf 
If weapon=906 And tur()\wani=25:PlaySound(3):Gosub pulqq6:
  If ax>0:
    tur5()\hto=tur()\swo:
    EndIf   
:EndIf 
If weapon=908 And tur()\wani=25:PlaySound(3):Gosub pulqq66:Gosub pulqq66:Gosub pulqq66:Gosub pulqq66:
  If ax>0:
    tur5()\hto=tur()\swo:
    EndIf   
:EndIf 
If weapon=905 And tur()\wani=71:PlaySound(3):Gosub pulqq5:
  If ax>0:
    tur5()\hto=tur()\swo:
    EndIf   
:EndIf 
If weapon=907 And tur()\wani=71:PlaySound(3):Gosub pulqq5:Gosub pulqq5:Gosub pulqq5:Gosub pulqq5:
  If ax>0:
    tur5()\hto=tur()\swo:
    EndIf   
:EndIf 
If weapon=904 And tur()\wani=25:PlaySound(4):Gosub pulqq4:
  If ax>0:
    tur5()\hto=tur()\swo:
    EndIf   
:EndIf 
If weapon=903 And tur()\wani=>22:PlaySound(1):Gosub pulqq3:
  If ax>0:
    tur5()\hto=tur()\swo:
    EndIf 
EndIf 
If weapon=902 And tur()\wani=25:PlaySound(3):Gosub razrw:
  If ax>0:
    tur5()\hto=tur()\swo:
    EndIf   
:EndIf 
If weapon=901 And tur()\wani>20:Gosub ognem:
  If ax>0:
    tur5()\hto=tur()\swo:
    EndIf   
:EndIf 
If weapon=900 And tur()\wani=25:Gosub plays2:Gosub pulqq:
  If ax>0:
    tur5()\hto=tur()\swo:
    EndIf   
:EndIf 
If weapon=909 And tur()\wani=25:PlaySound(4):Gosub pulqq09:
  If ax>0:
    tur5()\hto=tur()\swo:
    EndIf   
:EndIf 
If weapon=914 And tur()\wani=25:PlaySound(4):Gosub pulqq099:
  If ax>0:
    tur5()\hto=tur()\swo:
    EndIf   
:EndIf 


wydra2:

If weapon=910 And stena=1 And play=tur()\swo:
stena=2:EndIf 
dod=0
If tur()\fox=200:dod=5:EndIf 
dod2=0
If tur()\fox=200:dod2=24:EndIf 


If tur()\magic>0
If tur()\stor=0 And tur()\gravitator=>20 And tur()\upal=>1:DisplayTransparentSprite(639+700, tur()\x + c, tur()\y + d-10):Goto mmm:EndIf 
If tur()\stor=0 And tur()\gravitator=>20 And tur()\upal=0:DisplayTransparentSprite(641+700, tur()\x + c, tur()\y + d-10-10):Goto mmm:EndIf 
If tur()\stor=0 And tur()\gravitator<20 And tur()\gravitator>0:DisplayTransparentSprite(640+700, tur()\x + c, tur()\y + d-10):Goto mmm:EndIf 

If tur()\stor=1 And tur()\gravitator=>20 And tur()\upal=>1:DisplayTransparentSprite(636+700, tur()\x + c, tur()\y + d-10):Goto mmm:EndIf 
If tur()\stor=1 And tur()\gravitator=>20 And tur()\upal=0:DisplayTransparentSprite(638+700, tur()\x + c, tur()\y + d-10-10):Goto mmm:EndIf 
If tur()\stor=1 And tur()\gravitator<20 And tur()\gravitator>0:DisplayTransparentSprite(637+700, tur()\x + c, tur()\y + d-10):Goto mmm:EndIf 

If tur()\stor=0 And tur()\wani=>48 And tur()\wani<64:DisplayTransparentSprite(502+tur()\wani+700 , tur()\x + c, tur()\y + d-10):EndIf 
If tur()\stor=1 And tur()\wani=>48 And tur()\wani<64:DisplayTransparentSprite(502+tur()\wani+8+700 , tur()\x + c+5, tur()\y + d-10):EndIf

If tur()\stor=0 And tur()\wani=>48 And tur()\wani<52:DisplayTransparentSprite(502+tur()\wani+700 , tur()\x + c, tur()\y + d-10):EndIf 
If tur()\stor=1 And tur()\wani=>48 And tur()\wani<52:DisplayTransparentSprite(502+tur()\wani+8+700 , tur()\x + c+5, tur()\y + d-10):EndIf

If tur()\stor=0 And tur()\wani=>16 And tur()\wani<48:DisplayTransparentSprite(500+tur()\wani+700 , tur()\x + c, tur()\y + d-18-10):EndIf 
If tur()\stor=1 And tur()\wani=>16 And tur()\wani<48:DisplayTransparentSprite(500+tur()\wani+16+700 , tur()\x + c+5, tur()\y + d-18-10):EndIf

If tur()\stor=0 And tur()\wani=>64 And tur()\wani<128:DisplayTransparentSprite(500+tur()\wani+700 , tur()\x + c, tur()\y + d-18-10):EndIf 
If tur()\stor=1 And tur()\wani=>64 And tur()\wani<128:DisplayTransparentSprite(500+tur()\wani+12+700 , tur()\x + c+5, tur()\y + d-18-10):EndIf

If tur()\stor=0 And tur()\wani=>128:DisplayTransparentSprite(555+700 , tur()\x + c, tur()\y + d-13):EndIf 
If tur()\stor=1 And tur()\wani=>128:DisplayTransparentSprite(563+700 , tur()\x + c+5, tur()\y + d-13):EndIf
EndIf 

If tur()\magic=0

If tur()\stor=0 And tur()\gravitator=>20 And tur()\upal=>1:DisplayTransparentSprite(639+tur()\fox, tur()\x + c, tur()\y + d-dod2):Goto mmm:EndIf 
If tur()\stor=0 And tur()\gravitator=>20 And tur()\upal=0:DisplayTransparentSprite(641+tur()\fox, tur()\x + c, tur()\y + d-dod2-10):Goto mmm:EndIf 
If tur()\stor=0 And tur()\gravitator<20 And tur()\gravitator>0:DisplayTransparentSprite(640+tur()\fox, tur()\x + c, tur()\y + d-dod2):Goto mmm:EndIf 

If tur()\stor=1 And tur()\gravitator=>20 And tur()\upal=>1:DisplayTransparentSprite(636+tur()\fox, tur()\x + c, tur()\y + d-dod2):Goto mmm:EndIf 
If tur()\stor=1 And tur()\gravitator=>20 And tur()\upal=0:DisplayTransparentSprite(638+tur()\fox, tur()\x + c, tur()\y + d-dod2-10):Goto mmm:EndIf 
If tur()\stor=1 And tur()\gravitator<20 And tur()\gravitator>0:DisplayTransparentSprite(637+tur()\fox, tur()\x + c, tur()\y + d-dod2):Goto mmm:EndIf 

If tur()\stor=0 And tur()\wani=>48 And tur()\wani<64:DisplayTransparentSprite(502+tur()\wani+tur()\fox , tur()\x + c, tur()\y + d-dod2):EndIf 
If tur()\stor=1 And tur()\wani=>48 And tur()\wani<64:DisplayTransparentSprite(502+tur()\wani+8+tur()\fox , tur()\x + c+5, tur()\y + d-dod2):EndIf

If tur()\stor=0 And tur()\wani=>48 And tur()\wani<52:DisplayTransparentSprite(502+tur()\wani+tur()\fox , tur()\x + c, tur()\y + d-dod2):EndIf 
If tur()\stor=1 And tur()\wani=>48 And tur()\wani<52:DisplayTransparentSprite(502+tur()\wani+8+tur()\fox , tur()\x + c+5, tur()\y + d-dod2):EndIf

If tur()\stor=0 And tur()\wani=>16 And tur()\wani<48:DisplayTransparentSprite(500+tur()\wani+tur()\fox , tur()\x + c, tur()\y + d-18-dod):EndIf 
If tur()\stor=1 And tur()\wani=>16 And tur()\wani<48:DisplayTransparentSprite(500+tur()\wani+16+tur()\fox , tur()\x + c+5, tur()\y + d-18-dod):EndIf

If tur()\stor=0 And tur()\wani=>64 And tur()\wani<128:DisplayTransparentSprite(500+tur()\wani+tur()\fox , tur()\x + c, tur()\y + d-18-dod):EndIf 
If tur()\stor=1 And tur()\wani=>64 And tur()\wani<128:DisplayTransparentSprite(500+tur()\wani+12+tur()\fox , tur()\x + c+5, tur()\y + d-18-dod):EndIf

If tur()\stor=0 And tur()\wani=>128:DisplayTransparentSprite(500+tur()\wani+tur()\fox , tur()\x + c, tur()\y + d-dod2):EndIf 
If tur()\stor=1 And tur()\wani=>128:DisplayTransparentSprite(500+tur()\wani+4+tur()\fox , tur()\x + c+5, tur()\y + d-dod2):EndIf
EndIf 
mmm:

Start3D()

;If tur()\upal=0 And tur()\stor=0: RotateSprite3D(tur()\nom+tur()\wani, 370, 0):EndIf 
;If tur()\upal=1 And tur()\stor=0: RotateSprite3D(tur()\nom+tur()\wani, 360, 0):EndIf 
;If tur()\upal=1 And tur()\stor=1: RotateSprite3D(tur()\nom+tur()\wani+8, 370, 0):EndIf 
;If tur()\upal=0 And tur()\stor=1: RotateSprite3D(tur()\nom+tur()\wani+8, 370, 0):EndIf 
;If tur()\gravitator>20 And space=1 And tur()\stor=0: RotateSprite3D(tur()\nom+tur()\wani, 350, 0):EndIf 
; If tur()\gravitator>20 And space=1 And tur()\stor=1: RotateSprite3D(tur()\nom+tur()\wani+8, 350, 0):EndIf 

;If weapon=910:ZoomSprite3D(1011, fyr, fyr):EndIf 

If weapon=910 And play=tur()\swo:
  
  If tur()\y<8:kras=1:
:EndIf 
  
   ExamineMouse() 
   xmz = MouseX()                         
   ymz = MouseY() 
   xmz-c:ymz-d
   xmz/48:xmz*48
   ymz/48:ymz*48
kras=0
    *Old_Element33 = @tur()
  
   ResetList( tur() ) 
   While NextElement( tur())
     If  tur()\nom=>9 And tur()\nom<=77 And SpriteCollision(21, xmz, ymz-2, tur()\nom, tur()\x, tur()\y):

:kras=1:
:EndIf 

  Wend
  ChangeCurrentElement(tur(), *Old_Element33)
  If xmz+96<tur()\x Or  xmz-128>tur()\x:kras=1:EndIf 
  If ymz+96<tur()\y Or  ymz-128>tur()\y:kras=1:EndIf 
   If kras=1:DisplaySprite3D(1012 , xmz+c, ymz+d,200):EndIf 
  If kras=0:DisplaySprite3D(1011 , xmz+c, ymz+d,150):EndIf 
EndIf 

If stena=2 And kras=1:stena=0:EndIf 

If stena=2 And kras=0 And play=tur()\swo:
 *Old_Element22 = @tur()
   ExamineMouse() 
   xmz = MouseX()                         
   ymz = MouseY() 
   xmz-c:ymz-d
   xmz/48:xmz*48
   ymz/48:ymz*48
   wanim=10

 LastElement(tur())
 
  AddElement( tur() ) 
  tur()\x = xmz
  tur()\y = ymz
 tur()\nom = 21
  AddElement( tur() ) 
  tur()\x = xmz
  tur()\y = ymz
  tur()\nom = 96
  Gosub minusp:
  sl:
ChangeCurrentElement(tur(), *Old_Element22)

stena=0:fyr=8:EndIf 
dod=0
If tur()\fox=200:dod=25:EndIf 
If tur()\magic=0
If tur()\stor=0 And tur()\wani<16 And tur()\gravitator=0: DisplaySprite3D(tur()\nom+tur()\wani+tur()\fox , tur()\x + c, tur()\y + d-dod,255):EndIf 
If tur()\stor=1 And tur()\wani<16 And tur()\gravitator=0: DisplaySprite3D(tur()\nom+tur()\wani+8+tur()\fox , tur()\x + c+5, tur()\y + d-dod,255):EndIf 
EndIf 
If tur()\magic>0
  tur()\magic-1
If tur()\stor=0 And tur()\wani<16 And tur()\gravitator=0: DisplaySprite3D(tur()\nom+tur()\wani+700 , tur()\x + c, tur()\y + d-31,255):EndIf 
If tur()\stor=1 And tur()\wani<16 And tur()\gravitator=0: DisplaySprite3D(tur()\nom+tur()\wani+8+700 , tur()\x + c+5, tur()\y + d-31,255):EndIf 
EndIf 


a=SpriteWidth(tur()\nom+tur()\wani)
b= SpriteHeight(tur()\nom+tur()\wani)
a/2
b/2
If tur()\wani=>16 And tur()\wani<48:b+24:EndIf 
If tur()\swo=play:
xti=-tur()\x+xraz/2-48
yti=-tur()\y+yraz/2-48

EndIf 
StartDrawing( ScreenOutput())
DrawingFont(FontID(4)) 
DrawingMode(#PB_2DDrawing_Transparent )
ff=TextWidth(tur()\name$)
ff/2
uhg=0:uhg2=0
If tur()\swo2=333:uhg=16:uhg2=10:EndIf 
DrawText(tur()\x + c+a-(ff)+1-uhg2,tur()\y + d-b+38+stry+ uhg, tur()\name$, RGB(0,0,0))
DrawText(tur()\x + c+a-(ff)-1-uhg2,tur()\y + d-b+38+stry +uhg, tur()\name$, RGB(0,0,0))
DrawText(tur()\x + c+a-(ff)-uhg2,tur()\y + d-b+38+stry+uhg , tur()\name$, tur()\color )
    ff= tur()\energ+2
    If tur()\swo2<333:
   Box(tur()\x + c+a-(ff/2)+1, tur()\y + d-b+55+stry, tur()\energ+2,5, RGB(0, 0, 0))
   Box(tur()\x + c+a-(ff/2)+2, tur()\y + d-b+55+stry+1, tur()\energ,3, RGB(255, 0, 0))
If tur()\swo=play
ff=tqqq
     Box(tur()\x + c+a-(ff/2),tur()\y + d-b+55+stry+4, tqqq+2,5, RGB(0, 0, 0))
     Box(tur()\x + c+a-(ff/2)+1,tur()\y + d-b+55+stry+5, tqqq,3, RGB(0, 200, 60))
 EndIf 
 EndIf 
 StopDrawing() 
 Stop3D()
 Start3D()
Sprite3DBlendingMode(12, 0)

     If tur()\smilet>8:tur()\smilet-4:DisplaySprite3D(tur()\smile , tur()\x+c+20, tur()\y+d-40,tur()\smilet):EndIf 

Stop3D()
Return 



inercija:
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=97 And tur()\iner>0:
tur()\iner2=0
If tur()\iner>0:tur()\iner-1:EndIf 
iner=1
Gosub stop
iner=0
:EndIf 

If tur()\nom=97 And tur()\iner2>0 :
If tur()\iner2>0:tur()\iner2-1:EndIf 
tur()\iner=0
iner=1
Gosub stop2
iner=0
:EndIf 
Wend
Return 
shopenemy2:

If tur3()\pnom=play And tur3()\money=>10:
  If tur3()\slot2=903 And tur3()\slot2p<20:tur3()\slot2p+10:tur3()\money-10:EndIf 
  If tur3()\slot3=903 And tur3()\slot3p<20:tur3()\slot3p+10:tur3()\money-10:EndIf 
  If tur3()\slot4=903 And tur3()\slot4p<20:tur3()\slot4p+10:tur3()\money-10:EndIf 
  If tur3()\slot5=903 And tur3()\slot5p<20:tur3()\slot5p+10:tur3()\money-10:EndIf 
  If tur3()\slot6=903 And tur3()\slot6p<20:tur3()\slot6p+10:tur3()\money-10:EndIf 
  If tur3()\slot7=903 And tur3()\slot7p<20:tur3()\slot7p+10:tur3()\money-10:EndIf 
  If tur3()\slot8=903 And tur3()\slot8p<20:tur3()\slot8p+10:tur3()\money-10:EndIf 
EndIf 
If tur3()\pnom=play And tur3()\money=>20:
  If tur3()\slot2=901 And tur3()\slot2p<100:tur3()\slot2p+20:tur3()\money-20:EndIf 
  If tur3()\slot3=901 And tur3()\slot3p<100:tur3()\slot3p+20:tur3()\money-20:EndIf 
  If tur3()\slot4=901 And tur3()\slot4p<100:tur3()\slot4p+20:tur3()\money-20:EndIf 
  If tur3()\slot5=901 And tur3()\slot5p<100:tur3()\slot5p+20:tur3()\money-20:EndIf 
  If tur3()\slot6=901 And tur3()\slot6p<100:tur3()\slot6p+20:tur3()\money-20:EndIf 
  If tur3()\slot7=901 And tur3()\slot7p<100:tur3()\slot7p+20:tur3()\money-20:EndIf 
  If tur3()\slot8=901 And tur3()\slot8p<100:tur3()\slot8p+20:tur3()\money-20:EndIf 
EndIf 
If tur3()\pnom=play And tur3()\money=>5:
  If tur3()\slot2=909 And tur3()\slot2p<10:tur3()\slot2p+1:tur3()\money-5:EndIf 
  If tur3()\slot3=909 And tur3()\slot3p<10:tur3()\slot3p+1:tur3()\money-5:EndIf 
  If tur3()\slot4=909 And tur3()\slot4p<10:tur3()\slot4p+1:tur3()\money-5:EndIf 
  If tur3()\slot5=909 And tur3()\slot5p<10:tur3()\slot5p+1:tur3()\money-5:EndIf 
  If tur3()\slot6=909 And tur3()\slot6p<10:tur3()\slot6p+1:tur3()\money-5:EndIf 
  If tur3()\slot7=909 And tur3()\slot7p<10:tur3()\slot7p+1:tur3()\money-5:EndIf 
  If tur3()\slot8=909 And tur3()\slot8p<10:tur3()\slot8p+1:tur3()\money-5:EndIf 
EndIf 
If tur3()\pnom=play And tur3()\money=>5:
  If tur3()\slot2=905 And tur3()\slot2p<10:tur3()\slot2p+1:tur3()\money-5:EndIf 
  If tur3()\slot3=905 And tur3()\slot3p<10:tur3()\slot3p+1:tur3()\money-5:EndIf 
  If tur3()\slot4=905 And tur3()\slot4p<10:tur3()\slot4p+1:tur3()\money-5:EndIf 
  If tur3()\slot5=905 And tur3()\slot5p<10:tur3()\slot5p+1:tur3()\money-5:EndIf 
  If tur3()\slot6=905 And tur3()\slot6p<10:tur3()\slot6p+1:tur3()\money-5:EndIf 
  If tur3()\slot7=905 And tur3()\slot7p<10:tur3()\slot7p+1:tur3()\money-5:EndIf 
  If tur3()\slot8=905 And tur3()\slot8p<10:tur3()\slot8p+1:tur3()\money-5:EndIf 
EndIf 
If tur3()\pnom=play And tur3()\money=>5:
  If tur3()\slot2=906 And tur3()\slot2p<10:tur3()\slot2p+1:tur3()\money-5:EndIf 
  If tur3()\slot3=906 And tur3()\slot3p<10:tur3()\slot3p+1:tur3()\money-5:EndIf 
  If tur3()\slot4=906 And tur3()\slot4p<10:tur3()\slot4p+1:tur3()\money-5:EndIf 
  If tur3()\slot5=906 And tur3()\slot5p<10:tur3()\slot5p+1:tur3()\money-5:EndIf 
  If tur3()\slot6=906 And tur3()\slot6p<10:tur3()\slot6p+1:tur3()\money-5:EndIf 
  If tur3()\slot7=906 And tur3()\slot7p<10:tur3()\slot7p+1:tur3()\money-5:EndIf 
  If tur3()\slot8=906 And tur3()\slot8p<10:tur3()\slot8p+1:tur3()\money-5:EndIf 
EndIf 
If tur3()\pnom=play And tur3()\money=>5:
  If tur3()\slot2=907 And tur3()\slot2p<10:tur3()\slot2p+1:tur3()\money-5:EndIf 
  If tur3()\slot3=907 And tur3()\slot3p<10:tur3()\slot3p+1:tur3()\money-5:EndIf 
  If tur3()\slot4=907 And tur3()\slot4p<10:tur3()\slot4p+1:tur3()\money-5:EndIf 
  If tur3()\slot5=907 And tur3()\slot5p<10:tur3()\slot5p+1:tur3()\money-5:EndIf 
  If tur3()\slot6=907 And tur3()\slot6p<10:tur3()\slot6p+1:tur3()\money-5:EndIf 
  If tur3()\slot7=907 And tur3()\slot7p<10:tur3()\slot7p+1:tur3()\money-5:EndIf 
  If tur3()\slot8=907 And tur3()\slot8p<10:tur3()\slot8p+1:tur3()\money-5:EndIf 
EndIf 
If tur3()\pnom=play And tur3()\money=>5:
  If tur3()\slot2=908 And tur3()\slot2p<10:tur3()\slot2p+1:tur3()\money-5:EndIf 
  If tur3()\slot3=908 And tur3()\slot3p<10:tur3()\slot3p+1:tur3()\money-5:EndIf 
  If tur3()\slot4=908 And tur3()\slot4p<10:tur3()\slot4p+1:tur3()\money-5:EndIf 
  If tur3()\slot5=908 And tur3()\slot5p<10:tur3()\slot5p+1:tur3()\money-5:EndIf 
  If tur3()\slot6=908 And tur3()\slot6p<10:tur3()\slot6p+1:tur3()\money-5:EndIf 
  If tur3()\slot7=908 And tur3()\slot7p<10:tur3()\slot7p+1:tur3()\money-5:EndIf 
  If tur3()\slot8=908 And tur3()\slot8p<10:tur3()\slot8p+1:tur3()\money-5:EndIf 
EndIf 

If tur3()\pnom=play And tur3()\money=>5:
  If tur3()\slot2=902 And tur3()\slot2p<10:tur3()\slot2p+1:tur3()\money-5:EndIf 
  If tur3()\slot3=902 And tur3()\slot3p<10:tur3()\slot3p+1:tur3()\money-5:EndIf 
  If tur3()\slot4=902 And tur3()\slot4p<10:tur3()\slot4p+1:tur3()\money-5:EndIf 
  If tur3()\slot5=902 And tur3()\slot5p<10:tur3()\slot5p+1:tur3()\money-5:EndIf 
  If tur3()\slot6=902 And tur3()\slot6p<10:tur3()\slot6p+1:tur3()\money-5:EndIf 
  If tur3()\slot7=902 And tur3()\slot7p<10:tur3()\slot7p+1:tur3()\money-5:EndIf 
  If tur3()\slot8=902 And tur3()\slot8p<10:tur3()\slot8p+1:tur3()\money-5:EndIf 
EndIf 
If tur3()\pnom=play And tur3()\money=>20:
  If tur3()\slot2=914 And tur3()\slot2p<5:tur3()\slot2p+1:tur3()\money-20:EndIf 
  If tur3()\slot3=914 And tur3()\slot3p<5:tur3()\slot3p+1:tur3()\money-20:EndIf 
  If tur3()\slot4=914 And tur3()\slot4p<5:tur3()\slot4p+1:tur3()\money-20:EndIf 
  If tur3()\slot5=914 And tur3()\slot5p<5:tur3()\slot5p+1:tur3()\money-20:EndIf 
  If tur3()\slot6=914 And tur3()\slot6p<5:tur3()\slot6p+1:tur3()\money-20:EndIf 
  If tur3()\slot7=914 And tur3()\slot7p<5:tur3()\slot7p+1:tur3()\money-20:EndIf 
  If tur3()\slot8=914 And tur3()\slot8p<5:tur3()\slot8p+1:tur3()\money-20:EndIf 
EndIf 
If tur3()\pnom=play And tur3()\money=>10:
  If tur3()\slot2=904 And tur3()\slot2p<8:tur3()\slot2p+1:tur3()\money-10:EndIf 
  If tur3()\slot3=904 And tur3()\slot3p<8:tur3()\slot3p+1:tur3()\money-10:EndIf 
  If tur3()\slot4=904 And tur3()\slot4p<8:tur3()\slot4p+1:tur3()\money-10:EndIf 
  If tur3()\slot5=904 And tur3()\slot5p<8:tur3()\slot5p+1:tur3()\money-10:EndIf 
  If tur3()\slot6=904 And tur3()\slot6p<8:tur3()\slot6p+1:tur3()\money-10:EndIf 
  If tur3()\slot7=904 And tur3()\slot7p<8:tur3()\slot7p+1:tur3()\money-10:EndIf 
  If tur3()\slot8=904 And tur3()\slot8p<8:tur3()\slot8p+1:tur3()\money-10:EndIf 
EndIf 
If tur3()\pnom=play And tur3()\money=>20:
  If tur3()\slot2=912 And tur3()\slot2p<1:tur3()\slot2p+1:tur3()\money-20:EndIf 
  If tur3()\slot3=912 And tur3()\slot3p<1:tur3()\slot3p+1:tur3()\money-20:EndIf 
  If tur3()\slot4=912 And tur3()\slot4p<1:tur3()\slot4p+1:tur3()\money-20:EndIf 
  If tur3()\slot5=912 And tur3()\slot5p<1:tur3()\slot5p+1:tur3()\money-20:EndIf 
  If tur3()\slot6=912 And tur3()\slot6p<1:tur3()\slot6p+1:tur3()\money-20:EndIf 
  If tur3()\slot7=912 And tur3()\slot7p<1:tur3()\slot7p+1:tur3()\money-20:EndIf 
  If tur3()\slot8=912 And tur3()\slot8p<1:tur3()\slot8p+1:tur3()\money-20:EndIf 
EndIf 
Return 


Return 
shopenemy:
If sh=1:Return:EndIf 
sh=1
If Random(15)=0 And tur3()\pnom=play And tur3()\money=>150 And tur3()\slot8=0 And tur3()\slot2<>903 And tur3()\slot3<>903 And tur3()\slot4<>903 And tur3()\slot5<>903 And tur3()\slot6<>903 And tur3()\slot7<>903 And tur3()\slot8<>903:

  tur3()\money-150
  tur3()\slot8=903
   tur3()\slot8p=0
  Gosub instorr
EndIf 
If Random(15)=0 And tur3()\pnom=play And tur3()\money=>200 And tur3()\slot8=0 And tur3()\slot2<>901 And tur3()\slot3<>901 And tur3()\slot4<>901 And tur3()\slot5<>901 And tur3()\slot6<>901 And tur3()\slot7<>901 And tur3()\slot8<>901:

  tur3()\money-200
  tur3()\slot8=901
   tur3()\slot8p=0
  Gosub instorr
EndIf 
If Random(15)=0 And tur3()\pnom=play And tur3()\money=>250 And tur3()\slot8=0 And tur3()\slot2<>909 And tur3()\slot3<>909 And tur3()\slot4<>909 And tur3()\slot5<>909 And tur3()\slot6<>909 And tur3()\slot7<>909 And tur3()\slot8<>909:

  tur3()\money-250
  tur3()\slot8=909
   tur3()\slot8p=0
  Gosub instorr
EndIf 

If Random(15)=0 And tur3()\pnom=play And tur3()\money=>300 And tur3()\slot8=0 And tur3()\slot2<>905 And tur3()\slot3<>905 And tur3()\slot4<>905 And tur3()\slot5<>905 And tur3()\slot6<>905 And tur3()\slot7<>905 And tur3()\slot8<>905:

  tur3()\money-300
  tur3()\slot8=905
   tur3()\slot8p=0
  Gosub instorr
EndIf 

If Random(15)=0 And tur3()\pnom=play And tur3()\money=>300 And tur3()\slot8=0 And tur3()\slot2<>906 And tur3()\slot3<>906 And tur3()\slot4<>906 And tur3()\slot5<>906 And tur3()\slot6<>906 And tur3()\slot7<>906 And tur3()\slot8<>906:

  tur3()\money-300
  tur3()\slot8=906
   tur3()\slot8p=0
  Gosub instorr
EndIf 

If Random(15)=0 And tur3()\pnom=play And tur3()\money=>300 And tur3()\slot8=0 And tur3()\slot2<>906 And tur3()\slot3<>906 And tur3()\slot4<>906 And tur3()\slot5<>906 And tur3()\slot6<>906 And tur3()\slot7<>906 And tur3()\slot8<>906:

  tur3()\money-300
  tur3()\slot8=906
   tur3()\slot8p=0
  Gosub instorr
EndIf 

If Random(15)=0 And tur3()\pnom=play And tur3()\money=>200 And tur3()\slot8=0 And tur3()\slot2<>912 And tur3()\slot3<>912 And tur3()\slot4<>912 And tur3()\slot5<>912 And tur3()\slot6<>912 And tur3()\slot7<>912 And tur3()\slot8<>912:

  tur3()\money-200
  tur3()\slot8=912
   tur3()\slot8p=0
  Gosub instorr
EndIf

If Random(15)=0 And Random(20)=0 And tur3()\pnom=play And tur3()\money=>400 And tur3()\slot8=0 And tur3()\slot2<>904 And tur3()\slot3<>904 And tur3()\slot4<>904 And tur3()\slot5<>904 And tur3()\slot6<>904 And tur3()\slot7<>904 And tur3()\slot8<>904:

  tur3()\money-400
  tur3()\slot8=904
   tur3()\slot8p=0
  Gosub instorr
EndIf

If Random(8)=0 And tur3()\pnom=play And tur3()\money=>600 And tur3()\slot2<>902 And tur3()\slot3<>902 And tur3()\slot4<>902 And tur3()\slot5<>902 And tur3()\slot6<>902 And tur3()\slot7<>902 And tur3()\slot8<>902:

  tur3()\money-600
  tur3()\slot8=902
  tur3()\slot8p=0
  Gosub instorr
EndIf

If Random(8)=0 And tur3()\pnom=play And tur3()\money=>600 And tur3()\slot2<>907 And tur3()\slot3<>907 And tur3()\slot4<>907 And tur3()\slot5<>907 And tur3()\slot6<>907 And tur3()\slot7<>907 And tur3()\slot8<>907:

  tur3()\money-600
  tur3()\slot8=907
  tur3()\slot8p=0
  Gosub instorr
EndIf

If Random(8)=0 And tur3()\pnom=play And tur3()\money=>600 And tur3()\slot2<>908 And tur3()\slot3<>908 And tur3()\slot4<>908 And tur3()\slot5<>908 And tur3()\slot6<>908 And tur3()\slot7<>907 And tur3()\slot8<>908:

  tur3()\money-600
  tur3()\slot8=908
  tur3()\slot8p=0
  Gosub instorr
EndIf

If Random(8)=0 And tur3()\pnom=play And tur3()\money=>800 And tur3()\slot2<>914 And tur3()\slot3<>914 And tur3()\slot4<>914 And tur3()\slot5<>914 And tur3()\slot6<>914 And tur3()\slot7<>914 And tur3()\slot8<>914:

  tur3()\money-800
  tur3()\slot8=914
  tur3()\slot8p=0
  Gosub instorr
  EndIf
Return 




;---------------intelect000000000000
addbot:
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=97 And play=tur()\swo And tur()\bot=1 And tur()\swo2<>333 And tur3()\pnom=play:Goto addbot2:EndIf 
Wend 
Return 


addbot2:

timecpu+1

If timecpu>200:timecpu=0:nextlp=1:Return:EndIf 

If endturr=>1 Or diss=1:iko=0:Return:EndIf

If iko>0 And chet9=0:chet9=1:EndIf 
If chet9=25:chet9=0:ikom=1:iko=0:EndIf 
If chet9>0:chet9+1:EndIf 
If iko>0:Return:EndIf
spid3=0



addb=0
*Old_Element220 = @tur()
*Old_Elementtur3 = @tur3()
Gosub shopenemy
Gosub shopenemy2
ChangeCurrentElement(tur3(), *Old_Elementtur3) 
If tur()\magic=0:Gosub skanenemy:EndIf 
Gosub werhskan
Gosub jama
Gosub hodba
Gosub pryvok 
Gosub randslu
Gosub taim

If addb=0:nextlp=1:EndIf 

Return 

prowwea:
If tur3()\slot2=901 And  tur3()\slot2p>0:weapon=901:Return:EndIf 
If tur3()\slot3=901 And  tur3()\slot3p>0:weapon=901:Return:EndIf 
If tur3()\slot4=901 And  tur3()\slot4p>0:weapon=901:Return:EndIf 
If tur3()\slot5=901 And  tur3()\slot5p>0:weapon=901:Return:EndIf 
If tur3()\slot6=901 And  tur3()\slot6p>0:weapon=901:Return:EndIf 
If tur3()\slot7=901 And  tur3()\slot7p>0:weapon=901:Return:EndIf 
If tur3()\slot8=901 And  tur3()\slot8p>0:weapon=901:Return:EndIf 
Return 
prowwea2:
If norak=0 And Random(1)=0:norak=1:Return:EndIf 
If norak=1:Return:EndIf 
If tur3()\slot2=902 And  tur3()\slot2p>0:weapon=902:Return:EndIf 
If tur3()\slot3=902 And  tur3()\slot3p>0:weapon=902:Return:EndIf 
If tur3()\slot4=902 And  tur3()\slot4p>0:weapon=902:Return:EndIf 
If tur3()\slot5=902 And  tur3()\slot5p>0:weapon=902:Return:EndIf 
If tur3()\slot6=902 And  tur3()\slot6p>0:weapon=902:Return:EndIf 
If tur3()\slot7=902 And  tur3()\slot7p>0:weapon=902:Return:EndIf 
If tur3()\slot8=902 And  tur3()\slot8p>0:weapon=902:Return:EndIf 
Return 

prowwea3:
If norak2=0 And Random(1)=0:norak2=1:Return:EndIf 
If norak2=1:Return:EndIf 
If tur3()\slot2=903 And  tur3()\slot2p>0:weapon=903:Return:EndIf 
If tur3()\slot3=903 And  tur3()\slot3p>0:weapon=903:Return:EndIf 
If tur3()\slot4=903 And  tur3()\slot4p>0:weapon=903:Return:EndIf 
If tur3()\slot5=903 And  tur3()\slot5p>0:weapon=903:Return:EndIf 
If tur3()\slot6=903 And  tur3()\slot6p>0:weapon=903:Return:EndIf 
If tur3()\slot7=903 And  tur3()\slot7p>0:weapon=903:Return:EndIf 
If tur3()\slot8=903 And  tur3()\slot8p>0:weapon=903:Return:EndIf 
Return 


prowwea4:
If norak3=0 And Random(2)>0:norak3=1:Return:EndIf 
If norak3=1:Return:EndIf 
If tur3()\slot2=904 And  tur3()\slot2p>0:weapon=904:Return:EndIf 
If tur3()\slot3=904 And  tur3()\slot3p>0:weapon=904:Return:EndIf 
If tur3()\slot4=904 And  tur3()\slot4p>0:weapon=904:Return:EndIf 
If tur3()\slot5=904 And  tur3()\slot5p>0:weapon=904:Return:EndIf 
If tur3()\slot6=904 And  tur3()\slot6p>0:weapon=904:Return:EndIf 
If tur3()\slot7=904 And  tur3()\slot7p>0:weapon=904:Return:EndIf 
If tur3()\slot8=904 And  tur3()\slot8p>0:weapon=904:Return:EndIf 
Return 

prowwea5:
If norak4=0 And Random(2)>0:norak4=1:Return:EndIf 
If norak4=1:Return:EndIf 
If tur3()\slot2=909 And  tur3()\slot2p>0:weapon=909:Return:EndIf 
If tur3()\slot3=909 And  tur3()\slot3p>0:weapon=909:Return:EndIf 
If tur3()\slot4=909 And  tur3()\slot4p>0:weapon=909:Return:EndIf 
If tur3()\slot5=909 And  tur3()\slot5p>0:weapon=909:Return:EndIf 
If tur3()\slot6=909 And  tur3()\slot6p>0:weapon=909:Return:EndIf 
If tur3()\slot7=909 And  tur3()\slot7p>0:weapon=909:Return:EndIf 
If tur3()\slot8=909 And  tur3()\slot8p>0:weapon=909:Return:EndIf 
Return 

prowwea6:
If norak5=0 And Random(10)>0:norak5=1:Return:EndIf 
If norak5=1:Return:EndIf 
If tur3()\slot2=914 And  tur3()\slot2p>0:weapon=914:Return:EndIf 
If tur3()\slot3=914 And  tur3()\slot3p>0:weapon=914:Return:EndIf 
If tur3()\slot4=914 And  tur3()\slot4p>0:weapon=914:Return:EndIf 
If tur3()\slot5=914 And  tur3()\slot5p>0:weapon=914:Return:EndIf 
If tur3()\slot6=914 And  tur3()\slot6p>0:weapon=914:Return:EndIf 
If tur3()\slot7=914 And  tur3()\slot7p>0:weapon=914:Return:EndIf 
If tur3()\slot8=914 And  tur3()\slot8p>0:weapon=914:Return:EndIf 
Return 

prowwea7: 
If tur3()\slot2=905 And  tur3()\slot2p>0:weapon=905:Return:EndIf 
If tur3()\slot3=905 And  tur3()\slot3p>0:weapon=905:Return:EndIf 
If tur3()\slot4=905 And  tur3()\slot4p>0:weapon=905:Return:EndIf 
If tur3()\slot5=905 And  tur3()\slot5p>0:weapon=905:Return:EndIf 
If tur3()\slot6=905 And  tur3()\slot6p>0:weapon=905:Return:EndIf 
If tur3()\slot7=905 And  tur3()\slot7p>0:weapon=905:Return:EndIf 
If tur3()\slot8=905 And  tur3()\slot8p>0:weapon=905:Return:EndIf 
If tur3()\slot2=907 And  tur3()\slot2p>0:weapon=905:Return:EndIf 
If tur3()\slot3=907 And  tur3()\slot3p>0:weapon=905:Return:EndIf 
If tur3()\slot4=907 And  tur3()\slot4p>0:weapon=905:Return:EndIf 
If tur3()\slot5=907 And  tur3()\slot5p>0:weapon=905:Return:EndIf 
If tur3()\slot6=907 And  tur3()\slot6p>0:weapon=905:Return:EndIf 
If tur3()\slot7=907 And  tur3()\slot7p>0:weapon=905:Return:EndIf 
If tur3()\slot8=907 And  tur3()\slot8p>0:weapon=905:Return:EndIf 
Return 


prowwea8: 
If tur3()\slot2=906 And  tur3()\slot2p>0:weapon=906:Return:EndIf 
If tur3()\slot3=906 And  tur3()\slot3p>0:weapon=906:Return:EndIf 
If tur3()\slot4=906 And  tur3()\slot4p>0:weapon=906:Return:EndIf 
If tur3()\slot5=906 And  tur3()\slot5p>0:weapon=906:Return:EndIf 
If tur3()\slot6=906 And  tur3()\slot6p>0:weapon=906:Return:EndIf 
If tur3()\slot7=906 And  tur3()\slot7p>0:weapon=906:Return:EndIf 
If tur3()\slot8=906 And  tur3()\slot8p>0:weapon=906:Return:EndIf 
If tur3()\slot2=908 And  tur3()\slot2p>0:weapon=905:Return:EndIf 
If tur3()\slot3=908 And  tur3()\slot3p>0:weapon=905:Return:EndIf 
If tur3()\slot4=908 And  tur3()\slot4p>0:weapon=905:Return:EndIf 
If tur3()\slot5=908 And  tur3()\slot5p>0:weapon=905:Return:EndIf 
If tur3()\slot6=908 And  tur3()\slot6p>0:weapon=905:Return:EndIf 
If tur3()\slot7=908 And  tur3()\slot7p>0:weapon=905:Return:EndIf 
If tur3()\slot8=908 And  tur3()\slot8p>0:weapon=905:Return:EndIf 
Return 

skanenemy:


addb=1

ChangeCurrentElement(tur(), *Old_Element220) 
ChangeCurrentElement(tur3(), *Old_Elementtur3) 
If nosmile=1:Return:EndIf 

If addb32>0:addb=1:addb32-1:Return:EndIf

  xenem=tur()\x
  yenem=tur()\y
  


ResetList( tur() ) 
While NextElement( tur())

  If tur()\nom=24 Or tur()\nom=23 Or tur()\nom=22 Or tur()\nom=21:Goto skanenemy2:EndIf 
  If tur()\nom=97 And tur()\swo<>play And tur()\swo2<>333 And tur()\bot=0:

   xenem2=tur()\x
   yenem2=tur()\y
   
   

   
   If xenem>xenem2:zwer=0:EndIf 
   If xenem<xenem2:zwer=1:EndIf 
   
    
     If zwer=0 And xenem2=>xenem-32 And yenem-42>yenem2:Goto launch:EndIf 
     If zwer=1 And xenem2<=xenem+32 And yenem-42>yenem2:Goto launch:EndIf 
     If zwer=0 And xenem2=>xenem-32 And yenem+42<yenem2:Goto launch2:EndIf 
     If zwer=1 And xenem2<=xenem+32 And yenem+42<yenem2:Goto launch2:EndIf 
     ska2:
 
   If yenem>yenem2-24 And yenem<yenem2+24:
     

     
       If zwer=0 And xenem2=>xenem-42:ChangeCurrentElement(tur(), *Old_Element220):tur()\x2=Random(2000):addb=1:addb32=42:Return:EndIf 
       If zwer=1 And xenem2<=xenem+42:ChangeCurrentElement(tur(), *Old_Element220):tur()\x2=Random(2000):addb=1:addb32=42:Return:EndIf 
       
       
       
       
                                   Gosub prowwea6
                                  ; шаровая грави
                 If weapon=914:
                addb=1  
     
  If xenem=>xenem2:xm33=0:EndIf 
  If xenem<=xenem2:xm33=2000:EndIf 
  *Old_Element220888 = @tur()
  Gosub fireebot:
  ChangeCurrentElement(tur3(), *Old_Elementtur3) 
  ChangeCurrentElement(tur(), *Old_Element220888)
Goto ska:EndIf 
       
       
                            Gosub prowwea5
                                  ; шаровая 'энерго
                 If weapon=909:
                addb=1  
     
  If xenem=>xenem2:xm33=0:EndIf 
  If xenem<=xenem2:xm33=2000:EndIf 
  *Old_Element220888 = @tur()
  Gosub fireebot:
  ChangeCurrentElement(tur3(), *Old_Elementtur3) 
  ChangeCurrentElement(tur(), *Old_Element220888):Goto ska:EndIf 

       
       
       
                     Gosub prowwea4
                                  ; шаровая молынья 
                 If weapon=904:
                addb=1  
     
  If xenem=>xenem2:xm33=0:EndIf 
  If xenem<=xenem2:xm33=2000:EndIf 

  *Old_Element220888 = @tur()
  Gosub fireebot:
  ChangeCurrentElement(tur3(), *Old_Elementtur3) 
  ChangeCurrentElement(tur(), *Old_Element220888):Goto ska:EndIf 


       
       
       
       
              Gosub prowwea3
              If  zwer=0 And xenem2>xenem-500:;если минигшан
                 If weapon=903:
                addb=1  
     
  If xenem=>xenem2:xm33=0:EndIf 
  If xenem<=xenem2:xm33=2000:EndIf 

  *Old_Element220888 = @tur()
  Gosub fireebot:
  ChangeCurrentElement(tur3(), *Old_Elementtur3) 
  ChangeCurrentElement(tur(), *Old_Element220888):Goto ska:EndIf 
EndIf 

If  zwer=1 And xenem2<xenem+500:;если миниган
  
   If weapon=903:
  addb=1  
     
  If xenem=>xenem2:xm33=0:EndIf 
  If xenem<=xenem2:xm33=2000:EndIf 

  *Old_Element220888 = @tur()
  Gosub fireebot:
  ChangeCurrentElement(tur3(), *Old_Elementtur3) 
  ChangeCurrentElement(tur(), *Old_Element220888):Goto ska:EndIf 
EndIf 
       
       
       
       
       
       
       Gosub prowwea2
              If  zwer=0 And xenem2>xenem-400:;если ракетница
                 If weapon=902:
                addb=1  
     
  If xenem=>xenem2:xm33=0:EndIf 
  If xenem<=xenem2:xm33=2000:EndIf 

  *Old_Element220888 = @tur()
  Gosub fireebot:
  ChangeCurrentElement(tur3(), *Old_Elementtur3) 
  ChangeCurrentElement(tur(), *Old_Element220888):Goto ska:EndIf 
EndIf 

If  zwer=1 And xenem2<xenem+400:;если ракетница
  
   If weapon=902:
  addb=1  
     
  If xenem=>xenem2:xm33=0:EndIf 
  If xenem<=xenem2:xm33=2000:EndIf 

  *Old_Element220888 = @tur()
  Gosub fireebot:
  ChangeCurrentElement(tur3(), *Old_Elementtur3) 
  ChangeCurrentElement(tur(), *Old_Element220888):Goto ska:EndIf 
EndIf 

       
       
       
       
       
       
       Gosub prowwea
       
       If    zwer=0 And xenem2>xenem-250:;если огнемет
          If weapon=901:
         addb=1  
     
  If xenem=>xenem2:xm33=0:EndIf 
  If xenem<=xenem2:xm33=2000:EndIf 
  *Old_Element220888 = @tur()
  Gosub fireebot:
  ChangeCurrentElement(tur3(), *Old_Elementtur3) 
  ChangeCurrentElement(tur(), *Old_Element220888):Goto ska:EndIf 
EndIf 

If  zwer=1 And xenem2<xenem+250:;если огнемет
   If weapon=901
  addb=1  
     
  If xenem=>xenem2:xm33=0:EndIf 
  If xenem<=xenem2:xm33=2000:EndIf 

   *Old_Element220888 = @tur()
   Gosub fireebot:
   ChangeCurrentElement(tur3(), *Old_Elementtur3) 
  ChangeCurrentElement(tur(), *Old_Element220888):Goto ska:EndIf 
EndIf 








     If  zwer=0 And xenem2>xenem-300:;  если простой автомат
     
     addb=1  
     
  If xenem=>xenem2:xm33=0:EndIf 
  If xenem<=xenem2:xm33=2000:EndIf 

 weapon=900
   *Old_Element220888 = @tur()
   Gosub fireebot:
   ChangeCurrentElement(tur3(), *Old_Elementtur3) 
  ChangeCurrentElement(tur(), *Old_Element220888)

EndIf  

     If  zwer=1 And xenem2<xenem+300:
     
     addb=1  
     
  If xenem=>xenem2:xm33=0:EndIf 
  If xenem<=xenem2:xm33=2000:EndIf 
 
 weapon=900
  *Old_Element220888 = @tur()
  Gosub fireebot:
  ChangeCurrentElement(tur3(), *Old_Elementtur3) 
  ChangeCurrentElement(tur(), *Old_Element220888)

    EndIf  

    

    
 
EndIf 
   
EndIf 
ska:

  Wend 
  

  
Return 



launch:


             Gosub prowwea7
                                  ; Ракетница верх
                 If weapon=905:
                addb=1  

                *Old_Element220888 = @tur()
                
                 Gosub fireebot:
ChangeCurrentElement(tur3(), *Old_Elementtur3) 
  ChangeCurrentElement(tur(), *Old_Element220888)
                
              Goto ska:EndIf 
Goto ska2 


launch2:


             Gosub prowwea8
                                  ; Ракетница вниз
                 If weapon=906:
                addb=1  

  *Old_Element220888 = @tur()
  Gosub fireebot:
  ChangeCurrentElement(tur3(), *Old_Elementtur3) 
  ChangeCurrentElement(tur(), *Old_Element220888):Goto ska:EndIf 
Goto ska2 










skanenemy2:
If storr=0 And SpriteCollision(97, xenem, yenem, tur()\nom, tur()\x-16, tur()\y+1)=1:
xm33=2000::Goto fire223:EndIf 
If storr=1 And SpriteCollision(97, xenem, yenem, tur()\nom, tur()\x+16, tur()\y+1)=1:
xm33=0:Goto fire223:EndIf
Goto ska

fire223: 

weapon=900
 *Old_Element220888 = @tur()
 Gosub fireebot
 ChangeCurrentElement(tur3(), *Old_Elementtur3) 
 ChangeCurrentElement(tur(), *Old_Element220888)
addb=1 
Return 







randslu:

ChangeCurrentElement(tur(), *Old_Element220)
If tur()\wani=>16:Return:EndIf 
If Random(500)=0:tur()\x2=Random(2000):;------------вносим случайное поведение
  xenem5=tur()\x2
 addb=1
 tur()\target=1
EndIf 
Return 






werhskan:

ChangeCurrentElement(tur(), *Old_Element220)

If tur()\wani=>16:Return:EndIf 

xenem=tur()\x
yenem=tur()\y
storr=tur()\stor

ResetList( tur() )
While NextElement( tur())

    If tur()\nom=27 Or tur()\nom=67:Goto werhskan2:EndIf 
    If or1a=0 Or or2a=0 Or or3a=0 Or or4a=0
      If tur()\nom=>970 And tur()\nom<988:Goto werhskan2:EndIf 
    EndIf 
    uds:
    Wend 
    Return 
    
    
    
    jama:;wperedi jama
    If Random(2)>0:Return:EndIf 

    ChangeCurrentElement(tur(), *Old_Element220)

If tur()\wani=>16:Return:EndIf 

xenem=tur()\x
yenem=tur()\y
storr=tur()\stor

    ResetList( tur() )
While NextElement( tur())


  If storr=0 And tur()\nom=96 And SpriteCollision(97, xenem, yenem, tur()\nom, tur()\x-8, tur()\y)=1:
   
  Return 
:EndIf 


  If storr=1 And tur()\nom=96 And SpriteCollision(97, xenem, yenem, tur()\nom, tur()\x+8, tur()\y)=1:
   
  Return 
:EndIf 

Wend 

 botdjump=1
  Return 
  
  
  



werhskan2:

If SpriteCollision(97, xenem, yenem, tur()\nom, tur()\x, tur()\y+70)=1:
If Random(0)=0:botdjump=1:Return:EndIf 
addb=1  
:EndIf 
If SpriteCollision(97, xenem, yenem, tur()\nom, tur()\x, tur()\y+60+48)=1:
If Random(0)=0:botdjump=1:Return:EndIf 
addb=1  
:EndIf 
If SpriteCollision(97, xenem, yenem, tur()\nom, tur()\x, tur()\y+60+96)=1:
If Random(0)=0:botdjump=1:Return:EndIf 
addb=1  
:EndIf 

Goto uds


werhskan3:


If SpriteCollision(97, xenem, yenem, tur()\nom, tur()\x, tur()\y+1)=1: 
  xen2=tur()\x+24
  If Random(50)>0: Goto pry:EndIf 
  botdjump=1: ChangeCurrentElement(tur(), *Old_Element220):
  tur()\x2=xen2 
  stoitli=200: ;  как часто телепортироваться
  addb=1
:EndIf 
Goto pry


werhskan6:

If SpriteCollision(97, xenem, yenem, tur()\nom, tur()\x, tur()\y+1)=1: 
  xen2=tur()\x+24
 If Random(50)>0: Goto pry:EndIf 
  botdjump=1: ChangeCurrentElement(tur(), *Old_Element220):
tur()\x2=xen2
  stoitli=200: 
  addb=1
:EndIf 
Goto pry




werhskan4:; запрыгиваем выерх

b=100
;b=70+16+32
;b+tur3()\gravi*2
a=16
Repeat 
If SpriteCollision(97, xenem, yenem, tur()\nom, tur()\x, tur()\y+a)=1:
  Goto werhskan5
EndIf  
a+1
Until a=b
 Goto pry

 werhskan5:
 If gr>0 Or up=0:Return:EndIf 
  xen2=tur()\x
  botdjump=1: ChangeCurrentElement(tur(), *Old_Element220):
 tur()\x2=xen2
addb=1
stoitli2=1

Return 



pryvok:

If stoitli>0:stoitli-1:EndIf ;  как часто телепортироваться
ChangeCurrentElement(tur(), *Old_Element220)
If tur()\wani=>16:Return:EndIf 
xenem=tur()\x
yenem=tur()\y
storr=tur()\stor
up=tur()\upal 
gr=tur()\gravitator
ResetList( tur() )
While NextElement( tur())
  
  If tur()\nom=96 And stoitli2=1:Goto werhskan4:EndIf 
  If tur()\nom=96 And stoitli2=0 And Random(50)=0:Goto werhskan4:EndIf 
  If tur()\nom=30 And stoitli=0:Goto werhskan3:EndIf 
  If tur()\nom=250 And stoitli=0:Goto werhskan6:EndIf 
  If tur()\nom=98 And stoitli=0:Goto werhskan6:EndIf 
If tur()\nom=10 Or tur()\nom=11 Or tur()\nom=12 Or tur()\nom=13  Or tur()\nom=16 Or tur()\nom=17  Or tur()\nom=18 Or tur()\nom=19:
  Goto pryvok2:
EndIf 
  pry:

Wend 
If up=1 And gr=0:stoitli2=0:EndIf
 Return 

 pryvok2:
  If stoitli2>0:Goto pry:EndIf 
If storr=0 And SpriteCollision(97, xenem, yenem, tur()\nom, tur()\x-2, tur()\y+1)=1:ChangeCurrentElement(tur(), *Old_Element220):
  tur()\x2=xenem5
:Goto pryvok3:EndIf 
If storr=1 And SpriteCollision(97, xenem, yenem, tur()\nom, tur()\x+2, tur()\y+1)=1:ChangeCurrentElement(tur(), *Old_Element220):
    tur()\x2=xenem5
  :Goto pryvok3:EndIf
  
  
  
  
Goto pry


pryvok3:

botdjump=1
addb=1
Return 










taim:;  сброс по времени

ChangeCurrentElement(tur(), *Old_Element220)
If tur()\wani=>16:Return:EndIf 
If tur()\upal=0:Return:EndIf 

If time=>10 And time3=0:
  If tur()\stor=0
  tur()\x2=0:tur()\target=1:time3=1:EndIf 
    If tur()\stor=1
  tur()\x2=2000:tur()\target=1:time3=1:EndIf 
EndIf 

If time=>30:time3=0:time=0:addb=0:Return:EndIf 
If tur()\x=xenem4:time+1:Return:EndIf
If tur()\x<tur()\x2+32 And tur()\x>tur()\x2-32:time+1:Return:EndIf
;  если пришел к цели, передай ход
time=0
Return 




hodba:
ChangeCurrentElement(tur(), *Old_Element220)
 If Random(0)=0:Gosub prizy :EndIf ; пиздуй за призами 

ChangeCurrentElement(tur(), *Old_Element220)

If tur()\wani=>16:Return:EndIf 
storr=tur()\stor
up=tur()\upal 
gr=tur()\gravitator
xen666+1
If xen666=3:xenem4=tur()\x:xen666=0:EndIf 

If shlak=1:Goto sjl:EndIf 
If stoitli2>0:addb=1:Return:EndIf 
If tur()\upal=0 Or tur()\gravitator>0:addb=1:Return:EndIf 
sjl:
shlak=0





If tur()\target=1 And tur()\x=tur()\x2:tur()\target=0:EndIf 

xenem=tur()\x
yenem=tur()\y

target=tur()\target
a=0

If target=0:Goto hodba2:EndIf ; если цели нет, найди ее

If tur()\x<tur()\x2+16 And tur()\x>tur()\x2-16:tur()\target=0:addb=0:Return:EndIf ;  если пришел к цели, передай ход

addb=1

Return 

hodba2:



cnz=8
Repeat 
ResetList( tur() ) 
While NextElement( tur())
  If  tur()\target=0 And Random(1)=0 And tur()\nom=97 And tur()\swo<>play And tur()\swo2<>333 And tur()\bot=0:
    xenem2=tur()\x
    yenem2=tur()\y
    Goto hodba3
    
  EndIf 
  hod:
  Wend 
  cnz-1
Until cnz=0
 ChangeCurrentElement(tur(), *Old_Element220)
 tur()\x2=Random(2000)
 xenem5=tur()\x2
 addb=1
  tur()\target=1
  Return 
  
  hodba3:
 ChangeCurrentElement(tur(), *Old_Element220)
 tur()\x2=xenem2
 xenem5=xenem2
 tur()\target=1
 addb=1

Return 



prizy:


ResetList( tur() )
While NextElement( tur())
  If target=0 
    If tur()\nom=27 Or tur()\nom=67:Goto prizy2:EndIf 
    If or1a=0 Or or2a=0 Or or3a=0 Or or4a=0
      If tur()\nom=>970 And tur()\nom<988:Goto prizy2:EndIf 
      EndIf 
  EndIf 
  pry2:
Wend 

suda:
ChangeCurrentElement(tur(), *Old_Element220)

Return 

prizy2:


m=0
a=128
Repeat 
  If SpriteCollision(97, m, yenem, tur()\nom, m, tur()\y-a)=1:Goto prizy3:EndIf 
  a-32
Until a=0
a=128
Repeat 
  If SpriteCollision(97, m, yenem, tur()\nom, m, tur()\y+a)=1:Goto prizy3:EndIf 
  a-32
Until a=0
Goto pry2


prizy3:  


a=512
m=0
Repeat 
  If SpriteCollision(97, xenem, m, tur()\nom, tur()\x-a, m)=1:
    ChangeCurrentElement(tur(), *Old_Element220): 
    tur()\x2=tur()\x+a
     xenem5=tur()\x+a
    tur()\target=1
    addb=1
    Goto suda::EndIf 
  a-32
Until a=0

a=512
Repeat 
  If SpriteCollision(97, xenem,m, tur()\nom, tur()\x+a, m)=1:
    ChangeCurrentElement(tur(), *Old_Element220): 
    tur()\x2=tur()\x-a
     xenem5=tur()\x-a
    tur()\target=1
    addb=1
    Goto suda::EndIf 
  a-32
Until a=0

Goto pry2





























gravitacija:;------gravi

wanim=0

ResetList( tur() ) 
While NextElement( tur())

;If tur()\nom=97 And play=tur()\swo And tur()\bot=1 And tur()\swo2<>333:Gosub addbot2:EndIf 
nosmog=0
If tur()\nom=97 And tur()\iner>0:
tur()\iner2=0
If tur()\iner>0:tur()\iner-1:EndIf 
iner=1
Gosub stop
iner=0
:EndIf 
If tur()\nom=97 And tur()\iner2>0 :
If tur()\iner2>0:tur()\iner2-1:EndIf 
tur()\iner=0
iner=1
Gosub stop2
iner=0
:EndIf 

If tur()\wani=>128:tur()\wani+1:EndIf 
If tur()\wani=>132:tur()\wani-1:EndIf

If tur()\wani=>48 And tur()\wani<128:tur()\wani+1:EndIf 
If tur()\wani=>52 And tur()\wani<64:tur()\wani=0:EndIf 

If tur()\nom=97 And tur()\wani=>16 And tur()\wani<31:tur()\wani+1:Goto pokoj:EndIf 
If tur()\nom=97 And tur()\wani=31:tur()\wani=0:Goto pokoj:EndIf 
If tur()\nom=97 And tur()\wani=76:tur()\wani=0:Goto pokoj:EndIf 
If tur()\nom=97  And tur()\wani=>16 And tur()\wani<128::Goto pokoj:EndIf 
If tur()\nom=97  And tur()\upal=1:Gosub upal2:EndIf 
If tur()\nom=97  And tur()\x=tur()\x2:tur()\wani=0:Goto pokoj:EndIf 
If tur()\gravitator>0  And tur()\nom=97 And tur()\x<tur()\x2 And tur()\iner=0:Gosub stop:Gosub wani2:EndIf 
If tur()\gravitator>0  And tur()\nom=97 And tur()\x>tur()\x2 And tur()\iner2=0:Gosub stop2:Gosub wani2:EndIf



If tur()\nom=97  And tur()\wani<16 And tur()\x<tur()\x2 And tur()\iner=0::Gosub stop:Gosub wani2:EndIf 
If tur()\nom=97  And tur()\wani<16 And tur()\x>tur()\x2 And tur()\iner2=0::Gosub stop2:Gosub wani2:EndIf 
pokoj:

 




 If  tur()\nom=97:*Old_Element = @tur():stor=tur()\stor:gravitator=tur()\gravitator:wani=tur()\wani:swo=tur()\swo:wyd=tur()\nom:
 xww=tur()\x:yww=tur()\y:upal=tur()\upal :Gosub gravitacija2:Gosub pok:
 tur()\y=yww:tur()\upal=upal:tur()\gravitator=gravitator:EndIf 

Wend


Return

pok:

ChangeCurrentElement(tur(), *Old_Element):

PreviousElement(tur())

aas=SpriteWidth(tur()\nom)
If tur()\nom=500 And tur()\swo=swo:
If tur()\swo2<>333
tur()\wani=wani
EndIf 
:tur()\stor=stor:tur()\x=xww-(aas/2)+24:tur()\y=yww-44:tur()\upal=upal:tur()\gravitator=gravitator:EndIf
NextElement(tur())

If tur()\nom=97 And tur()\x<>tur()\x2 And tur()\swo=play:push=0:EndIf 

If tur()\upal=1 :spid=tur()\gravitator/4:EndIf 

If tur()\upal=0:spid=asas:EndIf 

spid2=tur()\spid 

Return 

pokk:
ResetList( tur() ) 
While NextElement( tur())
aas=SpriteWidth(tur()\nom)
If tur()\nom=500 And tur()\swo=swo:tur()\wani=wani:tur()\stor=stor:tur()\x=xww-(aas/2)+24:tur()\y=yww-44:tur()\upal=upal:tur()\gravitator=gravitator:EndIf

If tur()\nom=97 And tur()\x<>tur()\x2 And tur()\swo=play:push=0:EndIf 
;If gravitator>0:push=0:EndIf 


If tur()\nom=97 And tur()\swo=play:

If tur()\upal=1 :spid=tur()\gravitator/4:EndIf 

If tur()\upal=0:spid=asas:EndIf 

spid2=tur()\spid 

:EndIf 
Wend
ChangeCurrentElement(tur(), *Old_Element):
Return 

stop:
If tur()\x=>xyraz*48:Goto sols:EndIf 
aaa=0
wyd=tur()\nom:xww=tur()\x:yww=tur()\y:a2=tur()\iner:spi=tur()\spid
*Old_Element = @tur() 
ResetList( tur() )
While NextElement( tur())
If iner=1:Goto sli:EndIf 

If tur()\nom=>970 Or tur()\nom=27 Or tur()\nom=67  Or tur()\nom=16 Or tur()\nom=17  Or tur()\nom=18 Or tur()\nom=19 Or tur()\nom=21 Or tur()\nom=22 Or tur()\nom=23 Or tur()\nom=24:
Gosub stop3
EndIf
sli2:
Wend 

ChangeCurrentElement(tur(), *Old_Element)
sols:
If tur()\iner>0 And iner=1 And aaa=1:
tur()\x2=tur()\x
tur()\iner2=tur()\iner/2
tur()\iner=0
Return 
EndIf

If iner=1 And aaa=0 And tur()\iner>0
tur()\x+tur()\iner/2
tur()\x2+tur()\iner/2
Return 
EndIf 

ResetList( tur5() ) 
While NextElement( tur5())
If tur5()\nom<>0:nosmog=1:Return:EndIf 
Wend 

If aaa=1:tur()\x2=tur()\x:EndIf 
a=tur()\spid
Repeat
If aaa=0:tur()\x+1:tur()\stor=0:EndIf 
If tur()\x=tur()\x2:Return:Goto pokoj:EndIf 
a-1
Until a=0
Return 

sli:
If tur()\nom=16 Or tur()\nom=17  Or tur()\nom=18 Or tur()\nom=19 Or tur()\nom=21 Or tur()\nom=22 Or tur()\nom=23 Or tur()\nom=24:
Gosub stop3a
EndIf 
Goto sli2

sli3:
If  tur()\nom=16 Or tur()\nom=17  Or tur()\nom=18 Or tur()\nom=19 Or tur()\nom=21 Or tur()\nom=22 Or tur()\nom=23 Or tur()\nom=24:
Gosub stop4a
EndIf 
Goto sli4

stop2:
If tur()\x=<0:Goto solss:EndIf 
aaa=0
wyd=tur()\nom:xww=tur()\x:yww=tur()\y:a2=tur()\iner2:spi=tur()\spid
*Old_Element = @tur() 
ResetList( tur() )
While NextElement( tur())
If iner=1:Goto sli3:EndIf 
If tur()\nom=>970  Or tur()\nom=27 Or tur()\nom=67   Or tur()\nom=16 Or tur()\nom=17  Or tur()\nom=18 Or tur()\nom=19 Or tur()\nom=21 Or tur()\nom=22 Or tur()\nom=23 Or tur()\nom=24:

Gosub stop4
EndIf 

sli4:
Wend 
ChangeCurrentElement(tur(), *Old_Element)
solss:
If tur()\iner2>0 And iner=1 And aaa=1
tur()\x+2
tur()\x2=tur()\x
tur()\iner=tur()\iner2/2
tur()\iner2=0
Return 
EndIf 

If iner=1 And aaa=0 And tur()\iner2>0
tur()\x-tur()\iner2/2
tur()\x2-tur()\iner2/2
Return 
EndIf 
If aaa=1:tur()\x2=tur()\x:EndIf 

ResetList( tur5() ) 
While NextElement( tur5())
If tur5()\nom<>0:nosmog=1:Return:EndIf 
Wend 

a=tur()\spid
Repeat
If aaa=0:tur()\x-1:tur()\stor=1:EndIf 
If tur()\x=tur()\x2:Return:Goto pokoj:EndIf 
a-1
Until a=0


Return 


stop3a:
If SpriteCollision(97, xww, yww, tur()\nom, tur()\x-a2, tur()\y+1)=1:aaa=1:Return:EndIf 
Return 

stop4a:
If SpriteCollision(97, xww, yww, tur()\nom, tur()\x+a2, tur()\y+1)=1:tur()\x2=tur()\x:aaa=1:Return:EndIf 
Return 

stop3:

kto=tur()\nom
rrrr=0


If tur()\swo2<>333 And tur()\nom=27 And SpriteCollision(97, xww, yww, tur()\nom, tur()\x-spi, tur()\y+1)=1:
 
  tx=tur()\x
  ty=tur()\y
  DeleteElement( tur() )
    AddElement( tur() )
    tur()\nom=28
      tur()\x=tx
      tur()\y=ty
      kris=1013-15:Gosub wzryw2:kris=0:
         Gosub wzalart
    Return 
  EndIf 
  
  
  
If tur()\swo2<>333 And tur()\nom=67 And tur()\y2=0 And SpriteCollision(97, xww, yww, tur()\nom, tur()\x-spi, tur()\y+1)=1:
  Gosub wzylpriz
If nod=1:Return:EndIf 
kris=1013-15:Gosub wzryw2:kris=0:
DeleteElement( tur() )
Return:
:EndIf 

If tur()\swo2<>333 And tur()\nom=>970 And SpriteCollision(97, xww, yww, tur()\nom, tur()\x-spi, tur()\y+1)=1:
Gosub wzylpriz
If nod=1:Return:EndIf 
If rrrr=1:Return:EndIf 
kris=1013-15:Gosub wzryw2:kris=0:
DeleteElement( tur() )
Return:
:EndIf 

If SpriteCollision(97, xww, yww, tur()\nom, tur()\x-spi, tur()\y+1)=1:
aaa=1:wanim=0::Return:EndIf 
Return 

stop4:
rrrr=0
kto=tur()\nom

  If tur()\swo2<>333 And tur()\nom=27 And SpriteCollision(97, xww, yww, tur()\nom, tur()\x+spi, tur()\y+1)=1:
    tx=tur()\x
  ty=tur()\y
    DeleteElement( tur() )
    AddElement( tur() )
    tur()\nom=28
      tur()\x=tx
      tur()\y=ty
      kris=1013-15:Gosub wzryw2:kris=0:
        Gosub wzalart
    Return 
  EndIf 

If tur()\swo2<>333 And  tur()\nom=67 And tur()\y2=0 And SpriteCollision(97, xww, yww, tur()\nom, tur()\x+spi, tur()\y+1)=1:
  Gosub wzylpriz
If nod=1:Return:EndIf 
kris=1013-15:Gosub wzryw2:kris=0:
DeleteElement( tur() )
Return:
:EndIf 

If tur()\swo2<>333 And  tur()\nom=>970 And SpriteCollision(97, xww, yww, tur()\nom, tur()\x+spi, tur()\y+1)=1::
Gosub wzylpriz
If nod=1:Return:EndIf 
If rrrr=1:Return:EndIf 
kris=1013-15:Gosub wzryw2:kris=0:
DeleteElement( tur() )
Return:
:EndIf 


If SpriteCollision(97, xww, yww, tur()\nom, tur()\x+spi, tur()\y+1)=1:tur()\x2=tur()\x:aaa=1:Return:EndIf 
Return 

 
 
 
 
gravitacija2:



;Gosub tut2 
;Gosub tut

ao=gravitator/2
ao+1
aaa=ao


If upal=0:
Repeat
 Gosub tut3
If upal=1:ao=0:Return:EndIf 
yww+1
ao-1
Until ao=0
If swo=play:asas=aaa:EndIf  
gravitator+1

EndIf

Return 

tut:
If SpriteCollision(97, xwww, yww, 96, xwwww, ywwww)=1:Goto tut3:EndIf
Return 
tut3:
ResetList( tur() )
While NextElement( tur())
If Random(100)=0 And swo=play And tur3()\bot=1 And tur()\nom=250 And SpriteCollision(250, xww, yww, tur()\nom, tur()\x, tur()\y+50)=1:upal=1:tur()\nom=251:tur()\swo=3:gravitator=120:shlak=1:PlaySound(9):Return:EndIf 

If swo=play And prygnum>0 And tur()\nom=250 And SpriteCollision(250, xww, yww, tur()\nom, tur()\x, tur()\y+50)=1:upal=1:tur()\nom=251:tur()\swo=3:gravitator=120:shlak=1:PlaySound(9):Return:EndIf 
;--------------------------strange
If tur()\nom=77 And SpriteCollision(77, xww, yww, tur()\nom, tur()\x, tur()\y+85)=1:
    If bult=0 And gravitator>0:
       bult=1
       bul=0
       xbu=tur()\x
       ybu=tur()\y
       xbu+20
       PlaySound(11,0)
       EndIf 
  
  
  upal=1:gravitator=0:
  

       
     Return:EndIf 
If tur()\nom=96 And SpriteCollision(97, xww, yww, tur()\nom, tur()\x, tur()\y)=1:upal=1:Return:EndIf 
If tur()\nom=30 And SpriteCollision(97, xww, yww, tur()\nom, tur()\x, tur()\y)=1:Goto teleport:EndIf 
If tur()\nom=98 And SpriteCollision(97, xww, yww, tur()\nom, tur()\x, tur()\y)=1:Goto babahw:EndIf 
Wend 
Return

babahw:
If Random(3)=0:
  PlaySound(10)
  tur()\nom=99
        ResetList( tur() ) 
  While NextElement( tur())
    If tur()\nom=97 And tur()\swo=tur3()\pnom:
      tur()\magic=2000
      EndIf 
  Wend 
  ResetList( tur() ) 
  While NextElement( tur())
    If tur()\nom=500 And tur()\swo=tur3()\pnom:
      tur()\magic=2000
       kris=1013-15
    Goto wzrywmagic:
  EndIf 
  
  Wend 
    
  
  EndIf 
PlaySound(10)
tur()\nom=99
ap=8+Random(8)
Repeat 

 AddElement( tur5() )
 tur5()\life=5000
tur5()\x=Random(xyraz)*48
tur5()\yy=3000
tur5()\nom=6
tur5()\y=-50
tur5()\met=0;storona
tur5()\met2=Random(1)+1;chastota
tur5()\met3=tur5()\met2;
tur5()\met4=Random(3);pixel
tur5()\ataka=ataka
ap-1
Until ap=0

Return 


tut2:
ywww=yww+48
ywww/48
ywww*48
xwww=xww
xwww/48
xwww*48
ResetList( tur() )
While NextElement( tur())
If tur()\nom=96 And tur()\y=ywww And tur()\x=xwww:ywwww=tur()\y-1:xwwww=tur()\x:Return:EndIf
Wend 
Return 


;----------------------upal2
upal2: 
tur()\gravitator-6
gravitator=tur()\gravitator
If tur()\gravitator>0:tur()\y-(gravitator/4):Return:EndIf

upal=0 
tur()\upal=0
space=0
tur()\gravitator=0
gravitator=0
Return 



wani2:
If nosmog=1:Return:EndIf 
If anim2=0:Goto wani3:EndIf
If anim2=2:Goto wani3:EndIf
Return 
wani3:
If tur()\wani=>16 Or aaa=1:Return:EndIf 
wanim=1
tur()\wani+1
If tur()\wani=8:tur()\wani=0:EndIf 
Return 




soz:
  AddElement( tur2() )
  tur2()\xx = xx
  tur2()\yy = yy
  tur2()\x = xx+Random(48)
  tur2()\y = yy
  tur2()\nom = 1
  tur2()\ani = 16+Random(128)
  tur2()\tim = 0+Random(8)
    tur2()\tim2= tur2()\tim
    tur2()\pow = Random(3)
Return 


instalp:
pla=0
plaa=0
ResetList( tur() ) 
While NextElement( tur())
  If tur()\nom=09:pla+1:EndIf 
Wend 
alfaa=0
ResetList( tur3() ) 
While NextElement( tur3())
a1b=tur3()\energ
a11=tur3()\energ1
a111=tur3()\energ2
a2=tur3()\color
a3=tur3()\pnom
a$=tur3()\name$
fox=tur3()\fox
bot=tur3()\bot
Gosub inst22:
Wend 
Return 


inst22:

  inst2:
  If plaa=pla: Dim ss.l(32) :EndIf 
ResetList( tur() ) 
abb=Random(ListSize(tur()) )
If abb=0:abb+1:EndIf 
If abb=>ListSize(tur()):abb-1:EndIf 
SelectElement(tur(), abb)

If tur()\nom=09:
  
    alfaa=0
  Repeat 
    If ss(alfaa)=tur()\x And ss(alfaa+1)=tur()\y:Goto inst2:EndIf 
    alfaa+2
  Until alfaa=24
  
    alfaa=0
  Repeat 
    
   
  If ss(alfaa)=0:
  ss(alfaa)=tur()\x
  ss(alfaa+1)=tur()\y
plaa+1
x=tur()\x
y=tur()\y
Goto inst:
EndIf 
alfaa+2
Until alfaa=24
EndIf 


Goto inst2
Return 

inst:
ResetList( tur() ) 
While NextElement( tur())
 Wend
 
  AddElement( tur() )
  tur()\x = x
  tur()\x2 = x
  tur()\y = y
  tur()\nom = 500
    tur()\swo = a3
     tur()\upal = 0
        tur()\gravitator = 0
        tur()\name$=a$
        tur()\energ=a1b
        tur()\energ1=a11
        tur()\energ2=a111
        tur()\color=a2
        tur()\fox=fox
        tur()\bot=bot
       
  AddElement( tur() )
  tur()\x = x
  tur()\x2 =x
  tur()\y = y
  tur()\nom = 97
   tur()\spid =3
    tur()\swo = a3
       tur()\upal = 0
       tur()\gravitator = 0
       tur()\bot=bot
Return 





save:
CreateFile(0,"Tur/tur3.txt")
ResetList( tur() ) 
While NextElement( tur())
WriteLong(0,tur()\nom)
WriteLong(0,tur()\x)
WriteLong(0,tur()\y)
WriteLong(0,tur()\swo)
Wend
CloseFile(0) 
Return
CreateFile(0,"Tur/tur1dubl.txt")
ResetList( tur() ) 
While NextElement( tur())
WriteLong(0,tur()\nom)
WriteLong(0,tur()\x)
WriteLong(0,tur()\y)
WriteLong(0,tur()\swo)
Wend
CloseFile(0) 
Return


load:

If levelt=>ArraySize(mass2())-1:
  levelt=1
:EndIf 

a$=mass2(levelt)
If a$="0":a$="1":EndIf 
levelt+1

If  levelt=0:levelt=1:EndIf 
If  levelt=>18:levelt=1:EndIf 
ResetList( tur() ) 
While NextElement( tur())
DeleteElement( tur() )
Wend




OpenFile(0,"Tur/"+a$+".txt")

 
Length = Lof(0)
Length-8

ResetList( tur() ) 

Repeat
AddElement( tur() )
tur()\nom=ReadLong(0)
tur()\x=ReadLong(0)
tur()\y=ReadLong(0)
tur()\swo=ReadLong(0)
Length-16
Until Length=0
xyraz=ReadLong(0)

;If sizel=3 And xyraz<64:Goto load:EndIf 
;If sizel=2 And xyraz<47:Goto load:EndIf 
;If sizel=2 And xyraz>50:Goto load:EndIf 
;If sizel=1 And xyraz>33:Goto load:EndIf 

fon=ReadLong(0)
CloseFile(0)

If fon=3:
  
LoadSprite (33, "sprite/1073.png" )
LoadSprite (34, "sprite/1082.png" )
LoadSprite (35, "sprite/1093.png" )
LoadSprite (36, "sprite/1103.png" )
LoadSprite (37, "sprite/1113.png" )
LoadSprite (38, "sprite/1123.png" )
LoadSprite (39, "sprite/1133.png" )
LoadSprite (40, "sprite/1143.png" )
LoadSprite (41, "sprite/1153.png" )
LoadSprite (42, "sprite/1163.png" )
LoadSprite (43, "sprite/117.png" )
LoadSprite (32, "sprite/8bb2.png" )
LoadSprite (281, "sprite/633.png" )
LoadSprite (282, "sprite/643.png" )
LoadSprite (122, "sprite/1063.png" )
LoadSprite (119, "fon/fon4.png" )
LoadSprite (136, "sprite/200.png" )
LoadSprite (137, "sprite/201.png" )
LoadSprite (138, "sprite/202.png" )
LoadSprite (283, "fon/fon1b.png" )
LoadSprite (54, "sprite/10633.png" )
EndIf 




If fon=0:
If mods=1
LoadSprite (119, "mods/"+MORE$+"/TMoD/fon1.png" )
Else
LoadSprite (119, "fon/fon1.png" )
EndIf
LoadSprite (33, "sprite/107.png" )
LoadSprite (34, "sprite/108.png" )
LoadSprite (35, "sprite/109.png" )
LoadSprite (36, "sprite/110.png" )
LoadSprite (37, "sprite/111.png" )
LoadSprite (38, "sprite/112.png" )
LoadSprite (39, "sprite/113.png" )
LoadSprite (40, "sprite/114.png" )
LoadSprite (41, "sprite/115.png" )
LoadSprite (42, "sprite/116.png" )
LoadSprite (43, "sprite/117.png" )
LoadSprite (122, "sprite/106.png" )
LoadSprite (136, "sprite/200.png" )
LoadSprite (137, "sprite/201.png" )
LoadSprite (138, "sprite/202.png" )
LoadSprite (122, "sprite/1063b.png" )

LoadSprite (281, "sprite/63.png" )
LoadSprite (282, "sprite/64.png" )
If mods=1
LoadSprite (32, "mods/"+MORE$+"/TMoD/8bb.png" )
Else
LoadSprite (32, "sprite/8bb.png" )
EndIf
LoadSprite (283, "fon/fon1a.png" )
If mods=1 And ReadFile (0, "mods/"+MORE$+"/TMoD/fon1.png" )
LoadSprite (280, "mods/"+MORE$+"/TMoD/fon1.png" )
Else
LoadSprite (280, "fon/1.png" )
EndIf
LoadSprite (54, "sprite/54.png" )
EndIf 

If fon=1:

  LoadSprite (33, "sprite/107.png" )
LoadSprite (34, "sprite/108.png" )
LoadSprite (35, "sprite/109.png" )
LoadSprite (36, "sprite/110.png" )
LoadSprite (37, "sprite/111.png" )
LoadSprite (38, "sprite/112.png" )
LoadSprite (39, "sprite/113.png" )
LoadSprite (40, "sprite/114.png" )
LoadSprite (41, "sprite/115.png" )
LoadSprite (42, "sprite/116.png" )
LoadSprite (43, "sprite/117.png" )
LoadSprite (32, "sprite/8bb.png" )
LoadSprite (281, "sprite/63.png" )
LoadSprite (282, "sprite/64.png" )
LoadSprite (122, "sprite/106.png" )
LoadSprite (119, "fon/fon2.png" )
LoadSprite (136, "sprite/200.png" )
LoadSprite (137, "sprite/201.png" )
LoadSprite (138, "sprite/202.png" )
LoadSprite (283, "fon/fon1a.png" )
LoadSprite (280, "fon/1.png" )
LoadSprite (54, "sprite/54.png" )
EndIf 



If fon=2:
  LoadSprite (33, "sprite/1072.png" )
LoadSprite (34, "sprite/1082.png" )
LoadSprite (35, "sprite/1092.png" )
LoadSprite (36, "sprite/1102.png" )
LoadSprite (37, "sprite/1112.png" )
LoadSprite (38, "sprite/1122.png" )
LoadSprite (39, "sprite/1132.png" )
LoadSprite (40, "sprite/1142.png" )
LoadSprite (41, "sprite/1152.png" )
LoadSprite (42, "sprite/1162.png" )
LoadSprite (43, "sprite/117.png" )
LoadSprite (32, "sprite/8bb2.png" )
LoadSprite (281, "sprite/632.png" )
LoadSprite (282, "sprite/642.png" )

;If mods=1
;LoadSprite (122, "mods"+MODNAME+"sprite/1062.png" )
;Else
LoadSprite (122, "sprite/1062.png" )
;EndIf
LoadSprite (119, "fon/fon3.png" )
LoadSprite (136, "sprite/200.png" )
LoadSprite (137, "sprite/201.png" )
LoadSprite (138, "sprite/202.png" )
LoadSprite (283, "fon/fon1a.png" )
LoadSprite (280, "fon/1.png" )
LoadSprite (54, "sprite/54.png" )
EndIf 
Return
;----------------------teleport
teleport:
;If prygnum=0 And tur()\bot=0:Return:EndIf 
PlaySound(10)
If swo=play: 
If tur()\swo=0:Goto teleport20:EndIf 
If tur()\swo=1:Goto teleport2:EndIf 
If tur()\swo=2:Goto teleport23:EndIf 
If tur()\swo=3:Goto teleport202:EndIf
:EndIf 
Return

teleport2:
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=30 And tur()\swo=0:Goto teleport3:EndIf 
Wend 
Return 
teleport20:
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=30 And tur()\swo=1:Goto teleport3:EndIf 
Wend 
Return 
teleport23:
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=30 And tur()\swo=3:Goto teleport3:EndIf 
Wend 
Return 
teleport202:
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=30 And tur()\swo=2:Goto teleport3:EndIf 
Wend 
Return 


teleport3:
xww=tur()\x:yww=tur()\y
yww+47
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=97 And play=tur()\swo:tur()\x=xww:tur()\y=yww:tur()\x2=xww:tur()\y2=yww:tur()\gravitator=0
tur()\upal=0
gravitator=0
space=0
upal=0:Goto teleport50:EndIf 
Wend 

Return 
teleport50:
xwwww=xww
ywwww=yww
ywwww-10
xwwww+10
a000=1
teleport=4
teleport3=1
teleport2=1
Return 

teleportkre:;
If teleport2=1:Goto teleportkre2:EndIf 
Return 

teleportkre2:
teleport3-1
If teleport3=0:Goto teleportkre4:EndIf 
Return 

teleportkre4:
teleport3=a000
a000+1
If teleport=0:teleport2=0:EndIf 
teleport-1
a0=0
Repeat
AddElement( tur4() )
  tur4()\x = xwwww
  tur4()\y = ywwww
  tur4()\nom = a000
  tur4()\degr=a0
  If a0=0:tur4()\life = 25:EndIf 
  If a0=2:tur4()\life = 25:EndIf
  If a0=4:tur4()\life = 25:EndIf
  If a0=6:tur4()\life = 25:EndIf
  If a0=1:tur4()\life = 18:EndIf 
  If a0=3:tur4()\life = 18:EndIf
  If a0=5:tur4()\life = 18:EndIf
  If a0=7:tur4()\life = 18:EndIf
  a0+1
  Until a0=8
  Return 
  ikonn:
  If iko=0:Return:EndIf 
  DisplayTransparentSprite (1010 , xraz/2-(196/2), yraz/2-(96/2)-50)
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=500 And play=tur()\swo:Gosub ikonnn:EndIf 
Wend

Return 
ikonnn:
StartDrawing( ScreenOutput())
DrawingFont(FontID(4)) 
DrawingMode(#PB_2DDrawing_Transparent )
ff=TextWidth(tur()\name$)
ff/2
If lang=0
  DrawText(70+xraz/2-(196/2)-ff, 30+yraz/2-(96/2)-50, "Ходит ", RGB((255),(200),(100)) )
EndIf 
If lang=1
  DrawText(70+xraz/2-(196/2)-ff, 30+yraz/2-(96/2)-50, "Walks ", RGB((255),(200),(100)) )
  EndIf 
DrawText(70+xraz/2-(196/2)-ff+46, 30+yraz/2-(96/2)-50, tur()\name$, tur()\color )
  StopDrawing() 
  Return 
  
  
  shoppp:
    *Old_Element666 = @tur3() 

  
    Gosub ikon0:
  
 
  


  

If fon=0 Or fon=1:ClearScreen (RGB(0, 132, 255)):EndIf 
If fon=2:ClearScreen (RGB(0, 40, 80)):EndIf 
If fon=3:ClearScreen (RGB(255, 158, 158)):EndIf 
Gosub animacija

Gosub print2

Gosub gravitacija

Gosub print
Gosub print4
Gosub print3
Gosub textl


Gosub mouse




gotog2:
 ExamineMouse() 
 If MouseButton(1):Goto gotog2:EndIf
 
 gotog:
WaitWindowEvent()
If fon=0 Or fon=1:ClearScreen (RGB(0, 132, 255)):EndIf 
If fon=2:ClearScreen (RGB(0, 40, 80)):EndIf 
If fon=3:ClearScreen (RGB(255, 158, 158)):EndIf 
Gosub animacija

Gosub print2

Gosub gravitacija

Gosub print
Gosub print4
Gosub print3
Gosub textl
  Gosub ikon0

  
  ExamineMouse() 
    If MouseButton(1):Goto gotog3:EndIf 



 xm-c:ym-d
xm/48:xm*48
ym/48:ym*48
xm33=xm
ym33=ym
  xm = MouseX()                         
  ym = MouseY() 
  
  
;---------------ПОДАРОККККККККККККККККККК 


            ExamineKeyboard()
            let$ = KeyboardInkey()
            If (Asc(let$) >= 47 And Asc(let$) < 58): fulltext3$ + let$: EndIf
            
                         If KeyboardReleased(#PB_Key_Return)
     Goto gotog3
      EndIf
  
                              If KeyboardReleased(#PB_Key_Back)
        FullText3$ = Left(FullText3$, Len(FullText3$)-1)
      EndIf
  
      
      aggo=Val(fulltext3$)
      If aggo>money Or aggo<0:aggo=money:
        
        FullText3$=Str(money)
      EndIf 
      
 DisplayTransparentSprite(1010, xraz/2-90,yraz/2-140)
 StartDrawing( ScreenOutput())
 DrawingFont(FontID(4)) 
    DrawingMode(#PB_2DDrawing_Transparent )

    If lang=0
      DrawText(xraz/2-90+68,yraz/2-140+30,"Сколько?", RGB((255),(255),(255)) )
    EndIf 
       If lang=1
      DrawText(xraz/2-90+68,yraz/2-140+30,"How much?", RGB((255),(255),(255)) )
      EndIf 
    
    
     a=TextWidth(Str(aggo))
      a/2
      If asago=>25:DrawText(xraz/2-90+25+73-a,yraz/2-140+37+10,Str(aggo)+"_", RGB((255),(255),(255)) ):EndIf 
       If asago<25:DrawText(xraz/2-90+25+73-a,yraz/2-140+37+10,Str(aggo)+"  ", RGB((255),(255),(255)) ):EndIf 
   If asago=0:asago=50:EndIf 
   asago-1
   
   StopDrawing() 
 
DisplayTransparentSprite(1, xm, ym)



FlipBuffers()
Goto gotog:



  gotog3:
   ExamineMouse() 
   If MouseButton(1):Goto gotog3:EndIf
   FullText3$=""
   
       tur3()\money-aggo
     ChangeCurrentElement(tur3(), *Old_Element666)
  
     tur3()\money+aggo
     aggo=0
  shop1=0:Return
  
  ;----------------------shop
  shop:
  ;-----------------------frog1
  

  ExamineKeyboard()
  If KeyboardPushed(#PB_Key_1):
      ExamineKeyboard()
    If KeyboardPushed(#PB_Key_9):
      ResetList( tur() ) 
  While NextElement( tur())
    If tur()\nom=97 And tur()\swo=tur3()\pnom:
      tur()\magic=2000
      EndIf 
  Wend 
  ResetList( tur() ) 
  While NextElement( tur())
    If tur()\nom=500 And tur()\swo=tur3()\pnom:
      tur()\magic=2000
       kris=1013-15
    Goto wzrywmagic:
      EndIf 
  Wend 
    EndIf 
 :EndIf 
  
  
  
  If shop1=0 Or bot=1:Return:EndIf 
  
  
  
  
  
  skok2=ListSize(tur9())-5

ExamineMouse() 
 
 xm = MouseX()                         
 ym = MouseY() 

    StartDrawing( ScreenOutput())
    DrawingFont(FontID(1)) 
DrawingMode(#PB_2DDrawing_Transparent )

 If MouseButton(1) And xm<11+50:shop1=0:EndIf 
 If MouseButton(1) And xm>11+52+8+180+128-10-110+215:shop1=0:EndIf 
 If MouseButton(1) And ym<yraz-124+22+55-341:shop1=0:EndIf 
 If MouseButton(1) And ym>yraz-200:shop1=0:EndIf 

Box(11+50,yraz-124+22+55-341, 302+110, 82+100, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340, 300+110, 80+100, RGB(125,125,125))
Box(11+50,yraz-124+22+55-341, 302+110, 22, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340, 300+110, 20, RGB(125-20,125-20,125-20))

If xm=>11+52+8+180+128-10 And xm<11+52+8+180+128-10+100 And ym>yraz-124+22+55-340+1 And ym<yraz-124+22+55-340+1+18:Box(11+52+8+180+128-10,yraz-124+22+55-340+1, 103, 18, RGB(0,125,125)):
If MouseButton(1):shop1=0:Goto shopp:EndIf 
EndIf
If xm=>11+52+8+180+128-10-220 And xm<11+52+8+180+128-10+100-220 And ym>yraz-124+22+55-340+1 And ym<yraz-124+22+55-340+1+18:Box(11+52+8+180+128-10-220,yraz-124+22+55-340+1, 103, 18, RGB(0,125,125)):
If MouseButton(1):shop1=2:Goto shopp:EndIf 
EndIf
      
If xm=>11+52+8+180+128-10-306 And xm<11+52+8+180+128-10+100-306-20 And ym>yraz-124+22+55-340+1 And ym<yraz-124+22+55-340+1+18:Box(11+52+8+180+128-10-306,yraz-124+22+55-340+1, 80, 18, RGB(0,125,125)):
If MouseButton(1):shop1=1:Goto shopp:EndIf 
EndIf

If xm=>11+52+8+180+128-10-110 And xm<11+52+8+180+128-10+100-110 And ym>yraz-124+22+55-340+1 And ym<yraz-124+22+55-340+1+18:Box(11+52+8+180+128-10-110,yraz-124+22+55-340+1, 110, 18, RGB(0,125,125)):
If MouseButton(1):shop1=3:Goto shopp:EndIf 
EndIf
If lang=0
If shop1=1:DrawText(12+50+4,yraz-124+22+55-340-2, "Купить", RGB((255),(200),(100)) ):EndIf 
If shop1<>1:DrawText(12+50+4,yraz-124+22+55-340-2, "Купить", RGB((80),(80),(80)) ):EndIf 
If shop1=2:DrawText(12+50+4+95,yraz-124+22+55-340-2, "Продать", RGB((255),(200),(100)) ):EndIf 
If shop1<>2:DrawText(12+50+4+95,yraz-124+22+55-340-2, "Продать", RGB((80),(80),(80)) ):EndIf 
DrawText(12+50+4+90+110,yraz-124+22+55-340-2, "Подарить", RGB((80),(80),(80)) )
DrawText(12+50+4+90+230,yraz-124+22+55-340-2, "Выйти", RGB((80),(80),(80)) )

EndIf 
If lang=1
If shop1=1:DrawText(12+50+4,yraz-124+22+55-340-2, "Buy", RGB((255),(200),(100)) ):EndIf 
If shop1<>1:DrawText(12+50+4,yraz-124+22+55-340-2, "Buy", RGB((80),(80),(80)) ):EndIf 
If shop1=2:DrawText(12+50+4+95,yraz-124+22+55-340-2, "Sell", RGB((255),(200),(100)) ):EndIf 
If shop1<>2:DrawText(12+50+4+95,yraz-124+22+55-340-2, "Sell", RGB((80),(80),(80)) ):EndIf 
DrawText(12+50+4+90+110,yraz-124+22+55-340-2, "Give", RGB((80),(80),(80)) )
DrawText(12+50+4+90+230,yraz-124+22+55-340-2, "Exit", RGB((80),(80),(80)) )

EndIf 
      Box(11+52,yraz-124+22+55-340+32+4, 302+106, 32, RGB(125+20,125,125))
      Box(11+52,yraz-124+22+55-340+32+4+64, 302+106, 32, RGB(125+20,125,125))
      

      
 
     

   
   
If xm=>11+52+10 And xm<11+52+10+390 And ym>yraz-124+22+55-340+20 And ym<yraz-124+22+55-340+22+12:Box(11+52+8,yraz-124+22+55-340+22, 390, 12, RGB(0,125,125)):
  If MouseButton(1) And skok>0:skok-1:EndIf 
 

EndIf 
If xm=>11+52+10 And xm<11+52+10+390 And ym>yraz-124+22+55-340+20+128+16 And ym<yraz-124+22+55-340+22+12+128+16:Box(11+52+8,yraz-124+22+55-340+22+128+16, 390, 12, RGB(0,125,125)):
If MouseButton(1) And skok<skok2:skok+1:EndIf 
EndIf 




If shop1=3
  
   
     
  money=tur3()\money
     yt=0
      ResetList( tur3() ) 
      While NextElement( tur3())
        If tur3()\pnom>0 And tur3()\pnom<>play:  
           
          If xm>11+52+100 And xm<11+52+100+200 And ym>yraz-124+22+55-340+22+32+(yt*16) And ym<yraz-124+22+55-340+22+48+(yt*16)
         Box(11+52+100,yraz-124+22+55-340+22+32+(yt*16), 200, 16, RGB(0,125,125))
          
        
                  If MouseButton(1):
                    StopDrawing()
                    kto$=tur3()\name$
                  aggo=0
             Goto shoppp:
        :EndIf   

        
        
        EndIf 
         
          
    
           
           
           
        yt+1
      :EndIf 
         Wend 
      

EndIf 



skok3=0


If shop1=1
If xm=>11+52+10 And xm<11+52+10+180 And ym>yraz-124+22+55-340+20+14 And ym<yraz-124+22+55-340+22+12+32:Box(11+52+8,yraz-124+22+55-340+22+14, 180, 32, RGB(0,125,125)):
If MouseButton(1):skok3=0:Goto kupil:EndIf 
EndIf

If xm=>11+52+10+180 And xm<11+52+10+180+180 And ym>yraz-124+22+55-340+20+14 And ym<yraz-124+22+55-340+22+12+32:Box(11+52+8+180,yraz-124+22+55-340+22+14, 180, 32, RGB(0,125,125)):
  If MouseButton(1) :skok3=1:Goto kupil:EndIf 
EndIf 

If xm=>11+52+10 And xm<11+52+10+180 And ym>yraz-124+22+55-340+20+14+32 And ym<yraz-124+22+55-340+22+12+32+32:Box(11+52+8,yraz-124+22+55-340+22+14+32, 180, 32, RGB(0,125,125)):
If MouseButton(1)::skok3=2:Goto kupil:EndIf 
EndIf 
If xm=>11+52+10+180 And xm<11+52+10+180+180 And ym>yraz-124+22+55-340+20+14+32 And ym<yraz-124+22+55-340+22+12+32+32:Box(11+52+8+180,yraz-124+22+55-340+22+14+32, 180, 32, RGB(0,125,125)):
If MouseButton(1) ::skok3=3:Goto kupil:EndIf 
EndIf 

If xm=>11+52+10 And xm<11+52+10+180 And ym>yraz-124+22+55-340+20+14+32+32 And ym<yraz-124+22+55-340+22+12+32+32+32:Box(11+52+8,yraz-124+22+55-340+22+14+32+32, 180, 32, RGB(0,125,125)):
If MouseButton(1) :skok3=4:Goto kupil:EndIf 
EndIf 
If xm=>11+52+10+180 And xm<11+52+10+180+180 And ym>yraz-124+22+55-340+20+14+32+32 And ym<yraz-124+22+55-340+22+12+32+32+32:Box(11+52+8+180,yraz-124+22+55-340+22+14+32+32, 180, 32, RGB(0,125,125)):
If MouseButton(1) :skok3=5:Goto kupil:EndIf 
EndIf 

If xm=>11+52+10 And xm<11+52+10+180 And ym>yraz-124+22+55-340+20+14+32+32+32 And ym<yraz-124+22+55-340+22+12+32+32+32+32:Box(11+52+8,yraz-124+22+55-340+22+14+32+32+32, 180, 32, RGB(0,125,125)):
If MouseButton(1) :skok3=6:Goto kupil:EndIf 
EndIf 
If xm=>11+52+10+180 And xm<11+52+10+180+180 And ym>yraz-124+22+55-340+20+14+32+32+32 And ym<yraz-124+22+55-340+22+12+32+32+32+32:Box(11+52+8+180,yraz-124+22+55-340+22+14+32+32+32, 180, 32, RGB(0,125,125)):
If MouseButton(1) :skok3=7:Goto kupil:EndIf 
EndIf 
EndIf 

If shop1=2
If  tur3()\slot1a>0 And  xm=>11+52+10 And xm<11+52+10+280 And ym>yraz-124+22+55-340+20+14 And ym<yraz-124+22+55-340+22+12+32:Box(11+52+8,yraz-124+22+55-340+22+14, 380, 32, RGB(0,125,125)):
If MouseButton(1):skok3=0:Goto kupil:EndIf 
EndIf


If tur3()\slot2a>0 And xm=>11+52+10 And xm<11+52+10+280 And ym>yraz-124+22+55-340+20+14+32 And ym<yraz-124+22+55-340+22+12+32+32:Box(11+52+8,yraz-124+22+55-340+22+14+32, 380, 32, RGB(0,125,125)):
If MouseButton(1)::skok3=1:Goto kupil:EndIf 
EndIf 

If tur3()\slot3a>0 And  xm=>11+52+10 And xm<11+52+10+280 And ym>yraz-124+22+55-340+20+14+32+32 And ym<yraz-124+22+55-340+22+12+32+32+32:Box(11+52+8,yraz-124+22+55-340+22+14+32+32, 380, 32, RGB(0,125,125)):
If MouseButton(1) :skok3=2:Goto kupil:EndIf 
EndIf 


If tur3()\slot4a>0 And  xm=>11+52+10 And xm<11+52+10+280 And ym>yraz-124+22+55-340+20+14+32+32+32 And ym<yraz-124+22+55-340+22+12+32+32+32+32:Box(11+52+8,yraz-124+22+55-340+22+14+32+32+32, 380, 32, RGB(0,125,125)):
If MouseButton(1) :skok3=3:Goto kupil:EndIf 
EndIf 

EndIf 


shopp:
level=tur3()\kakoj
If level=0:ax=tur3()\slot1p:weapon=tur3()\slot1:EndIf 
If level=32:ax=tur3()\slot2p:weapon=tur3()\slot2:EndIf
If level=64:ax=tur3()\slot3p:weapon=tur3()\slot3:EndIf
If level=96:ax=tur3()\slot4p:weapon=tur3()\slot4:EndIf
If level=128:ax=tur3()\slot5p:weapon=tur3()\slot5:EndIf
If level=160:ax=tur3()\slot6p:weapon=tur3()\slot6:EndIf
If level=192:ax=tur3()\slot7p:weapon=tur3()\slot7:EndIf
If level=224:ax=tur3()\slot8p:weapon=tur3()\slot8:EndIf



ExamineMouse() 
If MouseButton(1) :Goto shopp:EndIf 


     StopDrawing()


  Delay(20)
ExamineMouse() 

     If skok>0 And MouseWheel()>0:skok-1:EndIf 
    If skok<skok2 And MouseWheel()<0:skok+1:EndIf 
  
  
  
  l=0
  ykto=yraz-124+22+55-340+32+4
  
  If shop1=2:Goto prod:EndIf 
    
  If shop1=3:Goto prod2:EndIf 
  ResetList( tur9() ) 
  SelectElement(tur9(),skok)
  While NextElement( tur9())
    If ykto<yraz-124+22+55-340+32+128:

     Gosub lp
    DisplayTransparentSprite(tur9()\kto,11+52+10,ykto)
      DisplayTransparentSprite(tur9()\kto2,11+52+10+180,ykto)
EndIf 
  ykto+32
  Wend 
  DisplayTransparentSprite(4,11+52+10+180,yraz-124+22+55-340+24)
  DisplayTransparentSprite(5,11+52+10+180,yraz-124+22+55-340+24+128+16)
  
  Return 
  lp:
  StartDrawing( ScreenOutput())
  DrawingFont(FontID(4)) 
   DrawingMode(#PB_2DDrawing_Transparent )
DrawText(11+52+10+36,ykto, tur9()\kto3, RGB((20),(20),(20)) )
DrawText(11+52+10+36,ykto+12, tur9()\kto4, RGB((50),(50),(50)) )
DrawText(11+52+10+36+180,ykto, tur9()\kto5, RGB((20),(20),(20)) )
DrawText(11+52+10+36+180,ykto+12, tur9()\kto6, RGB((50),(50),(50)) )
    StopDrawing() 
    Return 
    
    
    
    prod2:

    StartDrawing( ScreenOutput())
    DrawingFont(FontID(4)) 
    DrawingMode(#PB_2DDrawing_Transparent )
    If lang=0
       DrawText(11+52+10+106,ykto+2, "Кому хотите сделать подарок?", RGB((255),(200),(100)) ):
       EndIf 
           If lang=1
       DrawText(11+52+10+126,ykto+2, "Who want to make a gift?", RGB((255),(200),(100)) ):
       EndIf 
       
          
       
       yt=0
       ResetList( tur3() ) 
       While NextElement( tur3())
         If tur3()\pnom>0 And tur3()\pnom<>play:
        
         ff=TextWidth(tur3()\name$)
         ff/2

             :DrawText(11+52+10+86+106-ff,ykto+2+16+yt, tur3()\name$ , tur3()\color ): 
           
           yt+16:EndIf 
       
         Wend 


       StopDrawing()

  
       
Return 
    
    
    
    
    prod:


   If tur3()\slot1a>0: DisplayTransparentSprite(tur3()\slot1a,11+52+10,ykto):EndIf 
    If tur3()\slot2a>0:  DisplayTransparentSprite(tur3()\slot2a,11+52+10,ykto+32):EndIf 
    If tur3()\slot3a>0:  DisplayTransparentSprite(tur3()\slot3a,11+52+10,ykto+64):EndIf 
    If tur3()\slot4a>0:  DisplayTransparentSprite(tur3()\slot4a,11+52+10,ykto+64+32):EndIf 
    
    StartDrawing( ScreenOutput())
    DrawingFont(FontID(4)) 
       DrawingMode(#PB_2DDrawing_Transparent )
       

       
       If lang=0
    
If tur3()\slot1a=970: DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Мухомор 150 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=971:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Волшебная лампа. 1000 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=972:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Желтая кровь. 20 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=973:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Красная кровь. 140 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=974:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Зелье из рыбы. 80 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=975:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Кошелек. 20 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=976:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Синяя кровь. 60 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=977:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Морковь. 50 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=978:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Болотная жаба. 250 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=979:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Меч злого хорька. 100 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=980:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Ящик боеприпасов. 80 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=981:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Наливное яблочко. 50 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=982:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Тухлая рыба. 120 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=983:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Какашка лисички-фенька. 160 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=984:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Корона морской выдры. 500 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=985:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Древний доспех. 400 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=986:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Ботинки. 100 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=987:DrawText(11+52+10+36,ykto+2, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Кожаный щит. 260 кредитов", RGB((20),(20),(20)) ):EndIf 
       
If tur3()\slot2a=970:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Мухомор 150 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=971:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Волшебная лампа. 1000 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=972:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Желтая кровь. 20 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=973:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Красная кровь. 140 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=974:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Зелье из рыбы. 80 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=975:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Кошелек. 20 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=976:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Синяя кровь. 60 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=977:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Морковь. 50 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=978:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Болотная жаба. 250 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=979:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Меч злого хорька. 100 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=980:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Ящик боеприпасов. 80 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=981:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Наливное яблочко. 50 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=982:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Тухлая рыба. 120 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=983:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Какашка лисички-фенька. 160 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=984:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Корона морской выдры. 500 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=985:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Древний доспех. 400 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=986:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Ботинки. 100 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=987:DrawText(11+52+10+36,ykto+2+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Кожаный щит. 260 кредитов", RGB((20),(20),(20)) ):EndIf 

If tur3()\slot3a=970:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Мухомор 150 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=971:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Волшебная лампа. 1000 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=972:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Желтая кровь. 20 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=973:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Красная кровь. 140 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=974:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Зелье из рыбы. 80 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=975:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Кошелек. 20 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=976:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Синяя кровь. 60 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=977:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Морковь. 50 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=978:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Болотная жаба. 250 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=979:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Меч злого хорька. 100 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=980:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Ящик боеприпасов. 80 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=981:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Наливное яблочко. 50 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=982:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Тухлая рыба. 120 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=983:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Какашка лисички-фенька. 160 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=984:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Корона морской выдры. 500 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=985:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Древний доспех. 400 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=986:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Ботинки. 100 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=987:DrawText(11+52+10+36,ykto+2+64, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Кожаный щит. 260 кредитов", RGB((20),(20),(20)) ):EndIf 

If tur3()\slot4a=970:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Мухомор 150 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=971:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Волшебная лампа. 1000 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=972:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Желтая кровь. 20 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=973:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Красная кровь. 140 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=974:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Зелье из рыбы. 80 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=975:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Кошелек. 20 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=976:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Синяя кровь. 60 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=977:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Морковь. 50 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=978:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Болотная жаба. 250 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=979:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Меч злого хорька. 100 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=980:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Ящик боеприпасов. 80 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=981:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Наливное яблочко. 50 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=982:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Тухлая рыба. 120 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=983:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Какашка лисички-фенька. 160 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=984:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Корона морской выдры. 500 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=985:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Древний доспех. 400 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=986:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Ботинки. 100 кредитов", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=987:DrawText(11+52+10+36,ykto+2+64+32, "Артефакт:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Кожаный щит. 260 кредитов", RGB((20),(20),(20)) ):EndIf 
    
EndIf 

          If lang=1
    
If tur3()\slot1a=970: DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Amanita 150 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=971:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Magic Lamp. 1000 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=972:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Yellow blood. 20 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=973:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Red blood. 140 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=974:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Potion of fish. 80 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=975:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Purse. 20 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=976:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Blue blood. 60 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=977:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Carrots. 50 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=978:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Swamp toad. 250 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=979:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Sword of the evil ferret. 100 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=980:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Box of ammunition. 80 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=981:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Filler apple. 50 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=982:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Rotten fish. 120 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=983:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Poo-Fennec chanterelles. 160 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=984:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Crown of the sea otter. 500 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=985:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Ancient armor. 400 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=986:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Shoes. 100 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot1a=987:DrawText(11+52+10+36,ykto+2, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2, "Leather shield. 260 credits", RGB((20),(20),(20)) ):EndIf 
       
If tur3()\slot2a=970:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Amanita 150 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=971:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Magic Lamp. 1000 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=972:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Yellow blood. 20 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=973:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Red blood. 140 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=974:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Potion of fish. 80 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=975:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Purse. 20 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=976:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Blue blood. 60 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=977:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Carrots. 50 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=978:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Swamp toad. 250 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=979:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Sword of the evil ferret. 100 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=980:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Box of ammunition. 80 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=981:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Filler apple. 50 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=982:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Rotten fish. 120 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=983:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Poo-Fennec chanterelles. 160 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=984:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Crown of the sea otter. 500 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=985:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Ancient armor. 400 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=986:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Shoes. 100 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot2a=987:DrawText(11+52+10+36,ykto+2+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+32, "Leather shield. 260 credits", RGB((20),(20),(20)) ):EndIf 

If tur3()\slot3a=970:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Amanita 150 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=971:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Magic Lamp. 1000 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=972:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Yellow blood. 20 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=973:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Red blood. 140 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=974:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Potion of fish. 80 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=975:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Purse. 20 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=976:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Blue blood. 60 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=977:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Carrots. 50 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=978:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Swamp toad. 250 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=979:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Sword of the evil ferret. 100 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=980:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Box of ammunition. 80 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=981:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Filler apple. 50 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=982:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Rotten fish. 120 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=983:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Poo-Fennec chanterelles. 160 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=984:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Crown of the sea otter. 500 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=985:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Ancient armor. 400 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=986:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Shoes. 100 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot3a=987:DrawText(11+52+10+36,ykto+2+64, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64, "Leather shield. 260 credits", RGB((20),(20),(20)) ):EndIf 

If tur3()\slot4a=970:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Amanita 150 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=971:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Magic Lamp. 1000 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=972:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Yellow blood. 20 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=973:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Red blood. 140 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=974:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Potion of fish. 80 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=975:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Purse. 20 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=976:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Blue blood. 60 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=977:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Carrots. 50 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=978:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Swamp toad. 250 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=979:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Sword of the evil ferret. 100 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=980:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Box of ammunition. 80 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=981:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Filler apple. 50 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=982:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Rotten fish. 120 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=983:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Poo-Fennec chanterelles. 160 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=984:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Crown of the sea otter. 500 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=985:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Ancient armor. 400 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=986:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Shoes. 100 credits", RGB((20),(20),(20)) ):EndIf 
If tur3()\slot4a=987:DrawText(11+52+10+36,ykto+2+64+32, "Artifact:", RGB((255),(200),(100)) ):DrawText(11+52+10+36+70,ykto+2+64+32, "Leather shield. 260 credits", RGB((20),(20),(20)) ):EndIf 
    
EndIf 

    StopDrawing() 
    

   DisplayTransparentSprite(4,11+52+10+180,yraz-124+22+55-340+24)
   DisplayTransparentSprite(5,11+52+10+180,yraz-124+22+55-340+24+128+16)
  
  Return 

    
    
    
    kupil:
    If shop1=2:
      If skok3=0:
        If tur3()\slot1a=978:tur3()\money+250:tur3()\slot1a=0:PlaySound(5):or111=978:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
      If tur3()\slot1a=970:tur3()\money+150:tur3()\slot1a=0:PlaySound(5):or111=970:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
    If tur3()\slot1a=971:tur3()\money+1000:tur3()\slot1a=0:PlaySound(5):or111=971:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
     If tur3()\slot1a=972:tur3()\money+20:tur3()\slot1a=0:PlaySound(5):or111=972:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
     If tur3()\slot1a=973:tur3()\money+140:tur3()\slot1a=0:PlaySound(5):or111=973:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
   If tur3()\slot1a=974:tur3()\money+80:tur3()\slot1a=0:PlaySound(5):or111=974:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
   If tur3()\slot1a=975:tur3()\money+20:tur3()\slot1a=0:PlaySound(5):or111=975:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
  If tur3()\slot1a=976:tur3()\money+60:tur3()\slot1a=0:PlaySound(5):or111=976:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
  If tur3()\slot1a=977:tur3()\money+50:tur3()\slot1a=0:PlaySound(5):or111=977:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot1a=979:tur3()\money+100:tur3()\slot1a=0:PlaySound(5):or111=978:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot1a=980:tur3()\money+80:tur3()\slot1a=0:PlaySound(5):or111=980:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot1a=981:tur3()\money+50:tur3()\slot1a=0:PlaySound(5):or111=981:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot1a=982:tur3()\money+120:tur3()\slot1a=0:PlaySound(5):or111=982:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot1a=983:tur3()\money+160:tur3()\slot1a=0:PlaySound(5):or111=983:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot1a=984:tur3()\money+500:tur3()\slot1a=0:PlaySound(5):or111=984:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot1a=985:tur3()\money+400:tur3()\slot1a=0:PlaySound(5):or111=985:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot1a=986:tur3()\money+100:tur3()\slot1a=0:PlaySound(5):or111=986:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot1a=987:tur3()\money+260:tur3()\slot1a=0:PlaySound(5):or111=987:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 


      EndIf 
          If skok3=1:
        If tur3()\slot2a=978:tur3()\money+250:tur3()\slot2a=0:PlaySound(5):or111=978:Gosub minusa222:Gosub sdwig: Goto shopp:EndIf 
       If tur3()\slot2a=970:tur3()\money+150:tur3()\slot2a=0:PlaySound(5):or111=970:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
      If tur3()\slot2a=971:tur3()\money+100:tur3()\slot2a=0:PlaySound(5):or111=971:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
   If tur3()\slot2a=972:tur3()\money+20:tur3()\slot2a=0:PlaySound(5):or111=972:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
   If tur3()\slot2a=973:tur3()\money+140:tur3()\slot2a=0:PlaySound(5):or111=973:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
   If tur3()\slot2a=974:tur3()\money+80:tur3()\slot2a=0:PlaySound(5):or111=974:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
  If tur3()\slot2a=975:tur3()\money+20:tur3()\slot2a=0:PlaySound(5):or111=975:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
  If tur3()\slot2a=976:tur3()\money+60:tur3()\slot2a=0:PlaySound(5):or111=976:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
  If tur3()\slot2a=977:tur3()\money+50:tur3()\slot2a=0:PlaySound(5):or111=977:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot2a=979:tur3()\money+100:tur3()\slot2a=0:PlaySound(5):or111=978:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot2a=980:tur3()\money+80:tur3()\slot2a=0:PlaySound(5):or111=980:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot2a=981:tur3()\money+50:tur3()\slot2a=0:PlaySound(5):or111=981:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot2a=982:tur3()\money+120:tur3()\slot2a=0:PlaySound(5):or111=982:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot2a=983:tur3()\money+160:tur3()\slot2a=0:PlaySound(5):or111=983:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot2a=984:tur3()\money+500:tur3()\slot2a=0:PlaySound(5):or111=984:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot2a=985:tur3()\money+400:tur3()\slot2a=0:PlaySound(5):or111=985:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot2a=986:tur3()\money+100:tur3()\slot2a=0:PlaySound(5):or111=986:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot2a=987:tur3()\money+260:tur3()\slot2a=0:PlaySound(5):or111=987:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 


      EndIf 
          If skok3=2:
        If tur3()\slot3a=978:tur3()\money+250:tur3()\slot3a=0:PlaySound(5):or111=978:Gosub minusa222:Gosub sdwig: Goto shopp:EndIf 
       If tur3()\slot3a=970:tur3()\money+150:tur3()\slot3a=0:PlaySound(5):or111=970:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
      If tur3()\slot3a=971:tur3()\money+100:tur3()\slot3a=0:PlaySound(5):or111=971:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
   If tur3()\slot3a=972:tur3()\money+20:tur3()\slot3a=0:PlaySound(5):or111=972:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
   If tur3()\slot3a=973:tur3()\money+40:tur3()\slot3a=0:PlaySound(5):or111=973:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
   If tur3()\slot3a=974:tur3()\money+80:tur3()\slot3a=0:PlaySound(5):or111=974:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
  If tur3()\slot3a=975:tur3()\money+20:tur3()\slot3a=0:PlaySound(5):or111=975:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
  If tur3()\slot3a=976:tur3()\money+60:tur3()\slot3a=0:PlaySound(5):or111=976:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
  If tur3()\slot3a=977:tur3()\money+50:tur3()\slot3a=0:PlaySound(5):or111=977:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot3a=979:tur3()\money+100:tur3()\slot3a=0:PlaySound(5):or111=978:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot3a=980:tur3()\money+140:tur3()\slot3a=0:PlaySound(5):or111=980:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot3a=981:tur3()\money+50:tur3()\slot3a=0:PlaySound(5):or111=981:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot3a=982:tur3()\money+120:tur3()\slot3a=0:PlaySound(5):or111=982:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot3a=983:tur3()\money+160:tur3()\slot3a=0:PlaySound(5):or111=983:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot3a=984:tur3()\money+500:tur3()\slot3a=0:PlaySound(5):or111=984:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot3a=985:tur3()\money+400:tur3()\slot3a=0:PlaySound(5):or111=985:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot3a=986:tur3()\money+100:tur3()\slot3a=0:PlaySound(5):or111=986:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot3a=987:tur3()\money+260:tur3()\slot3a=0:PlaySound(5):or111=987:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 

      EndIf 
          If skok3=3:
        If tur3()\slot4a=978:tur3()\money+250:tur3()\slot4a=0:PlaySound(5):or111=978:Gosub minusa222:Gosub sdwig: Goto shopp:EndIf 
       If tur3()\slot4a=970:tur3()\money+150:tur3()\slot4a=0:PlaySound(5):or111=970:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
      If tur3()\slot4a=971:tur3()\money+100:tur3()\slot4a=0:PlaySound(5):or111=971:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
   If tur3()\slot4a=972:tur3()\money+20:tur3()\slot4a=0:PlaySound(5):or111=972:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
   If tur3()\slot4a=973:tur3()\money+40:tur3()\slot4a=0:PlaySound(5):or111=973:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
   If tur3()\slot4a=974:tur3()\money+140:tur3()\slot4a=0:PlaySound(5):or111=974:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
  If tur3()\slot4a=975:tur3()\money+20:tur3()\slot4a=0:PlaySound(5):or111=975:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
  If tur3()\slot4a=976:tur3()\money+60:tur3()\slot4a=0:PlaySound(5):or111=976:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
  If tur3()\slot4a=977:tur3()\money+50:tur3()\slot4a=0:PlaySound(5):or111=977:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot4a=979:tur3()\money+100:tur3()\slot4a=0:PlaySound(5):or111=978:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot4a=980:tur3()\money+80:tur3()\slot4a=0:PlaySound(5):or111=980:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot4a=981:tur3()\money+50:tur3()\slot4a=0:PlaySound(5):or111=981:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot4a=982:tur3()\money+120:tur3()\slot4a=0:PlaySound(5):or111=982:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot4a=983:tur3()\money+160:tur3()\slot4a=0:PlaySound(5):or111=983:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot4a=984:tur3()\money+500:tur3()\slot4a=0:PlaySound(5):or111=984:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot4a=985:tur3()\money+400:tur3()\slot4a=0:PlaySound(5):or111=985:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot4a=986:tur3()\money+100:tur3()\slot4a=0:PlaySound(5):or111=986:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 
If tur3()\slot4a=987:tur3()\money+260:tur3()\slot4a=0:PlaySound(5):or111=987:Gosub minusa222:Gosub sdwig:Goto shopp:EndIf 


      EndIf 
    
        EndIf 
    
      
   
    
     If tur3()\money=>20:
       If skok=0 And skok3=1:
         
      
         If tur3()\slot2=901:tur3()\slot2p+20: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=901:tur3()\slot3p+20: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=901:tur3()\slot4p+20: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=901:tur3()\slot5p+20: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=901:tur3()\slot6p+20: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=901:tur3()\slot7p+20: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=901:tur3()\slot8p+20: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
    

     :EndIf 
    
     
          If tur3()\money=>5:
       If skok=0 And skok3=3:
         
      
         If tur3()\slot2=902:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=902:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=902:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=902:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=902:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=902:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=902:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
           If skok=1 And skok3=1:
         
      
         If tur3()\slot2=902:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=902:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=902:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=902:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=902:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=902:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=902:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
       EndIf 
     :EndIf 
     
     
              If tur3()\money=>10:
       If skok=0 And skok3=5:
         
      
         If tur3()\slot2=903:tur3()\slot2p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot3=903:tur3()\slot3p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot4=903:tur3()\slot4p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot5=903:tur3()\slot5p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot6=903:tur3()\slot6p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot7=903:tur3()\slot7p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot8=903:tur3()\slot8p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
    
    
           If skok=1 And skok3=3:
         
      
         If tur3()\slot2=903:tur3()\slot2p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot3=903:tur3()\slot3p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot4=903:tur3()\slot4p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot5=903:tur3()\slot5p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot6=903:tur3()\slot6p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot7=903:tur3()\slot7p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot8=903:tur3()\slot8p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
    
    
               If skok=2 And skok3=1:
         
      
         If tur3()\slot2=903:tur3()\slot2p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot3=903:tur3()\slot3p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot4=903:tur3()\slot4p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot5=903:tur3()\slot5p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot6=903:tur3()\slot6p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot7=903:tur3()\slot7p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot8=903:tur3()\slot8p+10: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
    
     :EndIf 
    
    
     
          If tur3()\money=>10:
       If skok=0 And skok3=7:
         
      
         If tur3()\slot2=904:tur3()\slot2p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot3=904:tur3()\slot3p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot4=904:tur3()\slot4p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot5=904:tur3()\slot5p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot6=904:tur3()\slot6p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot7=904:tur3()\slot7p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot8=904:tur3()\slot8p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
           If skok=1 And skok3=5:
         
      
         If tur3()\slot2=904:tur3()\slot2p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot3=904:tur3()\slot3p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot4=904:tur3()\slot4p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot5=904:tur3()\slot5p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot6=904:tur3()\slot6p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot7=904:tur3()\slot7p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot8=904:tur3()\slot8p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf
           If skok=2 And skok3=3:
         
      
         If tur3()\slot2=904:tur3()\slot2p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot3=904:tur3()\slot3p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot4=904:tur3()\slot4p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot5=904:tur3()\slot5p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot6=904:tur3()\slot6p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot7=904:tur3()\slot7p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot8=904:tur3()\slot8p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf
           If skok=3 And skok3=1:
         
      
         If tur3()\slot2=904:tur3()\slot2p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot3=904:tur3()\slot3p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot4=904:tur3()\slot4p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot5=904:tur3()\slot5p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot6=904:tur3()\slot6p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot7=904:tur3()\slot7p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
         If tur3()\slot8=904:tur3()\slot8p+1: PlaySound(5):tur3()\money-10: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
       EndIf
     :EndIf 
     
     
     
     
          If tur3()\money=>5:
       If skok=1 And skok3=7:
         
      
         If tur3()\slot2=905:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=905:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=905:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=905:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=905:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=905:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=905:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
    
           If skok=2 And skok3=5:
         
      
         If tur3()\slot2=905:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=905:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=905:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=905:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=905:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=905:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=905:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=3 And skok3=3:
         
      
         If tur3()\slot2=905:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=905:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=905:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=905:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=905:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=905:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=905:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=4 And skok3=1:
         
      
         If tur3()\slot2=905:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=905:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=905:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=905:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=905:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=905:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=905:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
       EndIf 
     :EndIf 
     
     
      If tur3()\money=>5:
       If skok=2 And skok3=7:
         
      
         If tur3()\slot2=906:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=906:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=906:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=906:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=906:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=906:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=906:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
    
           If skok=3 And skok3=5:
         
      
         If tur3()\slot2=906:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=906:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=906:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=906:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=906:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=906:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=906:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=4 And skok3=3:
         
      
         If tur3()\slot2=906:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=906:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=906:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=906:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=906:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=906:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=906:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=5 And skok3=1:
         
      
         If tur3()\slot2=906:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=906:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=906:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=906:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=906:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=906:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=906:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
       EndIf 
     :EndIf 
     
     
      If tur3()\money=>5:
       If skok=3 And skok3=7:
         
      
         If tur3()\slot2=907:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=907:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=907:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=907:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=907:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=907:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=907:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
    
           If skok=4 And skok3=5:
         
      
         If tur3()\slot2=907:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=907:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=907:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=907:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=907:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=907:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=907:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=5 And skok3=3:
         
      
         If tur3()\slot2=907:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=907:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=907:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=907:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=907:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=907:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=907:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=6 And skok3=1:
         
      
         If tur3()\slot2=907:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=907:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=907:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=907:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=907:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=907:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=907:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
       EndIf 
     :EndIf 
     
     
     
         If tur3()\money=>5:
       If skok=4 And skok3=7:
         
      
         If tur3()\slot2=908:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=908:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=908:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=908:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=908:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=908:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=908:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
    
           If skok=5 And skok3=5:
         
      
         If tur3()\slot2=908:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=908:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=908:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=908:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=908:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=908:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=908:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=6 And skok3=3:
         
      
         If tur3()\slot2=908:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=908:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=908:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=908:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=908:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=908:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=908:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=7 And skok3=1:
         
      
         If tur3()\slot2=908:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=908:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=908:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=908:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=908:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=908:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=908:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
       EndIf 
     :EndIf 
     
     
     
     
     
         If tur3()\money=>5:
       If skok=5 And skok3=7:
         
      
         If tur3()\slot2=909:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=909:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=909:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=909:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=909:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=909:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=909:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
    
           If skok=6 And skok3=5:
         
      
         If tur3()\slot2=909:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=909:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=909:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=909:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=909:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=909:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=909:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=7 And skok3=3:
         
      
         If tur3()\slot2=909:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=909:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=909:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=909:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=909:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=909:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=909:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
      
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=8 And skok3=1:
         
      
         If tur3()\slot2=909:tur3()\slot2p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot3=909:tur3()\slot3p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot4=909:tur3()\slot4p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot5=909:tur3()\slot5p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot6=909:tur3()\slot6p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot7=909:tur3()\slot7p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
         If tur3()\slot8=909:tur3()\slot8p+1: PlaySound(5):tur3()\money-5: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
       EndIf 
     :EndIf 
     
     
     
          If tur3()\money=>20:
       If skok=6 And skok3=7:
         
      
         If tur3()\slot2=910:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=910:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=910:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=910:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=910:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=910:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=910:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
    
           If skok=7 And skok3=5:
         
      
         If tur3()\slot2=910:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=910:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=910:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=910:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=910:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=910:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=910:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=8 And skok3=3:
         
      
         If tur3()\slot2=910:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=910:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=910:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=910:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=910:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=910:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=910:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
      
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=9 And skok3=1:
         
      
         If tur3()\slot2=910:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=910:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=910:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=910:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=910:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=910:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=910:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
       EndIf 
     :EndIf 
     
     
     
     
             If tur3()\money=>20:
       If skok=6 And skok3=7:
         
      
         If tur3()\slot2=910:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=910:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=910:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=910:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=910:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=910:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=910:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
    
           If skok=7 And skok3=5:
         
      
         If tur3()\slot2=910:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=910:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=910:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=910:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=910:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=910:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=910:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=8 And skok3=3:
         
      
         If tur3()\slot2=910:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=910:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=910:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=910:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=910:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=910:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=910:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
      
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=9 And skok3=1:
         
      
         If tur3()\slot2=910:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=910:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=910:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=910:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=910:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=910:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=910:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
       EndIf 
     :EndIf 
     
     
     
      
             If tur3()\money=>20:
       If skok=7 And skok3=7:
         
     
         If tur3()\slot2=914:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=914:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=914:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=914:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=914:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=914:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=914:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
    
           If skok=8 And skok3=5:
         
      
         If tur3()\slot2=914:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=914:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=914:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=914:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=914:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=914:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=914:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=9 And skok3=3:
         
      
         If tur3()\slot2=914:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=914:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=914:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=914:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=914:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=914:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=914:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
      
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=10 And skok3=1:
         
      
         If tur3()\slot2=914:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=914:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=914:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=914:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=914:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=914:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=914:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
       EndIf 
     :EndIf 
     
     
     
     
     
         
             If tur3()\money=>20:
       If skok=8 And skok3=7:
         
     
         If tur3()\slot2=912:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=912:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=912:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=912:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=912:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=912:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=912:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
    
           If skok=9 And skok3=5:
         
      
         If tur3()\slot2=912:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=912:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=912:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=912:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=912:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=912:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=912:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=10 And skok3=3:
         
      
         If tur3()\slot2=912:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=912:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=912:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=912:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=912:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=912:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=912:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
      
      PlaySound(6)
      Goto shopp:  
    EndIf 
               If skok=11 And skok3=1:
         
      
         If tur3()\slot2=912:tur3()\slot2p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot3=912:tur3()\slot3p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot4=912:tur3()\slot4p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot5=912:tur3()\slot5p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot6=912:tur3()\slot6p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot7=912:tur3()\slot7p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
         If tur3()\slot8=912:tur3()\slot8p+1: PlaySound(5):tur3()\money-20: Goto shopp:  EndIf 
       
      PlaySound(6)
      Goto shopp:  
       EndIf 
     :EndIf 
     
     
     
     
     
    If tur3()\money=>200 And skok3=0 And skok=0:
   aaaaa=901
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-200
      EndIf  
       Goto shopp:
     :EndIf 
     
     
     If tur3()\money=>600:
       If skok=0 And skok3=2:
           aaaaa=902
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-600
      EndIf  
      Goto shopp:  
       EndIf 
               If skok=1 And skok3=0:
           aaaaa=902
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-600
      EndIf  
      Goto shopp:  
       EndIf 
     :EndIf 

     
          If tur3()\money=>150:
       If skok=0 And skok3=4:
           aaaaa=903
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-150
      EndIf  
      Goto shopp:  
    EndIf 
               If skok=1 And skok3=2:
           aaaaa=903
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-150
      EndIf  
      Goto shopp:  
       EndIf 
       If skok=2 And skok3=0:
     aaaaa=903
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-150
      EndIf  
      Goto shopp:  
    EndIf 
    
     :EndIf 
     
     
               If tur3()\money=>400:
       If skok=0 And skok3=6:
           aaaaa=904
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-400
      EndIf  
      Goto shopp:  
    EndIf 
               If skok=1 And skok3=4:
           aaaaa=904
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-400
      EndIf  
      Goto shopp:  
       EndIf 
       If skok=2 And skok3=2:
     aaaaa=904
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-400
      EndIf  
      Goto shopp:  
    EndIf 
           If skok=3 And skok3=0:
     aaaaa=904
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-400
      EndIf  
      Goto shopp:  
    EndIf 
     :EndIf 
     
     
       If tur3()\money=>300:
       If skok=1 And skok3=6:
           aaaaa=905
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-300
      EndIf  
      Goto shopp:  
    EndIf 
           If skok=2 And skok3=4:
           aaaaa=905
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-300
      EndIf  
      Goto shopp:  
    EndIf 
               If skok=3 And skok3=2:
           aaaaa=905
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-300
      EndIf  
      Goto shopp:  
    EndIf 
                   If skok=4 And skok3=0:
           aaaaa=905
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-300
      EndIf  
      Goto shopp:  
    EndIf 
     :EndIf 
     
     
            If tur3()\money=>300:
       If skok=2 And skok3=6:
           aaaaa=906
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-300
      EndIf  
      Goto shopp:  
    EndIf 
           If skok=3 And skok3=4:
           aaaaa=906
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-300
      EndIf  
      Goto shopp:  
    EndIf 
               If skok=4 And skok3=2:
           aaaaa=906
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-300
      EndIf  
      Goto shopp:  
    EndIf 
                   If skok=5 And skok3=0:
           aaaaa=906
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-300
      EndIf  
      Goto shopp:  
    EndIf 
  :EndIf 
  
  
              If tur3()\money=>600:
       If skok=3 And skok3=6:
           aaaaa=907
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-600
      EndIf  
      Goto shopp:  
    EndIf 
           If skok=4 And skok3=4:
           aaaaa=907
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-600
      EndIf  
      Goto shopp:  
    EndIf 
               If skok=5 And skok3=2:
           aaaaa=907
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-600
      EndIf  
      Goto shopp:  
    EndIf 
                   If skok=6 And skok3=0:
           aaaaa=907
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-600
      EndIf  
      Goto shopp:  
    EndIf 
  :EndIf 
  
  
                If tur3()\money=>600:
       If skok=4 And skok3=6:
           aaaaa=908
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-600
      EndIf  
      Goto shopp:  
    EndIf 
           If skok=5 And skok3=4:
           aaaaa=908
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-600
      EndIf  
      Goto shopp:  
    EndIf 
               If skok=6 And skok3=2:
           aaaaa=908
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-600
      EndIf  
      Goto shopp:  
    EndIf 
                   If skok=7 And skok3=0:
           aaaaa=908
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-600
      EndIf  
      Goto shopp:  
    EndIf 
     :EndIf 
     
     
                     If tur3()\money=>250:
       If skok=5 And skok3=6:
           aaaaa=909
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-250
      EndIf  
      Goto shopp:  
    EndIf 
           If skok=6 And skok3=4:
           aaaaa=909
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-250
      EndIf  
      Goto shopp:  
    EndIf 
               If skok=7 And skok3=2:
           aaaaa=909
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-250
      EndIf  
      Goto shopp:  
    EndIf 
                   If skok=8 And skok3=0:
           aaaaa=909
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-250
      EndIf  
      Goto shopp:  
    EndIf 
  :EndIf 
  
                       If tur3()\money=>500:
       If skok=6 And skok3=6:
           aaaaa=910
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-500
      EndIf  
      Goto shopp:  
    EndIf 
           If skok=7 And skok3=4:
           aaaaa=910
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-500
      EndIf  
      Goto shopp:  
    EndIf 
               If skok=8 And skok3=2:
           aaaaa=910
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-500
      EndIf  
      Goto shopp:  
    EndIf 
                   If skok=9 And skok3=0:
           aaaaa=910
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-500
      EndIf  
      Goto shopp:  
    EndIf 
  :EndIf 
    
                       If tur3()\money=>800:
       If skok=7 And skok3=6:
           aaaaa=914
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-800
      EndIf  
      Goto shopp:  
    EndIf 
           If skok=8 And skok3=4:
           aaaaa=914
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-800
      EndIf  
      Goto shopp:  
    EndIf 
               If skok=9 And skok3=2:
           aaaaa=914
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-800
      EndIf  
      Goto shopp:  
    EndIf 
                   If skok=10 And skok3=0:
           aaaaa=914
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-800
      EndIf  
      Goto shopp:  
    EndIf 
  :EndIf 
  
                      If tur3()\money=>200:
       If skok=8 And skok3=6:
           aaaaa=912
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-200
      EndIf  
      Goto shopp:  
    EndIf 
           If skok=9 And skok3=4:
           aaaaa=912
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-200
      EndIf  
      Goto shopp:  
    EndIf 
               If skok=10 And skok3=2:
           aaaaa=912
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-200
      EndIf  
      Goto shopp:  
    EndIf 
                   If skok=11 And skok3=0:
           aaaaa=912
      :Gosub kup:
      If f=0
        PlaySound(5):tur3()\money-200
      EndIf  
      Goto shopp:  
    EndIf 
  :EndIf 
     PlaySound(6)
 Goto shopp:
    Return 


    
    
    kup:
         f=0
         If tur3()\slot2=aaaaa:  PlaySound(6):  f=1:Goto shopp:  EndIf 
         If tur3()\slot3=aaaaa:  PlaySound(6): f=1:Goto shopp:  EndIf 
         If tur3()\slot4=aaaaa:  PlaySound(6): f=1:Goto shopp:  EndIf 
         If tur3()\slot5=aaaaa:  PlaySound(6):f=1: Goto shopp:  EndIf 
         If tur3()\slot6=aaaaa:  PlaySound(6):f=1: Goto shopp:  EndIf 
         If tur3()\slot7=aaaaa:  PlaySound(6):f=1: Goto shopp:  EndIf 
          If tur3()\slot8=aaaaa:  PlaySound(6): f=1:Goto shopp:  EndIf 
         

    If tur3()\slot8=0:tur3()\slot8=aaaaa:Gosub instorr:Return:EndIf 
    If tur3()\slot7=0:tur3()\slot7=aaaaa:Gosub instorr:Return:EndIf 
    If tur3()\slot6=0:tur3()\slot6=aaaaa:Gosub instorr:Return:EndIf 
    If tur3()\slot5=0:tur3()\slot5=aaaaa:Gosub instorr:Return:EndIf 
    If tur3()\slot4=0:tur3()\slot4=aaaaa:Gosub instorr:Return:EndIf 
    If tur3()\slot3=0:tur3()\slot3=aaaaa:Gosub instorr:Return:EndIf 
    If tur3()\slot2=0:tur3()\slot2=aaaaa:Gosub instorr:Return:EndIf 
    f=1
    PlaySound(6)
    Return 
   
    instorr:
    *Old_Element666 = @tur3() 
    ffff=1
    Gosub instor:
    ffff=0
    ChangeCurrentElement(tur3(), *Old_Element666)
    Return 
    
    
    mint:

;-----------------------------WARNING
Repeat 
tur3()\trafic3-1
 If tur3()\trafic3=0:Gosub mint2:EndIf 
If wanim>0:wanim-1:EndIf 
Until wanim=0
Return 
mint2:
If tur3()\trafic3=0 And wanim=>1 And tur3()\trafic>0:tur3()\trafic-1:EndIf
If tur3()\trafic3=0:tur3()\trafic3=tur3()\trafic4+Random(tur3()\trafic5):EndIf 
If tur3()\trafic=0 Or tur3()\trafic<0:plnex=1:nextlp=1:EndIf 
If nextplay2=1:nextplay2=0:nextlp=1:EndIf
Return 
    
    minthodba:


tur3()\trafic3-1
 If tur3()\trafic3=0:Gosub mint2:EndIf 
Return 
    
    ikon:      
   
Gosub shop
ikon0:
Gosub ikonn
If lang=0
  DisplayTransparentSprite (1009 , 0, yraz-130)
EndIf 
If lang=1
  DisplayTransparentSprite (1107 , 0, yraz-130)
  EndIf 
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=500 And tur()\swo=play:xg=tur()\x:yg=tur()\y:aq=tur()\swo:Goto ikon2:EndIf 
Wend
Return 
ikon2:
ResetList( tur3() ) 
While NextElement( tur3())
If tur3()\pnom=aq:bq=tur3()\money:cq=tur3()\opyt:tqqq=tur3()\trafic:Goto ikon3:EndIf 
Wend

Return 

ikon3: 


If wanim=>1 And tur3()\trafic3>0 And tur()\wani<16:Gosub minthodba:EndIf 
StartDrawing( ScreenOutput())
DrawingFont(FontID(4)) 
DrawingMode(#PB_2DDrawing_Transparent )
;cqq=StringByteLength(Str(cq))
cqq=TextWidth(Str(cq))
cqq/2
DrawText(307-cqq, yraz-104, Str(cq), RGB((255),(200),(100)) )
cqq=TextWidth(Str(bq))
cqq/2
DrawText(309-cqq, yraz-70, Str(bq), RGB((255),(200),(100)) )


  StopDrawing() 
  If igroplay<2:
level=tur3()\kakoj
If level=0:ax=tur3()\slot1p:weapon=tur3()\slot1:EndIf 
If level=32:ax=tur3()\slot2p:weapon=tur3()\slot2:EndIf
If level=64:ax=tur3()\slot3p:weapon=tur3()\slot3:EndIf
If level=96:ax=tur3()\slot4p:weapon=tur3()\slot4:EndIf
If level=128:ax=tur3()\slot5p:weapon=tur3()\slot5:EndIf
If level=160:ax=tur3()\slot6p:weapon=tur3()\slot6:EndIf
If level=192:ax=tur3()\slot7p:weapon=tur3()\slot7:EndIf
If level=224:ax=tur3()\slot8p:weapon=tur3()\slot8:EndIf

;-------------ikony

igroplay+1
:EndIf 

StartDrawing( ScreenOutput())
DrawingMode(  #PB_2DDrawing_Transparent)
DrawingFont(FontID(0)) 

name$=tur3()\name$
If tur3()\victory=kol:Goto viktor:EndIf ;------------------POBEDA
If lang=0
DrawText(2+xraz/2-128-32-130+1,2+1 , "Побед: "+Str(tur3()\victory), RGB((0),(0),(0)) )
DrawText(2+xraz/2-128-32-130,2 , "Побед: "+Str(tur3()\victory), RGB((255),(255),(255)) )
EndIf 
If lang=1
DrawText(2+xraz/2-128-32-130+1,2+1 , "Wins: "+Str(tur3()\victory), RGB((0),(0),(0)) )
DrawText(2+xraz/2-128-32-130,2 , "Wins: "+Str(tur3()\victory), RGB((255),(255),(255)) )
EndIf 
 StopDrawing() 

  DisplayTransparentSprite (7, 18+level, yraz-103-7)
DisplayTransparentSprite(1500, 2+xraz/2-128-32-32, 2)
DisplayTransparentSprite(1501, 2+64+xraz/2-128-32-32, 2)
DisplayTransparentSprite(1502, 2+128+xraz/2-128-32-32, 2)
DisplayTransparentSprite(1503, 2+128+64+xraz/2-128-32-32, 2)
DisplayTransparentSprite(1504, 2+128+128+xraz/2-128-32-32, 2)
DisplayTransparentSprite(1505, 2+128+128+64+xraz/2-128-32-32, 2)

or1=0:or2=0:or3=0:or4=0
or5=0:or6=0:or7=0:or8=0
or1a=0:or2a=0:or3a=0:or4a=0

If tur3()\slot1>0:DisplayTransparentSprite(tur3()\slot1,20,yraz-124+22-6):or1=tur3()\slot1:EndIf 
If tur3()\slot2>0:DisplayTransparentSprite(tur3()\slot2,52,yraz-124+22-6):or2=tur3()\slot2:EndIf 
If tur3()\slot3>0:DisplayTransparentSprite(tur3()\slot3,84,yraz-124+22-6):or3=tur3()\slot3:EndIf 
If tur3()\slot4>0:DisplayTransparentSprite(tur3()\slot4,116,yraz-124+22-6):or4=tur3()\slot4:EndIf 
If tur3()\slot5>0:DisplayTransparentSprite(tur3()\slot5,148,yraz-124+22-6):or5=tur3()\slot5:EndIf 
If tur3()\slot6>0:DisplayTransparentSprite(tur3()\slot6,170+10,yraz-124+22-6):or6=tur3()\slot6:EndIf 
If tur3()\slot7>0:DisplayTransparentSprite(tur3()\slot7,200+12,yraz-124+22-6):or7=tur3()\slot7:EndIf 
If tur3()\slot8>0:DisplayTransparentSprite(tur3()\slot8,230+14,yraz-124+22-6):or8=tur3()\slot8:EndIf 

If tur3()\slot1a>0:DisplayTransparentSprite(tur3()\slot1a,13,yraz-124+22-6+60):or1a=tur3()\slot1a:EndIf 
If tur3()\slot2a>0:DisplayTransparentSprite(tur3()\slot2a,13+32,yraz-124+22-6+60):or2a=tur3()\slot2a:EndIf 
If tur3()\slot3a>0:DisplayTransparentSprite(tur3()\slot3a,13+64,yraz-124+22-6+60):or3a=tur3()\slot3a:EndIf 
If tur3()\slot4a>0:DisplayTransparentSprite(tur3()\slot4a,13+96,yraz-124+22-6+60):or4a=tur3()\slot4a:EndIf 

If tur3()\slot1u>0:DisplayTransparentSprite(tur3()\slot1u,13+128+14,yraz-124+22-6+60):
StartDrawing( ScreenOutput())
DrawingMode(  #PB_2DDrawing_Transparent)
DrawingFont(FontID(0)) 
DrawText(13+128+14+12,yraz-124+22-6+60+32 , Str(tur3()\slot1uu), RGB((255),(255),(255)) )
 StopDrawing() 
:EndIf 
If tur3()\slot2u>0:DisplayTransparentSprite(tur3()\slot2u,13+128+14+32,yraz-124+22-6+60):
StartDrawing( ScreenOutput())
DrawingMode(  #PB_2DDrawing_Transparent)
DrawingFont(FontID(0)) 
DrawText(13+128+14+12+32,yraz-124+22-6+60+32 , Str(tur3()\slot2uu), RGB((255),(255),(255)) )
 StopDrawing() 
:EndIf 
If tur3()\slot3u>0:DisplayTransparentSprite(tur3()\slot3u,13+128+14+64,yraz-124+22-6+60):
StartDrawing( ScreenOutput())
DrawingMode(  #PB_2DDrawing_Transparent)
DrawingFont(FontID(0)) 
DrawText(13+128+14+12+64,yraz-124+22-6+60+32 , Str(tur3()\slot3uu), RGB((255),(255),(255)) )
 StopDrawing() 
:EndIf 
If tur3()\slot4u>0:DisplayTransparentSprite(tur3()\slot4u,13+128+14+96,yraz-124+22-6+60):
StartDrawing( ScreenOutput())
DrawingMode(  #PB_2DDrawing_Transparent)
DrawingFont(FontID(0)) 
DrawText(13+128+14+12+96,yraz-124+22-6+60+32 , Str(tur3()\slot4uu), RGB((255),(255),(255)) )
 StopDrawing() 
:EndIf 






If lang=0
If xm3>13+128+14 And xm3<13+128+14+32 And ym3>yraz-124+22-6+60 And ym3<yraz-124+22-6+60+32 
rt=230
StartDrawing( ScreenOutput())
DrawingFont(FontID(0)) 
If tur3()\slot1u=1100:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie31:EndIf  
If tur3()\slot1u=1101:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie32:EndIf  
If tur3()\slot1u=1102:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie33:EndIf  
If tur3()\slot1u=1103:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie34:EndIf  
If tur3()\slot1u=1104:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie35:EndIf  
If tur3()\slot1u=1105:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie36:EndIf  
If tur3()\slot1u=1106:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie37:EndIf  
 StopDrawing() 
EndIf 
If xm3>13+128+14+32 And xm3<13+128+14+32+32 And ym3>yraz-124+22-6+60 And ym3<yraz-124+22-6+60+32:
rt=230
StartDrawing( ScreenOutput())
DrawingMode(  #PB_2DDrawing_Transparent)
DrawingFont(FontID(0)) 
If tur3()\slot2u=1100:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie31:EndIf  
If tur3()\slot2u=1101:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie32:EndIf  
If tur3()\slot2u=1102:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie33:EndIf  
If tur3()\slot2u=1103:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie34:EndIf  
If tur3()\slot2u=1104:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie35:EndIf  
If tur3()\slot2u=1105:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie36:EndIf  
If tur3()\slot2u=1106:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie37:EndIf  
 StopDrawing() 
EndIf 
If xm3>13+128+14+32+32 And xm3<13+128+14+32+32+32 And ym3>yraz-124+22-6+60 And ym3<yraz-124+22-6+60+32:
rt=230
StartDrawing( ScreenOutput())

DrawingMode(  #PB_2DDrawing_Transparent)
DrawingFont(FontID(0)) 
If tur3()\slot3u=1100:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie31:EndIf  
If tur3()\slot3u=1101:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie32:EndIf  
If tur3()\slot3u=1102:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie33:EndIf  
If tur3()\slot3u=1103:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie34:EndIf  
If tur3()\slot3u=1104:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie35:EndIf  
If tur3()\slot3u=1105:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie36:EndIf  
If tur3()\slot3u=1106:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie37:EndIf  
 StopDrawing() 
EndIf 
If xm3>13+128+14+32+64 And xm3<13+128+14+32+32+64 And ym3>yraz-124+22-6+60 And ym3<yraz-124+22-6+60+32:
rt=230
StartDrawing( ScreenOutput())

DrawingMode(  #PB_2DDrawing_Transparent)
DrawingFont(FontID(0)) 
If tur3()\slot4u=1100:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie31:EndIf  
If tur3()\slot4u=1101:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie32:EndIf  
If tur3()\slot4u=1102:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie33:EndIf  
If tur3()\slot4u=1103:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie34:EndIf  
If tur3()\slot4u=1104:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie35:EndIf  
If tur3()\slot4u=1105:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie36:EndIf  
If tur3()\slot4u=1106:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((0),(0),(0)) ):Gosub umenie37:EndIf  
StopDrawing() 
EndIf 
EndIf 

If lang=1
If xm3>13+128+14 And xm3<13+128+14+32 And ym3>yraz-124+22-6+60 And ym3<yraz-124+22-6+60+32 
rt=230
StartDrawing( ScreenOutput())
DrawingFont(FontID(0)) 
If tur3()\slot1u=1100:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie31:EndIf  
If tur3()\slot1u=1101:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie32:EndIf  
If tur3()\slot1u=1102:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie33:EndIf  
If tur3()\slot1u=1103:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie34:EndIf  
If tur3()\slot1u=1104:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie35:EndIf  
If tur3()\slot1u=1105:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie36:EndIf  
If tur3()\slot1u=1106:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie37:EndIf  
 StopDrawing() 
EndIf 
If xm3>13+128+14+32 And xm3<13+128+14+32+32 And ym3>yraz-124+22-6+60 And ym3<yraz-124+22-6+60+32:
rt=230
StartDrawing( ScreenOutput())
DrawingMode(  #PB_2DDrawing_Transparent)
DrawingFont(FontID(0)) 
If tur3()\slot2u=1100:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie31:EndIf  
If tur3()\slot2u=1101:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie32:EndIf  
If tur3()\slot2u=1102:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie33:EndIf  
If tur3()\slot2u=1103:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie34:EndIf  
If tur3()\slot2u=1104:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie35:EndIf  
If tur3()\slot2u=1105:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie36:EndIf  
If tur3()\slot2u=1106:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie37:EndIf  
 StopDrawing() 
EndIf 
If xm3>13+128+14+32+32 And xm3<13+128+14+32+32+32 And ym3>yraz-124+22-6+60 And ym3<yraz-124+22-6+60+32:
rt=230
StartDrawing( ScreenOutput())

DrawingMode(  #PB_2DDrawing_Transparent)
DrawingFont(FontID(0)) 
If tur3()\slot3u=1100:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie31:EndIf  
If tur3()\slot3u=1101:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie32:EndIf  
If tur3()\slot3u=1102:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie33:EndIf  
If tur3()\slot3u=1103:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie34:EndIf  
If tur3()\slot3u=1104:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie35:EndIf  
If tur3()\slot3u=1105:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie36:EndIf  
If tur3()\slot3u=1106:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie37:EndIf  
 StopDrawing() 
EndIf 
If xm3>13+128+14+32+64 And xm3<13+128+14+32+32+64 And ym3>yraz-124+22-6+60 And ym3<yraz-124+22-6+60+32:
rt=230
StartDrawing( ScreenOutput())

DrawingMode(  #PB_2DDrawing_Transparent)
DrawingFont(FontID(0)) 
If tur3()\slot4u=1100:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie31:EndIf  
If tur3()\slot4u=1101:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie32:EndIf  
If tur3()\slot4u=1102:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie33:EndIf  
If tur3()\slot4u=1103:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie34:EndIf  
If tur3()\slot4u=1104:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie35:EndIf  
If tur3()\slot4u=1105:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie36:EndIf  
If tur3()\slot4u=1106:DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-124+22+55-341+rt, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-124+22+55-340+rt, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent):DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((0),(0),(0)) ):Gosub umenie37:EndIf  
StopDrawing() 
EndIf 

EndIf 





;----------------opyt

If tur3()\pnom=play And diss=1 And tur()\swo2<>333:
  
;If tur()\swo2<>333 And diss=1:


  r1=0:r2=0:r3=0:r4=0:r=0:rr=0:rt=0
  

If tur3()\slot1u>0:r1=tur3()\slot1u:r+1:EndIf 
If tur3()\slot2u>0:r2=tur3()\slot2u:r+1:EndIf 
If tur3()\slot3u>0:r3=tur3()\slot3u:r+1:EndIf 
If tur3()\slot4u>0:r4=tur3()\slot4u:r+1:EndIf 

If tur3()\slot1u>0 And tur3()\slot1uu=3:rr+1:EndIf 
If tur3()\slot2u>0 And tur3()\slot2uu=3:rr+1:EndIf 
If tur3()\slot3u>0 And tur3()\slot3uu=3:rr+1:EndIf 
If tur3()\slot4u>0 And tur3()\slot4uu=3:rr+1:EndIf 
If rr=4:displayb=0:diss=0:Return:EndIf 


suda2:
If displayb=0:
dis=Random(6)
If r=4:
If dis=r1-1100 And tur3()\slot1uu<3:Goto suda3:EndIf 
If dis=r2-1100 And tur3()\slot2uu<3:Goto suda3:EndIf 
If dis=r3-1100 And tur3()\slot3uu<3:Goto suda3:EndIf 
If dis=r4-1100 And tur3()\slot4uu<3:Goto suda3:EndIf 
Goto suda2:
EndIf 

:EndIf 


suda3:

If displayb=0:
dis2=Random(6)
If r=4:
If dis2=r1-1100 And tur3()\slot1uu<3:Goto suda33:EndIf 
If dis2=r2-1100 And tur3()\slot2uu<3::Goto suda33:EndIf 
If dis2=r3-1100 And tur3()\slot3uu<3::Goto suda33:EndIf 
If dis2=r4-1100 And tur3()\slot4uu<3::Goto suda33:EndIf 
Goto suda3:
EndIf 

:EndIf 


suda33:

rrr=0
If tur3()\slot1uu=3:rrr+1:EndIf 
If tur3()\slot2uu=3:rrr+1:EndIf 
If tur3()\slot3uu=3:rrr+1:EndIf 
If tur3()\slot4uu=3:rrr+1:EndIf 

If dis=dis2 And rrr<3:
Goto suda2:EndIf 


displayb=1

DisplayTransparentSprite(1010, 200, yraz-yraz/2-100)


DisplayTransparentSprite(1100+dis2, 200+32, yraz-yraz/2-72)
DisplayTransparentSprite(1100+dis, 200+128, yraz-yraz/2-72)
;--ПРАВКА_0001
rt=-48
 If yraz=720:rt=-40:EndIf 
 If yraz=1080:rt=-95:EndIf 
 If yraz=900:rt=-158:EndIf 
 
If xm3>200+128 And xm3<200+32+128 And ym3>yraz-yraz/2-72 And ym3<yraz-yraz/2-72+32
DisplayTransparentSprite (7, 200+128-2, yraz-yraz/2-72-2):
StartDrawing( ScreenOutput())
DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-yraz/2+5-190-1, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-yraz/2+5-190, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent)
DrawingFont(FontID(0)) 
If lang=0:DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((255),(200),(100)) ):EndIf 
If lang=1:DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((255),(200),(100)) ):EndIf 
Gosub umenie
 StopDrawing() 
EndIf 
  If xm3>200+32 And xm3<200+64 And ym3>yraz-yraz/2-72 And ym3<yraz-yraz/2-72+32
DisplayTransparentSprite (7, 200+32-2, yraz-yraz/2-72-2):
StartDrawing( ScreenOutput())
DrawingMode(#PB_2DDrawing_Default )
Box(11+50,yraz-yraz/2+5-190-1, 302+110, 82, RGB(255, 255, 255))
Box(12+50,yraz-yraz/2+5-190, 300+110, 80, RGB(125,125,125))
DrawingMode(  #PB_2DDrawing_Transparent)
DrawingFont(FontID(0)) 
If lang=0:DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Навык:", RGB((255),(200),(100)) ):EndIf 
If lang=1:DrawText(12+102-50,yraz-124+22+55-400+60+rt , "Skill:", RGB((255),(200),(100)) ):EndIf 
Gosub umenie2
 StopDrawing() 
EndIf 
  
  
StartDrawing( ScreenOutput())
DrawingMode(#PB_2DDrawing_Transparent )
DrawingFont(FontID(0)) 
If lang=0
DrawText(226,yraz-yraz/2+5-100 , "Вы получили уровень!", RGB((255),(200),(100)) )
DrawingFont(FontID(0)) 
DrawText(243,yraz-yraz/2+66-100 , "Выберете бонус.", RGB((255),(255),(255)) )
DrawingFont(FontID(1)) 
DrawText(200+78,yraz-yraz/2-68 , "или", RGB((255),(255),(255)) )
EndIf 
If lang=1
DrawText(236,yraz-yraz/2+5-100 , "Your level rose!", RGB((255),(200),(100)) )
DrawingFont(FontID(0)) 
DrawText(246,yraz-yraz/2+66-100 , "Select bonus.", RGB((255),(255),(255)) )
DrawingFont(FontID(1)) 
DrawText(200+78,yraz-yraz/2-68 , "or", RGB((255),(255),(255)) )
EndIf 
  StopDrawing() 
  ExamineMouse()
 If tur()\bot=1:Goto slp:EndIf 
If MouseButton(1) And tur()\bot=0 And xm3>200+128 And xm3<200+32+128 And ym3>yraz-yraz/2-72 And ym3<yraz-yraz/2-72+32:
  slp:
  displayb=0:diss=0

If tur3()\slot1u=dis+1100 And tur3()\slot1uu<3:tur3()\slot1uu+1:  Gosub instor31:Return:EndIf
If tur3()\slot2u=dis+1100 And tur3()\slot2uu<3:tur3()\slot2uu+1:  Gosub instor32:Return:EndIf
If tur3()\slot3u=dis+1100 And tur3()\slot3uu<3:tur3()\slot3uu+1:  Gosub instor33:Return:EndIf
If tur3()\slot4u=dis+1100 And tur3()\slot4uu<3:tur3()\slot4uu+1:  Gosub instor34:Return:EndIf

If tur3()\slot1u=0:tur3()\slot1u=dis+1100:tur3()\slot1uu=1:  Gosub instor31:Return:EndIf 
If tur3()\slot2u=0:tur3()\slot2u=dis+1100:tur3()\slot2uu=1:  Gosub instor32:Return:EndIf 
If tur3()\slot3u=0:tur3()\slot3u=dis+1100:tur3()\slot3uu=1:  Gosub instor33:Return:EndIf 
If tur3()\slot4u=0:tur3()\slot4u=dis+1100:tur3()\slot4uu=1:  Gosub instor34:Return:EndIf 



EndIf 
If MouseButton(1) And xm3>200+32 And xm3<200+64 And ym3>yraz-yraz/2-72 And ym3<yraz-yraz/2-72+32:

displayb=0:diss=0
If tur3()\slot1u=dis2+1100 And tur3()\slot1uu<3:tur3()\slot1uu+1:  Gosub instor31:Return:EndIf
If tur3()\slot2u=dis2+1100 And tur3()\slot2uu<3:tur3()\slot2uu+1:  Gosub instor32:Return:EndIf
If tur3()\slot3u=dis2+1100 And tur3()\slot3uu<3:tur3()\slot3uu+1:  Gosub instor33:Return:EndIf
If tur3()\slot4u=dis2+1100 And tur3()\slot4uu<3:tur3()\slot4uu+1:  Gosub instor34:Return:EndIf

If tur3()\slot1u=0:tur3()\slot1u=dis2+1100:tur3()\slot1uu=1:  Gosub instor31:Return:EndIf 
If tur3()\slot2u=0:tur3()\slot2u=dis2+1100:tur3()\slot2uu=1:  Gosub instor32:Return:EndIf 
If tur3()\slot3u=0:tur3()\slot3u=dis2+1100:tur3()\slot3uu=1:  Gosub instor33:Return:EndIf 
If tur3()\slot4u=0:tur3()\slot4u=dis2+1100:tur3()\slot4uu=1:  Gosub instor34:Return:EndIf 



EndIf 

:EndIf 



DisplayTransparentSprite(911,230+70+23,yraz-48)
DisplayTransparentSprite(925,230+70-12,yraz-48)
;If ym3>yraz-124+22-6 And ym3<yraz-124+22-6+35 And xm3>20 And xm3<230+14+32:Return:EndIf 



StartDrawing( ScreenOutput())
DrawingFont(FontID(2)) 
DrawingMode(#PB_2DDrawing_Transparent )
b=TextWidth("00000")
bb=TextWidth(Str(ax))
bbb=b-bb
If shop1=0:
DrawText(21+1+level+bbb, yraz-76+1 , Str(ax), RGB((0),(0),(0)) )
DrawText(21+level+bbb, yraz-76 , Str(ax), RGB((255),(255),(255)) )
EndIf 
axx=tur3()\energ2

DrawText(2+18+xraz/2-128+1-64, 3+1, Str(axx), RGB((0),(0),(0)) )
DrawText(2+18+xraz/2-128-64, 3, Str(axx), RGB((255),(255),(255)) )

axx=tur3()\reani

DrawText(2+18+xraz/2-128+64-64+1, 3+1, Str(axx), RGB((0),(0),(0)) )
DrawText(2+18+xraz/2-128+64-64, 3, Str(axx), RGB((255),(255),(255)) )

axx=tur3()\ataka

DrawText(2+18+xraz/2-128+128+1-64, 3+1, Str(axx), RGB((0),(0),(0)) )
DrawText(2+18+xraz/2-128+128-64, 3, Str(axx), RGB((255),(255),(255)) )

axx=tur3()\gravi

DrawText(2+18+xraz/2-128+64+128+1-64, 3+1, Str(axx), RGB((0),(0),(0)) )
DrawText(2+18+xraz/2-128+64+128-64, 3, Str(axx), RGB((255),(255),(255)) )

axx=tur3()\trafic5

DrawText(2+18+xraz/2-128+128+128+1-64, 3+1, Str(axx), RGB((0),(0),(0)) )
DrawText(2+18+xraz/2-128+128+128-64, 3, Str(axx), RGB((255),(255),(255)) )


axx=tur3()\metko

DrawText(2+18+xraz/2-128+128+128+1, 3+1, Str(axx), RGB((0),(0),(0)) )
DrawText(2+18+xraz/2-128+128+128, 3, Str(axx), RGB((255),(255),(255)) )
StopDrawing( )

Return 



umenie2:
If yraz=720:rt=-40:EndIf 
If yraz=1080:rt=-40-57:EndIf 
If yraz=900:rt=-40-57-60:EndIf 
If dis2=0:Goto umenie31:EndIf 
If dis2=1:Goto umenie32:EndIf 
If dis2=2:Goto umenie33:EndIf 
If dis2=3:Goto umenie34:EndIf 
If dis2=4:Goto umenie35:EndIf 
If dis2=5:Goto umenie36:EndIf 
If dis2=6:Goto umenie37:EndIf 
Return 
umenie:
If yraz=720:rt=-40:EndIf 
If yraz=1080:rt=-40-57:EndIf 
If yraz=900:rt=-40-57-60:EndIf 
If dis=0:Goto umenie31:EndIf 
If dis=1:Goto umenie32:EndIf 
If dis=2:Goto umenie33:EndIf 
If dis=3:Goto umenie34:EndIf 
If dis=4:Goto umenie35:EndIf 
If dis=5:Goto umenie36:EndIf 
If dis=6:Goto umenie37:EndIf 
Return 


;--------------------opyt2
umenie31:
If lang=0
DrawText(12+160-50,yraz-124+22+55-400+60+rt , "Искуство войны", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+16+8+rt , "Первичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+16+8+rt , "Атака: +1", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+32+8+rt , "Вторичный навык:", RGB((0),(0),(0)))
DrawText(12+232-50,yraz+60-124+22+55-400+32+8+rt , "Атака: +2", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+48+8+rt , "Третичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+48+8+rt , "Атака: +3, Броня: +1", RGB((100),(0),(0)) )
EndIf 
If lang=1
DrawText(12+160-50,yraz-124+22+55-400+60+rt , "Art of war", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+16+8+rt , "Primary skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+16+8+rt , "Attack: +1", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+32+8+rt , "Secondary skill:", RGB((0),(0),(0)))
DrawText(12+232-50,yraz+60-124+22+55-400+32+8+rt , "Attack: +2", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+48+8+rt , "Tertiary Skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+48+8+rt , "Attack: +3, Armor: +1", RGB((100),(0),(0)) )
EndIf 
Return 
umenie32:
If lang=0
DrawText(12+160-50,yraz+60-124+22+55-400+rt , "Искуство обороны.", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+16+8+rt , "Первичный навык:", RGB((0),(0),(0)))
DrawText(12+232-50,yraz+60-124+22+55-400+16+8+rt , "Броня: +1", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+32+8+rt , "Вторичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+32+8+rt , "Броня: +2", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+48+8+rt , "Третичный навык:", RGB((0),(0),(0)))
DrawText(12+232-50,yraz+60-124+22+55-400+48+8+rt , "Броня: +3, Атака: +1", RGB((100),(0),(0)) )
EndIf 
If lang=1
DrawText(12+160-50,yraz+60-124+22+55-400+rt , "Art of Defense.", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+16+8+rt , "Primary skill:", RGB((0),(0),(0)))
DrawText(12+232-50,yraz+60-124+22+55-400+16+8+rt , "Armor: +1", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+32+8+rt , "Secondary skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+32+8+rt , "Armor: +2", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+48+8+rt , "Tertiary Skill", RGB((0),(0),(0)))
DrawText(12+232-50,yraz+60-124+22+55-400+48+8+rt , "Armor: +3, : Attack+1", RGB((100),(0),(0)) )
EndIf 
Return 
umenie33:
If lang=0
DrawText(12+160-50,yraz+60-124+22+55-400+rt , "Искуство банкира.", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+16+8+rt , "Первичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+16+8+rt , "Добыча кристалов: +1", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+32+8+rt , "Вторичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+32+8+rt , "Добыча кристалов: +2", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+48+8+rt , "Третичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+48+8+rt , "Добыча кристалов: +3, Накопление: +1", RGB((100),(0),(0)) )
EndIf 
If lang=1
DrawText(12+160-50,yraz+60-124+22+55-400+rt , "Art banker.", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+16+8+rt , "Primary skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+16+8+rt , "Mining crystals: +1", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+32+8+rt , "Secondary skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+32+8+rt , "Mining crystals: +2", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+48+8+rt , "Tertiary Skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+48+8+rt , "Mining crystals: +3, Accumulation: +1", RGB((100),(0),(0)) )
EndIf 
Return 
umenie34:
If lang=0
DrawText(12+160-50,yraz+60-124+22+55-400+rt , "Логистика.", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+16+8+rt , "Первичный навык:", RGB((0),(0),(0)))
DrawText(12+232-50,yraz+60-124+22+55-400+16+8+rt , "Скорость: +1", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+32+8+rt , "Вторичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+32+8+rt , "Скорость: +2", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+48+8+rt , "Третичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+48+8+rt , "Скорость: +3, Гравитация: +1", RGB((100),(0),(0)))
EndIf 
If lang=1
DrawText(12+160-50,yraz+60-124+22+55-400+rt , "Logistics.", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+16+8+rt , "Primary skill:", RGB((0),(0),(0)))
DrawText(12+232-50,yraz+60-124+22+55-400+16+8+rt , "Speed: +1", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+32+8+rt , "Secondary skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+32+8+rt , "Speed: +2", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+48+8+rt , "Tertiary Skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+48+8+rt , "Speed: +3, Gravitation: +1", RGB((100),(0),(0)))
EndIf 
Return 
umenie35:
If lang=0
DrawText(12+160-50,yraz+60-124+22+55-400+rt , "Первая помощь.", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+16+8+rt , "Первичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+16+8+rt , "Востоновление: +1", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+32+8+rt , "Вторичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+32+8+rt , "Востоновление: +2", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+48+8+rt , "Третичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+48+8+rt , "Востоновление: +3, Купировать взрыв: +1", RGB((100),(0),(0)) )
EndIf 
If lang=1
DrawText(12+160-50,yraz+60-124+22+55-400+rt , "First-aid.", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+16+8+rt , "Primary skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+16+8+rt , "Data Recovery: +1", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+32+8+rt , "Secondary skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+32+8+rt , "Data Recovery: +2", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+48+8+rt , "Tertiary Skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+48+8+rt , "Data Recovery: +3, Arrest explosion: +1", RGB((100),(0),(0)) )
EndIf
Return 
umenie36:
If lang=0
DrawText(12+160-50,yraz+60-124+22+55-400+rt , "Кошачья ловкость.", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+16+8+rt , "Первичный навык:", RGB((0),(0),(0)))
DrawText(12+232-50,yraz+60-124+22+55-400+16+8+rt , "Гравитация: +1", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+32+8+rt , "Вторичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+32+8+rt , "Гравитация: +2, Увернуться от пули: +1", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+48+8+rt , "Третичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+48+8+rt , "Гравитация: +3, Увернуться от пули: +2", RGB((100),(0),(0)) )
EndIf 
If lang=1
DrawText(12+160-50,yraz+60-124+22+55-400+rt , "Feline agility.", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+16+8+rt , "Primary skill:", RGB((0),(0),(0)))
DrawText(12+232-50,yraz+60-124+22+55-400+16+8+rt , "Gravitation: +1", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+32+8+rt , "Secondary skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+32+8+rt , "Gravitation: +2, Dodge a bullet: +1", RGB((100),(0),(0)) )
DrawText(12+102-50,yraz+60-124+22+55-400+48+8+rt , "Tertiary Skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+48+8+rt , "Gravitation: +3, Dodge a bullet: +2", RGB((100),(0),(0)) )
EndIf 
Return 
umenie37:
If lang=0
DrawText(12+160-50,yraz+60-124+22+55-400+rt , "Тренировка.", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+16+8+rt , "Первичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+16+8+rt , "Меткость: +1", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+32+8+rt , "Вторичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+32+8+rt , "Меткость: +2", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+48+8+rt , "Третичный навык:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+48+8+rt , "Меткость: +3, Увернуться от пули: +1", RGB((100),(0),(0)))
EndIf 
If lang=1
DrawText(12+160-50,yraz+60-124+22+55-400+rt , "Training.", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+16+8+rt , "Primary skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+16+8+rt , "Accuracy: +1", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+32+8+rt , "Secondary skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+32+8+rt , "Accuracy: +2", RGB((100),(0),(0)))
DrawText(12+102-50,yraz+60-124+22+55-400+48+8+rt , "Tertiary Skill:", RGB((0),(0),(0)) )
DrawText(12+232-50,yraz+60-124+22+55-400+48+8+rt , "Accuracy: +3, Dodge a bullet: +1", RGB((100),(0),(0)))
EndIf 
Return 

skana:

  
ResetList( tur3() ) 
While NextElement( tur3())
tur3()\trafic=tur3()\trafic2
If tur3()\slot1a=980 
a=0
If a=0 And Random(30)=0 And tur3()\slot2>0:tur3()\slot2p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot3>0:tur3()\slot3p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot4>0:tur3()\slot4p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot5>0:tur3()\slot5p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot6>0:tur3()\slot6p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot7>0:tur3()\slot7p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot8>0:tur3()\slot8p+1:a=1:EndIf 
:EndIf 


If tur3()\slot2a=980
a=0
If a=0 And Random(30)=0 And tur3()\slot2>0:tur3()\slot2p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot3>0:tur3()\slot3p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot4>0:tur3()\slot4p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot5>0:tur3()\slot5p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot6>0:tur3()\slot6p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot7>0:tur3()\slot7p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot8>0:tur3()\slot8p+1:a=1:EndIf 
:EndIf 


If tur3()\slot3a=980 
a=0
If a=0 And Random(30)=0 And tur3()\slot2>0:tur3()\slot2p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot3>0:tur3()\slot3p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot4>0:tur3()\slot4p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot5>0:tur3()\slot5p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot6>0:tur3()\slot6p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot7>0:tur3()\slot7p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot8>0:tur3()\slot8p+1:a=1:EndIf 
:EndIf 


If tur3()\slot4a=980 
a=0
If a=0 And Random(30)=0 And tur3()\slot2>0:tur3()\slot2p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot3>0:tur3()\slot3p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot4>0:tur3()\slot4p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot5>0:tur3()\slot5p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot6>0:tur3()\slot6p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot7>0:tur3()\slot7p+1:a=1:EndIf 
If a=0 And Random(30)=0 And tur3()\slot8>0:tur3()\slot8p+1:a=1:EndIf 
:EndIf 
Wend
Return 











nextplay222:;-----------------передал ход

ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=97 And tur()\wani<16 And play=tur()\swo:
  nextlp=1:

EndIf 
Wend

Return 

nextplay:



*Old_Element666d = @tur3() 
If shop1=1: 
  
 ResetList( tur3() ) 
       While NextElement( tur3())
         If play=tur3()\pnom:
           
             StartDrawing( ScreenOutput())
           
DrawingFont(FontID(2)) 
DrawingMode(#PB_2DDrawing_Transparent )



    axzq=tur3()\slot1p
b=TextWidth("00000")
bb=TextWidth(Str(axzq))
bbb=b-bb
DrawText(21+1+0+bbb, yraz-76+1 , Str(axzq), RGB((0),(0),(0)) )
DrawText(21+0+bbb, yraz-76 , Str(axzq), RGB((255),(255),(255)) )

If tur3()\slot2>0:
    axzq=tur3()\slot2p
b=TextWidth("00000")
bb=TextWidth(Str(axzq))
bbb=b-bb
DrawText(21+1+32+bbb, yraz-76+1 , Str(axzq), RGB((0),(0),(0)) )
DrawText(21+32+bbb, yraz-76 , Str(axzq), RGB((255),(255),(255)) )
EndIf 


If tur3()\slot3>0:
    axzq=tur3()\slot3p
b=TextWidth("00000")
bb=TextWidth(Str(axzq))
bbb=b-bb
DrawText(21+1+64+bbb, yraz-76+1 , Str(axzq), RGB((0),(0),(0)) )
DrawText(21+64+bbb, yraz-76 , Str(axzq), RGB((255),(255),(255)) )
EndIf 

If tur3()\slot4>0:
    axzq=tur3()\slot4p
b=TextWidth("00000")
bb=TextWidth(Str(axzq))
bbb=b-bb
DrawText(21+1+64+32+bbb, yraz-76+1 , Str(axzq), RGB((0),(0),(0)) )
DrawText(21+64+32+bbb, yraz-76 , Str(axzq), RGB((255),(255),(255)) )
EndIf 


If tur3()\slot5>0:
    axzq=tur3()\slot5p
b=TextWidth("00000")
bb=TextWidth(Str(axzq))
bbb=b-bb
DrawText(21+1+64+64+bbb, yraz-76+1 , Str(axzq), RGB((0),(0),(0)) )
DrawText(21+64+64+bbb, yraz-76 , Str(axzq), RGB((255),(255),(255)) )
EndIf 


If tur3()\slot6>0:
    axzq=tur3()\slot6p
b=TextWidth("00000")
bb=TextWidth(Str(axzq))
bbb=b-bb
DrawText(21+1+64+64+32+bbb, yraz-76+1 , Str(axzq), RGB((0),(0),(0)) )
DrawText(21+64+64+32+bbb, yraz-76 , Str(axzq), RGB((255),(255),(255)) )
EndIf 


If tur3()\slot7>0:
    axzq=tur3()\slot7p
b=TextWidth("00000")
bb=TextWidth(Str(axzq))
bbb=b-bb
DrawText(21+1+128+64+bbb, yraz-76+1 , Str(axzq), RGB((0),(0),(0)) )
DrawText(21+128+64+bbb, yraz-76 , Str(axzq), RGB((255),(255),(255)) )
EndIf 


If tur3()\slot8>0:
    axzq=tur3()\slot8p
b=TextWidth("00000")
bb=TextWidth(Str(axzq))
bbb=b-bb
DrawText(21+1+128+64+32+bbb, yraz-76+1 , Str(axzq), RGB((0),(0),(0)) )
DrawText(21+128+64+32+bbb, yraz-76 , Str(axzq), RGB((255),(255),(255)) )
EndIf 
StopDrawing( )


           EndIf 
    
         Wend 
         
       
EndIf 
   
 ChangeCurrentElement(tur3(), *Old_Element666d)


If nextlp=0:Return:EndIf 


  
  ResetList( tur() ) 
While NextElement( tur())
  If tur()\nom=500:
    
  ResetList( tur3() ) 
While NextElement( tur3())
  If tur3()\pnom=tur()\swo
    
  If tur3()\slot1u=1102 And tur3()\slot1uu=3: 
    
  AddElement(tur8())
tur8()\x=tur()\x+50
tur8()\y=tur()\y-20
tur8()\nom=1
tur8()\plus=1
tur8()\rand=0  
  tur3()\money+1:EndIf 
  

  If tur3()\slot2u=1102 And tur3()\slot2uu=3: 
    AddElement(tur8())
tur8()\x=tur()\x+50
tur8()\y=tur()\y-20
tur8()\nom=1
tur8()\plus=1
tur8()\rand=0   
  tur3()\money+1:EndIf 
   

  If tur3()\slot3u=1102 And tur3()\slot3uu=3: 
    AddElement(tur8())
tur8()\x=tur()\x+50
tur8()\y=tur()\y-20
tur8()\nom=1
tur8()\plus=1
tur8()\rand=0   
  tur3()\money+1:EndIf 
   

  If tur3()\slot4u=1102 And tur3()\slot4uu=3: 
    AddElement(tur8())
tur8()\x=tur()\x+50
tur8()\y=tur()\y-20
tur8()\nom=1
tur8()\plus=1
tur8()\rand=0   
tur3()\money+1:EndIf 
EndIf 
Wend 
EndIf 
Wend 




If almazrea=1:



ResetList( tur() ) 
While NextElement( tur())




If tur()\nom=10:
 
x=tur()\x
y=tur()\y

*Old_Element3 = @tur()
ResetList( tur() ) 
While NextElement( tur())
  If tur()\nom=67 And SpriteCollision(67, x, y-48, tur()\nom, tur()\x, tur()\y):Goto sn:EndIf 
Wend 

  LastElement(tur())
 If Random(150)=0
  AddElement( tur() )
tur()\x = x
tur()\y = y-48
tur()\nom = 67
EndIf 
sn:
ChangeCurrentElement(tur(), *Old_Element3)

EndIf 

Wend 
EndIf 


ResetList( tur5() ) 
While NextElement( tur5())
If tur5()\nom<>0:Return:EndIf 
Wend 







If iko>0 Or shop1>0:Return:EndIf 
plnex=0

If players2=smertxw+1:endturr=1:Return:EndIf 


timecpu=0
nextlp=0
or1a=0:or2a=0:or3a=0:or4a=0

Gosub skana
igroplay=0
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=97 Or tur()\nom=500:tur()\x2=tur()\x:tur()\y2=tur()\y:
If tur()\wani<128
tur()\wani=0
EndIf 
:EndIf 
Wend

time=0
space=0
botdjump=0
nosmile=0

sh=0


chet9=0
sssss:
play+1
If players>0:players-1:EndIf 
push=0
If players=0:players=players2:play=1:EndIf 
ssssss:
ResetList( tur() ) 
While NextElement( tur())
  If tur()\nom=97 And tur()\swo=play And tur()\swo2=333
    play+1
  If players>0:players-1:EndIf 
push=0
If players=0:players=players2:play=1:EndIf 
:EndIf 
Wend




shlak=0
spid3=1
xti=0
yti=0
iko=10
stoitli2=0
stoitli=0
norak=0
norak2=0
norak3=0
norak4=0
norak5=0
norak6=0
norak7=0
norak8=0
norak9=0





ResetList( tur() ) 
While NextElement( tur())
  If tur()\nom=97 And tur()\bot=0 And tur()\swo2<>333:Return:EndIf 
Wend 
endturr=1
nechja=1







Return 

;---------------babah
babah:


ResetList( tur6() ) 
While NextElement( tur6())
If tur6()\nom=15:Gosub babah2:EndIf 
Wend
Return
babah2:
If tur6()\kris<>913:ZoomSprite3D(tur6()\spr+tur6()\kris, tur6()\degr+32, tur6()\degr+32):EndIf 
If tur6()\kris=913:ZoomSprite3D(913, tur6()\degr-32, tur6()\degr-32):EndIf 
Start3D()
Sprite3DBlendingMode(10, 7)
If tur6()\kris<>913:DisplaySprite3D(tur6()\spr+tur6()\kris ,  tur6()\x+c, tur6()\y+d,255):EndIf 
If tur6()\kris=913:DisplaySprite3D(913 ,  tur6()\x+c+32, tur6()\y+d,10):EndIf 
Sprite3DBlendingMode(2, 6)
Stop3D()
If Random(0)=0 And tur6()\spr<21 And tur6()\kris=0::tur6()\spr+1:EndIf 
If Random(0)=0 And tur6()\spr<29 And tur6()\kris>0::tur6()\spr+1:EndIf 
tur6()\x+tur6()\xx
tur6()\y+tur6()\yy
xwzq=tur6()\x
ywzq=tur6()\y

If Random(20)=0:
ResetList( tur() ) 
While NextElement( tur())
If tur()\nom=500 And SpriteCollision(tur()\nom,tur()\x,tur()\y,tur6()\spr,tur6()\x,tur6()\y):
If tur6()\cwet2>10 And  tur6()\cwet2<>25:
a=1:
If tur6()\kris=0:
;Gosub otnqtx
:EndIf 
EndIf 

If tur6()\cwet2=25 And play<>tur()\swo:
a=1:
If tur6()\kris=0:

NextElement(tur())
If tur()\stor=0:tur()\iner=4:EndIf 
If tur()\stor=1:tur()\iner2=4:EndIf 
PreviousElement(tur())
a=1
;Gosub otnqtx22
:EndIf 

EndIf 

:EndIf 
Wend
EndIf 

tur6()\life-1
a=255
radi=tur6()\cwet2
a/radi
tur6()\cwet-a
If tur6()\life=0:DeleteElement(tur6()):Return:EndIf 
If tur6()\cwet<=0:DeleteElement(tur6()):EndIf 


Return 




instalb:


;If insi=1:Return:EndIf 
;insi=1
b=rwzr*radi
Repeat


sss666=Random(radi)
If Random(200)=0:sss666+Random(20):EndIf 
radius=radi-sss666
X666.f = 2+sss666
Y666.f = 2+X666.f
s666.f=Random(10)
s666.f/10
ss666.f=Random(10)
ss666.f/100
aaaa.f=Random(5)+s666.f+ss666.f
X23666.f = X666*Cos(aaaa) + Y666*Sin(aaaa)
Y23666.f = X666*Sin(aaaa) - Y666*Cos(aaaa)
 AddElement( tur6() )
 a000=Random(wzr)+1
    tur6()\x=xwz-a000/2
    tur6()\y=ywz-a000/2
    tur6()\xx=X23666
    tur6()\yy=Y23666
    tur6()\nom=15
    tur6()\kris=kris
    tur6()\degr=a000
    tur6()\life=1+Random(radius)
    tur6()\cwet=255
    tur6()\cwet2=radi
    tur6()\spr=15
    b-1
      Until b=0
Return 


instalbb:

;If insi=1:Return:EndIf 
;insi=1
b=rwzr*radi
Repeat
sss666=Random(radi) 
radius=radi-sss666
X666.f = 2+sss666
Y666.f = 2+X666.f
s666.f=Random(10)
s666.f/10
ss666.f=Random(10)
ss666.f/100
X23666.f = X666*Cos(aaaa) + Y666*Sin(aaaa)
Y23666.f = X666*Sin(aaaa) - Y666*Cos(aaaa)
 AddElement( tur6() )
 a000=Random(wzr)+1
    tur6()\x=xwz-a000/2
    tur6()\y=ywz-a000/2
    tur6()\xx=X23666
    tur6()\yy=Y23666
    tur6()\nom=15
    tur6()\degr=a000
    tur6()\life=1+Random(radius)
    tur6()\cwet=255
    tur6()\cwet2=radi
    tur6()\spr=15
    b-1
      Until b=0
Return 

;------------------priz
wzylpriz:
nod=0

*Old_Element66 = @tur() 
ChangeCurrentElement(tur(), *Old_Element)
PreviousElement(tur())
If tur()\swo2=333:nod=1:NextElement(tur()):
ChangeCurrentElement(tur(), *Old_Element66):Return:EndIf 
NextElement(tur())
ResetList( tur3() ) 
While NextElement( tur3())
If tur3()\pnom=tur()\swo And kto=67:
  tur3()\money+10
  tur3()\opyt+1
  If tur3()\bot=1:tur3()\money+10:EndIf 
  
  If tur3()\slot1u=1102 And tur3()\slot1uu=1: tur3()\money+1:EndIf 
   If tur3()\slot1u=1102 And tur3()\slot1uu=2: tur3()\money+2:EndIf 
  If tur3()\slot1u=1102 And tur3()\slot1uu=3: tur3()\money+3:EndIf 
  
    If tur3()\slot2u=1102 And tur3()\slot2uu=1: tur3()\money+1:EndIf 
   If tur3()\slot2u=1102 And tur3()\slot2uu=2: tur3()\money+2:EndIf 
   If tur3()\slot2u=1102 And tur3()\slot2uu=3: tur3()\money+3:EndIf 
   
     If tur3()\slot3u=1102 And tur3()\slot3uu=1: tur3()\money+1:EndIf 
   If tur3()\slot3u=1102 And tur3()\slot3uu=2: tur3()\money+2:EndIf 
   If tur3()\slot3u=1102 And tur3()\slot3uu=3: tur3()\money+3:EndIf 
   
     If tur3()\slot4u=1102 And tur3()\slot4uu=1: tur3()\money+1:EndIf 
   If tur3()\slot4u=1102 And tur3()\slot4uu=2: tur3()\money+2:EndIf 
  If tur3()\slot4u=1102 And tur3()\slot4uu=3: tur3()\money+3:EndIf 
   
   
If tur3()\opyt=100:tur3()\money+100:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=210:tur3()\money+200:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=330:tur3()\money+300:tur()\x2=tur()\x:diss=1:EndIf
If tur3()\opyt=450:tur3()\money+400:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=570:tur3()\money+500:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=690:tur3()\money+600:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=810:tur3()\money+700:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=930:tur3()\money+800:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=1050:tur3()\money+900:tur()\x2=tur()\x:diss=1:EndIf  

If tur3()\bot=1: tur3()\opyt+1
  
  If tur3()\opyt=100:tur3()\money+100:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=210:tur3()\money+200:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=330:tur3()\money+300:tur()\x2=tur()\x:diss=1:EndIf
If tur3()\opyt=450:tur3()\money+400:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=570:tur3()\money+500:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=690:tur3()\money+600:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=810:tur3()\money+700:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=930:tur3()\money+800:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=1050:tur3()\money+900:tur()\x2=tur()\x:diss=1:EndIf 
  
  
:EndIf 

If tur3()\bot=1: tur3()\opyt+1
  
  If tur3()\opyt=100:tur3()\money+100:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=210:tur3()\money+200:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=330:tur3()\money+300:tur()\x2=tur()\x:diss=1:EndIf
If tur3()\opyt=450:tur3()\money+400:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=570:tur3()\money+500:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=690:tur3()\money+600:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=810:tur3()\money+700:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=930:tur3()\money+800:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=1050:tur3()\money+900:tur()\x2=tur()\x:diss=1:EndIf 
  
  
:EndIf 

If tur3()\bot=1: tur3()\opyt+1
  
  If tur3()\opyt=100:tur3()\money+100:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=210:tur3()\money+200:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=330:tur3()\money+300:tur()\x2=tur()\x:diss=1:EndIf
If tur3()\opyt=450:tur3()\money+400:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=570:tur3()\money+500:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=690:tur3()\money+600:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=810:tur3()\money+700:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=930:tur3()\money+800:tur()\x2=tur()\x:diss=1:EndIf 
If tur3()\opyt=1050:tur3()\money+900:tur()\x2=tur()\x:diss=1:EndIf 
  
  
:EndIf 
If or1a=971 Or  or2a=971 Or  or3a=971 Or  or4a=971:tur3()\money+4:EndIf 
If or1a=975 Or  or2a=975 Or  or3a=975 Or  or4a=975:tur3()\money+1:EndIf 

rrrr=0
If Random(100)=0:
PreviousElement(tur())
tur()\smilet=255
tur()\smilet2=50
tur()\smile=991
NextElement(tur())
EndIf

AddElement(tur8())
tur8()\x=tur()\x+50
tur8()\y=tur()\y-20
tur8()\nom=10
tur8()\plus=1
tur8()\rand=0
If or1a=971 :tur8()\nom+4:EndIf
 If or2a=971:tur8()\nom+4:EndIf
 If or3a=971 :tur8()\nom+4:EndIf
If or4a=971:tur8()\nom+4:EndIf


If or1a=975 : tur8()\nom+1:EndIf
If  or2a=975  :tur8()\nom+1:EndIf
If  or3a=975 :tur8()\nom+1:EndIf
If or4a=975:tur8()\nom+1:EndIf

If tur3()\bot=1:tur8()\nom+10:EndIf 

  If tur3()\slot1u=1102 And tur3()\slot1uu=1: tur8()\nom+1:EndIf 
   If tur3()\slot1u=1102 And tur3()\slot1uu=2: tur8()\nom+2:EndIf 
  If tur3()\slot1u=1102 And tur3()\slot1uu=3: tur8()\nom+3:EndIf 
  
    If tur3()\slot2u=1102 And tur3()\slot2uu=1: tur8()\nom+1:EndIf 
   If tur3()\slot2u=1102 And tur3()\slot2uu=2: tur8()\nom+2:EndIf 
   If tur3()\slot2u=1102 And tur3()\slot2uu=3: tur8()\nom+3:EndIf 
   
     If tur3()\slot3u=1102 And tur3()\slot3uu=1: tur8()\nom+1:EndIf 
   If tur3()\slot3u=1102 And tur3()\slot3uu=2:tur8()\nom+2:EndIf 
   If tur3()\slot3u=1102 And tur3()\slot3uu=3: tur8()\nom+3:EndIf 
   
     If tur3()\slot4u=1102 And tur3()\slot4uu=1: tur8()\nom+1:EndIf 
   If tur3()\slot4u=1102 And tur3()\slot4uu=2: tur8()\nom+2:EndIf 
  If tur3()\slot4u=1102 And tur3()\slot4uu=3: tur8()\nom+3:EndIf 
:EndIf 


If tur3()\pnom=tur()\swo And kto=>970:

If tur3()\slot1a=0:tur3()\slot1a=kto:Goto rand:EndIf 
If tur3()\slot2a=0:tur3()\slot2a=kto:Goto rand:EndIf 
If tur3()\slot3a=0:tur3()\slot3a=kto:Goto rand:EndIf 
If tur3()\slot4a=0:tur3()\slot4a=kto:Goto rand:EndIf 
rrrr=1:Goto rand1:

:EndIf 
Wend 
Goto rand1:
rand:
PreviousElement(tur())
tur()\smilet=255
tur()\smilet2=50
tur()\smile=991
;If kto=970:tur()\energ2+1:EndIf 
NextElement(tur())

Gosub instor22
rand1:

ChangeCurrentElement(tur(), *Old_Element66)


Return 



textl:
ResetList( tur8() ) 
While NextElement( tur8())
If tur8()\nom>0: 
 StartDrawing( ScreenOutput())
 DrawingMode(#PB_2DDrawing_Transparent )
 DrawingFont(FontID(0)) 
  If tur8()\plus=2:DrawText(tur8()\x+c-1,tur8()\y+d , "+ "+Str(tur8()\nom), RGB((0),(0),(0)) ):EndIf 
 If tur8()\plus=2:DrawText(tur8()\x+c,tur8()\y+d , "+ "+Str(tur8()\nom), RGB((150),(255),(255)) ):EndIf 
If tur8()\plus=1:DrawText(tur8()\x+c,tur8()\y+d , "+ "+Str(tur8()\nom), RGB((255),(255),(255)) ):EndIf 
If tur8()\plus=0:DrawText(tur8()\x+c,tur8()\y+d , "- "+Str(tur8()\nom), RGB((255),(20),(0)) ):EndIf 
  StopDrawing() 
  tur8()\y-1
  If tur8()\rand=1:tur8()\x-1:EndIf 
    If tur8()\rand=2:tur8()\x+1:EndIf 
      If tur8()\rand=3:tur8()\y-1:EndIf 
         If tur8()\rand=4:tur8()\y-2:EndIf 
         If tur8()\rand=5:tur8()\x+2:EndIf 
         If tur8()\rand=6:tur8()\x-2:EndIf 
         If tur8()\rand=7:tur8()\x+2:tur8()\y-1:EndIf 
         If tur8()\rand=8:tur8()\x+2:tur8()\y-1:EndIf 
  tur8()\life+1
  If tur8()\life=60:DeleteElement(tur8())
  EndIf 
   EndIf 
  Wend 
Return 


instor:
ResetList( tur3() ) 
While NextElement( tur3())
a=8
Repeat 
If tur3()\slot1=0:
tur3()\slot1p=tur3()\slot2p
tur3()\slot1=tur3()\slot2
tur3()\slot2=0:tur3()\slot2p=0
EndIf 
If tur3()\slot2=0:
tur3()\slot2p=tur3()\slot3p
tur3()\slot2=tur3()\slot3
tur3()\slot3=0:tur3()\slot3p=0
EndIf 
If tur3()\slot3=0:
tur3()\slot3p=tur3()\slot4p
tur3()\slot3=tur3()\slot4
tur3()\slot4=0:tur3()\slot4p=0
EndIf 
If tur3()\slot4=0:
tur3()\slot4p=tur3()\slot5p
tur3()\slot4=tur3()\slot5
tur3()\slot5=0:tur3()\slot5p=0
EndIf 
If tur3()\slot5=0:
tur3()\slot5p=tur3()\slot6p
tur3()\slot5=tur3()\slot6
tur3()\slot6=0:tur3()\slot6p=0
EndIf 
If tur3()\slot6=0:
tur3()\slot6p=tur3()\slot7p
tur3()\slot6=tur3()\slot7
tur3()\slot7=0:tur3()\slot7p=0
EndIf 
If tur3()\slot7=0:
tur3()\slot7p=tur3()\slot8p
tur3()\slot7=tur3()\slot8
tur3()\slot8=0:tur3()\slot8p=0
EndIf 
a-1
Until a=0

If tur3()\slot1a=0:
tur3()\slot1a=tur3()\slot2a
tur3()\slot2a=0
EndIf 
If tur3()\slot2a=0:
tur3()\slot2a=tur3()\slot3a
tur3()\slot3a=0
EndIf 
If tur3()\slot3a=0:
tur3()\slot3a=tur3()\slot4a
tur3()\slot4a=0
EndIf 

Wend 


If ffff=0:Gosub instor2:EndIf 
Return 





instor31:


ResetList( tur3() ) 
While NextElement( tur3())
  If tur3()\pnom=play:
  
If tur3()\slot1u=1100 And tur3()\slot1uu=1:
tur3()\ataka+1
EndIf 
If tur3()\slot1u=1100 And tur3()\slot1uu=2:
tur3()\ataka+2-1
EndIf 
If tur3()\slot1u=1100 And tur3()\slot1uu=3:
tur3()\ataka+3-2
tur3()\energ2+1
EndIf 
If tur3()\slot1u=1101 And tur3()\slot1uu=1:
tur3()\energ2+1
EndIf 
If tur3()\slot1u=1101 And tur3()\slot1uu=2:
tur3()\energ2+2-1
EndIf 
If tur3()\slot1u=1101 And tur3()\slot1uu=3:
tur3()\ataka+1
tur3()\energ2+3-2
EndIf 
If tur3()\slot1u=1103 And tur3()\slot1uu=1:
tur3()\trafic5+1
EndIf 
If tur3()\slot1u=1103 And tur3()\slot1uu=2:
tur3()\trafic5+2-1
EndIf 
If tur3()\slot1u=1103 And tur3()\slot1uu=3:
tur3()\gravi+1
tur3()\trafic5+3-2
EndIf 
If tur3()\slot1u=1104 And tur3()\slot1uu=1:
tur3()\reani+1
EndIf 
If tur3()\slot1u=1104 And tur3()\slot1uu=2:
tur3()\reani+2-1
EndIf 
If tur3()\slot1u=1104 And tur3()\slot1uu=3:
tur3()\reani+3-2
EndIf 
If tur3()\slot1u=1105 And tur3()\slot1uu=1:
tur3()\gravi+1
EndIf 
If tur3()\slot1u=1105 And tur3()\slot1uu=2:
tur3()\gravi+2-1
EndIf 
If tur3()\slot1u=1105 And tur3()\slot1uu=3:
tur3()\gravi+3-2
EndIf 
If tur3()\slot1u=1106 And tur3()\slot1uu=1:
tur3()\metko+1
EndIf 
If tur3()\slot1u=1106 And tur3()\slot1uu=2:
tur3()\metko+2-1
EndIf 
If tur3()\slot1u=1106 And tur3()\slot1uu=3:
tur3()\metko+3-2
EndIf 
EndIf 
Wend 
Return 

instor32:
ResetList( tur3() ) 
While NextElement( tur3())
  If tur3()\pnom=play:
If tur3()\slot2u=1100 And tur3()\slot1uu=1:
tur3()\ataka+1
EndIf 
If tur3()\slot2u=1100 And tur3()\slot1uu=2:
tur3()\ataka+2-1
EndIf 
If tur3()\slot2u=1100 And tur3()\slot1uu=3:
tur3()\ataka+3
tur3()\energ2+1
EndIf 
If tur3()\slot2u=1101 And tur3()\slot1uu=1:
tur3()\energ2+1
EndIf 
If tur3()\slot2u=1101 And tur3()\slot1uu=2:
tur3()\energ2+2-1
EndIf 
If tur3()\slot2u=1101 And tur3()\slot1uu=3:
tur3()\ataka+1
tur3()\energ2+3-2
EndIf 
If tur3()\slot2u=1103 And tur3()\slot1uu=1:
tur3()\trafic5+1
EndIf 
If tur3()\slot2u=1103 And tur3()\slot1uu=2:
tur3()\trafic5+2-1
EndIf 
If tur3()\slot2u=1103 And tur3()\slot1uu=3:
tur3()\gravi+1
tur3()\trafic5+3-2
EndIf 
If tur3()\slot2u=1104 And tur3()\slot1uu=1:
tur3()\reani+1
EndIf 
If tur3()\slot2u=1104 And tur3()\slot1uu=2:
tur3()\reani+2-1
EndIf 
If tur3()\slot2u=1104 And tur3()\slot1uu=3:
tur3()\reani+3-2
EndIf 
If tur3()\slot2u=1105 And tur3()\slot1uu=1:
tur3()\gravi+1
EndIf 
If tur3()\slot2u=1105 And tur3()\slot1uu=2:
tur3()\gravi+2-1
EndIf 
If tur3()\slot2u=1105 And tur3()\slot1uu=3:
tur3()\gravi+3-2
EndIf 
If tur3()\slot2u=1106 And tur3()\slot1uu=1:
tur3()\metko+1
EndIf 
If tur3()\slot2u=1106 And tur3()\slot1uu=2:
tur3()\metko+2-1
EndIf 
If tur3()\slot2u=1106 And tur3()\slot1uu=3:
tur3()\metko+3-2
EndIf 
EndIf 
Wend 
Return 
instor33:
ResetList( tur3() ) 
While NextElement( tur3())
  If tur3()\pnom=play:
If tur3()\slot3u=1100 And tur3()\slot1uu=1:
tur3()\ataka+1
EndIf 
If tur3()\slot3u=1100 And tur3()\slot1uu=2:
tur3()\ataka+2-1
EndIf 
If tur3()\slot3u=1100 And tur3()\slot1uu=3:
tur3()\ataka+3-2
tur3()\energ2+1
EndIf 
If tur3()\slot3u=1101 And tur3()\slot1uu=1:
tur3()\energ2+1
EndIf 
If tur3()\slot3u=1101 And tur3()\slot1uu=2:
tur3()\energ2+2-1
EndIf 
If tur3()\slot3u=1101 And tur3()\slot1uu=3:
tur3()\ataka+1
tur3()\energ2+3-2
EndIf 
If tur3()\slot3u=1103 And tur3()\slot1uu=1:
tur3()\trafic5+1
EndIf 
If tur3()\slot3u=1103 And tur3()\slot1uu=2:
tur3()\trafic5+2-1
EndIf 
If tur3()\slot3u=1103 And tur3()\slot1uu=3:
tur3()\gravi+1
tur3()\trafic5+3-2
EndIf 
If tur3()\slot3u=1104 And tur3()\slot1uu=1:
tur3()\reani+1
EndIf 
If tur3()\slot3u=1104 And tur3()\slot1uu=2:
tur3()\reani+2-1
EndIf 
If tur3()\slot3u=1104 And tur3()\slot1uu=3:
tur3()\reani+3-2
EndIf 
If tur3()\slot3u=1105 And tur3()\slot1uu=1:
tur3()\gravi+1
EndIf 
If tur3()\slot3u=1105 And tur3()\slot1uu=2:
tur3()\gravi+2-1
EndIf 
If tur3()\slot3u=1105 And tur3()\slot1uu=3:
tur3()\gravi+3-2
EndIf 
If tur3()\slot3u=1106 And tur3()\slot1uu=1:
tur3()\metko+1
EndIf 
If tur3()\slot3u=1106 And tur3()\slot1uu=2:
tur3()\metko+2-1
EndIf 
If tur3()\slot3u=1106 And tur3()\slot1uu=3:
tur3()\metko+3-2
EndIf 
EndIf 
Wend 
Return 

instor34:
ResetList( tur3() ) 
While NextElement( tur3())
  If tur3()\pnom=play:
If tur3()\slot4u=1100 And tur3()\slot1uu=1:
tur3()\ataka+1
EndIf 
If tur3()\slot4u=1100 And tur3()\slot1uu=2:
tur3()\ataka+2-1
EndIf 
If tur3()\slot4u=1100 And tur3()\slot1uu=3:
tur3()\ataka+3-2
tur3()\energ2+1
EndIf 
If tur3()\slot4u=1101 And tur3()\slot1uu=1:
tur3()\energ2+1
EndIf 
If tur3()\slot4u=1101 And tur3()\slot1uu=2:
tur3()\energ2+2-1
EndIf 
If tur3()\slot4u=1101 And tur3()\slot1uu=3:
tur3()\ataka+1
tur3()\energ2+3-2
EndIf
If tur3()\slot4u=1103 And tur3()\slot1uu=1:
tur3()\trafic5+1
EndIf 
If tur3()\slot4u=1103 And tur3()\slot1uu=2:
tur3()\trafic5+2-1
EndIf 
If tur3()\slot4u=1103 And tur3()\slot1uu=3:
tur3()\gravi+1
tur3()\trafic5+3-2
EndIf
If tur3()\slot4u=1104 And tur3()\slot1uu=1:
tur3()\reani+1
EndIf 
If tur3()\slot4u=1104 And tur3()\slot1uu=2:
tur3()\reani+2-1
EndIf 
If tur3()\slot4u=1104 And tur3()\slot1uu=3:
tur3()\reani+3-2
EndIf 
If tur3()\slot4u=1105 And tur3()\slot1uu=1:
tur3()\gravi+1
EndIf 
If tur3()\slot4u=1105 And tur3()\slot1uu=2:
tur3()\gravi+2-1
EndIf 
If tur3()\slot4u=1105 And tur3()\slot1uu=3:
tur3()\gravi+3-2
EndIf 
If tur3()\slot4u=1106 And tur3()\slot1uu=1:
tur3()\metko+1
EndIf 
If tur3()\slot4u=1106 And tur3()\slot1uu=2:
tur3()\metko+2-1
EndIf 
If tur3()\slot4u=1106 And tur3()\slot1uu=3:
tur3()\metko+3-2
EndIf 
EndIf 
Wend 
Return 










instor2:

ResetList( tur3() ) 
While NextElement( tur3())

If tur3()\slot1a=970:
tur3()\energ2+1
tur3()\ataka+1
EndIf 
If tur3()\slot1a=972:
tur3()\reani+1
EndIf 
If tur3()\slot1a=973:
tur3()\reani+2
EndIf 
If tur3()\slot1a=974:
tur3()\gravi+3
EndIf 
If tur3()\slot1a=976:
tur3()\reani+3
EndIf 
If tur3()\slot1a=977:
tur3()\gravi+1
EndIf 
If tur3()\slot1a=978:
tur3()\gravi+5
EndIf 
If tur3()\slot1a=979:
tur3()\ataka+3
EndIf 
If tur3()\slot1a=981:
tur3()\trafic5+1
EndIf 
If tur3()\slot1a=984:
tur3()\metko+4
tur3()\ataka+2
tur3()\energ2+2
EndIf 
If tur3()\slot1a=985:
tur3()\ataka+2
tur3()\energ2+5
EndIf 
If tur3()\slot1a=986:
tur3()\gravi+1
tur3()\trafic5+3
EndIf 
If tur3()\slot1a=987:
tur3()\energ2+3
EndIf 



If tur3()\slot2a=970:
tur3()\energ2+1
tur3()\ataka+1
EndIf 
If tur3()\slot2a=972:
tur3()\reani+1
EndIf 
If tur3()\slot2a=973:
tur3()\reani+2
EndIf 
If tur3()\slot2a=974:
tur3()\gravi+3
EndIf 
If tur3()\slot2a=976:
tur3()\reani+3
EndIf 
If tur3()\slot2a=977:
tur3()\gravi+1
EndIf
If tur3()\slot2a=978:
tur3()\gravi+5
EndIf 
If tur3()\slot2a=979:
tur3()\ataka+3
EndIf 
If tur3()\slot2a=981:
tur3()\trafic5+1
EndIf 
If tur3()\slot2a=984:
tur3()\metko+4
tur3()\ataka+2
tur3()\energ2+2
EndIf 
If tur3()\slot2a=985:
tur3()\ataka+2
tur3()\energ2+5
EndIf 
If tur3()\slot2a=986:
tur3()\gravi+1
tur3()\trafic5+3
EndIf 
If tur3()\slot2a=987:
tur3()\energ2+3
EndIf 



If tur3()\slot3a=970:
tur3()\energ2+1
tur3()\ataka+1
EndIf 
If tur3()\slot3a=972:
tur3()\reani+1
EndIf 
If tur3()\slot3a=973:
tur3()\reani+2
EndIf 
If tur3()\slot3a=974:
tur3()\gravi+3
EndIf 
If tur3()\slot3a=976:
tur3()\reani+3
EndIf 
If tur3()\slot3a=977:
tur3()\gravi+1
EndIf
If tur3()\slot3a=978:
tur3()\gravi+5
EndIf 
If tur3()\slot3a=979:
tur3()\ataka+3
EndIf 
If tur3()\slot3a=981:
tur3()\trafic5+1
EndIf 
If tur3()\slot3a=984:
tur3()\metko+4
tur3()\ataka+2
tur3()\energ2+2
EndIf 
If tur3()\slot3a=985:
tur3()\ataka+2
tur3()\energ2+5
EndIf 
If tur3()\slot3a=986:
tur3()\gravi+1
tur3()\trafic5+3
EndIf 
If tur3()\slot3a=987:
tur3()\energ2+3
EndIf 



If tur3()\slot4a=970:
tur3()\energ2+1
tur3()\ataka+1
EndIf 
If tur3()\slot4a=972:
tur3()\reani+1
EndIf 
If tur3()\slot4a=973:
tur3()\reani+2
EndIf 
If tur3()\slot4a=974:
tur3()\gravi+3
EndIf 
If tur3()\slot4a=976:
tur3()\reani+3
EndIf 
If tur3()\slot4a=977:
tur3()\gravi+1
EndIf
If tur3()\slot4a=978:
tur3()\gravi+5
EndIf 
If tur3()\slot4a=979:
tur3()\ataka+3
EndIf 
If tur3()\slot4a=981:
tur3()\trafic5+1
EndIf 
If tur3()\slot4a=984:
tur3()\metko+4
tur3()\ataka+2
tur3()\energ2+2
EndIf 
If tur3()\slot4a=985:
tur3()\ataka+2
tur3()\energ2+5
EndIf 
If tur3()\slot4a=986:
tur3()\gravi+1
tur3()\trafic5+3
EndIf 
If tur3()\slot4a=987:
tur3()\energ2+3
EndIf 


If tur3()\slot1u=1100 And tur3()\slot1uu=1:
tur3()\ataka+1
EndIf 
If tur3()\slot1u=1100 And tur3()\slot1uu=2:
tur3()\ataka+2
EndIf 
If tur3()\slot1u=1100 And tur3()\slot1uu=3:
tur3()\ataka+3
tur3()\energ2+1
EndIf 
If tur3()\slot2u=1100 And tur3()\slot2uu=1:
tur3()\ataka+1
EndIf 
If tur3()\slot2u=1100 And tur3()\slot2uu=2:
tur3()\ataka+2
EndIf 
If tur3()\slot2u=1100 And tur3()\slot2uu=3:
tur3()\ataka+3
tur3()\energ2+1
EndIf 
If tur3()\slot3u=1100 And tur3()\slot3uu=1:
tur3()\ataka+1
EndIf 
If tur3()\slot3u=1100 And tur3()\slot3uu=2:
tur3()\ataka+2
EndIf 
If tur3()\slot3u=1100 And tur3()\slot3uu=3:
tur3()\ataka+3
tur3()\energ2+1
EndIf 
If tur3()\slot4u=1100 And tur3()\slot4uu=1:
tur3()\ataka+1
EndIf 
If tur3()\slot4u=1100 And tur3()\slot4uu=2:
tur3()\ataka+2
EndIf 
If tur3()\slot4u=1100 And tur3()\slot4uu=3:
tur3()\ataka+3
tur3()\energ2+1
EndIf 

If tur3()\slot1u=1101 And tur3()\slot1uu=1:
tur3()\energ2+1
EndIf 
If tur3()\slot1u=1101 And tur3()\slot1uu=2:
tur3()\energ2+2
EndIf 
If tur3()\slot1u=1101 And tur3()\slot1uu=3:
tur3()\ataka+1
tur3()\energ2+3
EndIf 
If tur3()\slot2u=1101 And tur3()\slot2uu=1:
tur3()\energ2+1
EndIf 
If tur3()\slot2u=1101 And tur3()\slot2uu=2:
tur3()\energ2+2
EndIf 
If tur3()\slot2u=1101 And tur3()\slot2uu=3:
tur3()\ataka+1
tur3()\energ2+3
EndIf 
If tur3()\slot3u=1101 And tur3()\slot3uu=1:
tur3()\energ2+1
EndIf 
If tur3()\slot3u=1101 And tur3()\slot3uu=2:
tur3()\energ2+2
EndIf 
If tur3()\slot3u=1101 And tur3()\slot3uu=3:
tur3()\ataka+1
tur3()\energ2+3
EndIf 
If tur3()\slot4u=1101 And tur3()\slot4uu=1:
tur3()\energ2+1
EndIf 
If tur3()\slot4u=1101 And tur3()\slot4uu=2:
tur3()\energ2+2
EndIf 
If tur3()\slot4u=1101 And tur3()\slot4uu=3:
tur3()\ataka+1
tur3()\energ2+3
EndIf 

If tur3()\slot1u=1103 And tur3()\slot1uu=1:
tur3()\trafic5+1
EndIf 
If tur3()\slot1u=1103 And tur3()\slot1uu=2:
tur3()\trafic5+2
EndIf 
If tur3()\slot1u=1103 And tur3()\slot1uu=3:
tur3()\gravi+1
tur3()\trafic5+3
EndIf 
If tur3()\slot2u=1103 And tur3()\slot2uu=1:
tur3()\trafic5+1
EndIf 
If tur3()\slot2u=1103 And tur3()\slot2uu=2:
tur3()\trafic5+2
EndIf 
If tur3()\slot2u=1103 And tur3()\slot2uu=3:
tur3()\gravi+1
tur3()\trafic5+3
EndIf 
If tur3()\slot3u=1103 And tur3()\slot3uu=1:
tur3()\trafic5+1
EndIf 
If tur3()\slot3u=1103 And tur3()\slot3uu=2:
tur3()\trafic5+2
EndIf 
If tur3()\slot3u=1103 And tur3()\slot3uu=3:
tur3()\gravi+1
tur3()\trafic5+3
EndIf 
If tur3()\slot4u=1103 And tur3()\slot4uu=1:
tur3()\trafic5+1
EndIf 
If tur3()\slot4u=1103 And tur3()\slot4uu=2:
tur3()\trafic5+2
EndIf 
If tur3()\slot4u=1103 And tur3()\slot4uu=3:
tur3()\gravi+1
tur3()\trafic5+3
EndIf 

If tur3()\slot1u=1104 And tur3()\slot1uu=1:
tur3()\reani+1
EndIf 
If tur3()\slot1u=1104 And tur3()\slot1uu=2:
tur3()\reani+2
EndIf 
If tur3()\slot1u=1104 And tur3()\slot1uu=3:
tur3()\reani+3
EndIf 
If tur3()\slot2u=1104 And tur3()\slot2uu=1:
tur3()\reani+1
EndIf 
If tur3()\slot2u=1104 And tur3()\slot2uu=2:
tur3()\reani+2
EndIf 
If tur3()\slot2u=1104 And tur3()\slot2uu=3:
tur3()\reani+3
EndIf 
If tur3()\slot3u=1104 And tur3()\slot3uu=1:
tur3()\reani+1
EndIf 
If tur3()\slot3u=1104 And tur3()\slot3uu=2:
tur3()\reani+2
EndIf 
If tur3()\slot3u=1104 And tur3()\slot3uu=3:
tur3()\reani+3
EndIf 
If tur3()\slot4u=1104 And tur3()\slot4uu=1:
tur3()\reani+1
EndIf 
If tur3()\slot4u=1104 And tur3()\slot4uu=2:
tur3()\reani+2
EndIf 
If tur3()\slot4u=1104 And tur3()\slot4uu=3:
tur3()\reani+3
EndIf 

If tur3()\slot1u=1105 And tur3()\slot1uu=1:
tur3()\gravi+1
EndIf 
If tur3()\slot1u=1105 And tur3()\slot1uu=2:
tur3()\gravi+2
EndIf 
If tur3()\slot1u=1105 And tur3()\slot1uu=3:
tur3()\gravi+3
EndIf 
If tur3()\slot2u=1105 And tur3()\slot2uu=1:
tur3()\gravi+1
EndIf 
If tur3()\slot2u=1105 And tur3()\slot2uu=2:
tur3()\gravi+2
EndIf 
If tur3()\slot2u=1105 And tur3()\slot2uu=3:
tur3()\gravi+3
EndIf 
If tur3()\slot3u=1105 And tur3()\slot3uu=1:
tur3()\gravi+1
EndIf 
If tur3()\slot3u=1105 And tur3()\slot3uu=2:
tur3()\gravi+2
EndIf 
If tur3()\slot3u=1105 And tur3()\slot3uu=3:
tur3()\gravi+3
EndIf 
If tur3()\slot4u=1105 And tur3()\slot4uu=1:
tur3()\gravi+1
EndIf 
If tur3()\slot4u=1105 And tur3()\slot4uu=2:
tur3()\gravi+2
EndIf 
If tur3()\slot4u=1105 And tur3()\slot4uu=3:
tur3()\gravi+3
EndIf 

If tur3()\slot1u=1106 And tur3()\slot1uu=1:
tur3()\metko+1
EndIf 
If tur3()\slot1u=1106 And tur3()\slot1uu=2:
tur3()\metko+2
EndIf 
If tur3()\slot1u=1106 And tur3()\slot1uu=3:
tur3()\metko+3
EndIf 
If tur3()\slot2u=1106 And tur3()\slot2uu=1:
tur3()\metko+1
EndIf 
If tur3()\slot2u=1106 And tur3()\slot2uu=2:
tur3()\metko+2
EndIf 
If tur3()\slot2u=1106 And tur3()\slot2uu=3:
tur3()\metko+3
EndIf 
If tur3()\slot3u=1106 And tur3()\slot3uu=1:
tur3()\metko+1
EndIf 
If tur3()\slot3u=1106 And tur3()\slot3uu=2:
tur3()\metko+2
EndIf 
If tur3()\slot3u=1106 And tur3()\slot3uu=3:
tur3()\metko+3
EndIf 
If tur3()\slot4u=1106 And tur3()\slot4uu=1:
tur3()\metko+1
EndIf 
If tur3()\slot4u=1106 And tur3()\slot4uu=2:
tur3()\metko+2
EndIf 
If tur3()\slot4u=1106 And tur3()\slot4uu=3:
tur3()\metko+3
EndIf 

Wend 
Return 


instor22:

If kto=970:
tur3()\energ2+1
tur3()\ataka+1
EndIf 
If kto=972:
tur3()\reani+1
EndIf 
If kto=973:
tur3()\reani+2
EndIf 
If kto=974:
tur3()\gravi+3
EndIf 
If kto=976:
tur3()\reani+3
EndIf 
If kto=977:
tur3()\gravi+1
EndIf
If kto=978:
tur3()\gravi+5
EndIf 
If kto=979:
tur3()\ataka+3
EndIf 
If kto=981:
tur3()\trafic5+1
EndIf 
If kto=984:
tur3()\metko+4
tur3()\ataka+2
tur3()\energ2+2
EndIf 
If kto=985:
tur3()\ataka+2
tur3()\energ2+5
EndIf 
If kto=986:
tur3()\gravi+1
tur3()\trafic5+3
EndIf 
If kto=987:
tur3()\energ2+3
EndIf 

Return 




minusa:
ResetList( tur3() ) 
While NextElement( tur3())
If tur3()\pnom=play:
If or111=970:
tur3()\energ2-1
tur3()\ataka-1
EndIf 
If or111=972:
tur3()\reani-1
EndIf 
If or111=973:
tur3()\reani-2
EndIf 
If or111=974:
tur3()\gravi-3
EndIf 
If or111=976:
tur3()\reani-3
EndIf 
If or111=977:
tur3()\gravi-1
EndIf
If or111=978:
tur3()\gravi-5
EndIf 
If or111=979:
tur3()\ataka-3
EndIf 
If or111=981:
tur3()\trafic5-1
EndIf 
If or111=984:
tur3()\metko-4
tur3()\ataka-2
tur3()\energ2-2
EndIf 
If or111=985:
tur3()\ataka-2
tur3()\energ2-5
EndIf 
If or111=986:
tur3()\gravi-1
tur3()\trafic5-3
EndIf 
If or111=987:
tur3()\energ2-3
EndIf 


EndIf 
Wend 
Return 

minusa222:
If or111=970:
tur3()\energ2-1
tur3()\ataka-1
EndIf 
If or111=972:
tur3()\reani-1
EndIf 
If or111=973:
tur3()\reani-2
EndIf 
If or111=974:
tur3()\gravi-3
EndIf 
If or111=976:
tur3()\reani-3
EndIf 
If or111=977:
tur3()\gravi-1
EndIf
If or111=978:
tur3()\gravi-5
EndIf 
If or111=979:
tur3()\ataka-3
EndIf 
If or111=981:
tur3()\trafic5-1
EndIf 
If or111=984:
tur3()\metko-4
tur3()\ataka-2
tur3()\energ2-2
EndIf 
If or111=985:
tur3()\ataka-2
tur3()\energ2-5
EndIf 
If or111=986:
tur3()\gravi-1
tur3()\trafic5-3
EndIf 
If or111=987:
tur3()\energ2-3
EndIf 

Return 

katalog:
dir$ = "tur"
   levelt=1
     
lok = 0
If ExamineDirectory(0, dir$, "*.txt")  
  While NextDirectoryEntry(0)
    
    If DirectoryEntryType(0) = #PB_DirectoryEntry_File
      
      mass(lok) = DirectoryEntryName(0)
    
      lok + 1
       
     ReDim mass(lok)
    EndIf
    
  Wend
  FinishDirectory(0)
EndIf


lok3=-1
lok2=0
a=lok
b=0
c=1

 ReDim mass2(1)
 Repeat 
kwak:
  lok2=Random(lok)
  
  b=ArraySize(mass2())
  Repeat 
  If lok2=Val(mass2(b))
  Goto kwak:  
  :EndIf 
  b-1
  Until b=0
  
 
  mass2(c)=Str(lok2) 
   
  c+1
    ReDim mass2(c)
  a-1
Until a=0



Return 


skanaa:
ResetList( tur() ) 
While NextElement( tur())
  If tur()\nom=97
    tur()\x2=tur()\x
    tur()\y2=tur()\y
  EndIf 
  Wend 
ResetList( tur3() ) 
While NextElement( tur3())
tur3()\trafic=tur3()\trafic2
Wend

 olsa:
ExamineMouse()
If MouseButton(1)=1 :Goto olsa:EndIf 

ResetList( tur() ) 
While NextElement( tur())
  If tur()\nom=97 And tur()\swo2<>333:play=tur()\swo:EndIf 

Wend 

Goto retu:

;----------------------endtur
endtur:


If endturr=0 Or diss=1:Goto retu:EndIf





ResetList( tur() ) 
While NextElement( tur())
  If tur()\nom=97 And tur()\bot=0 And tur()\swo2<>333: Goto endturi:EndIf 
Wend 

nechja=1

endturi:

wsenofire=1

ResetList( tur() ) 
While NextElement( tur())
  If tur()\swo2<>333 And tur()\nom=500 And tur3()\pnom=play:a$=tur()\name$:EndIf 
  If tur()\nom=97
    tur()\x2=tur()\x
    tur()\y2=tur()\y
    EndIf 
Wend 

If nechja=1:
  push=1
  DisplayTransparentSprite (1010 , xraz/2-(196/2), yraz/2-(96/2)-50)
 StartDrawing( ScreenOutput())
DrawingMode(#PB_2DDrawing_Transparent )
DrawingFont(FontID(0)) 
If lang=0
DrawText(xraz/2-(196/2)+61+15, yraz/2-(96/2)-50+4+30, "Ничья", RGB((255),(200),(100)) )
EndIf 
If lang=1
DrawText(xraz/2-(196/2)+61+15+8, yraz/2-(96/2)-50+4+30, "Draw", RGB((255),(200),(100)) )
EndIf 
  StopDrawing() 
 
 EndIf 
 If pobeda1=1:pobeda1=0:Goto newtur2:EndIf 
 
If nechja=0:
  DisplayTransparentSprite (1010 , xraz/2-(196/2), yraz/2-(96/2)-50)
 StartDrawing( ScreenOutput())
DrawingMode(#PB_2DDrawing_Transparent )
DrawingFont(FontID(0)) 
If lang=0
DrawText(xraz/2-(196/2)+61, yraz/2-(96/2)-50+4, "Победитель ", RGB((255),(200),(100)) )
EndIf 
If lang=1
DrawText(xraz/2-(196/2)+76, yraz/2-(96/2)-50+4, "Winner ", RGB((255),(200),(100)) )
EndIf 
DrawingMode(#PB_2DDrawing_Transparent  )

bb=TextWidth(a$)
bb/2
DrawText(xraz/2-(196/2)+100-bb, yraz/2-(96/2)-30-2, a$, RGB((255),(200),(100)) )
DrawingMode(#PB_2DDrawing_Transparent )
If lang=0
DrawText(xraz/2-(196/2)+50, yraz/2-(96/2)-50+4+60+4, "Собрать призы?", RGB((255),(255),(255)) )
EndIf 
If lang=1
DrawText(xraz/2-(196/2)+50, yraz/2-(96/2)-50+4+60+4, "Collect prizes?", RGB((255),(255),(255)) )
EndIf 
DrawingFont(FontID(1)) 
;If lang=0
DrawText(xraz/2-(196/2)+85-40, yraz/2-(96/2)-16 , YES$, RGB((255),(200),(100)) )

DrawText(xraz/2-(196/2)+85+40, yraz/2-(96/2)-16 , NO$, RGB((255),(200),(100)) )
;EndIf 
;If lang=1
;DrawText(xraz/2-(196/2)+85-40, yraz/2-(96/2)-16 , "Yes", RGB((255),(200),(100)) )
;
;DrawText(xraz/2-(196/2)+85+40, yraz/2-(96/2)-16 , "No", RGB((255),(200),(100)) )
;EndIf 
DrawingMode(#PB_2DDrawing_XOr )
If lang=0
If moun=1:DrawText(xraz/2-(196/2)+85-40, yraz/2-(96/2)-16 , "Да", RGB((255),(200),(100)) ):EndIf 

If moun=2:DrawText(xraz/2-(196/2)+85+40, yraz/2-(96/2)-16 , "Нет", RGB((255),(200),(100)) ):EndIf 
EndIf 
If lang=1
If moun=1:DrawText(xraz/2-(196/2)+85-40, yraz/2-(96/2)-16 , "Yes", RGB((255),(200),(100)) ):EndIf 

If moun=2:DrawText(xraz/2-(196/2)+85+40, yraz/2-(96/2)-16 , "No", RGB((255),(200),(100)) ):EndIf 
EndIf 
  StopDrawing() 
  DisplayTransparentSprite (8 , xraz/2-(196/2)+85, yraz/2-(96/2)-16)
EndIf 

  ExamineMouse()
xm = MouseX()                         
ym = MouseY() 
moun=0
If xm>xraz/2-(196/2)+85-40 And xm<xraz/2-(196/2)+85-40+26 And ym>yraz/2-(96/2)-16 And ym<yraz/2-(96/2)-16+24:moun=1:EndIf 
  If xm>xraz/2-(196/2)+85+40 And xm<xraz/2-(196/2)+85+40+36 And ym>yraz/2-(96/2)-16 And ym<yraz/2-(96/2)-16+24:moun=2:EndIf 
  If MouseButton(1)=1 And moun=2:Goto newtur2:EndIf 
  If MouseButton(1)=1 And nechja=1:Goto newtur2:EndIf 
  If MouseButton(1)=1 And moun=1:nextlp=0:endturr=0:pobeda1=1:Goto skanaa:EndIf 
  

  ResetList( tur() ) 
While NextElement( tur())
If tur()\swo2<>333 And tur()\nom=500 And tur()\bot=1 And wins=0:wins=1:EndIf 
Wend 
If wins>0:wins+1:EndIf 
If wins=100:Goto newtur2:EndIf 
Goto retu:

newtur2:

 nextlp=0:endturr=0
  wins=0
  xenem=0
xenem2=0
xenem3=0
xenem4=0
chet999=0
smertxw=0
addb=0
pryg=0
play=1
nechja=0
push=0
players=players2
sh=0
plnex=0
nosbor=0
wsenofire=0
Dim alfa.w(32)
  OpenFile(0,"work/work.work")
ResetList( tur3() ) 
While NextElement( tur3())
  
      WriteLong(0,tur3()\pnom)
      WriteLong(0,tur3()\opyt)
      WriteLong(0,tur3()\fox)
      WriteLong(0,tur3()\money)
      
      ;WriteLong(0,tur3()\trafic)
      WriteLong(0,tur3()\trafic2)
      WriteLong(0,tur3()\trafic3)
      WriteLong(0,tur3()\trafic4)
      WriteLong(0,tur3()\trafic5)
      
      WriteStringN(0,tur3()\name$) 
     
     ; WriteLong(0,tur3()\energ)
      WriteLong(0,tur3()\energ1)
      WriteLong(0,tur3()\energ2)
      
      WriteLong(0,tur3()\ataka.w)
      WriteLong(0,tur3()\reani.w)
      WriteLong(0,tur3()\gravi.w)
      
      WriteLong(0,tur3()\color.l)
      WriteLong(0,tur3()\metko.w)
      
      WriteLong(0,tur3()\slot1.w)
      WriteLong(0,tur3()\slot2.w)
      WriteLong(0,tur3()\slot3.w)
      WriteLong(0,tur3()\slot4.w)
      WriteLong(0,tur3()\slot5.w)
      WriteLong(0,tur3()\slot6.w)
      WriteLong(0,tur3()\slot7.w)
      WriteLong(0,tur3()\slot8.w)
      
      WriteLong(0,tur3()\slot1a.w)
      WriteLong(0,tur3()\slot2a.w)
      WriteLong(0,tur3()\slot3a.w)
      WriteLong(0,tur3()\slot4a.w)
       
      WriteLong(0,tur3()\slot1p.w)
    
         WriteLong(0,tur3()\slot2p.w)
         WriteLong(0,tur3()\slot3p.w)
         WriteLong(0,tur3()\slot4p.w)
         WriteLong(0,tur3()\slot5p.w)
         WriteLong(0,tur3()\slot6p.w)
         WriteLong(0,tur3()\slot7p.w)
         WriteLong(0,tur3()\slot8p.w)
         WriteLong(0,tur3()\slot1u.w)
         WriteLong(0,tur3()\slot2u.w)
         WriteLong(0,tur3()\slot3u.w)
         WriteLong(0,tur3()\slot4u.w)
         WriteLong(0,tur3()\slot1uu.w)
         WriteLong(0,tur3()\slot2uu.w)
         WriteLong(0,tur3()\slot3uu.w)
         WriteLong(0,tur3()\slot4uu.w)
         WriteLong(0,tur3()\kakoj.w)
         WriteLong(0,tur3()\victory.w)
          WriteLong(0,tur3()\bot.w)
  
Wend
CloseFile(0) 

ResetList( tur() ) 
While NextElement( tur())
DeleteElement( tur() )
Wend

ResetList( tur3() ) 
While NextElement( tur3())
DeleteElement( tur3() )
Wend


obraz+1

  Goto cuda

  
  
  sozper:
  
If obraz>0:
  OpenFile(0,"work/work.work")
  
  a=players2
Repeat 


  AddElement( tur3() )
  
  tur3()\pnom=ReadLong(0)
  tur3()\opyt=ReadLong(0)
       tur3()\fox=ReadLong(0)
  tur3()\money=ReadLong(0)

  tur3()\trafic=64
    tur3()\trafic2=ReadLong(0)
   tur3()\trafic2=64
     tur3()\trafic3=ReadLong(0)
     tur3()\trafic4=ReadLong(0)
     tur3()\trafic5=ReadLong(0)
         tur3()\trafic5=0
         
          tur3()\name$=ReadString(0)
   
          tur3()\energ=64
          tur3()\energ1=ReadLong(0)
         tur3()\energ2=ReadLong(0)
          tur3()\energ2=0
           tur3()\ataka=ReadLong(0)
      tur3()\reani=ReadLong(0)
      tur3()\gravi=ReadLong(0)
          
      tur3()\ataka=0
      tur3()\reani=0
      tur3()\gravi=0
          
      tur3()\color=ReadLong(0)
      tur3()\metko=ReadLong(0)
          tur3()\metko=0
          
    tur3()\slot1=ReadLong(0)
    tur3()\slot2=ReadLong(0)
    tur3()\slot3=ReadLong(0)
    tur3()\slot4=ReadLong(0)
    tur3()\slot5=ReadLong(0)
    tur3()\slot6=ReadLong(0)
    tur3()\slot7=ReadLong(0)
    tur3()\slot8=ReadLong(0)
    
    tur3()\slot1a=ReadLong(0)
    tur3()\slot2a=ReadLong(0)
    tur3()\slot3a=ReadLong(0)
    tur3()\slot4a=ReadLong(0)

       tur3()\slot1p=ReadLong(0)
       tur3()\slot2p=ReadLong(0)
       tur3()\slot3p=ReadLong(0)
       tur3()\slot4p=ReadLong(0)
       tur3()\slot5p=ReadLong(0)
       tur3()\slot6p=ReadLong(0)
       tur3()\slot7p=ReadLong(0)
       tur3()\slot8p=ReadLong(0)
 
       tur3()\slot1u=ReadLong(0)
       tur3()\slot2u=ReadLong(0)
       tur3()\slot3u=ReadLong(0)
       tur3()\slot4u=ReadLong(0)
       tur3()\slot1uu=ReadLong(0)
       tur3()\slot2uu=ReadLong(0)
       tur3()\slot3uu=ReadLong(0)
       tur3()\slot4uu=ReadLong(0)
       tur3()\kakoj=ReadLong(0)
       tur3()\victory=ReadLong(0)
         tur3()\bot=ReadLong(0)
a-1
  Until a=0


       CloseFile(0)
              weapon=900
       weapon=tur3()\slot1:ax=tur3()\slot1p
       level=0
       level2=0
   ffff=0
       tur3()\kakoj=level2

EndIf 
  Return 
  
  
  sasa:

  ClearList(namee()) 
  If lang=0
 AddElement( namee() )
If lang=0: namee()\name$="Игрок 1":EndIf 
 namee()\yes=2016
  namee()\huisit=2018
  namee()\color=RGB(255,255,255) 
 AddElement( namee() )
 namee()\name$="Игрок 2"  
 namee()\yes=2016
  namee()\huisit=2018
  namee()\color=RGB(255,255,255) 
 AddElement( namee() )
  namee()\name$="Игрок 3"   
  namee()\yes=2016
   namee()\huisit=2018
  namee()\color=RGB(255,255,255) 
   AddElement( namee() )
   namee()\name$="Игрок 4"  
   namee()\yes=2016
    namee()\huisit=2018
  namee()\color=RGB(255,255,255) 
    AddElement( namee() )
    namee()\name$="Игрок 5" 
    namee()\yes=2016
     namee()\huisit=2018
    namee()\color=RGB(255,255,255) 
     AddElement( namee() )
     namee()\name$="Игрок 6"   
     namee()\yes=2016
      namee()\huisit=2018
   namee()\color=RGB(255,255,255) 
      AddElement( namee() )
      namee()\name$="Игрок 7" 
      namee()\yes=2016
       namee()\huisit=2018
   namee()\color=RGB(255,255,255) 
       AddElement( namee() )
       namee()\name$="Игрок 8"   
       namee()\yes=2016
        namee()\huisit=2018
        namee()\color=RGB(255,255,255) 
      EndIf 
      
        If lang=1:
 AddElement( namee() )
 namee()\name$="Player 1"
 namee()\yes=2016
  namee()\huisit=2018
  namee()\color=RGB(255,255,255) 
 AddElement( namee() )
 namee()\name$="Player 2"  
 namee()\yes=2016
  namee()\huisit=2018
  namee()\color=RGB(255,255,255) 
 AddElement( namee() )
  namee()\name$="Player 3"   
  namee()\yes=2016
   namee()\huisit=2018
  namee()\color=RGB(255,255,255) 
   AddElement( namee() )
   namee()\name$="Player 4"  
   namee()\yes=2016
    namee()\huisit=2018
  namee()\color=RGB(255,255,255) 
    AddElement( namee() )
    namee()\name$="Player 5" 
    namee()\yes=2016
     namee()\huisit=2018
    namee()\color=RGB(255,255,255) 
     AddElement( namee() )
     namee()\name$="Player 6"   
     namee()\yes=2016
      namee()\huisit=2018
   namee()\color=RGB(255,255,255) 
      AddElement( namee() )
      namee()\name$="Player 7" 
      namee()\yes=2016
       namee()\huisit=2018
   namee()\color=RGB(255,255,255) 
       AddElement( namee() )
       namee()\name$="Player 8"   
       namee()\yes=2016
        namee()\huisit=2018
        namee()\color=RGB(255,255,255) 
        EndIf 
        Return 
        
        
        zoof:


  
ClearScreen (RGB(0, 0, 0))

PlaySound (551, #PB_Sound_Loop ) 

Start3D()
Sprite3DBlendingMode(2, 6)
ZoomSprite3D(299, xraz, yraz)

DisplaySprite3D(299 , 0, 0,255)

DisplaySprite3D(2011 , xraz/2-sobd/2-290, 0,255)

Stop3D()
  StartDrawing( ScreenOutput())
DrawingFont(FontID(3)) 
DrawingMode(#PB_2DDrawing_Transparent )

If ReadFile(0, "mods/"+MORE$+"/mod.dat")

  MOV$ =  Trim(ReadString(0))

  MODV = Val(MOV$)

EndIf

If mods=1
DrawText(xraz/32-b/2, 10 , MORE$+" v"+Str(MODV), RGB((255),(255),(255)) )
EndIf


If lang=0




b=TextWidth(Str(xraz)+"x"+Str(yraz))
DrawText(xraz/2-b/2, 200 ,  Str(fov), RGB((255),(0),(255)) )
b=TextWidth("Разрешение")
DrawText(xraz/2-b/2, 180 , "Размер", RGB((255),(255),(255)) )
b=TextWidth("Esc - выход из игры")
DrawText(xraz/2-b/2, 240 , "Esc - выход из игры", RGB((255),(255),(255)) )
b=TextWidth("M - вход в магазин")
DrawText(xraz/2-b/2, 260 , "M - вход в магазин", RGB((255),(255),(255)) )
b=TextWidth("Space - прыжок")
DrawText(xraz/2-b/2, 280 , "Space - прыжок", RGB((255),(255),(255)) )
b=TextWidth("Enter - передать ход")
DrawText(xraz/2-b/2, 300 , "Enter - передать ход", RGB((255),(255),(255)) )
b=TextWidth("Стрелки - осмотр карты")
DrawText(xraz/2-b/2, 320 , "Стрелки - осмотр карты", RGB((255),(255),(255)) )
b=TextWidth("Правая клавиша мыши - стрельба, или выкинуть предмет")
DrawText(xraz/2-b/2, 340 , "Правая клавиша мыши - стрельба, или выкинуть предмет", RGB((255),(255),(255)) )
b=TextWidth("Левая клавиша мыши - передвижения")
DrawText(xraz/2-b/2, 360 , "Левая клавиша мыши - передвижения", RGB((255),(255),(255)) )
b=TextWidth("Caps Shift - Центровка")
DrawText(xraz/2-b/2, 380 , "Caps Shift - Центровка", RGB((255),(255),(255)) )

b=TextWidth("Marie Slip 2012")
DrawText(xraz/2-b/2, 420 , "Marie Slip 2013", RGB((255),(255),(255)) )

EndIf 










If lang=1



b=TextWidth(Str(xraz)+"x"+Str(yraz))
DrawText(xraz/2-b/2, 200 ,  Str(fov), RGB((255),(0),(255)) )
b=TextWidth("Resolution")
DrawText(xraz/2-b/2, 180 , "Field of View", RGB((255),(255),(255)) )
b=TextWidth("Esc - Exit")
DrawText(xraz/2-b/2, 240 , "Esc - Exit", RGB((255),(255),(255)) )
b=TextWidth("M - Shop")
DrawText(xraz/2-b/2, 260 , "M - Shop", RGB((255),(255),(255)) )
b=TextWidth("Space - Jump")
DrawText(xraz/2-b/2, 280 , "Space - Jump", RGB((255),(255),(255)) )
b=TextWidth("Enter - End turn")
DrawText(xraz/2-b/2, 300 , "Enter - End turn", RGB((255),(255),(255)) )
b=TextWidth("Arrows - Survey maps")
DrawText(xraz/2-b/2, 320 , "Arrows - Survey maps", RGB((255),(255),(255)) )
b=TextWidth("Right mouse button - shoot or throw the object")
DrawText(xraz/2-b/2, 340 , "Right mouse button - shoot or throw the object", RGB((255),(255),(255)) )
b=TextWidth ("Left mouse button - Move")
DrawText(xraz/2-b/2, 360 , "Left mouse button - Move", RGB((255),(255),(255)) )

b=TextWidth("Caps Shift - Alignment")
DrawText(xraz/2-b/2, 380 , "Caps Shift - Alignment", RGB((255),(255),(255)) )

b=TextWidth("Marie Slip 2012")
DrawText(xraz/2-b/2, 420 , "Marie Slip 2013", RGB((255),(255),(255)) )

EndIf 



  StopDrawing() 
  FlipBuffers()
   WindowEvent()
 DisableGadget(1, 1)
  Return 
  
 
; IDE Options = PureBasic 4.50 (Windows - x86)
; CursorPosition = 2621
; FirstLine = 2608
; Folding = -
; EnableThread
; EnableXP
; UseIcon = favicon (1).ico
; Executable = G:\Debug.exe
; CompileSourceDirectory
; Compiler = PureBasic 4.50 (Windows - x86)
; IncludeVersionInfo
; VersionField0 = 1.0.0-alpha
; VersionField1 = 1.0.0-alpha
; VersionField2 = Unknown Inc
; VersionField3 = Otters & Fenech
; VersionField4 = 1.0.0-alpha
; VersionField5 = 1.0.0-alpha
; VersionField6 = Debug Version
; VersionField9 = Marie Slip
; VersionField10 = Marie Slip
; VersionField16 = VFT_APP