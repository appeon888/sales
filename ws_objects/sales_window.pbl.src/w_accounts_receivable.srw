$PBExportHeader$w_accounts_receivable.srw
$PBExportComments$Accounts Receivable
forward
global type w_accounts_receivable from w_sheet
end type
type tab_1 from tab within w_accounts_receivable
end type
type tabpage_1 from userobject within tab_1
end type
type st_m1 from statictext within tabpage_1
end type
type cb_12 from commandbutton within tabpage_1
end type
type cb_5 from commandbutton within tabpage_1
end type
type cb_10 from commandbutton within tabpage_1
end type
type st_10 from statictext within tabpage_1
end type
type st_11 from statictext within tabpage_1
end type
type cb_4 from commandbutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_order from datawindow within tabpage_1
end type
type p_1 from picture within tabpage_1
end type
type p_2 from picture within tabpage_1
end type
type dw_custlist from datawindow within tabpage_1
end type
type p_13 from picture within tabpage_1
end type
type dw_custdetail from datawindow within tabpage_1
end type
type p_8 from picture within tabpage_1
end type
type p_3 from picture within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_m1 st_m1
cb_12 cb_12
cb_5 cb_5
cb_10 cb_10
st_10 st_10
st_11 st_11
cb_4 cb_4
cb_1 cb_1
dw_order dw_order
p_1 p_1
p_2 p_2
dw_custlist dw_custlist
p_13 p_13
dw_custdetail dw_custdetail
p_8 p_8
p_3 p_3
end type
type tabpage_2 from userobject within tab_1
end type
type p_6 from picture within tabpage_2
end type
type p_4 from picture within tabpage_2
end type
type p_11 from picture within tabpage_2
end type
type p_5 from picture within tabpage_2
end type
type st_m3 from statictext within tabpage_2
end type
type cb_6 from commandbutton within tabpage_2
end type
type st_1 from statictext within tabpage_2
end type
type cb_3 from commandbutton within tabpage_2
end type
type cb_11 from commandbutton within tabpage_2
end type
type dw_2 from datawindow within tabpage_2
end type
type cb_update from commandbutton within tabpage_2
end type
type st_12 from statictext within tabpage_2
end type
type cb_9 from commandbutton within tabpage_2
end type
type cb_7 from commandbutton within tabpage_2
end type
type dw_1 from datawindow within tabpage_2
end type
type dw_3 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
p_6 p_6
p_4 p_4
p_11 p_11
p_5 p_5
st_m3 st_m3
cb_6 cb_6
st_1 st_1
cb_3 cb_3
cb_11 cb_11
dw_2 dw_2
cb_update cb_update
st_12 st_12
cb_9 cb_9
cb_7 cb_7
dw_1 dw_1
dw_3 dw_3
end type
type tab_1 from tab within w_accounts_receivable
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_accounts_receivable from w_sheet
integer width = 4379
integer height = 2184
string title = "Accounts Receivable"
long backcolor = 32039904
boolean center = true
event type integer ue_setfilter ( string as_custfilter,  string as_orderfilter,  string as_productfilter )
tab_1 tab_1
end type
global w_accounts_receivable w_accounts_receivable

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

Boolean ib_Retrieved = False,ib_LastChang = False
String  is_CustFilter[2],is_OrderFilter[2]
Integer   ii_Index = 1
String  is_FilterType

end variables

forward prototypes
public function integer wf_showall ()
public function integer wf_print_customer (string as_custno)
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

datawindow   ldw_Temp
Int  li_Row
String  lS_No1,ls_No2

If is_FilterType = 'customer' Then
	is_CustFilter[ii_Index] = as_CustFilter
Else
	is_OrderFilter[ii_Index] = as_OrderFilter
End If

