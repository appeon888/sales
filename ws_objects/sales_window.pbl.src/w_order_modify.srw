﻿$PBExportHeader$w_order_modify.srw
$PBExportComments$Modify Order from orderno
forward
global type w_order_modify from window
end type
type p_2 from picture within w_order_modify
end type
type p_3 from picture within w_order_modify
end type
type p_1 from picture within w_order_modify
end type
type p_bar_customer_r from picture within w_order_modify
end type
type p_product from picture within w_order_modify
end type
type p_order from picture within w_order_modify
end type
type cb_3 from commandbutton within w_order_modify
end type
type cb_2 from commandbutton within w_order_modify
end type
type cb_close from commandbutton within w_order_modify
end type
type cb_save from commandbutton within w_order_modify
end type
type dw_cust_product from datawindow within w_order_modify
end type
type dw_cust_order from datawindow within w_order_modify
end type
end forward

global type w_order_modify from window
integer width = 3200
integer height = 1872
boolean titlebar = true
string title = "Modify Order"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
event ue_postopen ( )
event type integer ue_save ( )
event ue_addproduct ( )
event ue_addorder ( )
event ue_refreshproduct ( )
event ue_refreshorder ( )
p_2 p_2
p_3 p_3
p_1 p_1
p_bar_customer_r p_bar_customer_r
p_product p_product
p_order p_order
cb_3 cb_3
cb_2 cb_2
cb_close cb_close
cb_save cb_save
dw_cust_product dw_cust_product
dw_cust_order dw_cust_order
end type
global w_order_modify w_order_modify

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

string		is_OrgCustNo,is_custNo		//customer NO
string		is_orderNO		//customer Order NO
long			il_lineID		//lineID

string  		is_CustFilter,is_SKU

// Determine if data has been changed
boolean   ib_changed
end variables

forward prototypes
public function string wf_get_orderno (string as_custno)
public function integer wf_calc_amount ()
end prototypes

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

Integer		li_Row,ll_rowcount,li_LineID,li_ValidCount
String  ls_sku
dwitemstatus    ldws
Dec   ldc_Qty

If Not ib_changed  Then Return 0
dw_cust_order.AcceptText()
dw_cust_product.AcceptText()

If dw_cust_product.RowCount() < 1 Then
	MessageBox("Warning",'Please enter product information for the order.',exclamation!)
	Return -1
End If

If is_OrderNo = '' Or is_CustNo = '' Then
	MessageBox('Alert','Please enter Customer ID and Order ID.')
	Return -1
End If

ll_rowcount = dw_cust_product.RowCount()
//get max lineId
SELECT isnull(MAX(flineid),0) INTO :li_LineID
	FROM t_orders_items
	Where forderNo = :is_OrderNo;
If IsNull(li_LineID) Or li_LineID < 1 Then
	li_LineID = 0
End If

For li_Row = 1 To ll_rowcount Step 1
	ldws = dw_cust_product.GetItemStatus(li_Row,0,Primary!)
	If ldws = new! Then Continue
	li_ValidCount ++
	If ldws = notmodified!  Then Continue
	
	ls_sku =  Trim(dw_cust_product.Object.fsku[li_Row])
	If IsNull(ls_sku) Or ls_sku = '' Then
		dw_cust_product.ScrollToRow(li_Row)
		MessageBox('Alert','Please enter SKU.')
		Return -1
	End If
	
	
	ldc_Qty =  dw_cust_product.Object.fquantity[li_Row]
	If IsNull(ldc_Qty) Or ldc_Qty <= 0 Then
		dw_cust_product.ScrollToRow(li_Row)
		MessageBox('Alert','Please enter a valid quantity.')
		Return -1
	End If
	li_LineID++
	dw_cust_product.Object.forderNo[li_Row] = is_OrderNo
	dw_cust_product.Object.flineid[li_Row] = li_LineID
Next

If li_ValidCount < 1 Then
	MessageBox("Warning",'Please enter product information for the order. ',exclamation!)
	Return -1
