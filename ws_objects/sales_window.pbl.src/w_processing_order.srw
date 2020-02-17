$PBExportHeader$w_processing_order.srw
forward
global type w_processing_order from w_sheet
end type
type tab_order from tab within w_processing_order
end type
type tabpage_new from userobject within tab_order
end type
type mle_1 from multilineedit within tabpage_new
end type
type cb_7 from commandbutton within tabpage_new
end type
type cb_13 from commandbutton within tabpage_new
end type
type cb_15 from commandbutton within tabpage_new
end type
type cb_1 from commandbutton within tabpage_new
end type
type dw_1 from u_dw within tabpage_new
end type
type st_10 from statictext within tabpage_new
end type
type cb_14 from commandbutton within tabpage_new
end type
type tabpage_new from userobject within tab_order
mle_1 mle_1
cb_7 cb_7
cb_13 cb_13
cb_15 cb_15
cb_1 cb_1
dw_1 dw_1
st_10 st_10
cb_14 cb_14
end type
type tabpage_processing from userobject within tab_order
end type
type mle_2 from multilineedit within tabpage_processing
end type
type cb_6 from commandbutton within tabpage_processing
end type
type st_7 from statictext within tabpage_processing
end type
type cb_5 from commandbutton within tabpage_processing
end type
type cb_3 from commandbutton within tabpage_processing
end type
type cb_2 from commandbutton within tabpage_processing
end type
type dw_2 from u_dw within tabpage_processing
end type
type cb_4 from commandbutton within tabpage_processing
end type
type tabpage_processing from userobject within tab_order
mle_2 mle_2
cb_6 cb_6
st_7 st_7
cb_5 cb_5
cb_3 cb_3
cb_2 cb_2
dw_2 dw_2
cb_4 cb_4
end type
type tab_order from tab within w_processing_order
tabpage_new tabpage_new
tabpage_processing tabpage_processing
end type
end forward

global type w_processing_order from w_sheet
integer width = 3982
integer height = 2080
string title = "Order Processing"
long backcolor = 32039904
event type integer ue_setfilter ( string as_custfilter,  string as_orderfilter,  string as_productfilter )
tab_order tab_order
end type
global w_processing_order w_processing_order

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
integer   ii_index
boolean  ib_Retrieved=false
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

datawindow   ldw_filter
String  ls_filter
nvo_util  lnv_util

//If as_custfilter <> '' Or as_orderfilter <> '' Then //comment by liulihua for filter all data
	
	ls_filter = f_combine_filter_string(as_custfilter,as_orderfilter)
	
	ls_filter = wf_custfilter_replace(ls_filter)
	ls_filter = wf_orderfilter_replace(ls_filter)
	
	If  ii_Index = 1 Then
		ldw_filter = tab_order.tabpage_new.dw_1
	Else
		ldw_filter = tab_order.tabpage_processing.dw_2
	End If
	ldw_filter.SetFilter(ls_filter)
	ldw_filter.Filter()
	
	If  ii_Index = 1 Then
		tab_order.tabpage_new.mle_1.Text = String(ldw_filter.RowCount())+" matches."
	Else
		tab_order.tabpage_processing.mle_2.Text = String(ldw_filter.RowCount())+" matches."
	End If
	
//End If

Return 1

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

public subroutine wf_setflag ();ieon_resize.of_setflag(tab_Order.Tabpage_new.cb_7,"2200")
ieon_resize.of_setflag(tab_Order.Tabpage_new.cb_1,"2200")
ieon_resize.of_setflag(tab_Order.Tabpage_new.mle_1,"1200")

ieon_resize.of_setflag(tab_Order.Tabpage_processing.cb_5,"2200")
ieon_resize.of_setflag(tab_Order.Tabpage_processing.cb_6,"2200")
ieon_resize.of_setflag(tab_Order.Tabpage_processing.mle_2,"1200")
end subroutine

on w_processing_order.create
int iCurrent
call super::create
this.tab_order=create tab_order
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_order
end on

on w_processing_order.destroy
call super::destroy
destroy(this.tab_order)
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

ii_index = 1
end event

