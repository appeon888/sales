$PBExportHeader$w_customer_modify.srw
forward
global type w_customer_modify from w_customer_new
end type
type rbb_1 from ribbonbar within w_customer_modify
end type
end forward

global type w_customer_modify from w_customer_new
integer width = 2514
integer height = 1540
boolean titlebar = true
string title = "Customer Maintenance Modify"
boolean controlmenu = true
windowtype windowtype = response!
windowstate windowstate = normal!
boolean center = true
rbb_1 rbb_1
end type
global w_customer_modify w_customer_modify

on w_customer_modify.create
int iCurrent
call super::create
this.rbb_1=create rbb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rbb_1
end on

on w_customer_modify.destroy
call super::destroy
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
string   ls_custno  

ls_custno  = message.stringparm

dw_1.event  ue_init()
dw_1.event  ue_retrieve(ls_custno)
end event

type cb_1 from w_customer_new`cb_1 within w_customer_modify
integer x = 2021
integer y = 952
end type

type dw_1 from w_customer_new`dw_1 within w_customer_modify
integer width = 2437
string dataobject = "d_customer_modify"
end type

type cb_update from w_customer_new`cb_update within w_customer_modify
integer x = 1527
integer y = 948
end type

event cb_update::clicked;//====================================================================
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
	cb_update.Enabled = False
	ib_changed = False
	If IsValid(w_customer_maintenance) Then
		datawindow   ldw
		Integer  li_Count
		
		ldw = w_customer_maintenance.dw_1
		li_Row = ldw.GetRow()
		ldw.RowsDiscard(li_Row,li_Row,primary!)
		dw_1.RowsCopy(1,1,primary!,ldw,li_Row,primary!)
		ldw.SetItemStatus(li_Row,0,primary!,datamodified!)
		ldw.SetItemStatus(li_Row,0,primary!,notmodified!)
		ldw.SelectRow(0,False)
		ldw.SelectRow(li_Row,True)
	End If
	MessageBox("Alert","The customer "+lnv_util.of_parse_custno(ls_CustNo)+" has been modified successfully.")
	cb_1.Event Clicked()
Else
	ls_error = sqlca.SQLErrText
	ROLLBACK;
	MessageBox("Warning","Failed to save the changes.",exclamation!)
	Return
End If

end event

type rbb_1 from ribbonbar within w_customer_modify
integer x = 9
integer y = 1092
integer width = 2505
integer height = 260
boolean bringtotop = true
long backcolor = 15132390
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hebrewcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