End If


If dw_cust_order.UPDATE(True,False) = 1 Then
	If dw_cust_product.UPDATE(True,False) = 1 Then
		COMMIT;
		ib_changed = False
		cb_save.Enabled = False
		dw_cust_order.ResetUpdate()
		dw_cust_product.ResetUpdate()
//		Return 1
	Else
		//		ls_error = sqlca.sqlerrtext
		ROLLBACK;
		MessageBox("Warning","Failed to save the changes.",exclamation!)
		Return -1
	End If
Else
	//	ls_error = sqlca.sqlerrtext
	ROLLBACK;
	MessageBox("Warning","Failed to save the changes.",exclamation!)
	Return -1
End If

//同步
IF isvalid(w_order_main) AND is_OrgCustNo = is_CustNo THEN
	w_order_main.event ue_refreshorder()
END IF

Return 1

end event

event ue_addproduct();//====================================================================
// Event: ue_addproduct()
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

//ue_addproduct

//w_cust_product_edit		lwin_product_edit
str_general		lstr_parm

//save order main info
dwitemstatus ldws
Int  li_Row

li_Row = dw_cust_order.GetRow()
If li_Row < 1 Then Return
ldws = dw_cust_order.GetItemStatus(li_Row,0,Primary!)

lstr_parm.faction = "modify!"
lstr_parm.fcustno = is_custNo
lstr_parm.forderNo = is_orderNo

OpenWithParm(w_cust_product_edit,lstr_parm)




end event

event ue_addorder();//====================================================================
// Event: ue_addorder()
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

Long		ll_row,ll_i,li_Max
dwitemstatus ldws

ll_i = dw_cust_order.GetRow()
If ll_i > 0  Then
	ldws = dw_cust_order.GetItemStatus(ll_i,0,Primary!)
	If ldws = NewModified!  Then
		MessageBox("Alert","Please save order first.")
		Return
	End If
End If
dw_cust_order.DataObject = 'd_order_cust_new'
dw_cust_order.SetTransObject(SQLCA)
ll_row = dw_cust_order.InsertRow(0)
dw_cust_order.ScrollToRow(ll_row)
dw_cust_product.Reset()

//get max customer order NO
If is_custNo <> '' Then
	is_orderNo = wf_get_orderno(is_custNo)
	//ini datawindow
	dw_cust_order.Object.forderNo[ll_row] = is_orderNo
	dw_cust_order.Object.fcustNo[ll_row] = is_custNo
End If
dw_cust_order.Object.fstatus[ll_row] = "1"
dw_cust_order.Object.forderdate[ll_row] = Today()
dw_cust_order.Object.fpaid[ll_row] = "0"
dw_cust_order.Object.ftype[ll_row] = "Internet"
dw_cust_order.Object.famount[ll_row] = 0
//dw_cust_order.setItemStatus(ll_row,0,Primary!,NotModified!)

dw_cust_order.SetFocus()



end event

event ue_refreshproduct();//====================================================================
// Event: ue_refreshproduct()
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

dw_cust_product.event ue_retrieve()
end event

event ue_refreshorder();//====================================================================
// Event: ue_refreshorder()
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

dw_cust_order.event ue_retrieve()
end event

public function string wf_get_orderno (string as_custno);//====================================================================
// Function: wf_get_orderno()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_custno		
//--------------------------------------------------------------------
// Returns: string
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

string  ls_OrderNo
int li_Max

select max(convert(integer,right(forderNo,2)))+1
//select max(to_int(right(forderNo,2)))+1
	into :li_Max
	from t_orders
		where fcustNo = :as_custNo;
IF isnull(li_Max) or li_Max <=0 THEN li_Max = 1
ls_OrderNo = string(li_Max,'00')
ls_orderNo = as_custNo + ls_orderNo 

return ls_OrderNo
end function

public function integer wf_calc_amount ();//====================================================================
// Function: wf_calc_amount()
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

integer li_Order,li_Row
dec  ldc_Amount,ldc_Total

