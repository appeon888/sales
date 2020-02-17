$PBExportHeader$w_order_main.srw
forward
global type w_order_main from w_sheet
end type
type p_3 from picture within w_order_main
end type
type p_2 from picture within w_order_main
end type
type p_1 from picture within w_order_main
end type
type cb_4 from commandbutton within w_order_main
end type
type cb_3 from commandbutton within w_order_main
end type
type cb_close from commandbutton within w_order_main
end type
type mle_filter1 from multilineedit within w_order_main
end type
type cb_5 from commandbutton within w_order_main
end type
type cb_1 from commandbutton within w_order_main
end type
type cb_show from commandbutton within w_order_main
end type
type cb_filter from commandbutton within w_order_main
end type
type cb_sort from commandbutton within w_order_main
end type
type dw_cust_product from datawindow within w_order_main
end type
type dw_cust_order from datawindow within w_order_main
end type
type dw_cust from u_dw within w_order_main
end type
end forward

global type w_order_main from w_sheet
integer width = 4370
integer height = 2124
string title = "Order Maintenance"
long backcolor = 32039904
event ue_postopen ( )
event ue_deleteorder ( )
event ue_deleteproduct ( )
event ue_addproduct ( )
event ue_addorder ( )
event type integer ue_saveorder ( )
event ue_saveproduct ( )
event ue_refreshorder ( )
event ue_refreshproduct ( )
event ue_modifyproduct ( )
event ue_setfilter ( string as_custfilter,  string as_orderfilter,  string as_productfilter )
event ue_showall ( string as_type )
p_3 p_3
p_2 p_2
p_1 p_1
cb_4 cb_4
cb_3 cb_3
cb_close cb_close
mle_filter1 mle_filter1
cb_5 cb_5
cb_1 cb_1
cb_show cb_show
cb_filter cb_filter
cb_sort cb_sort
dw_cust_product dw_cust_product
dw_cust_order dw_cust_order
dw_cust dw_cust
end type
global w_order_main w_order_main

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

string		is_custNo		//customer NO
string		is_orderNO		//customer Order NO
long			il_lineID		//lineID

string  		is_SKU,is_CustFilter,is_OrderFilter,is_ProductFilter
// Determine if data has been changed
boolean   ib_changed
string  is_FilterType
end variables

event ue_postopen();//====================================================================
// Event: ue_postopen()
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

//ue_postopen
Long		ll_row

dw_cust.Object.datawindow.Readonly = True
dw_cust_order.Object.datawindow.Readonly = True
dw_cust_product.Object.datawindow.Readonly = True

dw_cust.Retrieve()

If is_custNo <> "" And Not IsNull(is_custNo) Then
	ll_row = dw_cust.Find("fcustno = '" + is_custNo+"'",1,dw_cust.RowCount())
	If ll_row > 0 Then
		dw_cust.ScrollToRow(ll_row)
	End If
End If

end event

event ue_deleteorder();//====================================================================
// Event: ue_deleteorder()
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

//ue_deleteorder
Int	li_Ans
Long	ll_i,ll_row
nvo_util  lnv_util
String  ls_CustNo
String ls_OrderNo

ll_Row = dw_cust_order.GetRow()
If ll_Row < 1  Then Return
ls_CustNo = dw_cust_order.GetItemString(ll_Row,'FCustNo')
ls_OrderNo = dw_cust_order.GetItemString(ll_Row,'FOrderNo')
If ls_CustNo = '' Or IsNull(ls_CustNo) Or ls_OrderNo = '' Or IsNull(ls_OrderNo)Then Return

li_Ans = MessageBox("Delete","Are you sure you want to delete the order " + lnv_util.of_parse_orderno(is_orderNo) + "?" ,&
	Question!,YesNo!)
If li_Ans <> 1 Then Return
//delete customer Order
//firstly delete order item detail
dw_cust_product.Reset()
DELETE From t_orders_items Where forderno = :is_orderNo;


