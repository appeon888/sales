$PBExportHeader$w_product_edit.srw
forward
global type w_product_edit from w_sheet
end type
type cb_1 from commandbutton within w_product_edit
end type
type mle_1 from multilineedit within w_product_edit
end type
type cb_9 from commandbutton within w_product_edit
end type
type cb_4 from commandbutton within w_product_edit
end type
type cb_2 from commandbutton within w_product_edit
end type
type cb_update from commandbutton within w_product_edit
end type
type cb_delete from commandbutton within w_product_edit
end type
type cb_insert from commandbutton within w_product_edit
end type
type dw_product from datawindow within w_product_edit
end type
type cb_close from commandbutton within w_product_edit
end type
end forward

global type w_product_edit from w_sheet
integer width = 3579
integer height = 1656
string title = "Catalog Manager - Products"
long backcolor = 32039904
event ue_insert ( )
event ue_refresh ( )
event ue_modify ( )
event type integer ue_setfilter ( string as_productfilter )
event type integer ue_save ( )
cb_1 cb_1
mle_1 mle_1
cb_9 cb_9
cb_4 cb_4
cb_2 cb_2
cb_update cb_update
cb_delete cb_delete
cb_insert cb_insert
dw_product dw_product
cb_close cb_close
end type
global w_product_edit w_product_edit

type variables
//====================================================================
// Declare: Instance Variables()
//--------------------------------------------------------------------
// Description: Determine if data has been changed
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

boolean   ib_changed
end variables

event ue_insert();//====================================================================
// Event: ue_insert()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		None		
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

str_general			lstr_parm

lstr_parm.faction = "new!"

openwithParm(w_product_new_response,lstr_parm)
end event

event ue_refresh();//====================================================================
// Event: ue_refresh()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		None		
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

dw_product.retrieve()
end event

event ue_modify();//====================================================================
// Event: ue_modify()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		None		
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

//ue_modify

If ib_changed Then
	Int  li_Ret
	li_Ret = MessageBox("Save Data","Changes have not been saved.  Do you want to save changes before    ~r~n proceeding with the modify function?  Unsaved changes may be lost.",question!,yesnocancel!)
	If li_Ret = 1 Then
		If This.Event ue_save() < 1 Then Return
	ElseIf li_Ret = 3 Then
		Return
	End If
End If
Long					ll_row
w_product_new		lwin_product_new
str_general			lstr_parm

ll_row = dw_product.GetRow()
If ll_row = 0 Then Return

lstr_parm.faction = "modify!"
lstr_parm.fsku = dw_product.Object.fsku[ll_row]

OpenWithParm(w_product_new_response,lstr_parm)

end event

event type integer ue_setfilter(string as_productfilter);//====================================================================
// Event: ue_setfilter()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		string	as_productfilter		
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

//If as_ProductFilter <> '' Then //comment by liulihua filter all
	dw_Product.SetFilter(as_ProductFilter)
	dw_Product.Filter()
	mle_1.Text = String(dw_Product.RowCount())+" matches."
	dw_Product.Event RowFocusChanged(dw_Product.GetRow())
//End If

Return 1

end event

event type integer ue_save();//====================================================================
// Event: ue_save()
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

String	ls_error

If Not ib_changed Then Return 0

String	ls_Temp
Integer li_Row
dwitemstatus  ldws

dw_product.AcceptText()
For li_Row = 1 To dw_product.RowCount()
	ldws = dw_product.GetItemStatus(li_Row,0,primary!)
	If ldws = new! Or ldws = notmodified! Then Continue
	ls_Temp = Trim(dw_product.GetItemString(li_Row,'fsku'))
	If IsNull(ls_Temp) Or ls_Temp = '' Then
		dw_product.ScrollToRow(li_Row)
		MessageBox('Alert','Please enter SKU.')
		Return -1
	End If
	If Len(ls_Temp) <> 6 Then
		dw_product.ScrollToRow(li_Row)
		MessageBox('Alert','SKU must be 6 characters.')
		Return -1
	End If
	ls_Temp = dw_product.GetItemString(li_Row,'fcategory')
	If IsNull(ls_Temp) Or ls_Temp = '' Then
		dw_product.ScrollToRow(li_Row)
		MessageBox('Alert','Please enter Category.')
		Return -1
	End If
	ls_Temp = Trim(dw_product.GetItemString(li_Row,'fproname'))
	If IsNull(ls_Temp) Or ls_Temp = '' Then
		dw_product.ScrollToRow(li_Row)
		MessageBox('Alert','Please enter Product Name.')
		Return -1
	End If
Next

If dw_product.UPDATE() = 1 Then
	COMMIT;
	ib_changed = False
	cb_update.Enabled = False
	Return 1
Else
	ls_error = sqlca.SQLErrText
	ROLLBACK;
	MessageBox("Warning","Failed to save the changes.",exclamation!)
	Return -1
