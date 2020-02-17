$PBExportHeader$w_user_authorize.srw
$PBExportComments$User authorize
forward
global type w_user_authorize from window
end type
type p_3 from picture within w_user_authorize
end type
type p_2 from picture within w_user_authorize
end type
type p_1 from picture within w_user_authorize
end type
type cb_close from commandbutton within w_user_authorize
end type
type cb_1 from commandbutton within w_user_authorize
end type
type dw_3 from datawindow within w_user_authorize
end type
type cb_2 from commandbutton within w_user_authorize
end type
type cb_3 from commandbutton within w_user_authorize
end type
type cb_4 from commandbutton within w_user_authorize
end type
type cb_5 from commandbutton within w_user_authorize
end type
type st_1 from statictext within w_user_authorize
end type
type st_2 from statictext within w_user_authorize
end type
type dw_1 from datawindow within w_user_authorize
end type
type dw_2 from datawindow within w_user_authorize
end type
end forward

global type w_user_authorize from window
integer width = 2939
integer height = 2072
boolean titlebar = true
string title = "User Maintenance"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
p_3 p_3
p_2 p_2
p_1 p_1
cb_close cb_close
cb_1 cb_1
dw_3 dw_3
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
st_1 st_1
st_2 st_2
dw_1 dw_1
dw_2 dw_2
end type
global w_user_authorize w_user_authorize

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

string  is_UserNo
string is_Changed=''
end variables

on w_user_authorize.create
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.cb_close=create cb_close
this.cb_1=create cb_1
this.dw_3=create dw_3
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.st_1=create st_1
this.st_2=create st_2
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.p_3,&
this.p_2,&
this.p_1,&
this.cb_close,&
this.cb_1,&
this.dw_3,&
this.cb_2,&
this.cb_3,&
this.cb_4,&
this.cb_5,&
this.st_1,&
this.st_2,&
this.dw_1,&
this.dw_2}
end on

on w_user_authorize.destroy
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.dw_2)
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

is_UserNo  = message.stringparm

//dw_1.modify("datawindow.readonly=yes")
dw_2.modify("datawindow.readonly=yes")
dw_3.modify("datawindow.readonly=yes")
dw_1.settransobject(SQLCA)
dw_2.settransobject(SQLCA)
dw_3.settransobject(SQLCA)

dw_2.retrieve(is_UserNo)
dw_3.retrieve(is_UserNo)

IF is_UserNo = '-1' THEN
	dw_1.insertrow(0)
	dw_1.setitem(1,"FPassword",'')
	dw_1.setitem(1,"FConfirm",'')
ELSE
	dw_1.retrieve(is_UserNo)

	dw_1.object.fuserno.protect=1
	dw_1.object.fuserno.background.color =  32039904//Button Face
	IF lower(dw_1.getitemstring(1,'fuserno')) <> lower(gs_user_no) THEN
		dw_1.object.fpassword.protect=1
		dw_1.object.fconfirm.protect=TRUE
		dw_1.object.fpassword.background.color=   32039904//Button Face
		dw_1.object.fconfirm.background.color=   32039904//Button Face
	END IF
END IF

end event

type p_3 from picture within w_user_authorize
integer x = 2272
integer width = 425
integer height = 120
boolean originalsize = true
string picturename = ".\picture\titlebar_m.jpg"
boolean focusrectangle = false
end type

type p_2 from picture within w_user_authorize
integer x = 2642
integer width = 192
integer height = 120
boolean originalsize = true
string picturename = ".\picture\titlebar_r.jpg"
boolean focusrectangle = false
end type

type p_1 from picture within w_user_authorize
integer x = 37
integer width = 2514
integer height = 120
boolean originalsize = true
string picturename = ".\picture\user-Information.jpg"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_user_authorize
integer x = 2405
integer y = 1844
integer width = 448
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
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

closewithreturn(parent,is_Changed)
end event

type cb_1 from commandbutton within w_user_authorize
integer x = 1925
integer y = 1844
integer width = 448
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Save"
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

String  ls_Err,ls_Temp,ls_Confirm,ls_UserNo
Int  li
dwitemstatus  ldws

If dw_1.GetRow() < 1 Then Return -1
If dw_1.AcceptText() < 0 Then Return -1

ls_UserNo = Trim(dw_1.GetItemString(1,'fuserno'))
If ls_UserNo = '' Or IsNull(ls_UserNo) Then
	dw_1.SetFocus()
	dw_1.SetColumn('fuserno')
	MessageBox("Alert",'Please enter User ID.')
	Return -1