li_Order = dw_cust_order.getrow()
IF li_Order < 1 THEN return -1
IF dw_cust_product.accepttext()< 0 THEN return -1
FOR li_Row = 1 TO dw_cust_product.rowcount()
	ldc_Amount =dw_cust_product.getitemdecimal(li_Row,'FAmount')
	IF isnull(ldc_Amount) THEN ldc_Amount = 0
	ldc_Total +=ldc_Amount
NEXT
dw_cust_order.setitem(li_Order,'FAmount',ldc_Total)
return 1
end function

on w_order_modify.create
this.p_2=create p_2
this.p_3=create p_3
this.p_1=create p_1
this.p_bar_customer_r=create p_bar_customer_r
this.p_product=create p_product
this.p_order=create p_order
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_cust_product=create dw_cust_product
this.dw_cust_order=create dw_cust_order
this.Control[]={this.p_2,&
this.p_3,&
this.p_1,&
this.p_bar_customer_r,&
this.p_product,&
this.p_order,&
this.cb_3,&
this.cb_2,&
this.cb_close,&
this.cb_save,&
this.dw_cust_product,&
this.dw_cust_order}
end on

on w_order_modify.destroy
destroy(this.p_2)
destroy(this.p_3)
destroy(this.p_1)
destroy(this.p_bar_customer_r)
destroy(this.p_product)
destroy(this.p_order)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_cust_product)
destroy(this.dw_cust_order)
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


If Not IsNull(Message.PowerObjectParm) And TypeOf(Message.PowerObjectParm) = TypeOf(istr_parm) Then
	istr_parm = Message.PowerObjectParm
End If

dw_cust_order.SetTransObject(sqlca)
dw_cust_product.SetTransObject(sqlca)
is_CustNo = istr_parm.FCustNo
is_OrderNo = istr_parm.FOrderNo
is_OrgCustNo = is_CustNo

dw_cust_order.Retrieve(is_OrderNo)
dw_cust_product.Retrieve(is_CustNo,is_OrderNo)


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
	li_rc = MessageBox ("Save Data", "Save changes to Customer Order before closing?", question!, yesnocancel!)	
	
	// Yes
	if li_rc = 1 then
		IF this.TriggerEvent ("ue_save") < 0 THEN
			return 1
		end if
	elseif li_rc = 3 then
		return 1
	end if
end if

return 0

end event

type p_2 from picture within w_order_modify
integer x = 2953
integer y = 692
integer width = 192
integer height = 120
boolean bringtotop = true
string picturename = ".\picture\titlebar_r.jpg"
boolean focusrectangle = false
end type

type p_3 from picture within w_order_modify
integer x = 2670
integer y = 692
integer width = 425
integer height = 120
string picturename = ".\picture\titlebar_m.jpg"
boolean focusrectangle = false
end type

type p_1 from picture within w_order_modify
integer x = 2670
integer y = 12
integer width = 425
integer height = 120
string picturename = ".\picture\titlebar_m.jpg"
boolean focusrectangle = false
end type

type p_bar_customer_r from picture within w_order_modify
integer x = 2953
integer y = 12
integer width = 192
integer height = 120
boolean bringtotop = true
string picturename = ".\picture\titlebar_r.jpg"
boolean focusrectangle = false
end type

type p_product from picture within w_order_modify
integer x = 32
integer y = 692
integer width = 2743
integer height = 120
string picturename = ".\picture\Product-Detail600-2.jpg"
boolean focusrectangle = false
end type

type p_order from picture within w_order_modify
integer x = 32
integer y = 12
integer width = 2743
integer height = 120
boolean originalsize = true
string picturename = ".\picture\Order-Information2.jpg"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_order_modify
integer x = 521
integer y = 1628
integer width = 453
integer height = 120
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Remove Item"
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

dw_cust_product.deleterow(0)
wf_calc_amount()

cb_save.enabled = TRUE
ib_changed = TRUE
end event

type cb_2 from commandbutton within w_order_modify
integer x = 37
integer y = 1628
integer width = 453
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add Item"
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

