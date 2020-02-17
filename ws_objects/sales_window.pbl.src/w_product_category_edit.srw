$PBExportHeader$w_product_category_edit.srw
forward
global type w_product_category_edit from w_sheet
end type
type cb_close from commandbutton within w_product_category_edit
end type
type cb_update from commandbutton within w_product_category_edit
end type
type cb_delete from commandbutton within w_product_category_edit
end type
type cb_insert from commandbutton within w_product_category_edit
end type
type dw_product_category from datawindow within w_product_category_edit
end type
end forward

global type w_product_category_edit from w_sheet
integer width = 2633
integer height = 1352
string title = "Catalog Manager - Categories"
long backcolor = 32039904
cb_close cb_close
cb_update cb_update
cb_delete cb_delete
cb_insert cb_insert
dw_product_category dw_product_category
end type
global w_product_category_edit w_product_category_edit

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

on w_product_category_edit.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_update=create cb_update
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.dw_product_category=create dw_product_category
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_update
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_insert
this.Control[iCurrent+5]=this.dw_product_category
end on

on w_product_category_edit.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.dw_product_category)
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

dw_product_category.setTransObject(sqlca)
dw_product_category.retrieve()
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
	li_rc = MessageBox ("Save Data", "Save changes to product category before closing?", question!, yesnocancel!)	
	
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
end event

type cb_close from commandbutton within w_product_category_edit
boolean visible = false
integer x = 2103
integer y = 1092
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

close(parent)
end event

type cb_update from commandbutton within w_product_category_edit
boolean visible = false
integer x = 992
integer y = 1092
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

string	ls_error

If dw_product_category.Update() = 1 Then
	Commit;
	ib_changed = False
	cb_update.enabled = false
Else
	ls_error = sqlca.sqlerrtext
	Rollback;
	Messagebox("Warning","Failed to save the changes.",exclamation!)
	Return
End If
end event

type cb_delete from commandbutton within w_product_category_edit
boolean visible = false
integer x = 512
integer y = 1092
integer width = 448
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
string  ls_Category

li_Row = dw_product_category.getrow()
IF li_Row < 1 THEN return
ls_Category = dw_product_category.getitemstring(li_Row,'FCategory')
li_Ret = MessageBox("Delete","Are you sure you want to delete the category " + ls_Category + "?" ,&
			Question!,YesNo!) 
IF li_Ret <> 1 THEN return			

SELECT count(*) into :li_Count from t_products
WHERE FCategory = :ls_Category;
IF li_Count > 0 THEN
	messagebox('Warning',"You cannot delete the category because there are "+string(li_Count)+" products defined in this category. ")
	return
END IF
dw_product_category.deleterow(0)
cb_update.enabled = TRUE
end event

type cb_insert from commandbutton within w_product_category_edit
boolean visible = false
integer x = 32
integer y = 1092
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

long		ll_row 

ll_row = dw_product_category.insertrow(0)
dw_product_category.scrollToRow(ll_row)
end event

type dw_product_category from datawindow within w_product_category_edit
integer x = 32
integer y = 24
integer width = 2523
integer height = 1024
integer taborder = 10
string title = "none"
string dataobject = "d_product_categroy_edit"
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

If currentRow = 0 Then
	Return
End If

this.selectrow(0,False)
this.selectrow(currentrow,true)
end event

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

IF dwo.name <>'fcategory' THEN return
IF row < 1 THEN return
int li_Count
dwitemstatus   ldws

ldws = this.getitemstatus(row,0,primary!)
IF ldws = new! OR ldws  = newmodified! THEN
	SELECT count(*) into :li_Count from t_prod_category where FCategory = :data;
	IF li_Count > 0 THEN
		messagebox('Alert','The product category already exists.')
		return 1
	END IF
ELSE
	string  ls_Category
	ls_Category = this.getitemstring(row,'FCategory')
	SELECT count(*) into :li_Count from t_products where FCategory = :ls_Category;
	IF li_Count > 0 THEN
		messagebox('Alert','Please do not modify the category because there are products in it.')
		return 2
	END IF
	
END IF

end event