End If
If Len(ls_UserNo) < 5 Then
	dw_1.SetFocus()
	dw_1.SetColumn('fuserno')
	MessageBox("Alert",'User ID must be at least 5 characters.')
	Return -1
End If

ls_Temp = Trim(dw_1.GetItemString(1,'flastname'))
If ls_Temp = '' Or IsNull(ls_Temp) Then
	dw_1.SetFocus()
	dw_1.SetColumn('flastname')
	MessageBox("Alert",'Please enter Last Name.')
	Return -1
End If
ls_Temp = Trim(dw_1.GetItemString(1,'ffirstname'))
If ls_Temp = '' Or IsNull(ls_Temp) Then
	dw_1.SetFocus()
	dw_1.SetColumn('ffirstname')
	MessageBox("Alert",'Please enter First Name.')
	Return -1
End If
ls_Temp = Trim(dw_1.GetItemString(1,'fpassword'))
If ls_Temp = '' Or IsNull(ls_Temp) Then
	dw_1.SetFocus()
	dw_1.SetColumn('fpassword')
	MessageBox("Alert",'Please enter Password ID.')
	Return -1
End If
If IsNull(ls_Temp) Then ls_Temp = ''
ls_Confirm = dw_1.GetItemString(1,'fconfirm')
If IsNull(ls_Confirm) Then ls_Confirm = ''

If ls_Temp <> ls_Confirm Then
	dw_1.SetFocus()
	dw_1.SetColumn('fconfirm')
	MessageBox("Alert",'The passwords you entered do not match. Please enter the password again.')
	Return -1
End If
If dw_1.GetItemStatus(1,'fpassword',primary!) = datamodified! Then
	dw_1.SetItem(1,'fpassword',gf_simple_encode(dw_1.Object.fpassword[1],'1'))
	dw_1.SetItem(1,'fconfirm',dw_1.Object.fpassword[1])
End If

For li = 1 To dw_3.RowCount()
	ldws = dw_3.GetItemStatus(li,0,primary!)
	If ldws = newmodified! Then
		dw_3.SetItem(li,'FUserNo',ls_UserNo)
	End If
Next

If dw_1.UPDATE() > 0 And dw_3.UPDATE() > 0 Then
	COMMIT;
	is_Changed = 'changed'
	This.Enabled = False
	cb_close.Post Event Clicked()
Else
	ROLLBACK;
	MessageBox(Parent.Title,"Failed to save changes to database.",exclamation!)
End If

end event

type dw_3 from datawindow within w_user_authorize
integer x = 1618
integer y = 892
integer width = 1257
integer height = 916
integer taborder = 10
string title = "none"
string dataobject = "dw_assigned_group"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

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

IF rowcount > 0 THEN
	this.selectrow(0,FALSE)
	this.scrolltorow(1)
	this.selectrow(1,TRUE)
END IF

end event

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

IF currentrow > 0 THEN
	this.selectrow(0,FALSE)
	this.selectrow(currentrow,TRUE)
END IF
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

cb_4.event clicked()
end event

type cb_2 from commandbutton within w_user_authorize
integer x = 1358
integer y = 896
integer width = 215
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = ">"
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

Long  ll_Row,ll_Find
Long  ll_NewRow
String  ls_GroupNo

ll_Row = dw_2.GetRow()
If ll_Row < 1 Then Return
ls_GroupNo = dw_2.GetItemString(ll_Row,'fgroupno')
ll_Find = dw_3.Find("fGroupNo > '"+String(ls_GroupNo)+"'",1,dw_3.RowCount())
If ll_Find < 1  Then
	ll_Find = dw_3.RowCount() +1
End If

cb_1.Enabled = True

ll_NewRow = dw_3.InsertRow(ll_Find)

dw_3.SetItem( ll_NewRow, "fGroupNo", dw_2.GetItemString(ll_Row,'fGroupNo') )
dw_3.SetItem( ll_NewRow, "fuserno", is_UserNo )
dw_3.ScrollToRow(ll_Find)
dw_3.SelectRow(0,False)
dw_3.SelectRow(dw_3.GetRow(),True)

dw_2.RowsDiscard(ll_Row,ll_Row,primary!)

dw_2.SelectRow(0,False)

dw_2.SelectRow(dw_2.GetRow(),True)


end event

