$PBExportHeader$w_mdi_ribbonbar.srw
forward
global type w_mdi_ribbonbar from window
end type
type mdi_1 from mdiclient within w_mdi_ribbonbar
end type
type rbb_1 from ribbonbar within w_mdi_ribbonbar
end type
end forward

global type w_mdi_ribbonbar from window
integer width = 3543
integer height = 1608
boolean titlebar = true
string title = "Sales Application Demo"
string menuname = "m_customer_order"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
windowtype windowtype = mdi!
windowstate windowstate = maximized!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
event ue_closesheet ( string as_winname )
event ue_opensheet ( string as_winname )
mdi_1 mdi_1
rbb_1 rbb_1
end type
global w_mdi_ribbonbar w_mdi_ribbonbar

type variables
string  is_opened_sheet[]

w_navigator  iw_navigator

end variables

forward prototypes
public subroutine wf_init_ribbonbar ()
end prototypes

event ue_closesheet(string as_winname);long i=0,ll_valid_count=0

window  lw_sheet


lw_sheet = this.getfirstsheet()

do while isvalid(lw_sheet)
	if lw_sheet.classname()<>'w_navigator' then
		ll_valid_count ++
	end if
	lw_sheet = this.getnextsheet(lw_sheet)
loop 

if ll_valid_count < 1 and gb_auto_navigator then
	if isvalid(w_navigator) then
		w_navigator.show()
	else
		opensheet(w_navigator,this,0,original!)
	end if
end if
end event

event ue_opensheet(string as_winname);boolean lb_opened=false
window  lw_sheet

if isvalid(w_navigator) and gb_auto_navigator then
	close(w_navigator)
end if
end event

public subroutine wf_init_ribbonbar ();//根据菜单构建RibbonBar

end subroutine

on w_mdi_ribbonbar.create
if this.MenuName = "m_customer_order" then this.MenuID = create m_customer_order
this.mdi_1=create mdi_1
this.rbb_1=create rbb_1
this.Control[]={this.mdi_1,&
this.rbb_1}
end on

on w_mdi_ribbonbar.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.rbb_1)
end on

event open;//====================================================================
// Event: open()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_open]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

this.title = this.title + ' (User ID: '+gs_User_No+")"


nvo_security  lnv_Security

lnv_Security.of_setmenuright(this.menuid)

opensheet(w_navigator,this, 0, Original!)

end event

event resize;if isvalid(w_navigator) then
	w_navigator.x = (this.workspacewidth() - w_navigator.width)/2
	int  li_y=0
	
	if this.workspaceheight() > w_navigator.height then
			
		li_y = (this.workspaceheight() - w_navigator.height)/2 - 100
		
		if li_y < 100 then
			li_y=100
		end if
	end if
	w_navigator.y = li_y
	
end if

//resize ribbonbar
rbb_1.width = newwidth
mdi_1.move(0,rbb_1.height)
mdi_1.resize(newwidth,newheight - rbb_1.height)
end event

type mdi_1 from mdiclient within w_mdi_ribbonbar
long BackColor=268435456
end type

type rbb_1 from ribbonbar within w_mdi_ribbonbar
integer width = 3433
integer height = 492
long backcolor = 15132390
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