//If as_CustFilter <> '' Then //comment by liulihua for filter all data if not set the filter condition
	If  ii_Index = 1 Then
		ldw_Temp = tab_1.tabpage_1.dw_custlist
	Else
		ldw_Temp = tab_1.tabpage_2.dw_1
	End If
	li_Row = ldw_Temp.GetRow()
	If li_Row > 0 Then
		lS_No1 = ldw_Temp.GetItemString(li_Row,'fcustno')
	End If
	ldw_Temp.SetFilter(as_CustFilter)
	ldw_Temp.Filter()
	
	//After set filter,must refresh order data and cust detail info
	li_Row = ldw_Temp.GetRow()
	If li_Row > 0 Then
		ls_No2 = ldw_Temp.GetItemString(li_Row,'fcustno')
	End If
	If lS_No1 <> ls_No2 Then
		ldw_Temp.SelectRow(li_Row,True)
		ldw_Temp.Event RowFocusChanged(li_Row)
	End If
	If ii_Index = 1 Then
		tab_1.tabpage_1.st_m1.Text = String(ldw_Temp.RowCount())+" matches."
		If ldw_Temp.RowCount() < 1 Then
			tab_1.tabpage_1.dw_CustDetail.Reset()
			tab_1.tabpage_1.dw_Order.Reset()
			Return 1
		End If
	Else
		tab_1.tabpage_2.st_m3.Text = String(ldw_Temp.RowCount())+" matches."
		If ldw_Temp.RowCount() < 1 Then
			tab_1.tabpage_2.dw_2.Reset()
			tab_1.tabpage_2.dw_3.Reset()
			Return 1
		End If
	End If
	
//End If

//If as_OrderFilter <> '' Then //comment by liulihua for filter all data if not set the filter condition
	If  ii_Index = 1 Then
		tab_1.tabpage_1.dw_Order.SetFilter(as_OrderFilter)
		tab_1.tabpage_1.dw_Order.Filter()
	Else
		tab_1.tabpage_2.dw_3.SetFilter(as_OrderFilter)
		tab_1.tabpage_2.dw_3.Filter()
	End If
//End If
tab_1.tabpage_1.dw_Order.SelectRow(tab_1.tabpage_1.dw_Order.GetRow(),True)
tab_1.tabpage_2.dw_3.SelectRow(tab_1.tabpage_2.dw_3.GetRow(),True)

Return 1

end event

public function integer wf_showall ();//====================================================================
// Function: wf_showall()
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

datawindow   ldw_Temp
int  li_Row
string  lS_No1,ls_No2,ls_CustFilter,ls_ProductFilter

IF is_FilterType = 'customer' THEn
	IF  ii_Index = 1 THEN
		ldw_Temp = tab_1.tabpage_1.dw_custlist
	ELSE
		ldw_Temp = tab_1.tabpage_2.dw_1
	END IF
	li_Row = ldw_Temp.getrow()
	IF li_Row > 0 THEN
		ls_No1 = ldw_Temp.getitemstring(li_Row,'fcustno')
	END IF
	is_CustFilter[ii_Index] = ""
	ldw_Temp.SetFilter("")
	ldw_Temp.filter()

	//After set filter,must refresh order data and cust detail info
	li_Row = ldw_Temp.getrow()
	IF li_Row > 0 THEN
		ls_No2 = ldw_Temp.getitemstring(li_Row,'fcustno')
	END IF
	ldw_Temp.selectrow(0,false)
	ldw_Temp.selectrow(li_Row,true)
	IF ls_No1 <> ls_No2 THEN
		ldw_Temp.event rowfocuschanged(li_Row)
	END IF
	IF ii_index = 1 THEN
		tab_1.tabpage_1.st_m1.text = ""
		IF ldw_Temp.rowcount() < 1 THEN
			tab_1.tabpage_1.dw_CustDetail.reset()
			tab_1.tabpage_1.dw_Order.reset()
			return 1
		END IF
	ELSE
		tab_1.tabpage_2.st_m3.text = ""
		IF ldw_Temp.rowcount() < 1 THEN
			tab_1.tabpage_2.dw_2.reset()
			tab_1.tabpage_2.dw_3.reset()
			return 1
		END IF
	END IF
ELSE
	IF  ii_Index = 1 THEN
		tab_1.tabpage_1.dw_order.SetFilter("")
		tab_1.tabpage_1.dw_order.filter()
	ELSE
		tab_1.tabpage_2.dw_3.SetFilter(is_OrderFilter[ii_Index])
		tab_1.tabpage_2.dw_3.filter()
	END IF
	is_OrderFilter[ii_Index] = ''
