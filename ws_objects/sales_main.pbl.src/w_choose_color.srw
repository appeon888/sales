$PBExportHeader$w_choose_color.srw
$PBExportComments$Choose Color from color datawindow
forward
global type w_choose_color from window
end type
type cb_2 from commandbutton within w_choose_color
end type
type cb_1 from commandbutton within w_choose_color
end type
type dw_1 from datawindow within w_choose_color
end type
type gb_1 from groupbox within w_choose_color
end type
end forward

global type w_choose_color from window
integer width = 1897
integer height = 1380
boolean titlebar = true
string title = "Choose Color"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
event type integer ue_colorchanged ( long al_newcolor )
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_choose_color w_choose_color

type variables
//====================================================================
// Declare: Instance Variables()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: (none)
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

private:
string  is_OrgColor
integer   ii_Red,ii_Green,ii_Blue
long  il_SelectedColor = -1
end variables

forward prototypes
public function integer of_parsecolor (long al_srccolor)
end prototypes

event type integer ue_colorchanged(long al_newcolor);//====================================================================
// Event: ue_colorchanged()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	long	al_newcolor		
//--------------------------------------------------------------------
// Returns: integer
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

il_SelectedColor = al_NewColor

return 1
end event

public function integer of_parsecolor (long al_srccolor);//====================================================================
// Function: of_parsecolor()
//--------------------------------------------------------------------
// Description: Parse a long color value to Red,Green,Blue
//--------------------------------------------------------------------
// Arguments:
// al_srccolor:		Source color value	
//--------------------------------------------------------------------
// Returns:			integer
//						1 -- Success
//                -1 -- Failed. The source color is null or too big 
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================


IF al_SrcColor > 16777215  OR al_SrcColor < 0 THEN
	return -1
END IF
ii_blue = truncate(al_SrcColor / 65536,0)
ii_green = truncate((al_SrcColor - ii_blue*65536)/256,0)
ii_red = al_SrcColor - ii_blue*65536 - ii_green * 256

return 1
end function

on w_choose_color.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1,&
this.gb_1}
end on

on w_choose_color.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type cb_2 from commandbutton within w_choose_color
integer x = 955
integer y = 1124
integer width = 434
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean cancel = true
end type

event clicked;//====================================================================
// Event: clicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_bnclicked]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

closewithreturn(parent,'cancel')

end event

type cb_1 from commandbutton within w_choose_color
integer x = 466
integer y = 1124
integer width = 434
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;//====================================================================
// Event: clicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_bnclicked]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

IF il_SelectedColor < 0 THEN
	messagebox("Alert","Please choose one color.")
	return
END IF

closewithreturn(parent,string(il_SelectedColor))

end event

type dw_1 from datawindow within w_choose_color
integer x = 50
integer y = 60
integer width = 1746
integer height = 1004
integer taborder = 10
string title = "none"
string dataobject = "d_colors_panel"
boolean border = false
boolean livescroll = true
end type

event clicked;//====================================================================
// Event: clicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	integer 	xpos		
//		value	integer 	ypos		
//		value	long    	row 		
//		value	dwobject	dwo 		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnlbuttonclk]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

string  ls_Name,ls_Tag
long  ll_Color
int  li_Ret

ls_Name = dwo.name

IF this.describe(ls_Name+'.type') <>'text' THEN return
ls_Tag = this.describe(ls_Name+".tag")
IF ls_Tag = '' OR ls_Tag = '?' or ls_Tag = '!'THEN return

IF ls_Name = 't_transparent' THEN
	ll_Color = 553648127//Transparent
ELSE
	ll_Color = long(this.describe(ls_Name+".background.color"))
END IF


IF dwo.name<>is_OrgColor THEN
	this.modify(is_OrgColor+".border=2")
	is_OrgColor = ls_Name
	this.modify(ls_Name+".border=5")
	this.modify("t_colorname.text = '"+ls_Tag+"'")
	this.modify("t_50.background.color = "+string(ll_Color))
	li_Ret = of_parsecolor(ll_Color)
	IF li_Ret < 0 THEN
		this.setitem(1,'red','')
		this.setitem(1,'Green','')
		this.setitem(1,'Blue','')
	ELSE
		this.setitem(1,'red',string(ii_Red))
		this.setitem(1,'Green',string(ii_Green))
		this.setitem(1,'Blue',string(ii_Blue))
	END IF
END IF


parent.event ue_ColorChanged(ll_Color)
end event

event doubleclicked;//====================================================================
// Event: doubleclicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	integer 	xpos		
//		value	integer 	ypos		
//		value	long    	row 		
//		value	dwobject	dwo 		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnlbuttondblclk]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

string  ls_Name,ls_Tag
long  ll_Color
int  li_Ret

ls_Name = dwo.name

IF this.describe(ls_Name+'.type') <>'text' THEN return
ls_Tag = this.describe(ls_Name+".tag")
IF ls_Tag = '' OR ls_Tag = '?' or ls_Tag = '!'THEN return

cb_1.post event clicked()

end event

type gb_1 from groupbox within w_choose_color
integer x = 23
integer width = 1810
integer height = 1080
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32039904
end type

