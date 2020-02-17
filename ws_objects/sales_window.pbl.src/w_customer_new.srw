$PBExportHeader$w_customer_new.srw
forward
global type w_customer_new from w_sheet
end type
type cb_1 from commandbutton within w_customer_new
end type
type dw_1 from datawindow within w_customer_new
end type
type cb_update from commandbutton within w_customer_new
end type
end forward

global type w_customer_new from w_sheet
integer width = 2578
integer height = 1208
string title = "New Customer"
long backcolor = 32039904
event ue_open ( )
cb_1 cb_1
dw_1 dw_1
cb_update cb_update
end type
global w_customer_new w_customer_new

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

boolean  ib_changed = FALSE
end variables

on w_customer_new.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_update=create cb_update
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_update
end on

on w_customer_new.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_update)
end on

event open;call super::open;//====================================================================
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

dw_1.event  ue_init()
dw_1.event  ue_insert()
end event

event closequery;//====================================================================
// Event: closequery()
//--------------------------------------------------------------------
// Description: If data in the DataWindow has been changed but not saved, prompt user to save it.
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_closequery]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Int	li_rc

If ib_changed Then
	li_rc = MessageBox ("Save Data", "Do you want to save changes to product before closing?", question!, yesnocancel!)
	
	// Yes
	If li_rc = 1 Then
		cb_update.TriggerEvent ("clicked")
		If ib_changed Then
			Return 1
		End If
	Else
		// Cancel
		If li_rc = 3 Then
			Return 1
		End If
	End If
End If

Return 0


end event

type cb_1 from commandbutton within w_customer_new
integer x = 2057
integer y = 956
integer width = 448
integer height = 120
integer taborder = 20
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

close(parent)
end event

type dw_1 from datawindow within w_customer_new
event ue_insert ( )
event ue_init ( )
event type integer ue_update ( )
event ue_retrieve ( string as_custno )
integer x = 32
integer y = 28
integer width = 2469
integer height = 884
integer taborder = 10
string title = "none"
string dataobject = "d_customer_new"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_insert();//====================================================================
// Event: ue_insert()
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

this.insertrow(0)
end event

event ue_init();//====================================================================
// Event: ue_init()
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

this.settransobject(sqlca)
end event

event type integer ue_update();//====================================================================
// Event: ue_update()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
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

return this.update()

end event

event ue_retrieve(string as_custno);//====================================================================
// Event: ue_retrieve()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_custno		
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

this.retrieve(as_custno)
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

cb_update.enabled = true
ib_changed = TRUE
end event

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

cb_update.Enabled = True
ib_changed = True
If dwo.Name <> 'fcustno' Then Return
If row < 1 Then Return

Int li_Count
dwitemstatus   ldws

ldws = This.GetItemStatus(row,0,primary!)
If ldws = new! Or ldws  = newmodified! Then
	SELECT count(*) Into :li_Count From t_customers Where fcustno = :Data;
	If li_Count > 0 Then
		MessageBox('Alert','The customer already exists.')
		Return 1
	End If
End If


end event

type cb_update from commandbutton within w_customer_new
integer x = 1577
integer y = 956
integer width = 448
integer height = 120
integer taborder = 10
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

String	ls_error,ls_Temp,ls_CustNo
Integer li_Row
dwitemstatus  ldws
nvo_util  lnv_util

dw_1.AcceptText()
li_Row = dw_1.GetRow()
If li_Row < 1 Then Return
ldws = dw_1.GetItemStatus(li_Row,0,primary!)
If ldws = new! Or ldws = notmodified! Then Return

ls_Temp = Trim(dw_1.GetItemString(li_Row,'FCustNo'))
ls_CustNo = ls_Temp

If IsNull(ls_Temp) Or ls_Temp = '' Then
	MessageBox('Alert','Please enter Customer ID.')
	Return
End If
If Len(ls_Temp) <> 4 Then
	MessageBox('Alert','Customer ID must be 4 numbers.')
	Return
End If
ls_Temp = Trim(dw_1.GetItemString(li_Row,'FLastName'))
If IsNull(ls_Temp) Or ls_Temp = '' Then
	MessageBox('Alert','Please enter Last Name.')
	Return
End If
ls_Temp = Trim(dw_1.GetItemString(li_Row,'FFirstName'))
If IsNull(ls_Temp) Or ls_Temp = '' Then
	MessageBox('Alert','Please enter First Name.')
	Return
End If
If dw_1.UPDATE() = 1 Then
	COMMIT;
	ib_changed = False
	cb_update.Enabled = False
	If IsValid(w_customer_maintenance) Then
		datawindow   ldw
		Integer  li_Count
		
		ldw = w_customer_maintenance.dw_1
		dw_1.RowsCopy(1,1,primary!,ldw,65535,primary!)
		li_Count = ldw.RowCount()
		ldw.ScrollToRow(li_Count)
		ldw.SetItemStatus(li_Count,0,primary!,datamodified!)
		ldw.SetItemStatus(li_Count,0,primary!,notmodified!)
	End If
	MessageBox("Alert","The customer "+lnv_util.of_parse_custno(ls_CustNo)+" has been added successfully.")
	dw_1.Reset()
	dw_1.Event ue_insert()
Else
	ls_error = sqlca.SQLErrText
	ROLLBACK;
	MessageBox("Warning","Faild to save the changes.",exclamation!)
	Return
End If

end event