//delete order information
dw_cust_order.DeleteRow(0)
This.Event ue_saveorder()
dw_cust_order.Event RowFocusChanged(dw_cust_order.GetRow())
end event

event ue_deleteproduct();//====================================================================
// Event: ue_deleteproduct()
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

//ue_deleteproduct
Int	li_Ans

If dw_cust_product.RowCount() = 0 Then
	Return
End If

li_Ans = MessageBox("Delete","Are you sure you want to delete the product " + is_SKU + "?" ,&
	Question!,YesNo!)

Choose	Case li_Ans
	Case	1
		//delete order prodcut information
		dw_cust_product.DeleteRow(0)
		
		//auto update customer payment due
		
	Case	2
		Return
End Choose

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
w_cust_product_edit		lwin_product_edit
str_general		lstr_parm

//save order main info
dwitemstatus ldws
Int  li_Row

li_Row = dw_cust_order.GetRow()
If li_Row < 1 Then Return
ldws = dw_cust_order.GetItemStatus(li_Row,0,Primary!)
If ldws = New!  Then
	MessageBox("Alert","Please save the order first.")
	Return
End If
If This.Event ue_saveorder() < 0 Then Return

lstr_parm.faction = "new!"
lstr_parm.fcustno = is_custNo
lstr_parm.forderNo = is_orderNo

OpenWithParm(lwin_product_edit,lstr_parm)




end event

event ue_addorder();//====================================================================
// Event: ue_addorder()
//--------------------------------------------------------------------
// Description: add customer order info
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

//w_order_new		lwin_order_new
str_general		lstr_parm

lstr_parm.faction = "new!"
lstr_parm.fcustno = is_custNo
lstr_parm.forderNo = is_orderNo

if isvalid(w_order_new) then return	
opensheetwithParm(w_order_new ,lstr_parm, w_mdi, 0 , Original! )

//refresh order information
//This.event ue_refreshOrder()

end event

event type integer ue_saveorder();//====================================================================
// Event: ue_saveorder()
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

//ue_saveorder
string		ls_error

If dw_cust_order.Update(true,false) = 1 Then
	If dw_cust_product.Update(true,false) = 1 Then
		commit;
		dw_cust_order.resetupdate()
		dw_cust_product.resetupdate()
		ib_changed = False
		return 1
	Else
		ls_error = sqlca.sqlerrtext
		rollback;
		Messagebox("Warning",'Failed to save the changes.',exclamation!)
		Return -1
	End If
Else
	ls_error = sqlca.sqlerrtext
	rollback;
	Messagebox("Warning",'Failed to save the changes.',exclamation!)
	Return -1
End IF
end event

event ue_saveproduct();//====================================================================
// Event: ue_saveproduct()
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

//ue_saveproduct
string		ls_error

IF dw_cust_product.rowcount() < 1 THEN
	messagebox("Warning",'Please enter product information for the order. ',exclamation!)
	return
END IF
If dw_cust_product.Update() = 1 Then
	commit;
	ib_changed = False
	//refresh order & product item
	This.event ue_refreshOrder()
	This.event ue_refreshProduct()
Else
	ls_error = sqlca.sqlerrtext
	rollback;
	Messagebox("Warning",'Failed to save the changes.',exclamation!)
	Return
End IF
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

string		ls_orderNo
long			ll_row,ll_rowcount


ls_orderNo = is_orderNO
ll_rowcount = dw_cust_order.event ue_retrieve()

if len(ls_orderno) <=0 then
	ls_orderno = is_orderno
end if

ll_row = dw_cust_order.find("forderNo = '"+ ls_orderNo +"'",1,ll_rowcount)

If ll_row > 0 Then
	dw_cust_order.event rowfocuschanged(ll_row)
	dw_cust_order.ScrollToRow ( ll_row )
End If
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

event ue_modifyproduct();//====================================================================
// Event: ue_modifyproduct()
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

//ue_modifyproduct
w_cust_product_edit		lwin_product_edit
str_general		lstr_parm

