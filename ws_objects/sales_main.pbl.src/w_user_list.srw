$PBExportHeader$w_user_list.srw
$PBExportComments$All users
forward
global type w_user_list from window
end type
type cb_6 from commandbutton within w_user_list
end type
type cb_4 from commandbutton within w_user_list
end type
type cb_2 from commandbutton within w_user_list
end type
type cb_1 from commandbutton within w_user_list
end type
type dw_1 from datawindow within w_user_list
end type
end forward

global type w_user_list from window
integer width = 2702
integer height = 1200
boolean titlebar = true
string title = "Security Manager - User Accounts"
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
global w_user_list w_user_list

on w_user_list.create
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

on w_user_list.destroy
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

dw_1.SetTransObject(SQLCA)
dw_1.Retrieve()

end event

type cb_6 from commandbutton within w_user_list
integer x = 2194
integer y = 292
integer width = 448
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
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

String  ls_UserNo
Integer li_Row

li_Row = dw_1.GetRow()
If li_Row < 1 Then Return
ls_UserNo = dw_1.GetItemString(li_Row,'FUserNo')
If IsNull(ls_UserNo) Or ls_UserNo = '' Then Return

OpenWithParm(w_user_authorize,ls_UserNo)

If Message.StringParm = 'changed' Then
	dw_1.Retrieve()
End If

end event

type cb_4 from commandbutton within w_user_list
integer x = 2203
integer y = 964
integer width = 448
integer height = 120
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
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

CLOSE(Parent)

end event

type cb_2 from commandbutton within w_user_list
integer x = 2194
integer y = 152
integer width = 448
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
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

String  ls_UserNo
Integer li_Row

li_Row = dw_1.GetRow()
If li_Row < 1 Then Return
ls_UserNo = dw_1.GetItemString(li_Row,'FUserNo')

If MessageBox("Delete",'Are you sure you want to delete the current user '+ls_UserNo+'?',question!,yesno!) <> 1 Then Return

dw_1.DeleteRow(0)
If dw_1.UPDATE() > 0 Then
	DELETE From t_usergroup Where fuserno  = :ls_UserNo;	
	COMMIT;
Else
	ROLLBACK;
	MessageBox("Warning","Failed to save the changes.",exclamation!)
End If




end event

type cb_1 from commandbutton within w_user_list
integer x = 2194
integer y = 12
integer width = 448
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
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

openwithparm(w_user_authorize,'-1')
IF message.stringparm = 'changed' THEN
	dw_1.retrieve()
END IF
end event

type dw_1 from datawindow within w_user_list
integer x = 27
integer y = 20
integer width = 2139
integer height = 1052
integer taborder = 10
string title = "none"
string dataobject = "dw_all_users"
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

