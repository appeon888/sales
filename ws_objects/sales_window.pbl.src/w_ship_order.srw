$PBExportHeader$w_ship_order.srw
forward
global type w_ship_order from w_sheet
end type
type mle_filter from multilineedit within w_ship_order
end type
type cb_2 from commandbutton within w_ship_order
end type
type dw_1 from datawindow within w_ship_order
end type
type cb_5 from commandbutton within w_ship_order
end type
type cb_4 from commandbutton within w_ship_order
end type
type cb_3 from commandbutton within w_ship_order
end type
type st_3 from statictext within w_ship_order
end type
type cb_1 from commandbutton within w_ship_order
end type
type cbx_2 from checkbox within w_ship_order
end type
type cbx_1 from checkbox within w_ship_order
end type
end forward

global type w_ship_order from w_sheet
integer width = 3497
integer height = 1892
string title = "Order Shipment"
long backcolor = 32039904
event ue_open ( )
event type integer ue_setfilter ( string as_custfilter,  string as_orderfilter,  string as_productfilter )
event ue_refresh ( )
mle_filter mle_filter
cb_2 cb_2
dw_1 dw_1
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
st_3 st_3
cb_1 cb_1
cbx_2 cbx_2
cbx_1 cbx_1
end type
global w_ship_order w_ship_order

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

string    is_last_col ,is_sort_type

end variables

forward prototypes
public function string wf_custfilter_replace (string as_custfilter)
public function string wf_orderfilter_replace (string as_orderfilter)
public subroutine wf_setflag ()
end prototypes

event type integer ue_setfilter(string as_custfilter, string as_orderfilter, string as_productfilter);//====================================================================
// Event: ue_setfilter()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_custfilter   		
//		value	string	as_orderfilter  		
//		value	string	as_productfilter		
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

string	ls_filter
nvo_util  lnv_util

IF as_CustFilter <>'' or as_orderfilter<>'' THEN
	ls_filter = f_combine_filter_string(as_custfilter,as_orderfilter)
	
	ls_filter = wf_custfilter_replace(ls_filter)
	ls_filter = wf_orderfilter_replace(ls_filter)
	
	dw_1.SetFilter(ls_filter)
	dw_1.filter()

	mle_filter.text = string(dw_1.rowcount())+" matches."
END IF

return 1
end event

event ue_refresh();//====================================================================
// Event: ue_refresh()
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

dw_1.retrieve('3') //order status <'3': ready for ship>

dw_1.event rowfocuschanged(dw_1.getrow())

cb_1.enabled = (dw_1.rowcount() > 0)

end event

public function string wf_custfilter_replace (string as_custfilter);//====================================================================
// Function: wf_custfilter_replace()
//--------------------------------------------------------------------
// Description: Add the table name on the head of the column.
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_custfilter		
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

as_custfilter = f_replace_all(as_custfilter,'fcustno','t_customers_fcustno')
as_custfilter = f_replace_all(as_custfilter,'flastname','t_customers_flastname')
as_custfilter = f_replace_all(as_custfilter,'ffirstname','t_customers_ffirstname')
as_custfilter = f_replace_all(as_custfilter,'fcity','t_customers_fcity')
as_custfilter = f_replace_all(as_custfilter,'fstate','t_customers_fstate')
as_custfilter = f_replace_all(as_custfilter,'fcountry','t_customers_fcountry')
as_custfilter = f_replace_all(as_custfilter,'fm','t_customers_fm')
as_custfilter = f_replace_all(as_custfilter,'fpaymentdue','t_customers_fpaymentdue')

return as_custfilter


end function

public function string wf_orderfilter_replace (string as_orderfilter);//====================================================================
// Function: wf_orderfilter_replace()
//--------------------------------------------------------------------
// Description: Add the table name on the head of the column.
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_orderfilter		
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

as_orderfilter = f_replace_all(as_orderfilter,'forderno','t_orders_forderno')
as_orderfilter = f_replace_all(as_orderfilter,'fstatus','t_orders_fstatus')
as_orderfilter = f_replace_all(as_orderfilter,'ftype','t_orders_ftype')
as_orderfilter = f_replace_all(as_orderfilter,'famount','t_orders_famount')
as_orderfilter = f_replace_all(as_orderfilter,'fpaid','t_orders_fpaid')

return as_orderfilter
end function

public subroutine wf_setflag ();ieon_resize.of_setflag(cb_2,"2200")
ieon_resize.of_setflag(cb_1,"2200")
end subroutine

on w_ship_order.create
int iCurrent
call super::create
this.mle_filter=create mle_filter
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.st_3=create st_3
this.cb_1=create cb_1
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_filter
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_5
this.Control[iCurrent+5]=this.cb_4
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cbx_2
this.Control[iCurrent+10]=this.cbx_1
end on

on w_ship_order.destroy
call super::destroy
destroy(this.mle_filter)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.cbx_2)
destroy(this.cbx_1)
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

dw_1.settransobject(sqlca)
this.event ue_refresh()
end event

event resize;call super::resize;ieon_resize.of_resize(this,newwidth,newheight,true) //add by liuilhua
end event

type mle_filter from multilineedit within w_ship_order
boolean visible = false
integer x = 1312
integer y = 1656
integer width = 475
integer height = 76
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
end type

type cb_2 from commandbutton within w_ship_order
integer x = 2971
integer y = 1628
integer width = 448
integer height = 120
integer taborder = 80
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

