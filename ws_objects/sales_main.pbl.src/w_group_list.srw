$PBExportHeader$w_group_list.srw
$PBExportComments$All Groups
forward
global type w_group_list from window
end type
type cb_6 from commandbutton within w_group_list
end type
type cb_4 from commandbutton within w_group_list
end type
type cb_2 from commandbutton within w_group_list
end type
type cb_1 from commandbutton within w_group_list
end type
type dw_1 from datawindow within w_group_list
end type
end forward

global type w_group_list from window
integer width = 2555
integer height = 1140
boolean titlebar = true
string title = "Security Manager - Security Groups"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
cb_6 cb_6
cb_4 cb_4
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_group_list w_group_list

on w_group_list.create
this.cb_6=create cb_6
this.cb_4=create cb_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_6,&
this.cb_4,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_group_list.destroy
destroy(this.cb_6)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
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

w_group_list.setposition(topmost!)
dw_1.SetTransObject(SQLCA)
dw_1.Retrieve()

end event

type cb_6 from commandbutton within w_group_list
integer x = 2062
integer y = 296
integer width = 448
integer height = 120
integer taborder = 40
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Modify"
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

string  ls_GroupNo
integer li_Row

li_Row = dw_1.getrow()
IF li_Row < 1 THEN return
ls_GroupNo = dw_1.getitemstring(li_Row,'FGroupNo')

Openwithparm(w_group_authorize,ls_GroupNo)
IF message.stringparm = 'changed' THEN
	dw_1.retrieve()
END IF
end event

type cb_4 from commandbutton within w_group_list
integer x = 2062
integer y = 900
integer width = 448
integer height = 120
integer taborder = 50
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
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

close(parent)
end event

type cb_2 from commandbutton within w_group_list
integer x = 2062
integer y = 156
integer width = 448
integer height = 120
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Remove"
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

String  ls_GroupNo
Integer li_Row,li_Count

li_Row = dw_1.GetRow()
If li_Row < 1 Then Return
ls_GroupNo = dw_1.GetItemString(li_Row,'FGroupNo')

If MessageBox("Delete",'Each group is represented by a unique identifier which is independent of the group name.~r~nOnce a group is deleted, even creating an identically name group in the future will not ~r~nrestore access to resources which currently include the group their access rights.~r~n~r~nAre you sure you want to delete the current group '+ls_GroupNo+'?',question!,yesno!) <> 1 Then Return


dw_1.DeleteRow(0)
If dw_1.UPDATE() > 0 Then
	DELETE From t_usergroup Where fgroupno = :ls_GroupNo;
	DELETE From t_menu_manager Where fgroupno = :ls_GroupNo;
	COMMIT;
Else
	ROLLBACK;
	MessageBox("Remove","Failed to save changes to database.",exclamation!)
End If




end event

type cb_1 from commandbutton within w_group_list
integer x = 2062
integer y = 16
integer width = 448
integer height = 120
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add"
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

Openwithparm(w_group_authorize,'-1')
IF message.stringparm = 'changed' THEN
	dw_1.retrieve()
END IF
end event

type dw_1 from datawindow within w_group_list
integer x = 27
integer y = 20
integer width = 2002
integer height = 1004
integer taborder = 10
string title = "none"
string dataobject = "dw_all_groups"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;//====================================================================
// Event: rowfocuschanged()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	long	currentrow		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnrowchange]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

IF currentrow < 1 or isnull(currentrow) THEN return

this.selectrow(0,FALSE)
this.selectrow(currentrow,TRUE)

end event

event retrieveend;//====================================================================
// Event: retrieveend()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	long	rowcount		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnretrieveend]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

this.selectrow(0,FALSE)
this.selectrow(this.getrow(),TRUE)

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

cb_6.event clicked()
end event