lstr_parm.faction = "modify!"
lstr_parm.fcustno = is_custNo
lstr_parm.forderNo = is_orderNo
lstr_parm.flineID = il_lineID

openwithParm(lwin_product_edit,lstr_parm)



end event

event ue_setfilter(string as_custfilter, string as_orderfilter, string as_productfilter);//====================================================================
// Event: ue_setfilter()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_custfilter   		
//		value	string	as_orderfilter  		
//		value	string	as_productfilter		
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

int  li_Row
string  lS_No1,ls_No2

IF is_FilterType = 'customer' THEN
	is_CustFilter = as_CustFilter
ELSE
	is_OrderFilter = as_OrderFilter
END IF

//IF as_CustFilter <>'' THEN //coment by liulihua for filter all data
	li_Row = dw_cust.getrow()
	IF li_Row > 0 THEN
		ls_No1 = dw_cust.getitemstring(li_Row,'fcustno')
	END IF
	dw_cust.SetFilter(as_CustFilter)
	dw_cust.filter()

	//After set filter,must refresh order data and cust detail info
	li_Row = dw_cust.getrow()
	IF li_Row > 0 THEN
		ls_No2 = dw_cust.getitemstring(li_Row,'fcustno')
	END IF
	IF ls_No1 <> ls_No2 THEN
		dw_cust.selectrow(li_Row,true)
		dw_cust.event rowfocuschanged(li_Row)
	END IF

	mle_filter1.text = string(dw_cust.rowcount())+" matches."
	IF dw_cust.rowcount() < 1 THEN
		dw_cust_order.reset()
		dw_cust_product.reset()
		return
	END IF
//END IF
IF as_OrderFilter <>'' THEN 
	li_Row = dw_cust_order.getrow()
	IF li_Row > 0 THEN
		ls_No1 = dw_cust_order.getitemstring(li_Row,'forderno')
	END IF
	dw_cust_order.SetFilter(as_OrderFilter)
	dw_cust_order.filter()
//	IF mle_filter1.text = '' THEN
//		mle_filter1.text =string(dw_cust_order.rowcount())+" matches."
//	END IF
	//After set filter,must refresh order data and cust detail info
	li_Row = dw_cust_order.getrow()
	IF li_Row > 0 THEN
		ls_No2 = dw_cust_order.getitemstring(li_Row,'forderno')
	END IF
	IF ls_No1 <> ls_No2 THEN
		dw_cust_order.event rowfocuschanged(li_Row)
	END IF

	IF dw_cust_order.rowcount() < 1 THEN
		dw_cust_product.reset()
		return
	END IF
END IF

end event

event ue_showall(string as_type);//====================================================================
// Event: ue_showall()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_type		
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

//reset filter criteria
String		ls_custNo1,ls_custNo2
Long			ll_currentrow

If as_Type = 'customer' Then
	is_CustFilter = ""
	mle_filter1.Text = ""
	ll_currentrow = dw_cust.GetRow()
	If ll_currentrow > 0 Then
		ls_custNo1 = dw_cust.Object.fcustNo[ll_currentrow]
	End If
	
	dw_cust.SetFilter(is_CustFilter)
	dw_cust.Filter( )
	ll_currentrow = dw_cust.GetRow()
	If ll_currentrow > 0 Then
		ls_custNo2 = dw_cust.Object.fcustNo[ll_currentrow]
	End If
	
	If ls_custNo1 <> ls_custNo2 Then
		//rowfocuschanged
		dw_cust.Event RowFocusChanged(dw_cust.GetRow())
	End If
Else
	is_OrderFilter = ""
	ll_currentrow = dw_cust_order.GetRow()
	If ll_currentrow > 0 Then
		ls_custNo1 = dw_cust_order.Object.forderNo[ll_currentrow]
	End If
	
	dw_cust_order.SetFilter(is_OrderFilter)
	dw_cust_order.Filter( )
	ll_currentrow = dw_cust_order.GetRow()
	If ll_currentrow > 0 Then
		ls_custNo2 = dw_cust_order.Object.forderNo[ll_currentrow]
	End If