type dw_1 from datawindow within w_ship_order
event ue_update ( )
event ue_setenabled ( )
integer x = 37
integer y = 124
integer width = 3392
integer height = 1472
integer taborder = 10
string title = "none"
string dataobject = "d_order_status"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//====================================================================
// Event: clicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	integer 	xpos		
//		value	integer 	ypos		
//		value	long    	row 		
//		value	dwobject	dwo 		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnlbuttonclk]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

String  	ls_ret
Integer	li_pos

//the following  code   implement  the sort  function by  clicking  column head
ls_ret = f_sort_by_head(This, dwo.Name,is_last_col,is_sort_type)
If ls_ret <> '' Then
	li_pos = Pos(ls_ret,'$')
	is_last_col = Left(ls_ret,li_pos - 1)
	is_sort_type = Mid(ls_ret,li_pos + 1)
End If

If  row <= 0 Then Return

SelectRow(0,False)
SelectRow(row,True)

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

String   ls_custno,ls_orderno

If row <= 0 Then  Return

ls_custno  = This.GetItemString(row,'t_customers_fcustno')
ls_orderno = This.GetItemString(row,'t_orders_forderno')
OpenWithParm(w_order_detail, ls_custno + '$' + ls_orderno)

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
	selectrow(0,false)
	selectrow(currentrow,true)
END IF
end event

type cb_5 from commandbutton within w_ship_order
boolean visible = false
integer x = 471
integer y = 1628
integer width = 402
integer height = 120
integer taborder = 40
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

dw_1.SetFilter("")
dw_1.Filter()
mle_filter.Text =  ''
dw_1.Event RowFocusChanged(dw_1.GetRow())

end event

type cb_4 from commandbutton within w_ship_order
boolean visible = false
integer x = 896
integer y = 1628
integer width = 402
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

openwithparm(w_set_filter_cust_order,'w_ship_order')
end event

type cb_3 from commandbutton within w_ship_order
boolean visible = false
integer x = 37
integer y = 1628
integer width = 402
integer height = 120
integer taborder = 20
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

openwithparm(w_sort_single,dw_1)
end event

type st_3 from statictext within w_ship_order
integer x = 37
integer y = 36
integer width = 1399
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Show orders with status: Ready for Shipment"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_ship_order
integer x = 2491
integer y = 1628
integer width = 448
integer height = 120
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Ship"
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

Integer    li_Row ,li_Count,li_Ret
String      ls_check,ls_orderno,ls_Error

li_Row  = dw_1.GetRow()
If li_Row < 1 Then Return

ls_orderno  = dw_1.GetItemString(li_Row,'t_orders_forderno')
UPDATE t_orders  Set fstatus = '4' ,fship_date = getdate() Where  forderno = :ls_orderno;
If sqlca.SQLCode  < 0 Then
	ls_Error = sqlca.SQLErrText
	ROLLBACK;
	MessageBox('Warning','Failed to save the order status.~r~n'+ls_Error,exclamation!)
	Return
End If
UPDATE t_orders_items  Set fship_date = getdate() Where  forderno = :ls_orderno;
If sqlca.SQLCode  < 0 Then
	ls_Error = sqlca.SQLErrText
	ROLLBACK;
	MessageBox('Warning','Failed to save the order status.~r~n'+ls_Error,exclamation!)
	Return
End If

COMMIT ;

dw_1.RowsDiscard(li_Row,li_Row,primary!)

This.Enabled = (dw_1.RowCount() > 0)

li_Row = dw_1.GetRow()
dw_1.SelectRow(0,False)
dw_1.SelectRow(li_Row,True)

If cbx_1.Checked And cbx_2.Checked Then
	li_Ret = MessageBox('Order Shipment','The status of the checked order is now Shipped.~r~nDo you want to print packing slip and address label?',question!,yesno!)
ElseIf cbx_1.Checked Then
	li_Ret = MessageBox('Order Shipment','The status of the checked order is now Shipped. ~r~nDo you want to print packing slip?',question!,yesno!)
ElseIf cbx_2.Checked Then
	li_Ret = MessageBox('Order Shipment','The status of the checked order is now Shipped. ~r~nDo you want to print address label?',question!,yesno!)
Else
	//	messagebox('Order Shipment','The status of the checked order is now Shipped.')
	Return
End If
If li_Ret <> 1 Then Return

//Print
datastore  lds_slip,lds_address

If cbx_1.Checked Then
	lds_slip = Create datastore
	lds_slip.DataObject = 'd_rep_order_packing_slip'
	lds_slip.SetTransObject(sqlca)
End If
If cbx_2.Checked Then
	lds_address = Create datastore
	lds_address.DataObject = 'd_ship_label'
	lds_address.SetTransObject(sqlca)
End If

If cbx_1.Checked Then
	lds_slip.Retrieve(ls_orderno)
	lds_slip.Print()
End If
If cbx_2.Checked Then
	lds_address.Retrieve(ls_orderno)
	lds_address.Print()
End If

If IsValid(lds_slip) Then
	Destroy lds_slip
End If
If IsValid(lds_address) Then
	Destroy lds_address
End If



end event

type cbx_2 from checkbox within w_ship_order
integer x = 745
integer y = 1656
integer width = 635
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Print address label"
boolean checked = true
end type

type cbx_1 from checkbox within w_ship_order
integer x = 59
integer y = 1656
integer width = 635
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Print packing slip"
boolean checked = true
end type

