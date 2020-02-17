$PBExportHeader$w_group_authorize.srw
$PBExportComments$Group Authorize
forward
global type w_group_authorize from window
end type
type p_group from picture within w_group_authorize
end type
type cb_close from commandbutton within w_group_authorize
end type
type cb_1 from commandbutton within w_group_authorize
end type
type dw_1 from datawindow within w_group_authorize
end type
type cb_2 from commandbutton within w_group_authorize
end type
type cb_3 from commandbutton within w_group_authorize
end type
type cb_4 from commandbutton within w_group_authorize
end type
type cb_5 from commandbutton within w_group_authorize
end type
type st_1 from statictext within w_group_authorize
end type
type st_2 from statictext within w_group_authorize
end type
type gb_1 from groupbox within w_group_authorize
end type
type dw_3 from datawindow within w_group_authorize
end type
type dw_2 from datawindow within w_group_authorize
end type
end forward

global type w_group_authorize from window
integer width = 3003
integer height = 1884
boolean titlebar = true
string title = "Group Maintenance"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
p_group p_group
cb_close cb_close
cb_1 cb_1
dw_1 dw_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
st_1 st_1
st_2 st_2
gb_1 gb_1
dw_3 dw_3
dw_2 dw_2
end type
global w_group_authorize w_group_authorize

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

string  is_GroupNo
string  is_Changed=''
end variables

on w_group_authorize.create
this.p_group=create p_group
this.cb_close=create cb_close
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.st_1=create st_1
this.st_2=create st_2
this.gb_1=create gb_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.Control[]={this.p_group,&
this.cb_close,&
this.cb_1,&
this.dw_1,&
this.cb_2,&
this.cb_3,&
this.cb_4,&
this.cb_5,&
this.st_1,&
this.st_2,&
this.gb_1,&
this.dw_3,&
this.dw_2}
end on

on w_group_authorize.destroy
destroy(this.p_group)
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.dw_3)
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


is_GroupNo  = Message.StringParm
w_group_authorize.setposition(topmost!)
dw_2.Modify("datawindow.readonly=yes")
dw_3.Modify("datawindow.readonly=yes")
dw_1.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
dw_3.SetTransObject(SQLCA)

dw_2.Retrieve(is_GroupNo)
dw_3.Retrieve(is_GroupNo)

If is_GroupNo = '-1' Then
	dw_1.InsertRow(0)
Else
	dw_1.Retrieve(is_GroupNo)
	
	dw_1.Object.fgroupno.protect = 1
	dw_1.Object.fgroupno.background.Color =  32039904 //Button Face
End If

end event

type p_group from picture within w_group_authorize
integer x = 37
integer y = 8
integer width = 2889
integer height = 120
string picturename = ".\picture\Group-Information.jpg"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_group_authorize
integer x = 2514
integer y = 1648
integer width = 448
integer height = 120
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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

CloseWithReturn(Parent,is_changed)

end event

type cb_1 from commandbutton within w_group_authorize
integer x = 2030
integer y = 1648
integer width = 448
integer height = 120
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Save"
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

String  ls_Err,ls_GroupNo
Int  li
dwitemstatus  ldws

If dw_1.GetRow() < 1 Then Return -1
If dw_1.AcceptText() < 0 Then Return -1

ls_GroupNo = Trim(dw_1.GetItemString(1,'fgroupno'))
If ls_GroupNo = '' Or IsNull(ls_GroupNo) Then
	dw_1.SetFocus()
	dw_1.SetColumn('fgroupno')
	MessageBox(Parent.Title,'Please enter Group Name.')
	Return -1
End If
For li = 1 To dw_3.RowCount()
	ldws = dw_3.GetItemStatus(li,0,primary!)
	If ldws = newmodified! Then
		dw_3.SetItem(li,'fgroupno',ls_GroupNo)
	End If
Next

If dw_1.UPDATE() > 0 And dw_3.UPDATE() > 0 Then
	COMMIT;
	is_Changed = 'changed'
	This.Enabled = False
	cb_close.Post Event Clicked()
	Return 1
End If

ls_Err =  sqlca.SQLErrText
ROLLBACK;
MessageBox('Save',"Failed to save changes to database.",exclamation!)
Return -1


end event

type dw_1 from datawindow within w_group_authorize
integer x = 37
integer y = 128
integer width = 2889
integer height = 368
integer taborder = 20
string title = "none"
string dataobject = "dw_group_fr"
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

If dwo.Name <> 'fgroupno' Then Return
If row < 1 Then Return

Int li_Count
dwitemstatus   ldws

ldws = This.GetItemStatus(row,0,primary!)
If ldws = new! Or ldws  = newmodified! Then
	SELECT count(*) Into :li_Count From t_groups Where fgroupno = :Data;
	If li_Count > 0 Then
		MessageBox('Alert','The group already exists.')
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

cb_1.Enabled = True

end event

type cb_2 from commandbutton within w_group_authorize
integer x = 1394
integer y = 604
integer width = 197
integer height = 136
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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
String  ls_MenuNo