End If








end event

on w_order_main.create
int iCurrent
call super::create
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_close=create cb_close
this.mle_filter1=create mle_filter1
this.cb_5=create cb_5
this.cb_1=create cb_1
this.cb_show=create cb_show
this.cb_filter=create cb_filter
this.cb_sort=create cb_sort
this.dw_cust_product=create dw_cust_product
this.dw_cust_order=create dw_cust_order
this.dw_cust=create dw_cust
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_3
this.Control[iCurrent+2]=this.p_2
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.mle_filter1
this.Control[iCurrent+8]=this.cb_5
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.cb_show
this.Control[iCurrent+11]=this.cb_filter
this.Control[iCurrent+12]=this.cb_sort
this.Control[iCurrent+13]=this.dw_cust_product
this.Control[iCurrent+14]=this.dw_cust_order
this.Control[iCurrent+15]=this.dw_cust
end on

on w_order_main.destroy
call super::destroy
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_close)
destroy(this.mle_filter1)
destroy(this.cb_5)
destroy(this.cb_1)
destroy(this.cb_show)
destroy(this.cb_filter)
destroy(this.cb_sort)
destroy(this.dw_cust_product)
destroy(this.dw_cust_order)
destroy(this.dw_cust)
end on

event open;call super::open;//====================================================================
// Event: open()
//--------------------------------------------------------------------
// Description: Open script for w_order_main
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
x =0
y =0

//get message parm
If Message.StringParm <> "" And Not IsNull(Message.StringParm) Then
	is_custNo = Message.StringParm
End If

dw_cust.SetTransObject(sqlca)
dw_cust_order.SetTransObject(sqlca)
dw_cust_product.SetTransObject(sqlca)

This.Post Event ue_postopen()

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
	li_rc = MessageBox ("Save Data", "Save changes to Customer Order before closing?", question!, yesnocancel!)
	
	// Yes
	If li_rc = 1 Then
		This.Event ue_saveproduct()
		If ib_changed Then
			Return  1
		End If
	Else
		// Cancel
		If li_rc = 3 Then
			Return  1
		End If
	End If
End If

Return 0


end event

type p_3 from picture within w_order_main
integer x = 1536
integer y = 840
integer width = 2743
integer height = 120
boolean originalsize = true
string picturename = ".\picture\Product-Detail600-2.jpg"
boolean focusrectangle = false
end type

type p_2 from picture within w_order_main
integer x = 1545
integer y = 24
integer width = 2743
integer height = 120
boolean originalsize = true
string picturename = ".\picture\Order-Information2.jpg"
boolean focusrectangle = false
end type

type p_1 from picture within w_order_main
integer x = 32
integer y = 20
integer width = 1486
integer height = 120
boolean originalsize = true
string picturename = ".\picture\Selectacustomer.jpg"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_order_main
integer x = 3753
integer y = 548
integer width = 453
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "View"
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

string  ls_CustNo,ls_OrderNo
int li_Row

li_Row = dw_cust_order.getrow()
IF li_Row <1  THEN return
ls_CustNo = dw_cust_order.getitemstring(li_Row,'FCustNo')
ls_OrderNo = dw_cust_order.getitemstring(li_Row,'FOrderNo')
IF ls_CustNo = '' or isnull(ls_CustNo) OR ls_OrderNo = '' or isnull(ls_orderNo)THEN return

openwithparm(w_order_detail_print, ls_custno + '$' + ls_orderno)
end event

type cb_3 from commandbutton within w_order_main
integer x = 3753
integer y = 428
integer width = 453
integer height = 104
integer taborder = 20
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
// Description: add customer order info 
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

str_general		lstr_parm
String  ls_CustNo,ls_OrderNo
Int li_Row