type cb_3 from commandbutton within w_user_authorize
integer x = 1358
integer y = 1032
integer width = 215
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = ">>"
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

Long  ll_Row,ll_MenuID,ll_Find
Long  ll_NewRow

If dw_2.GetRow() < 1 Then Return
cb_1.Enabled = True

For ll_Row = 1 To dw_2.RowCount()
	ll_NewRow = dw_3.InsertRow(0)
	
	dw_3.SetItem( ll_NewRow, "fGroupNo", dw_2.GetItemString(ll_Row,'fGroupNo') )
	dw_3.SetItem( ll_NewRow, "fuserno", is_userno )
Next

dw_3.Sort()
dw_3.ScrollToRow(1)

dw_2.Reset()

end event

type cb_4 from commandbutton within w_user_authorize
integer x = 1358
integer y = 1168
integer width = 215
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "<"
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

Long  ll_Row,ll_Find
Long  ll_NewRow
String  ls_GroupNo

ll_Row = dw_3.GetRow()
If ll_Row < 1 Then Return
ls_GroupNo = dw_3.GetItemString(ll_Row,'fGroupNo')
ll_Find = dw_2.Find("fGroupNo > '"+ls_GroupNo+"'",1,dw_2.RowCount())
If ll_Find < 1  Then
	ll_Find = dw_2.RowCount() +1
End If

cb_1.Enabled = True

ll_NewRow = dw_2.InsertRow(ll_Find)

dw_2.SetItem( ll_NewRow, "fGroupNo", dw_3.GetItemString(ll_Row,'fGroupNo') )
dw_2.ScrollToRow(ll_Find)
dw_2.SelectRow(0,False)
dw_2.SelectRow(dw_2.GetRow(),True)

dw_3.DeleteRow(ll_Row)

dw_3.SelectRow(0,False)

dw_3.SelectRow(dw_3.GetRow(),True)


end event

type cb_5 from commandbutton within w_user_authorize
integer x = 1358
integer y = 1304
integer width = 215
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "<<"
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

Long  ll_Row,ll_MenuID,ll_Find
Long  ll_NewRow

If dw_3.GetRow() < 1 Then Return
cb_1.Enabled = True

For ll_Row = 1 To dw_3.RowCount()
	ll_NewRow = dw_2.InsertRow(0)
	
	dw_2.SetItem( ll_NewRow, "fGroupNo", dw_3.GetItemString(ll_Row,'fGroupNo') )
Next

dw_2.Sort()
dw_2.ScrollToRow(1)

dw_3.RowsMove(1, dw_3.RowCount(), primary!,dw_3, 1, DELETE!)


end event

type st_1 from statictext within w_user_authorize
integer x = 50
integer y = 800
integer width = 750
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Not a member of group(s):"
boolean focusrectangle = false
end type

type st_2 from statictext within w_user_authorize
integer x = 1627
integer y = 800
integer width = 750
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Member of group(s):"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_user_authorize
integer x = 37
integer y = 120
integer width = 2798
integer height = 644
integer taborder = 20
string title = "none"
string dataobject = "dw_user_fr"
boolean livescroll = true
end type

event itemchanged;//====================================================================
// Event: itemchanged()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	long    	row 		
//		value	dwobject	dwo 		
//		value	string  	data		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnitemchange]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

cb_1.Enabled = True

If dwo.Name <> 'fuserno' Then Return
If row < 1 Then Return

Int li_Count
dwitemstatus   ldws

ldws = This.GetItemStatus(row,0,primary!)
If ldws = new! Or ldws  = newmodified! Then
	SELECT count(*) Into :li_Count From t_user Where fuserno = :Data;
	If li_Count > 0 Then
		MessageBox('Alert','The user already exists.')
		Return 1
	End If
End If


end event

event editchanged;//====================================================================
// Event: editchanged()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	long    	row 		
//		value	dwobject	dwo 		
//		value	string  	data		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnchanging]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

cb_1.enabled = true
end event

type dw_2 from datawindow within w_user_authorize
integer x = 50
integer y = 892
integer width = 1257
integer height = 916
integer taborder = 10
string title = "none"
string dataobject = "dw_unassigned_group"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

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

If RowCount > 0 Then
	This.SelectRow(0,False)
	This.ScrollToRow(1)
	This.SelectRow(1,True)
End If


end event

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

If currentrow > 0 Then
	This.SelectRow(0,False)
	This.SelectRow(currentrow,True)
End If

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

cb_2.Event Clicked()

end event