event resize;call super::resize;ieon_resize.of_resize(this,newwidth,newheight,true)
end event

type tab_order from tab within w_processing_order
integer x = 32
integer y = 20
integer width = 3890
integer height = 1940
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_new tabpage_new
tabpage_processing tabpage_processing
end type

on tab_order.create
this.tabpage_new=create tabpage_new
this.tabpage_processing=create tabpage_processing
this.Control[]={this.tabpage_new,&
this.tabpage_processing}
end on

on tab_order.destroy
destroy(this.tabpage_new)
destroy(this.tabpage_processing)
end on

event selectionchanged;//====================================================================
// Event: selectionchanged()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	integer	oldindex		
//		value	integer	newindex		
//--------------------------------------------------------------------
// Returns: long [pbm_tcnselchanged]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

IF newindex = 2 THEN
	IF not ib_Retrieved THEN
		tab_order.tabpage_processing.dw_2.event ue_retrieve()
		ib_Retrieved = TRUE
	END IF
END IF
ii_index = newindex
end event

type tabpage_new from userobject within tab_order
integer x = 18
integer y = 112
integer width = 3854
integer height = 1812
long backcolor = 32039904
string text = "New Orders"
long tabtextcolor = 33554432
long tabbackcolor = 32039904
string picturename = "DataWindow5!"
long picturemaskcolor = 536870912
mle_1 mle_1
cb_7 cb_7
cb_13 cb_13
cb_15 cb_15
cb_1 cb_1
dw_1 dw_1
st_10 st_10
cb_14 cb_14
end type

on tabpage_new.create
this.mle_1=create mle_1
this.cb_7=create cb_7
this.cb_13=create cb_13
this.cb_15=create cb_15
this.cb_1=create cb_1
this.dw_1=create dw_1
this.st_10=create st_10
this.cb_14=create cb_14
this.Control[]={this.mle_1,&
this.cb_7,&
this.cb_13,&
this.cb_15,&
this.cb_1,&
this.dw_1,&
this.st_10,&
this.cb_14}
end on

on tabpage_new.destroy
destroy(this.mle_1)
destroy(this.cb_7)
destroy(this.cb_13)
destroy(this.cb_15)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.st_10)
destroy(this.cb_14)
end on

type mle_1 from multilineedit within tabpage_new
integer x = 1289
integer y = 1696
integer width = 448
integer height = 68
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
boolean displayonly = true
end type

type cb_7 from commandbutton within tabpage_new
integer x = 3378
integer y = 1668
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

close(of_parent_window())
end event

type cb_13 from commandbutton within tabpage_new
boolean visible = false
integer x = 41
integer y = 1668
integer width = 384
integer height = 120
integer taborder = 20
boolean bringtotop = true
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

//openwithparm(w_sort_single,dw_1)

dw_1.event ue_sort()
end event

type cb_15 from commandbutton within tabpage_new
boolean visible = false
integer x = 462
integer y = 1668
integer width = 384
integer height = 120
integer taborder = 20
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

dw_1.setfilter("")
dw_1.filter()

mle_1.text=  ''
end event

type cb_1 from commandbutton within tabpage_new
integer x = 2866
integer y = 1668
integer width = 475
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Start to Process"
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

//update  t_order table  fstatus 
tab_order.tabpage_new.dw_1.event ue_update()
//reflesh  the datawindow data.
ib_Retrieved = false
dw_1.event ue_setenabled()
end event

type dw_1 from u_dw within tabpage_new
event ue_retrieve ( )
event ue_update ( )
event ue_setenabled ( )
integer x = 46
integer y = 136
integer width = 3776
integer height = 1500
integer taborder = 20
string dataobject = "d_order_status_processing"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_retrieve();//====================================================================
// Event: ue_retrieve()
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
this.retrieve('1') //order status <'1': new>
end event

event ue_update();//====================================================================
// Event: ue_update()
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

Integer    li_loop ,li_Count
String      ls_check,ls_orderno,ls_Error

