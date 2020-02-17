$PBExportHeader$w_sheet.srw
forward
global type w_sheet from window
end type
end forward

global type w_sheet from window
integer width = 3931
integer height = 1552
windowtype windowtype = popup!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
end type
global w_sheet w_sheet

type variables
eon_appeon_resize ieon_resize
end variables

forward prototypes
public function window of_parent_window ()
public subroutine wf_setflag ()
end prototypes

public function window of_parent_window ();return this
end function

public subroutine wf_setflag ();//处理resize逻辑
end subroutine

event close;parentwindow().post dynamic event ue_closesheet(this.classname())

if isvalid(w_mdi) then
	w_mdi.post function wf_refresh_ribbon()
end if

//parentwindow().post function Arrangesheets(Layer!) //comment by liulihua
end event

on w_sheet.create
end on

on w_sheet.destroy
end on

event open;ieon_resize = create eon_appeon_resize
this.x = 0
this.y = 0
parentwindow().dynamic  post event ue_opensheet(this.classname())

ieon_resize.of_init(this,true)

wf_setflag()

parentwindow().post function Arrangesheets(Layer!) //uncomment by liulihua:Guarantee to open the window display not use normal size

//设置recentlist
parentwindow().dynamic  post function wf_addrecentitem(this.classname())

end event

event resize;//ieon_resize.of_resize(this,newwidth,newheight,true)
end event

event activate;//add by liulihua set the ribbonbar enabled object--------//
If	gs_WindowClassname	<>	this.Classname()	Then
	parentwindow().dynamic event ue_refresh_ribbonbar(this.Classname()) 
	gs_WindowClassname = this.Classname()
	
End	If
//add end-----------------------------------------------------//
end event