END IF
tab_1.tabpage_1.dw_order.selectrow(0,false)
tab_1.tabpage_1.dw_order.selectrow(tab_1.tabpage_1.dw_order.getrow(),TRUE)
tab_1.tabpage_2.dw_3.selectrow(0,false)
tab_1.tabpage_2.dw_3.selectrow(tab_1.tabpage_2.dw_3.getrow(),TRUE)


return 1
end function

public function integer wf_print_customer (string as_custno);//====================================================================
// Function: wf_print_customer()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_custno		
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

If IsNull(as_CustNo) Or as_CustNo = '' Then Return -1

nvo_util   lnv_util
Int  li_ret

li_ret = lnv_util.of_print_customer(as_CustNo)
If li_ret <> 1  Then
	Return -1
End If
UPDATE t_customers
	SET fprintflag = 1,
	flastprint = getdate()
	Where fcustno = :as_CustNo;
	
COMMIT;

Return 1





end function

public subroutine wf_setflag ();ieon_resize.of_setflag(tab_1.tabpage_1.cb_10,"2200")
ieon_resize.of_setflag(tab_1.tabpage_1.cb_1,"2200")
ieon_resize.of_setflag(tab_1.tabpage_1.st_m1,"1200")

ieon_resize.of_setflag(tab_1.tabpage_1.p_13,"1000")
ieon_resize.of_setflag(tab_1.tabpage_1.p_2,"1010")
ieon_resize.of_setflag(tab_1.tabpage_1.dw_custlist,"1012")
ieon_resize.of_setflag(tab_1.tabpage_1.p_3,"1000")
ieon_resize.of_setflag(tab_1.tabpage_1.p_8,"1010")
ieon_resize.of_setflag(tab_1.tabpage_1.dw_custdetail,"1010")

ieon_resize.of_setflag(tab_1.tabpage_2.p_4,"1000")
ieon_resize.of_setflag(tab_1.tabpage_2.p_5,"1010")
ieon_resize.of_setflag(tab_1.tabpage_2.dw_1,"1012")

ieon_resize.of_setflag(tab_1.tabpage_2.p_6,"1000")
ieon_resize.of_setflag(tab_1.tabpage_2.p_11,"1010")
ieon_resize.of_setflag(tab_1.tabpage_2.dw_2,"1010")

ieon_resize.of_setflag(tab_1.tabpage_1.dw_order,"1012")
ieon_resize.of_setflag(tab_1.tabpage_2.dw_3,"1012")

ieon_resize.of_setflag(tab_1.tabpage_2.cb_6,"2200")
ieon_resize.of_setflag(tab_1.tabpage_2.cb_update,"2200")
ieon_resize.of_setflag(tab_1.tabpage_2.cb_11,"2200")
ieon_resize.of_setflag(tab_1.tabpage_2.st_m3,"1200")


ieon_resize.of_setflag(tab_1.tabpage_1.st_11,"0000")
ieon_resize.of_setflag(tab_1.tabpage_1.st_10,"0000")
ieon_resize.of_setflag(tab_1.tabpage_2.st_12,"0000")
ieon_resize.of_setflag(tab_1.tabpage_2.st_1,"0000")


end subroutine

on w_accounts_receivable.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_accounts_receivable.destroy
call super::destroy
destroy(this.tab_1)
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

tab_1.tabpage_1.dw_custlist.settransobject(SQLCA)
tab_1.tabpage_1.dw_custdetail.settransobject(SQLCA)
tab_1.tabpage_1.dw_order.settransobject(SQLCA)
tab_1.tabpage_2.dw_1.settransobject(SQLCA)
tab_1.tabpage_2.dw_2.settransobject(SQLCA)
tab_1.tabpage_2.dw_3.settransobject(SQLCA)

tab_1.tabpage_1.dw_custlist.retrieve()

tab_1.tabpage_1.dw_order.modify("datawindow.readonly=yes")
tab_1.tabpage_1.dw_custlist.modify("datawindow.readonly=yes")
tab_1.tabpage_2.dw_1.modify("datawindow.readonly=yes")

end event

event resize;call super::resize;ieon_resize.of_resize(this,newwidth,newheight,true)
end event

type tab_1 from tab within w_accounts_receivable
integer x = 32
integer y = 24
integer width = 4306
integer height = 2056
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
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
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

ii_Index = newindex
If newindex = 2 Then
	If Not ib_Retrieved Then
		tab_1.tabpage_2.dw_1.Retrieve()
		ib_Retrieved = True
	End If