For  li_loop  = 1 To  This.RowCount()
	ls_check  = This.GetItemString(li_loop,'no')
	If ls_check = '1'  Then //  check to process
		ls_orderno  = This.GetItemString(li_loop,'t_orders_forderno')
		UPDATE t_orders  Set fstatus = '2'  Where  forderno = :ls_orderno;
		If sqlca.SQLCode  < 0 Then
			ls_Error = sqlca.SQLErrText
			ROLLBACK;
			MessageBox('Warning','Failed to update the order status.~r~n'+ls_Error,exclamation!)
			Return
		End If
		li_Count ++
	End If
Next
If li_Count < 1 Then
	MessageBox('Alert','Do you want to process some order(s)? Please first check the box(es) beside the order(s).')
	Return
End If
COMMIT ;
For  li_loop = This.RowCount() To 1 Step -1
	ls_check  = This.GetItemString(li_loop,'no')
	If ls_check = '1'  Then //  check to process
		This.RowsDiscard(li_loop,li_loop,primary!)
	End If
Next
li_loop = This.GetRow()
This.SelectRow(0,False)
This.SelectRow(li_loop,True)

//messagebox('Start to Process','The status of the checked order(s) is now Processing.')




end event

event ue_setenabled();//====================================================================
// Event: ue_setenabled()
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

int  li_Row,li_Count

FOR li_Row = 1 TO this.rowcount()
	IF this.getitemstring(li_Row,'no') = '1' THEN
		li_Count++
	END IF
NEXT

cb_1.enabled = (li_Count > 0)

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

string   ls_custno,ls_orderno

if row <=0 then  return

ls_custno  = this.getitemstring(row,'t_customers_fcustno')
ls_orderno = this.getitemstring(row,'t_orders_forderno')
openwithparm(w_order_detail, ls_custno + '$' + ls_orderno)
end event

event constructor;call super::constructor;//====================================================================
// Event: constructor()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_constructor]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

this.event ue_retrieve()
end event

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
This.ScrollToRow(row)
SelectRow(0,False)
SelectRow(row,True)

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

this.post event ue_SetEnabled()
end event

type st_10 from statictext within tabpage_new
integer x = 50
integer y = 40
integer width = 1266
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "The Order Status of the orders: New"
boolean focusrectangle = false
end type

type cb_14 from commandbutton within tabpage_new
boolean visible = false
integer x = 882
integer y = 1668
integer width = 384
integer height = 120
integer taborder = 20
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

openwithparm(w_set_filter_cust_order,'w_processing_order',of_parent_window())

end event

type tabpage_processing from userobject within tab_order
integer x = 18
integer y = 112
integer width = 3854
integer height = 1812
long backcolor = 32039904
string text = "Orders in Process"
long tabtextcolor = 33554432
long tabbackcolor = 32039904
string picturename = "DataWindow!"
long picturemaskcolor = 536870912
mle_2 mle_2
cb_6 cb_6
st_7 st_7
cb_5 cb_5
cb_3 cb_3
cb_2 cb_2
dw_2 dw_2
cb_4 cb_4
end type

on tabpage_processing.create
this.mle_2=create mle_2
this.cb_6=create cb_6
this.st_7=create st_7
this.cb_5=create cb_5
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_2=create dw_2
this.cb_4=create cb_4
this.Control[]={this.mle_2,&
this.cb_6,&
this.st_7,&
this.cb_5,&
this.cb_3,&
this.cb_2,&
this.dw_2,&
this.cb_4}
end on

on tabpage_processing.destroy
destroy(this.mle_2)
destroy(this.cb_6)
destroy(this.st_7)
destroy(this.cb_5)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.cb_4)
end on

type mle_2 from multilineedit within tabpage_processing
integer x = 1289
integer y = 1696
integer width = 448
integer height = 68
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711935
long backcolor = 32039904
boolean border = false
boolean displayonly = true
end type

type cb_6 from commandbutton within tabpage_processing
integer x = 3378
integer y = 1668
integer width = 448
integer height = 120
integer taborder = 40
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

close(of_parent_window())
end event

type st_7 from statictext within tabpage_processing
integer x = 50
integer y = 40
integer width = 1266
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "The Order Status of the orders: Processing"
boolean focusrectangle = false
end type