End If



end event

on w_product_edit.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.mle_1=create mle_1
this.cb_9=create cb_9
this.cb_4=create cb_4
this.cb_2=create cb_2
this.cb_update=create cb_update
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.dw_product=create dw_product
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.mle_1
this.Control[iCurrent+3]=this.cb_9
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_update
this.Control[iCurrent+7]=this.cb_delete
this.Control[iCurrent+8]=this.cb_insert
this.Control[iCurrent+9]=this.dw_product
this.Control[iCurrent+10]=this.cb_close
end on

on w_product_edit.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.mle_1)
destroy(this.cb_9)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.cb_update)
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.dw_product)
destroy(this.cb_close)
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

dw_product.setTransObject(sqlca)

this.post event ue_refresh()
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
	li_rc = MessageBox ("Save Data", "Save changes to the product before closing?", question!, yesnocancel!)
	
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

event resize;call super::resize;ieon_resize.of_resize(this,newwidth,newheight,true) //add by liulihua
end event

type cb_1 from commandbutton within w_product_edit
boolean visible = false
integer x = 2482
integer y = 1400
integer width = 320
integer height = 120
integer taborder = 30
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

parent.event ue_modify()
end event

type mle_1 from multilineedit within w_product_edit
integer x = 1042
integer y = 1416
integer width = 434
integer height = 84
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711935
long backcolor = 32039904
boolean border = false
boolean autovscroll = true
boolean displayonly = true
end type

type cb_9 from commandbutton within w_product_edit
boolean visible = false
integer x = 370
integer y = 1404
integer width = 320
integer height = 120
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Show All"
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

dw_product.SetFilter("")
dw_product.filter()

mle_1.text = ''
dw_product.event rowfocuschanged(dw_product.getrow())
end event

type cb_4 from commandbutton within w_product_edit
boolean visible = false
integer x = 713
integer y = 1404
integer width = 320
integer height = 120
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Filter"
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

openwithparm(w_set_filter_product,'w_product_edit')
end event

type cb_2 from commandbutton within w_product_edit
boolean visible = false
integer x = 32
integer y = 1400
integer width = 320
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sort"
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

openwithparm(w_sort_single,dw_product)
end event

type cb_update from commandbutton within w_product_edit
boolean visible = false
integer x = 2834
integer y = 1400
integer width = 320
integer height = 120
integer taborder = 30
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

parent.event ue_save()
end event

type cb_delete from commandbutton within w_product_edit
boolean visible = false
integer x = 2130
integer y = 1400
integer width = 320
integer height = 120
integer taborder = 20
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

integer  li_Ret,li_Count,li_Row
string ls_SKU
nvo_util  lnv_util

li_Row = dw_product.getrow()
IF li_Row < 1 THEN return
ls_SKU = dw_product.getitemstring(li_Row,'fsku')
li_Ret = MessageBox("Delete","Are you sure you want to delete the product " + lnv_util.of_parse_sku(ls_SKU) + "?" ,&
			Question!,YesNo!) 
IF li_Ret <> 1 THEN return			

SELECT count(*) into :li_Count from t_orders_items
WHERE FSKU = :ls_SKU;
IF li_Count > 0 THEN
	messagebox('Warning',"You cannot delete the product because it is included in some order(s). ")
	return
END IF
dw_product.deleterow(0)
cb_update.enabled = TRUE
ib_changed = TRUE
end event

type cb_insert from commandbutton within w_product_edit
boolean visible = false
integer x = 1778
integer y = 1400
integer width = 320
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

parent.event ue_insert()
end event

type dw_product from datawindow within w_product_edit
integer x = 32
integer y = 24
integer width = 3465
integer height = 1328
integer taborder = 10
string title = "none"
string dataobject = "d_product_edit"
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
//		long	currentrow		
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

If currentRow = 0 Then
	Return
End If

This.selectrow(0,False)
This.selectrow(currentrow,true)
end event

event doubleclicked;//====================================================================
// Event: doubleclicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		integer 	xpos		
//		integer 	ypos		
//		long    	row 		
//		dwobject	dwo 		
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

parent.event ue_modify()
end event

event editchanged;//====================================================================
// Event: editchanged()
//--------------------------------------------------------------------
// Description: Update instance variable indicating that data in the DataWindow has changed.
//--------------------------------------------------------------------
// Arguments: 
//		long    	row 		
//		dwobject	dwo 		
//		string  	data		
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

ib_changed = true
cb_update.enabled = true
end event

event itemchanged;//====================================================================
// Event: itemchanged()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		long    	row 		
//		dwobject	dwo 		
//		string  	data		
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

ib_changed = true
cb_update.enabled = true
end event

type cb_close from commandbutton within w_product_edit
boolean visible = false
integer x = 3186
integer y = 1400
integer width = 320
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

Close(parent)
end event