End If


end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4270
integer height = 1928
long backcolor = 32039904
string text = "Send Statement"
long tabtextcolor = 33554432
long tabbackcolor = 32039904
string picturename = "CrossTab!"
long picturemaskcolor = 536870912
st_m1 st_m1
cb_12 cb_12
cb_5 cb_5
cb_10 cb_10
st_10 st_10
st_11 st_11
cb_4 cb_4
cb_1 cb_1
dw_order dw_order
p_1 p_1
p_2 p_2
dw_custlist dw_custlist
p_13 p_13
dw_custdetail dw_custdetail
p_8 p_8
p_3 p_3
end type

on tabpage_1.create
this.st_m1=create st_m1
this.cb_12=create cb_12
this.cb_5=create cb_5
this.cb_10=create cb_10
this.st_10=create st_10
this.st_11=create st_11
this.cb_4=create cb_4
this.cb_1=create cb_1
this.dw_order=create dw_order
this.p_1=create p_1
this.p_2=create p_2
this.dw_custlist=create dw_custlist
this.p_13=create p_13
this.dw_custdetail=create dw_custdetail
this.p_8=create p_8
this.p_3=create p_3
this.Control[]={this.st_m1,&
this.cb_12,&
this.cb_5,&
this.cb_10,&
this.st_10,&
this.st_11,&
this.cb_4,&
this.cb_1,&
this.dw_order,&
this.p_1,&
this.p_2,&
this.dw_custlist,&
this.p_13,&
this.dw_custdetail,&
this.p_8,&
this.p_3}
end on

on tabpage_1.destroy
destroy(this.st_m1)
destroy(this.cb_12)
destroy(this.cb_5)
destroy(this.cb_10)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.dw_order)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.dw_custlist)
destroy(this.p_13)
destroy(this.dw_custdetail)
destroy(this.p_8)
destroy(this.p_3)
end on

type st_m1 from statictext within tabpage_1
integer x = 965
integer y = 1796
integer width = 343
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 32039904
boolean focusrectangle = false
end type

type cb_12 from commandbutton within tabpage_1
boolean visible = false
integer x = 649
integer y = 1784
integer width = 279
integer height = 104
integer taborder = 60
boolean bringtotop = true
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
OpenWithParm(w_set_filter_customer,'w_accounts_receivable')

end event

type cb_5 from commandbutton within tabpage_1
boolean visible = false
integer x = 23
integer y = 1784
integer width = 279
integer height = 104
integer taborder = 50
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

openwithparm(w_sort_single,dw_custlist)
end event

type cb_10 from commandbutton within tabpage_1
integer x = 3803
integer y = 1784
integer width = 448
integer height = 120
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

close(of_parent_window())
end event

type st_10 from statictext within tabpage_1
integer x = 41
integer y = 88
integer width = 1627
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "2) The Paid of the orders is FALSE,  the Status of the order is Shipped."
boolean focusrectangle = false
end type

type st_11 from statictext within tabpage_1
integer x = 41
integer y = 20
integer width = 1303
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "1) The Payment Due status of the customers: TRUE"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within tabpage_1
boolean visible = false
integer x = 334
integer y = 1784
integer width = 279
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

is_FilterType  = 'customer'
wf_showall()
end event

type cb_1 from commandbutton within tabpage_1
integer x = 3246
integer y = 1788
integer width = 535
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Print Statement"
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

Int  li_Row,li_Find
String  ls_Ret,ls_CustNo
datastore  lds_Print

li_Row = dw_custdetail.GetRow()
If li_Row < 1  Then Return
ls_CustNo = dw_custdetail.GetItemString(li_Row,'fcustno')

If wf_print_customer(ls_CustNo) > 0 Then
	dw_custlist.SetItem(li_Row,'flastprint',Today())
	dw_custlist.SetItem(li_Row,'fprintflag',dw_custlist.GetItemNumber(li_Row,'fprintflag')+1)
	li_Find = tab_1.tabpage_2.dw_1.Find("FCustNo='"+ls_CustNo+"'",1,tab_1.tabpage_2.dw_1.RowCount())
	If li_Find > 0 Then
		tab_1.tabpage_2.dw_1.SetItem(li_Find,'flastprint',Today())
		tab_1.tabpage_2.dw_1.SetItem(li_Find,'fprintflag',tab_1.tabpage_2.dw_1.GetItemNumber(li_Find,'fprintflag')+1)
	End If