int  li_Row

li_Row = dw_cust_product.insertrow(0)
dw_cust_product.scrolltorow(li_Row)

end event

type cb_close from commandbutton within w_order_modify
integer x = 2697
integer y = 1640
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

type cb_save from commandbutton within w_order_modify
integer x = 2208
integer y = 1640
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

IF parent.event ue_save() < 1 THEN return

end event

type dw_cust_product from datawindow within w_order_modify
event type long ue_retrieve ( )
integer x = 32
integer y = 808
integer width = 3113
integer height = 800
integer taborder = 30
string title = "none"
string dataobject = "d_product_order_new"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type long ue_retrieve();//====================================================================
// Event: ue_retrieve()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Return This.Retrieve(is_custNo,is_orderNo)
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

String	ls_category,ls_description,ls_sku,ls_ProdName
Dec		ldec_unitprice

ib_Changed = True
cb_save.Enabled = True
Choose	Case	Lower(dwo.Name)
	Case	"funit_price"
		If Dec(Data) < 0 Then Return 1
		//cal amount
		This.Object.famount[row] = This.Object.fquantity[row] * Dec(Data)
		wf_calc_amount()
	Case	"fquantity"
		If Dec(Data) <= 0 Then Return 1
		//cal amount
		This.Object.famount[row] = This.Object.funit_price[row] * Dec(Data)
		wf_calc_amount()
	Case	"fsku"
		//filled with category and name
		SELECT fcategory,fproname,funit_price,fdescription
			INTO :ls_category,:ls_ProdName,:ldec_unitprice,:ls_description
			FROM t_products
			Where fsku = :Data;
			
		If sqlca.SQLCode <> 0 Then
			MessageBox("Alert","The SKU does not exist!")
			Return 1
		End If
		This.Object.fcategory[row] = ls_category
		This.Object.fproname[row] = ls_ProdName
		This.Object.funit_price[row] = ldec_unitprice
		This.Object.fdescription[row] = ls_description
		This.Object.famount[row] = ldec_unitprice*This.Object.fquantity[row]
		wf_calc_amount()
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
		
		This.Object.fcategory[row] = ls_category
		This.Object.funit_price[row] = ldec_unitprice
		This.Object.fdescription[row] = ls_description
		This.Object.fsku[row] = ls_sku
		This.Object.famount[row] = ldec_unitprice*This.Object.fquantity[row]
		wf_calc_amount()
End Choose

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

type dw_cust_order from datawindow within w_order_modify
event type long ue_retrieve ( )
integer x = 32
integer y = 128
integer width = 3113
integer height = 560
integer taborder = 10
string title = "New Order "
string dataobject = "d_order_cust_modify"
borderstyle borderstyle = stylelowered!
end type

event type long ue_retrieve();//====================================================================
// Event: ue_retrieve()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//ue_retrieve
long		ll_row 

This.Retrieve(is_custNo)
ll_row = This.Find("forderNo = '"+ is_orderNO +"'",1,This.rowcount())

If ll_row > 0 Then
	This.event rowfocuschanged(ll_row)
End If

Return ll_row
end event

event editchanged;//====================================================================
// Event: editchanged()
//--------------------------------------------------------------------
// Description:  Update instance variable indicating that data in the DataWindow has changed.
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

Integer  li_Count
String ls_OrderNo

ib_changed = True
cb_save.Enabled = True

Choose Case Lower(dwo.Name)
	Case 'fcustno'
		SELECT Count(*) Into :li_Count From t_customers Where fcustno = :Data;
		If li_Count < 1 Then
			MessageBox('Alert','The customer does not exist.')
			Return 1
		End If
		
		ls_OrderNo = 	wf_get_orderno(Data)
		is_CustNo = Data
		is_orderNo = ls_OrderNo
		
		//ini datawindow
		dw_cust_order.Object.forderNo[row] = ls_OrderNo
		dw_cust_order.Object.fcustno[row] = is_CustNo
End Choose



end event