ll_Row = dw_2.GetRow()
If ll_Row < 1 Then Return
ls_MenuNo = dw_2.GetItemString(ll_Row,'fmenuno')
ll_Find = dw_3.Find("fmenuno > '"+String(ls_MenuNo)+"'",1,dw_3.RowCount())
If ll_Find < 1  Then
	ll_Find = dw_3.RowCount() +1
End If
cb_1.Enabled = True
ll_NewRow = dw_3.InsertRow(ll_Find)

dw_3.SetItem( ll_NewRow, "fmenuno", dw_2.GetItemString(ll_Row,'fmenuno') )
dw_3.SetItem( ll_NewRow, "fgroupno", is_GroupNo )
dw_3.SetItem( ll_NewRow, "fmenuname",  dw_2.GetItemString(ll_Row,'fmenuname') )
dw_3.SetItem( ll_NewRow, "fdescription", dw_2.GetItemString(ll_Row,'fdescription') )
dw_3.ScrollToRow(ll_Find)
dw_3.SelectRow(0,False)
dw_3.SelectRow(dw_3.GetRow(),True)

dw_2.RowsDiscard(ll_Row,ll_Row,primary!)

dw_2.SelectRow(0,False)

dw_2.SelectRow(dw_2.GetRow(),True)


end event

type cb_3 from commandbutton within w_group_authorize
integer x = 1394
integer y = 764
integer width = 197
integer height = 136
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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
	
	dw_3.SetItem( ll_NewRow, "fmenuno", dw_2.GetItemString(ll_Row,'fmenuno') )
	dw_3.SetItem( ll_NewRow, "fgroupno", is_GroupNo )
	dw_3.SetItem( ll_NewRow, "fmenuname",  dw_2.GetItemString(ll_Row,'fmenuname') )
	dw_3.SetItem( ll_NewRow, "fdescription", dw_2.GetItemString(ll_Row,'fdescription') )
Next

dw_3.Sort()
dw_3.ScrollToRow(1)

dw_2.Reset()

end event

type cb_4 from commandbutton within w_group_authorize
integer x = 1394
integer y = 924
integer width = 197
integer height = 136
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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

Long    ll_Row,ll_Find
Long    ll_NewRow
String  ls_MenuNo


ll_Row = dw_3.GetRow()
If ll_Row < 1 Then Return
ls_MenuNo = dw_3.GetItemString(ll_Row,'fmenuno')
ll_Find = dw_2.Find("fmenuno > '"+ls_MenuNo+"'",1,dw_2.RowCount())
If ll_Find < 1  Then
	ll_Find = dw_2.RowCount() +1
End If

cb_1.Enabled = True

ll_NewRow = dw_2.InsertRow(ll_Find)
dw_2.SetItem( ll_NewRow, "fmenuno", dw_3.GetItemString(ll_Row,'fmenuno') )
dw_2.SetItem( ll_NewRow, "fmenuname",  dw_3.GetItemString(ll_Row,'fmenuname') )
dw_2.SetItem( ll_NewRow, "fdescription", dw_3.GetItemString(ll_Row,'fdescription') )
dw_2.ScrollToRow(ll_Find)
dw_2.SelectRow(0,False)
dw_2.SelectRow(dw_2.GetRow(),True)

dw_3.DeleteRow(ll_Row)
dw_3.SelectRow(0,False)
dw_3.SelectRow(dw_3.GetRow(),True)


end event

type cb_5 from commandbutton within w_group_authorize
integer x = 1394
integer y = 1084
integer width = 197
integer height = 136
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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
	
	dw_2.SetItem( ll_NewRow, "fmenuno", dw_3.GetItemString(ll_Row,'fmenuno') )
	dw_2.SetItem( ll_NewRow, "fmenuname",  dw_3.GetItemString(ll_Row,'fmenuname') )
	dw_2.SetItem( ll_NewRow, "fdescription", dw_3.GetItemString(ll_Row,'fdescription') )
Next

dw_2.Sort()
dw_2.ScrollToRow(1)

dw_3.RowsMove(1, dw_3.RowCount(), primary!,dw_3, 1, DELETE!)


end event

type st_1 from statictext within w_group_authorize
integer x = 37
integer y = 520
integer width = 750
integer height = 60
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "Unassigned Menu Items:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_group_authorize
integer x = 1627
integer y = 520
integer width = 750
integer height = 60
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "Assigned Menu Items:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_group_authorize
boolean visible = false
integer x = 37
integer y = 20
integer width = 2363
integer height = 444
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33093880
string text = "Group Information"
end type

type dw_3 from datawindow within w_group_authorize
integer x = 1632
integer y = 604
integer width = 1330
integer height = 1004
integer taborder = 10
string title = "none"
string dataobject = "dw_manager_menu"
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

cb_4.Event Clicked()

end event

type dw_2 from datawindow within w_group_authorize
integer x = 37
integer y = 604
integer width = 1321
integer height = 1004
integer taborder = 10
string title = "none"
string dataobject = "dw_all_menu"
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

cb_2.Event Clicked()

end event