End If




end event

type dw_order from datawindow within tabpage_1
integer x = 1765
integer y = 1148
integer width = 2482
integer height = 604
integer taborder = 30
string title = "none"
string dataobject = "d_order_detail_ar"
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

IF currentrow < 1 THEN return

This.selectrow(0,FALSE)
this.selectrow(currentrow,TRUE)
end event

event buttonclicked;//====================================================================
// Event: buttonclicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	long    	row             		
//		value	long    	actionreturncode		
//		value	dwobject	dwo             		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnbuttonclicked]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

IF row < 1 THEN return

string   ls_OrderNo

ls_OrderNO = this.getitemstring(row,'forderno')

//openwithparm(w_222,ls_OrderNo)
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

IF row > 0 THEN
	this.scrolltorow(row)
END IF
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

IF rowcount > 0 THEN
	this.selectrow(1,TRUE)
	
END IF
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

ls_custno  = this.getitemstring(row,'fcustno')
ls_orderno = this.getitemstring(row,'forderno')
openwithparm(w_order_detail, ls_custno + '$' + ls_orderno)
end event

type p_1 from picture within tabpage_1
boolean visible = false
integer x = 27
integer y = 180
integer width = 1312
integer height = 120
boolean bringtotop = true
string picturename = ".\picture\customers.jpg"
boolean focusrectangle = false
end type

type p_2 from picture within tabpage_1
integer x = 27
integer y = 180
integer width = 1705
integer height = 124
string picturename = ".\picture\titlebar_m.jpg"
boolean focusrectangle = false
end type

type dw_custlist from datawindow within tabpage_1
integer x = 27
integer y = 296
integer width = 1705
integer height = 1456
integer taborder = 30
string title = "none"
string dataobject = "d_cust_ar_tabular"
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

string  ls_CustNo
long ll_rowcnt,ll_Find

IF currentrow < 1 THEN return

This.selectrow(0,FALSE)
this.selectrow(currentrow,TRUE)
ls_CustNo = this.getitemstring(currentrow,'fcustno')

dw_custdetail.retrieve(ls_CustNo)
dw_Order.retrieve(ls_CustNo)

ll_rowcnt = tab_1.tabpage_2.dw_1.RowCount()
ll_Find = tab_1.tabpage_2.dw_1.Find("fcustno='"+ls_CustNo+"'",1,ll_rowcnt)
If ll_Find > 0 Then
	tab_1.tabpage_2.dw_1.ScrollToRow(ll_Find)
	tab_1.tabpage_2.dw_1.SelectRow(0,false)
	tab_1.tabpage_2.dw_1.SelectRow(ll_Find,true)
End If




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

IF row > 0 THEN
	this.event rowfocuschanged(row)
END IF
end event

type p_13 from picture within tabpage_1
integer x = 32
integer y = 184
integer width = 430
integer height = 116
boolean bringtotop = true
string picturename = ".\picture\Customers02.png"
boolean focusrectangle = false
end type

type dw_custdetail from datawindow within tabpage_1
integer x = 1765
integer y = 296
integer width = 2482
integer height = 856
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_customer"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.modify("datawindow.readonly = 'yes'")
end event

type p_8 from picture within tabpage_1
integer x = 1765
integer y = 180
integer width = 2482
integer height = 120
boolean bringtotop = true
string picturename = ".\picture\titlebar_m.jpg"
boolean focusrectangle = false
end type

type p_3 from picture within tabpage_1
integer x = 1769
integer y = 184
integer width = 649
integer height = 116
boolean bringtotop = true
string picturename = ".\picture\CustomersDetails02.png"
boolean focusrectangle = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4270
integer height = 1928
long backcolor = 32039904
string text = "Receive Payment"
long tabtextcolor = 33554432
long tabbackcolor = 32039904
string picturename = "DataWindow!"
long picturemaskcolor = 536870912
p_6 p_6
p_4 p_4
p_11 p_11
p_5 p_5
st_m3 st_m3
cb_6 cb_6
st_1 st_1
cb_3 cb_3
cb_11 cb_11
dw_2 dw_2
cb_update cb_update
st_12 st_12
cb_9 cb_9
cb_7 cb_7
dw_1 dw_1
dw_3 dw_3
end type