li_Row = dw_cust_order.GetRow()
If li_Row < 1  Then Return
ls_CustNo = dw_cust_order.GetItemString(li_Row,'FCustNo')
ls_OrderNo = dw_cust_order.GetItemString(li_Row,'FOrderNo')
lstr_parm.faction = "modify!"
lstr_parm.fcustno = ls_CustNo
lstr_parm.forderNo = ls_OrderNo
If ls_CustNo = '' Or IsNull(ls_CustNo) Or ls_OrderNo = '' Or IsNull(ls_OrderNo)Then Return


OpenWithParm(w_order_modify ,lstr_parm )


end event

type cb_close from commandbutton within w_order_main
integer x = 3817
integer y = 1868
integer width = 466
integer height = 124
integer taborder = 50
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

close(Parent)
end event

type mle_filter1 from multilineedit within w_order_main
integer x = 1006
integer y = 1884
integer width = 443
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711935
long backcolor = 32039904
boolean border = false
end type

type cb_5 from commandbutton within w_order_main
integer x = 3753
integer y = 308
integer width = 453
integer height = 104
integer taborder = 10
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

parent.event ue_deleteOrder()

end event

type cb_1 from commandbutton within w_order_main
integer x = 3753
integer y = 188
integer width = 453
integer height = 104
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "New"
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

parent.event ue_addOrder()
end event

type cb_show from commandbutton within w_order_main
boolean visible = false
integer x = 357
integer y = 1876
integer width = 306
integer height = 104
integer taborder = 30
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

parent.event ue_showall('customer')
end event

type cb_filter from commandbutton within w_order_main
boolean visible = false
integer x = 686
integer y = 1876
integer width = 306
integer height = 104
integer taborder = 30
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

is_FilterType = 'customer' 
openwithparm(w_set_filter_customer,'w_order_main')
end event

type cb_sort from commandbutton within w_order_main
boolean visible = false
integer x = 27
integer y = 1876
integer width = 306
integer height = 104
integer taborder = 30
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

//openwithparm(w_sort_single,dw_cust)

dw_cust.event ue_sort()
end event

type dw_cust_product from datawindow within w_order_main
event type long ue_retrieve ( )
integer x = 1541
integer y = 960
integer width = 2743
integer height = 884
integer taborder = 30
string title = "none"
string dataobject = "d_product_order_list"
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

If rowcount > 0 Then 
	This.event rowfocuschanged(1)
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

If currentRow = 0 Then 
	Return 
End If

This.selectRow(0,False)
This.selectRow(currentrow,true)

is_SKU = This.Object.fsku[currentrow]
il_lineID = This.Object.flineid[currentRow]
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

If row > 0 Then
	parent.event ue_modifyproduct()
End If
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
end event

type dw_cust_order from datawindow within w_order_main
event type long ue_retrieve ( )
integer x = 1541
integer y = 148
integer width = 2743
integer height = 692
integer taborder = 10
string title = "none"
string dataobject = "d_order_cust_list"
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
Return This.Retrieve(is_custNo)
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

If rowcount > 0 Then
	This.event rowFocusChanged(1)
Else 
	//reset order product item
	this.insertrow(0)
	dw_cust_product.reset()
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

string  ls_Status

currentrow = this.getrow()
If currentrow > 0  Then
	is_orderNo = This.getitemstring(currentRow,'forderNo')
	ls_Status = This.getitemstring(currentRow,'fstatus')
	dw_cust_product.event ue_retrieve()
END IF

IF ls_Status = '1' THEN
	cb_3.enabled = TRUE
	cb_5.enabled = TRUE
ELSE
	cb_3.enabled = FALSE
	cb_5.enabled = FALSE
END IF	
	
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
end event

type dw_cust from u_dw within w_order_main
integer x = 32
integer y = 140
integer width = 1486
integer height = 1704
integer taborder = 20
string dataobject = "d_cust_list_all"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrieveend;call super::retrieveend;//====================================================================
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

If rowcount > 0 Then
	This.event rowfocuschanged(1)
End If
end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
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

If currentRow > 0 Then 
	is_custNo = This.object.fcustNo[currentRow]
	dw_cust_order.event ue_retrieve()
End If


end event

