$PBExportHeader$w_product_new.srw
forward
global type w_product_new from w_sheet
end type
type cb_close from commandbutton within w_product_new
end type
type cb_update from commandbutton within w_product_new
end type
type dw_product from datawindow within w_product_new
end type
end forward

global type w_product_new from w_sheet
integer width = 2267
integer height = 964
string title = "New Product"
long backcolor = 32039904
cb_close cb_close
cb_update cb_update
dw_product dw_product
end type
global w_product_new w_product_new

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

str_general		istr_parm
// Determine if data has been changed
boolean   ib_changed
end variables

on w_product_new.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_update=create cb_update
this.dw_product=create dw_product
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_update
this.Control[iCurrent+3]=this.dw_product
end on

on w_product_new.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.dw_product)
end on

event open;call super::open;//====================================================================
// Event: open()
//--------------------------------------------------------------------
// Description: get message parm
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

long		ll_row


istr_parm = Message.powerobjectparm
dw_product.setTransObject(sqlca)

choose	case lower(istr_parm.faction)
	case	"new!"
		ll_row = dw_product.insertRow(0)
		dw_product.ScrollToRow(ll_row)
	case	"modify!"
		dw_product.retrieve(istr_parm.FSKU)
		dw_product.object.fsku.protect = '1'
		dw_product.object.fsku.background.color = 32039904 //Button Face
		dw_product.object.fcategory.protect = '1'
		dw_product.object.fcategory.background.color = 32039904 //Button Face
End Choose

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

int	li_rc

if ib_changed then
	li_rc = MessageBox ("Save Data", "Do you want to save changes to product before closing?", question!, yesnocancel!)	
	
	// Yes
	if li_rc = 1 then
		cb_update.TriggerEvent ("clicked")
		if ib_changed then
			return 1
		end if
	else
		// Cancel
		if li_rc = 3 then
			return 1
		end if
	end if
end if

return 0

end event

type cb_close from commandbutton within w_product_new
boolean visible = false
integer x = 1751
integer y = 708
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

Close(parent)
end event

type cb_update from commandbutton within w_product_new
boolean visible = false
integer x = 1257
integer y = 708
integer width = 448
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

string	ls_error,ls_Temp
integer li_Row
dec  ldc_unitPrice
string  ls_SKU
dwitemstatus  ldws
nvo_util  lnv_util

dw_product.accepttext()
li_Row = dw_product.getrow()
IF li_Row < 1 THEN return
ldws = dw_product.getitemstatus(li_Row,0,primary!)
IF ldws = new! or ldws = notmodified! THEN return
ls_SKU = trim(dw_product.getitemstring(li_Row,'fsku'))
IF isnull(ls_SKU) OR ls_SKU = ''THEN
	messagebox('Alert','Please enter SKU.')
	return
END IF
IF len(ls_SKU) <> 6 THEN
	messagebox('Alert','SKU must be 6 characters.')
	return
END IF
ls_Temp = dw_product.getitemstring(li_Row,'fcategory')
IF isnull(ls_Temp) OR ls_Temp='' THEN
	messagebox('Alert','Please enter Category.')
	return
END IF
ls_Temp = trim(dw_product.getitemstring(li_Row,'fproname'))
IF isnull(ls_Temp) OR ls_Temp='' THEN
	messagebox('Alert','Please enter Product Name.')
	return
END IF
ldc_unitPrice = dw_product.getitemdecimal(li_Row,'funit_price')
IF isnull(ldc_unitPrice) OR ldc_unitPrice <= 0 THEN
	messagebox('Alert','Please enter Unit Price.')
	return
END IF

If dw_product.Update() = 1 Then
	Commit;
	ib_changed = False
	cb_update.enabled = false
	//refresh main window
	If IsValid(w_product_edit) Then
		w_product_edit. event ue_refresh()
	End If
	Messagebox("Alert","The product "+lnv_util.of_parse_sku(ls_SKU)+" has been added successfully.")
	IF lower(istr_parm.faction) = 'new!' THEN
		dw_product.reset()
		dw_product.insertrow(0)
	END IF
Else
	ls_error = sqlca.sqlerrtext
	Rollback;
	Messagebox("Warning","Faild to save the changes.",exclamation!)
	Return
End If
end event

type dw_product from datawindow within w_product_new
integer x = 32
integer y = 24
integer width = 2162
integer height = 652
integer taborder = 10
string title = "none"
string dataobject = "d_product_new"
borderstyle borderstyle = stylelowered!
end type

event editchanged;//====================================================================
// Event: editchanged()
//--------------------------------------------------------------------
// Description: Update instance variable indicating that data in the DataWindow has changed.
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

ib_changed = true
cb_update.enabled = true
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

ib_changed = true
cb_update.enabled = true

IF dwo.name <>'fsku' THEN return
IF row < 1 THEN return

int li_Count
dwitemstatus   ldws

ldws = this.getitemstatus(row,0,primary!)
IF ldws = new! OR ldws  = newmodified! THEN
	SELECT count(*) into :li_Count from t_products where FSKU = :data;
	IF li_Count > 0 THEN
		messagebox('Alert','The product already exists.')
		return 1
	END IF
END IF

end event