on tabpage_2.create
this.p_6=create p_6
this.p_4=create p_4
this.p_11=create p_11
this.p_5=create p_5
this.st_m3=create st_m3
this.cb_6=create cb_6
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_11=create cb_11
this.dw_2=create dw_2
this.cb_update=create cb_update
this.st_12=create st_12
this.cb_9=create cb_9
this.cb_7=create cb_7
this.dw_1=create dw_1
this.dw_3=create dw_3
this.Control[]={this.p_6,&
this.p_4,&
this.p_11,&
this.p_5,&
this.st_m3,&
this.cb_6,&
this.st_1,&
this.cb_3,&
this.cb_11,&
this.dw_2,&
this.cb_update,&
this.st_12,&
this.cb_9,&
this.cb_7,&
this.dw_1,&
this.dw_3}
end on

on tabpage_2.destroy
destroy(this.p_6)
destroy(this.p_4)
destroy(this.p_11)
destroy(this.p_5)
destroy(this.st_m3)
destroy(this.cb_6)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_11)
destroy(this.dw_2)
destroy(this.cb_update)
destroy(this.st_12)
destroy(this.cb_9)
destroy(this.cb_7)
destroy(this.dw_1)
destroy(this.dw_3)
end on

type p_6 from picture within tabpage_2
integer x = 1769
integer y = 184
integer width = 649
integer height = 116
string picturename = ".\picture\CustomersDetails02.png"
boolean focusrectangle = false
end type

type p_4 from picture within tabpage_2
integer x = 32
integer y = 184
integer width = 430
integer height = 116
string picturename = ".\picture\Customers02.png"
boolean focusrectangle = false
end type

type p_11 from picture within tabpage_2
integer x = 1765
integer y = 180
integer width = 2482
integer height = 120
string picturename = ".\picture\titlebar_m.jpg"
boolean focusrectangle = false
end type

type p_5 from picture within tabpage_2
integer x = 27
integer y = 180
integer width = 1705
integer height = 124
string picturename = ".\picture\titlebar_m.jpg"
boolean focusrectangle = false
end type

type st_m3 from statictext within tabpage_2
integer x = 946
integer y = 1800
integer width = 343
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 32039904
long backcolor = 32039904
boolean focusrectangle = false
end type

type cb_6 from commandbutton within tabpage_2
integer x = 1765
integer y = 1784
integer width = 357
integer height = 120
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Select All"
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

integer   li_Row
string  ls_Paid

IF dw_3.rowcount() < 1 THEN return
IF this.text = 'Select All' THEN
	this.text = 'Unselect All'
	ls_Paid = '1'
ELSE
	this.text = 'Select All'
	ls_Paid = '0'
END IF

For li_Row = 1 TO dw_3.Rowcount()
	dw_3.setitem(li_Row,'fpaid',ls_Paid)
NEXT
cb_update.enabled = TRUE
end event

type st_1 from statictext within tabpage_2
integer x = 41
integer y = 84
integer width = 1120
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "status of the customer will be set automatically."
boolean focusrectangle = false
end type

type cb_3 from commandbutton within tabpage_2
boolean visible = false
integer x = 23
integer y = 1784
integer width = 279
integer height = 104
integer taborder = 40
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

openwithparm(w_sort_single,dw_1)
end event

type cb_11 from commandbutton within tabpage_2
integer x = 3808
integer y = 1784
integer width = 448
integer height = 120
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

close(of_parent_window())
end event

type dw_2 from datawindow within tabpage_2
integer x = 1765
integer y = 296
integer width = 2482
integer height = 856
integer taborder = 30
string title = "none"
string dataobject = "d_customer"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.modify("datawindow.readonly = 'yes'")
end event

type cb_update from commandbutton within tabpage_2
integer x = 2144
integer y = 1784
integer width = 535
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Submit Payment"
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

Int  li_row
String ls_CustNo

