$PBExportHeader$w_cust_product_edit.srw
forward
global type w_cust_product_edit from window
end type
type cb_view from commandbutton within w_cust_product_edit
end type
type cb_close from commandbutton within w_cust_product_edit
end type
type cb_save from commandbutton within w_cust_product_edit
end type
type dw_product from datawindow within w_cust_product_edit
end type
end forward

global type w_cust_product_edit from window
integer width = 2331
integer height = 992
boolean titlebar = true
string title = "Product"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
cb_view cb_view
cb_close cb_close
cb_save cb_save
dw_product dw_product
end type
global w_cust_product_edit w_cust_product_edit

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
Boolean   ib_changed

end variables

on w_cust_product_edit.create
this.cb_view=create cb_view
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_product=create dw_product
this.Control[]={this.cb_view,&
this.cb_close,&
this.cb_save,&
this.dw_product}
end on

on w_cust_product_edit.destroy
destroy(this.cb_view)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_product)
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

Long		ll_row
String  ls_Status


istr_parm = Message.PowerObjectParm

dw_product.SetTransObject(sqlca)
Choose	Case	Lower(istr_parm.faction)
	Case	"modify!"
		dw_product.Retrieve(istr_parm.forderNo,istr_parm.flineID)
		
	Case	"new!"
		ll_row = dw_product.InsertRow(0)
		dw_product.ScrollToRow(ll_row)
End Choose
SELECT FStatus Into :ls_Status From t_orders Where forderNo = :istr_parm.forderNo;
If ls_Status <> '1' Then
	dw_product.Modify("datawindow.readonly=yes")
End If

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
		cb_save.TriggerEvent ("clicked")
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

type cb_view from commandbutton within w_cust_product_edit
integer x = 23
integer y = 752
integer width = 681
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "View Product Catalog"
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

open(w_product_catalog_view_repose)
end event

type cb_close from commandbutton within w_cust_product_edit
integer x = 1829
integer y = 752
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

type cb_save from commandbutton within w_cust_product_edit
integer x = 1335
integer y = 752
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

string		ls_error
long			ll_quantity,ll_row

dw_product.Accepttext()
ll_row = dw_product.getrow()

If ll_row = 0 Then 
	Return
End if
//sure fquantity filled with valid value
ll_quantity = dw_product.object.fquantity[ll_row]
If ll_quantity = 0 Or IsNUll(ll_quantity) Then
	messagebox('Alert','Please enter a valid quantity.')
	dw_product.setColumn("fquantity")
	dw_product.setFocus()
	Return
End If

If dw_product.Update () = 1 Then	
	
	  UPDATE "t_orders"  
     SET "t_orders"."famount" = (select sum("t_orders_items"."fquantity" * "t_orders_items"."funit_price") from "t_orders_items"
											where "t_orders"."forderno" = "t_orders_items"."forderno")
											from 	"t_orders"	
											WHERE "t_orders"."fcustno" = :istr_parm.fcustno 
        									  and "t_orders"."forderno" =:istr_parm.forderNo;
	if sqlca.sqlnrows >0 then
			commit;
		
			ib_changed = False
			this.enabled = false
			//refresh order & product information 
			If IsValid(w_order_main) Then
				w_order_main.event ue_refreshOrder()
				//w_order_main.event ue_refreshProduct()
			End If
	else
			rollback;
	end if
else
	ls_error = sqlca.sqlerrtext
	rollback;
	Messagebox("Warning",'Failed to save the changes.',exclamation!)
	Return
	
End If
end event

type dw_product from datawindow within w_cust_product_edit
integer x = 37
integer y = 32
integer width = 2235
integer height = 664
integer taborder = 10
string title = "none"
string dataobject = "d_cust_product_edit"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event updatestart;//====================================================================
// Event: updatestart()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_dwnupdatestart]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long		ll_i,ll_rowcount,ll_j

ll_rowcount = This.RowCount()

//get max lineId
SELECT isnull(MAX(flineid),0) + 1 INTO :ll_j
	FROM t_orders_items
	Where forderNo = :istr_parm.forderNo;
	
For ll_i = 1 To ll_rowcount Step 1
	If This.GetItemStatus(ll_i,0,Primary!) <> NewModified! Then Continue
	This.Object.forderNo[ll_i] = istr_parm.forderNo
	This.Object.flineid[ll_i] = ll_j
	ll_j++
Next

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

String	ls_category,ls_description,ls_sku,ls_ProName
Dec		ldec_unitprice

Choose	Case	Lower(dwo.Name)
	Case	"funit_price"
		//cal amount
		This.Object.famount[row] = This.Object.fquantity[row] * Integer(Data)
	Case	"fquantity"
		//cal amount
		This.Object.famount[row] = This.Object.funit_price[row] * Integer(Data)
	Case	"fsku"
		//filled with category and name
		SELECT fcategory,funit_price,fproname,fdescription
			INTO :ls_category,:ldec_unitprice,:ls_ProName,:ls_description
			FROM t_products
			Where fsku = :Data;
			
		If sqlca.SQLCode <> 0 Then
			MessageBox("Alert","The SKU does not exist.")
			Return 1
		End If
		
		This.Object.t_products_fcategory[row] = ls_category
		This.Object.funit_price[row] = ldec_unitprice
		This.Object.t_products_fdescription[row] = ls_description
		This.Object.fproname[row] = ls_ProName
	Case	"fproname"
		
		//filled with category and name
		SELECT top 1 fcategory,funit_price,fsku,fdescription
			INTO :ls_category,:ldec_unitprice,:ls_Sku,:ls_description
			FROM t_products
			Where fproname = :Data;
			
		If sqlca.SQLCode <> 0 Then
			MessageBox("Alert","The Product Name does not exist.")
			Return 1
		End If
		
		This.Object.t_products_fcategory[row] = ls_category
		This.Object.funit_price[row] = ldec_unitprice
		This.Object.t_products_fdescription[row] = ls_description
		This.Object.fsku[row] = ls_sku
End Choose

ib_changed = True
cb_save.Enabled = True

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
cb_save.enabled = TRUE
end event