type cb_5 from commandbutton within tabpage_processing
integer x = 2866
integer y = 1668
integer width = 475
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Processed"
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

//update  t_order table  fstatus 
tab_order.tabpage_processing.dw_2.event ue_update()
//reflesh  the datawindow data.
//tab_order.tabpage_processing.dw_2.event ue_retrieve()
IF isvalid(w_ship_order) THEN
	w_ship_order.event ue_refresh()
END IF

dw_2.event ue_setenabled()
end event

type cb_3 from commandbutton within tabpage_processing
boolean visible = false
integer x = 882
integer y = 1668
integer width = 384
integer height = 120
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

openwithparm(w_set_filter_cust_order,'w_processing_order')
end event

type cb_2 from commandbutton within tabpage_processing
boolean visible = false
integer x = 41
integer y = 1668
integer width = 384
integer height = 120
integer taborder = 30
boolean bringtotop = true
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

dw_2.event ue_sort()
end event

type dw_2 from u_dw within tabpage_processing
event ue_retrieve ( )
event ue_update ( )
event ue_setenabled ( )
integer x = 46
integer y = 136
integer width = 3776
integer height = 1500
integer taborder = 20
string dataobject = "d_order_status_processing"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_retrieve();//====================================================================
// Event: ue_retrieve()
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
this.retrieve('2') //order status <'2': processing>
end event

event ue_update();//====================================================================
// Event: ue_update()
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

Integer    li_loop ,li_Count
String      ls_check,ls_orderno

For  li_loop  = 1 To  This.RowCount()
	ls_check  = This.GetItemString(li_loop,'no')
	If ls_check = '1'  Then //  check to process
		ls_orderno  = This.GetItemString(li_loop,'t_orders_forderno')
		UPDATE t_orders  Set fstatus = '3'  Where  forderno = :ls_orderno;
		If sqlca.SQLCode  < 0 Then
			ROLLBACK;
			MessageBox('Warning','Failed to save the order status.',exclamation!)
			Return
		End If
		li_Count ++
	End If
Next
If li_Count < 1 Then
	MessageBox('Alert','Have you got some of the order(s) processed? Please first check the box(es) beside the order(s), then click the Processed button.')
Return
End If
COMMIT ;
For  li_loop = This.RowCount() To 1 Step -1
	ls_check  = This.GetItemString(li_loop,'no')
	If ls_check = '1'  Then //  check to process
		This.RowsDiscard(li_loop,li_loop,primary!)
	End If
Next
li_loop = This.GetRow()
This.SelectRow(0,False)
This.SelectRow(li_loop,True)

//messagebox('Order Processed','The status of the checked order(s) is now Ready to Ship.')



end event

event ue_setenabled();//====================================================================
// Event: ue_setenabled()
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

int  li_Row,li_Count

FOR li_Row = 1 TO this.rowcount()
	IF this.getitemstring(li_Row,'no') = '1' THEN
		li_Count++
	END IF
NEXT

cb_5.enabled = (li_Count > 0)

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

string   ls_custno,ls_orderno

if row <=0 then  return

ls_custno  = this.getitemstring(row,'t_customers_fcustno')
ls_orderno = this.getitemstring(row,'t_orders_forderno')
openwithparm(w_order_detail, ls_custno + '$' + ls_orderno)
end event

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

string  	ls_ret
integer	li_pos

//the following  code   implement  the sort  function by  clicking  column head
ls_ret = f_sort_by_head(this, dwo.name,is_last_col,is_sort_type)
if ls_ret<>'' then
	li_pos = pos(ls_ret,'$')
	is_last_col = left(ls_ret,li_pos - 1)
	is_sort_type = mid(ls_ret,li_pos + 1)
end if


if  row <=0 then return
this.scrolltorow(row)
selectrow(0,false)
selectrow(row,true)
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

this.post event ue_setenabled()
end event

type cb_4 from commandbutton within tabpage_processing
boolean visible = false
integer x = 462
integer y = 1668
integer width = 384
integer height = 120
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

dw_2.setfilter("")
dw_2.filter()
mle_2.text=  ''
end event