If dw_3.RowCount() < 1 Then Return
If dw_3.UPDATE() > 0 Then
	COMMIT;
	This.Enabled = False
	For li_row = dw_3.RowCount() To 1 Step -1
		If dw_3.Object.fpaid[li_row] = '1' Then
			dw_3.RowsDiscard(li_row,li_row,primary!)
		End If
	Next
	li_row = dw_1.GetRow()
	ls_CustNo = dw_1.GetItemString(li_row,'FCustNo')
	
	If dw_3.RowCount() < 1 Then
		ib_LastChang = True
		
		dw_1.RowsDiscard(li_row,li_row,primary!)
		dw_2.SetItem(1,'FPaymentDue','0')
		dw_1.SelectRow(0,False)
		dw_1.SelectRow(dw_1.GetRow(),True)
		//		dw_1.event rowfocuschanged(dw_1.getrow())
		li_row = tab_1.tabpage_1.dw_custlist.GetRow()
		tab_1.tabpage_1.dw_custlist.RowsDiscard(li_row,li_row,primary!)
		tab_1.tabpage_1.dw_custlist.Event RowFocusChanged(dw_1.GetRow())
		
		cb_6.Text = 'Select All'
		//Change print flag
		UPDATE t_customers
			SET fprintflag = 0
			Where fcustno = :ls_CustNo;
		COMMIT;
	Else
		dw_3.Event RowFocusChanged(dw_3.GetRow())
	End If
	
	//	messagebox("Receive Payment","Update order paid status successfully.")
Else
	ROLLBACK;
	MessageBox("Receive Payment","Failed to save the order paid status.",exclamation!)
End If

end event

type st_12 from statictext within tabpage_2
integer x = 41
integer y = 12
integer width = 3045
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "If the payment for an order is received, please change the Paid status of the order to TRUE by checking the Paid column.  The Payment Due"
boolean focusrectangle = false
end type

type cb_9 from commandbutton within tabpage_2
boolean visible = false
integer x = 645
integer y = 1784
integer width = 279
integer height = 104
integer taborder = 30
boolean bringtotop = true
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
openwithparm(w_set_filter_customer,'w_accounts_receivable')
end event

type cb_7 from commandbutton within tabpage_2
boolean visible = false
integer x = 334
integer y = 1784
integer width = 279
integer height = 104
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

is_FilterType = 'customer'
wf_showall()
end event

type dw_1 from datawindow within tabpage_2
integer x = 27
integer y = 296
integer width = 1705
integer height = 1456
integer taborder = 40
string title = "none"
string dataobject = "d_cust_ar_tabular"
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

String  ls_CustNo
long ll_rowcnt,ll_Find

If currentrow < 1 Then Return

This.SelectRow(0,False)
This.SelectRow(currentrow,True)

If ib_LastChang Then
	ib_LastChang = False
	Return
End If
ls_CustNo = This.GetItemString(currentrow,'fcustno')

dw_2.Retrieve(ls_CustNo)
dw_3.Retrieve(ls_CustNo)
cb_6.Text = 'Select All'

ll_rowcnt = tab_1.tabpage_1.dw_custlist.RowCount()
ll_Find = tab_1.tabpage_1.dw_custlist.Find("fcustno='"+ls_CustNo+"'",1,ll_rowcnt)
If ll_Find > 0 Then
	tab_1.tabpage_1.dw_custlist.ScrollToRow(ll_Find)
	tab_1.tabpage_1.dw_custlist.SelectRow(0,false)
	tab_1.tabpage_1.dw_custlist.SelectRow(ll_Find,true)
End If





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

IF row > 0 THEN
//	this.scrolltorow(row)
	IF ib_LastChang THEN
		ib_LastChang = FALSE
	END IF
	this.event rowfocuschanged(row)
END IF
end event

type dw_3 from datawindow within tabpage_2
integer x = 1765
integer y = 1148
integer width = 2482
integer height = 604
integer taborder = 40
string title = "none"
string dataobject = "d_order_detail_ar"
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

IF currentrow < 1 THEN return

This.selectrow(0,FALSE)
this.selectrow(currentrow,TRUE)
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

IF row > 0 THEN
	this.scrolltorow(row)
END IF
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

IF rowcount > 0 THEN
	this.selectrow(1,TRUE)
END IF
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

cb_update.enabled = true
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

ls_custno  = this.getitemstring(row,'fcustno')
ls_orderno = this.getitemstring(row,'forderno')
openwithparm(w_order_detail, ls_custno + '$' + ls_orderno)
end event

