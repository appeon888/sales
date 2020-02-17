$PBExportHeader$w_order_viewer.srw
$PBExportComments$Order Viewer
forward
global type w_order_viewer from w_sheet
end type
type pb_print from commandbutton within w_order_viewer
end type
type pb_close from commandbutton within w_order_viewer
end type
type st_5 from statictext within w_order_viewer
end type
type dw_orders from datawindow within w_order_viewer
end type
type dw_custdetail from datawindow within w_order_viewer
end type
type p_bar_tv from picture within w_order_viewer
end type
type dw_orderdetail from datawindow within w_order_viewer
end type
type tab_1 from tab within w_order_viewer
end type
type tabpage_1 from userobject within tab_1
end type
type dw_cust from datawindow within tabpage_1
end type
type p_bar_customer_m from picture within tabpage_1
end type
type p_bar_customer_r from picture within tabpage_1
end type
type p_bar_customer from picture within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_cust dw_cust
p_bar_customer_m p_bar_customer_m
p_bar_customer_r p_bar_customer_r
p_bar_customer p_bar_customer
end type
type tabpage_2 from userobject within tab_1
end type
type dw_orderlist from datawindow within tabpage_2
end type
type p_bar_order_m from picture within tabpage_2
end type
type p_bar_order_r from picture within tabpage_2
end type
type p_bar_order from picture within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_orderlist dw_orderlist
p_bar_order_m p_bar_order_m
p_bar_order_r p_bar_order_r
p_bar_order p_bar_order
end type
type tabpage_3 from userobject within tab_1
end type
type cbx_2 from checkbox within tabpage_3
end type
type cb_3 from commandbutton within tabpage_3
end type
type ddlb_1 from dropdownlistbox within tabpage_3
end type
type em_custno from editmask within tabpage_3
end type
type ddlb_2 from dropdownlistbox within tabpage_3
end type
type em_orderno from editmask within tabpage_3
end type
type gb_2 from groupbox within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cbx_2 cbx_2
cb_3 cb_3
ddlb_1 ddlb_1
em_custno em_custno
ddlb_2 ddlb_2
em_orderno em_orderno
gb_2 gb_2
end type
type tab_1 from tab within w_order_viewer
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type r_1 from rectangle within w_order_viewer
end type
type r_2 from rectangle within w_order_viewer
end type
type tv_1 from treeview within w_order_viewer
end type
type p_bar_result_m from picture within w_order_viewer
end type
type p_bar_result_r from picture within w_order_viewer
end type
type p_bar_result from picture within w_order_viewer
end type
end forward

global type w_order_viewer from w_sheet
integer width = 4201
integer height = 2616
string title = "Order Viewer"
long backcolor = 32039904
event ue_inittree ( )
pb_print pb_print
pb_close pb_close
st_5 st_5
dw_orders dw_orders
dw_custdetail dw_custdetail
p_bar_tv p_bar_tv
dw_orderdetail dw_orderdetail
tab_1 tab_1
r_1 r_1
r_2 r_2
tv_1 tv_1
p_bar_result_m p_bar_result_m
p_bar_result_r p_bar_result_r
p_bar_result p_bar_result
end type
global w_order_viewer w_order_viewer

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
// CopyRight 2003----2013 Appeon Inc.
//====================================================================


boolean   ib_Retrieved=false
datastore   ids_Tree
end variables

forward prototypes
public function boolean uf_inittree (long handle, string as_custno)
public subroutine wf_print ()
end prototypes

event ue_inittree();//====================================================================
// Event: ue_inittree()
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
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

treeviewitem ltvi_root
long ll_row , i
long ll_treehandle[]
string ls_name ,ls_CustNo[]

ll_row = tab_1.tabpage_1.dw_cust.rowcount()
if ll_row < 1 then return
tv_1.deleteitem(0)
for i = 1 to ll_row
	ls_CustNo[i] = tab_1.tabpage_1.dw_cust.getitemstring(i , 'fcustno')
	ls_name = tab_1.tabpage_1.dw_cust.getitemstring(i , 'ffirstname') 
	ltvi_root.children = true
	ltvi_root.label = ls_name
	ltvi_root.data = ls_CustNo[i]
	ltvi_root.pictureindex = 1
	ltvi_root.selectedpictureindex = 3
	ll_treehandle[i] = tv_1.insertitemlast(0 , ltvi_root)
next



end event

public function boolean uf_inittree (long handle, string as_custno);//====================================================================
// Function: uf_inittree()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	long  	handle   		
//		value	string	as_custno		
//--------------------------------------------------------------------
// Returns: boolean
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

treeviewitem ltvi_cur
long ll_row , i
string ls_OrderDate ,ls_OrderNo
nvo_util  lnv_util

ll_row = ids_Tree.retrieve(as_custno)

for i = 1 to ll_row
	ls_OrderNo = ids_Tree.getitemstring(i , 'forderno')
	ls_OrderDate = string(ids_Tree.getitemdate(i , 'forderdate'),'mm/dd/yyyy')
	ltvi_cur.label = lnv_util.of_parse_orderno(ls_OrderNo) + '--' + ls_OrderDate
	ltvi_cur.data = ls_OrderNo
	ltvi_cur.children = false
	ltvi_cur.pictureindex = 2
	ltvi_cur.selectedpictureindex = 3
	ltvi_cur.Selected	 = false
	tv_1.insertitemlast(handle , ltvi_cur)
next
if ll_row > 0 then 
	return true
else
	return false
end if

end function

public subroutine wf_print ();int  li_Row
string  ls_Ret,ls_CustNo
datastore   lds_print

li_Row = dw_custdetail.getrow() 
IF li_Row > 0 THEN
	ls_CustNo = dw_custdetail.getitemstring(li_Row,'fcustno')
ELSE
	return
END IF

nvo_util   lnv_util

lnv_util.of_print_customer(ls_CustNo)

end subroutine

on w_order_viewer.create
int iCurrent
call super::create
this.pb_print=create pb_print
this.pb_close=create pb_close
this.st_5=create st_5
this.dw_orders=create dw_orders
this.dw_custdetail=create dw_custdetail
this.p_bar_tv=create p_bar_tv
this.dw_orderdetail=create dw_orderdetail
this.tab_1=create tab_1
this.r_1=create r_1
this.r_2=create r_2
this.tv_1=create tv_1
this.p_bar_result_m=create p_bar_result_m
this.p_bar_result_r=create p_bar_result_r
this.p_bar_result=create p_bar_result
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_print
this.Control[iCurrent+2]=this.pb_close
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.dw_orders
this.Control[iCurrent+5]=this.dw_custdetail
this.Control[iCurrent+6]=this.p_bar_tv
this.Control[iCurrent+7]=this.dw_orderdetail
this.Control[iCurrent+8]=this.tab_1
this.Control[iCurrent+9]=this.r_1
this.Control[iCurrent+10]=this.r_2
this.Control[iCurrent+11]=this.tv_1
this.Control[iCurrent+12]=this.p_bar_result_m
this.Control[iCurrent+13]=this.p_bar_result_r
this.Control[iCurrent+14]=this.p_bar_result
end on

on w_order_viewer.destroy
call super::destroy
destroy(this.pb_print)
destroy(this.pb_close)
destroy(this.st_5)
destroy(this.dw_orders)
destroy(this.dw_custdetail)
destroy(this.p_bar_tv)
destroy(this.dw_orderdetail)
destroy(this.tab_1)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.tv_1)
destroy(this.p_bar_result_m)
destroy(this.p_bar_result_r)
destroy(this.p_bar_result)
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
// CopyRight 2003----2013 Appeon Inc.
//====================================================================


dw_OrderDetail.settransobject(sqlca)
dw_CustDetail.settransobject(sqlca)
dw_Orders.settransobject(sqlca)

tab_1.tabpage_1.dw_cust.settransobject(sqlca)
tab_1.tabpage_2.dw_orderlist.settransobject(sqlca)

tab_1.tabpage_1.dw_cust.event ue_retrieve()
tab_1.tabpage_2.dw_OrderList.Event ue_retrieve()

ids_Tree = create datastore
ids_Tree.dataobject = 'd_order_detail'
ids_Tree.settransobject(SQLCA)

end event

event close;call super::close;//====================================================================
// Event: close()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_close]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

destroy ids_Tree
end event

event resize;
long li_xoffset,li_yoffset
long ll_temp

this.setredraw( false)

 li_xoffset = 0
 li_yoffset = 0	


ll_temp = pb_close.width
pb_close.x = 	newwidth - li_xoffset - ll_temp - 36
ll_temp = pb_print.width
pb_print.x =    pb_close.x - ll_temp - 66

ll_temp = p_bar_tv.width
p_bar_tv.x =  newwidth - li_xoffset - ll_temp - 36

tv_1.x =  p_bar_tv.x
ll_temp = tv_1.y
tv_1.height = newheight - li_yoffset - ll_temp - 40

//ll_temp = p_ll.width
//p_ll.x =  tv_1.x - ll_temp - 1
//ll_temp = p_ll.y
//p_ll.height =  newheight - li_yoffset - ll_temp - 60

ll_temp = tab_1.x
//tab_1.width = p_ll.x  - ll_temp - 10
tab_1.width = tv_1.x  - ll_temp - 60
ll_temp = tab_1.y
//tab_1.height = newheight - li_yoffset - ll_temp - 40


ll_temp = tab_1.tabpage_1.dw_cust.x 
tab_1.tabpage_1.dw_cust.width= tab_1.width - ll_temp - 40
tab_1.tabpage_2.dw_orderlist.width= tab_1.tabpage_1.dw_cust.width

ll_temp = tab_1.tabpage_1.p_bar_customer_r.width
tab_1.tabpage_1.p_bar_customer_r.x= tab_1.width - ll_temp - 40
tab_1.tabpage_2.p_bar_order_r.x= tab_1.tabpage_1.p_bar_customer_r.x
                           
tab_1.tabpage_1.p_bar_customer_m.x= tab_1.tabpage_1.p_bar_customer.x+600
tab_1.tabpage_2.p_bar_order_m.x= tab_1.tabpage_1.p_bar_customer_m.x

ll_temp = tab_1.tabpage_1.p_bar_customer_m.x
tab_1.tabpage_1.p_bar_customer_m.width= tab_1.tabpage_1.p_bar_customer_r.x - ll_temp +100
tab_1.tabpage_2.p_bar_order_m.width= tab_1.tabpage_1.p_bar_customer_m.width


ll_temp = tab_1.tabpage_3.ddlb_1.x
tab_1.tabpage_3.ddlb_1.width= tab_1.width - 2*ll_temp 

tab_1.tabpage_3.cb_3.width = tab_1.tabpage_3.ddlb_1.width
tab_1.tabpage_3.ddlb_2.width = tab_1.tabpage_3.ddlb_1.width
tab_1.tabpage_3.em_custno.width = tab_1.tabpage_3.ddlb_1.width
tab_1.tabpage_3.em_orderno.width = tab_1.tabpage_3.ddlb_1.width
tab_1.tabpage_3.cbx_2.width = tab_1.tabpage_3.ddlb_1.width


dw_orderdetail.width = tab_1.tabpage_1.dw_cust.width
dw_custdetail.width = tab_1.tabpage_1.dw_cust.width
dw_orders.width = tab_1.tabpage_1.dw_cust.width



ll_temp = p_bar_result_r.width
p_bar_result_r.x = dw_orderdetail.x+ dw_orderdetail.width - ll_temp

p_bar_result_m.x = p_bar_result.x + 600
ll_temp = p_bar_result_m.x
p_bar_result_m.width =p_bar_result_r.x -  ll_temp+100


//------Height-------------------------------

tv_1.height = newheight -  tv_1.y - pb_print.height - 40
pb_print.y = tv_1.y + tv_1.height + 20
pb_close.y = pb_print.y 

ll_temp = tab_1.y
tab_1.height = newheight -  ll_temp - pb_print.height - 40

ll_temp= dw_orderdetail.y
dw_orderdetail.height =  newheight -  ll_temp - pb_print.height - 60
dw_custdetail.height = dw_orderdetail.height
dw_orders.height = dw_orderdetail.height


this.setredraw( true)
end event

type pb_print from commandbutton within w_order_viewer
integer x = 3090
integer y = 2308
integer width = 457
integer height = 128
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Print Order"
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
string  ls_Ret,ls_CustNo
datastore   lds_print

li_Row = dw_custdetail.getrow() 
IF li_Row > 0 THEN
	ls_CustNo = dw_custdetail.getitemstring(li_Row,'fcustno')
ELSE
	return
END IF

nvo_util   lnv_util

lnv_util.of_print_customer(ls_CustNo)



end event

type pb_close from commandbutton within w_order_viewer
integer x = 3584
integer y = 2308
integer width = 457
integer height = 128
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;close(parent)
end event

type st_5 from statictext within w_order_viewer
boolean visible = false
integer x = 2053
integer y = 1392
integer width = 613
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Mailing Address"
boolean focusrectangle = false
end type

type dw_orders from datawindow within w_order_viewer
boolean visible = false
integer x = 78
integer y = 1296
integer width = 2619
integer height = 964
integer taborder = 60
string title = "Customer Detail - Freeform DataWindow"
string dataobject = "d_order_search"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
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
//				zhouchaoqun		Date: 2004/09/08
//--------------------------------------------------------------------
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

string    ls_CustNo
nvo_util  lnv_util
long      ll_count,ll_count2

if currentrow < 1 then return

dw_Orders.selectrow(0 , false)
dw_Orders.selectrow(currentrow , true)

ls_CustNo = dw_Orders.getitemstring(currentrow , 'fcustno')

//Mailing Address
ll_count = tab_1.tabpage_1.dw_cust.Find("fcustno = '" + ls_CustNo + "'",1,tab_1.tabpage_1.dw_cust.rowcount())
ll_count2 = tab_1.tabpage_2.dw_orderlist.Find("fcustno = '" + ls_CustNo + "'",1,tab_1.tabpage_2.dw_orderlist.rowcount())

if ll_count > 0 then	
	tab_1.tabpage_1.dw_cust.scrolltorow(ll_count)
	tab_1.tabpage_2.dw_orderlist.scrolltorow(ll_count2)
	//tab_1.tabpage_1.dw_cust.event rowfocuschanged(ll_count)
end if


end event

type dw_custdetail from datawindow within w_order_viewer
boolean visible = false
integer x = 78
integer y = 1296
integer width = 2619
integer height = 964
integer taborder = 80
string title = "Customer Detail - Freeform DataWindow"
string dataobject = "d_customer"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;if currentrow > 0 then
	this.selectrow(0,false)
	this.selectrow(currentrow,true)
end if
end event

type p_bar_tv from picture within w_order_viewer
integer x = 2779
integer y = 132
integer width = 1266
integer height = 120
string picturename = ".\picture\customer_tree.jpg"
boolean focusrectangle = false
end type

type dw_orderdetail from datawindow within w_order_viewer
integer x = 78
integer y = 1300
integer width = 2619
integer height = 964
integer taborder = 60
string title = "Order Detail - Grid DataWindow"
string dataobject = "d_order_detail"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
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
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

string  ls_CustNo
nvo_util  lnv_util

if currentrow < 1 then return

dw_OrderDetail.selectrow(0 , false)
dw_OrderDetail.selectrow(currentrow , true)

ls_CustNo = dw_OrderDetail.getitemstring(currentrow , 'fcustno')

end event

type tab_1 from tab within w_order_viewer
integer x = 37
integer y = 28
integer width = 2683
integer height = 2256
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
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
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
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

Choose Case newindex
	Case 1
		dw_OrderDetail.Visible = True
		dw_CustDetail.Visible = False
		dw_orders.Visible = False
		
		pb_print.Enabled = True
	Case 2
		dw_OrderDetail.Visible = False
		dw_CustDetail.Visible = True
		dw_orders.Visible = False
		//If Not ib_Retrieved Then
		//	tab_1.tabpage_2.dw_OrderList.Event ue_retrieve()
		//	ib_Retrieved = True
		//End If
		pb_print.Enabled = True
	Case 3
				
		dw_OrderDetail.Visible = False
		dw_CustDetail.Visible = False
		dw_orders.Visible = True
		pb_print.Enabled = False
End Choose

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2647
integer height = 2128
long backcolor = 32039904
string text = " Customers"
long tabtextcolor = 33554432
long tabbackcolor = 32039904
string picturename = ".\picture\customer16.png"
long picturemaskcolor = 536870912
dw_cust dw_cust
p_bar_customer_m p_bar_customer_m
p_bar_customer_r p_bar_customer_r
p_bar_customer p_bar_customer
end type

on tabpage_1.create
this.dw_cust=create dw_cust
this.p_bar_customer_m=create p_bar_customer_m
this.p_bar_customer_r=create p_bar_customer_r
this.p_bar_customer=create p_bar_customer
this.Control[]={this.dw_cust,&
this.p_bar_customer_m,&
this.p_bar_customer_r,&
this.p_bar_customer}
end on

on tabpage_1.destroy
destroy(this.dw_cust)
destroy(this.p_bar_customer_m)
destroy(this.p_bar_customer_r)
destroy(this.p_bar_customer)
end on

type dw_cust from datawindow within tabpage_1
event ue_retrieve ( )
integer x = 23
integer y = 128
integer width = 2619
integer height = 896
integer taborder = 10
string title = "Customer Master - Grid DataWindow"
string dataobject = "d_customer_master"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_retrieve();//====================================================================
// Event: ue_retrieve()
//--------------------------------------------------------------------
// Description: Retrieve data from database and initialize treeview
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
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

retrieve()
event ue_inittree()

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
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

Long ll_OrderCount
String ls_CustNo

If currentrow < 1 Then Return

SelectRow(0 , False)
SelectRow(currentrow , True)
ls_CustNo = dw_cust.GetItemString(currentrow , 'fcustno')

ll_OrderCount = dw_OrderDetail.Retrieve(ls_CustNo)

dw_CustDetail.Retrieve(ls_CustNo)

If ll_OrderCount >0 Then
	dw_OrderDetail.Event RowFocusChanged(1)
End If


end event

type p_bar_customer_m from picture within tabpage_1
integer x = 640
integer y = 16
integer width = 1911
integer height = 120
boolean bringtotop = true
string picturename = ".\picture\titlebar_m.jpg"
boolean focusrectangle = false
end type

type p_bar_customer_r from picture within tabpage_1
integer x = 2450
integer y = 16
integer width = 192
integer height = 120
boolean bringtotop = true
string picturename = ".\picture\titlebar_r.jpg"
boolean focusrectangle = false
end type

type p_bar_customer from picture within tabpage_1
integer x = 23
integer y = 16
integer width = 649
integer height = 120
boolean bringtotop = true
boolean originalsize = true
string picturename = ".\picture\customers_details.jpg"
boolean focusrectangle = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2647
integer height = 2128
long backcolor = 32039904
string text = " Orders   "
long tabtextcolor = 33554432
long tabbackcolor = 32039904
string picturename = ".\picture\orders.png"
long picturemaskcolor = 536870912
dw_orderlist dw_orderlist
p_bar_order_m p_bar_order_m
p_bar_order_r p_bar_order_r
p_bar_order p_bar_order
end type

on tabpage_2.create
this.dw_orderlist=create dw_orderlist
this.p_bar_order_m=create p_bar_order_m
this.p_bar_order_r=create p_bar_order_r
this.p_bar_order=create p_bar_order
this.Control[]={this.dw_orderlist,&
this.p_bar_order_m,&
this.p_bar_order_r,&
this.p_bar_order}
end on

on tabpage_2.destroy
destroy(this.dw_orderlist)
destroy(this.p_bar_order_m)
destroy(this.p_bar_order_r)
destroy(this.p_bar_order)
end on

type dw_orderlist from datawindow within tabpage_2
event ue_retrieve ( )
integer x = 23
integer y = 128
integer width = 2619
integer height = 896
integer taborder = 10
string title = "Order - Grid DataWindow"
string dataobject = "d_order"
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
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

retrieve()
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
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

Long ll_row
String  ls_CustNo

ll_row = GetRow()
If ll_row < 1 Then Return
//Hignlight current row
SelectRow(0 , False)
SelectRow(ll_row , True)

ls_CustNo = GetItemString(ll_row , 'fcustno')

 dw_CustDetail.Retrieve(ls_CustNo)
end event

type p_bar_order_m from picture within tabpage_2
integer x = 640
integer y = 16
integer width = 1911
integer height = 120
boolean bringtotop = true
string picturename = ".\picture\titlebar_m.jpg"
boolean focusrectangle = false
end type

type p_bar_order_r from picture within tabpage_2
integer x = 2450
integer y = 16
integer width = 192
integer height = 120
boolean bringtotop = true
string picturename = ".\picture\titlebar_r.jpg"
boolean focusrectangle = false
end type

type p_bar_order from picture within tabpage_2
integer x = 23
integer y = 16
integer width = 649
integer height = 120
boolean bringtotop = true
boolean originalsize = true
string picturename = ".\picture\order_details.jpg"
boolean focusrectangle = false
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2647
integer height = 2128
long backcolor = 32039904
string text = " Search   "
long tabtextcolor = 33554432
long tabbackcolor = 32039904
string picturename = ".\picture\search.png"
long picturemaskcolor = 536870912
cbx_2 cbx_2
cb_3 cb_3
ddlb_1 ddlb_1
em_custno em_custno
ddlb_2 ddlb_2
em_orderno em_orderno
gb_2 gb_2
end type

on tabpage_3.create
this.cbx_2=create cbx_2
this.cb_3=create cb_3
this.ddlb_1=create ddlb_1
this.em_custno=create em_custno
this.ddlb_2=create ddlb_2
this.em_orderno=create em_orderno
this.gb_2=create gb_2
this.Control[]={this.cbx_2,&
this.cb_3,&
this.ddlb_1,&
this.em_custno,&
this.ddlb_2,&
this.em_orderno,&
this.gb_2}
end on

on tabpage_3.destroy
destroy(this.cbx_2)
destroy(this.cb_3)
destroy(this.ddlb_1)
destroy(this.em_custno)
destroy(this.ddlb_2)
destroy(this.em_orderno)
destroy(this.gb_2)
end on

type cbx_2 from checkbox within tabpage_3
boolean visible = false
integer x = 375
integer y = 404
integer width = 379
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Paid"
end type

type cb_3 from commandbutton within tabpage_3
integer x = 375
integer y = 652
integer width = 1888
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Search"
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
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

string ls_Column
string ls_Paid='-1',ls_Type='-1',ls_Temp
string  ls_OrderNo='-1',ls_CustNo='-1'
nvo_util  lnv_util

ls_Column = lower(ddlb_1.text)
if len(trim(ls_Column)) < 1 then return

choose case ls_Column
	case 'customer id'
		ls_Temp = trim(em_custno.text)
		IF ls_Temp = '' THEN
			messagebox('Alert','Please enter a valid Customer ID.')
			return
		END IF
		ls_CustNo = lnv_util.of_combine_custno(ls_Temp)
	case'order id'
		ls_Temp = trim(em_orderno.text)
		IF ls_Temp = ''  THEN
			messagebox('Alert','Please enter a valid Order ID.')
			return
		END IF
		ls_OrderNo = lnv_util.of_combine_orderno(ls_Temp)
	case 'paid'
		if cbx_2.checked = true then
			ls_Paid = '1'
		else
			ls_Paid = '0'
		end if
	case 'order type'
		ls_Temp = ddlb_2.text
		IF ls_Temp = '' THEN
			messagebox('Alert','Please select a valid Order Type.')
			return
		END IF
		ls_Type = ls_Temp
	case else
		return
end choose
dw_Orders.reset()
dw_Orders.retrieve(ls_CustNo,ls_OrderNo,ls_Paid,ls_Type)
IF dw_Orders.rowcount() < 1 THEN
	messagebox("Search","No matching record found.")
END IF


end event

type ddlb_1 from dropdownlistbox within tabpage_3
integer x = 375
integer y = 240
integer width = 1888
integer height = 736
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string item[] = {"Order ID","Paid","Order Type","Customer ID"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//====================================================================
// Event: selectionchanged()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	integer	index		
//--------------------------------------------------------------------
// Returns: long [pbm_cbnselchange]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

String ls_text

cbx_2.Visible = False
em_custno.Visible = False
ddlb_2.Visible = False

ls_text = Lower(ddlb_1.Text)
If Len(Trim(ls_text)) < 1 Then Return

Choose Case ls_text
	Case 'customer id'
		em_custno.Visible = True
		em_custno.SetFocus()
		em_orderno.Visible = False
		cbx_2.Visible = False
		ddlb_2.Visible = False
	Case 'order id'
		em_custno.Visible = False
		em_orderno.Visible = True
		cbx_2.Visible = False
		ddlb_2.Visible = False
		em_orderno.SetFocus()
	Case 'paid'
		em_custno.Visible = False
		em_orderno.Visible = False
		ddlb_2.Visible = False
		cbx_2.Visible = True
	Case 'order type'
		em_custno.Visible = False
		em_orderno.Visible = False
		cbx_2.Visible = False
		ddlb_2.Visible = True
		ddlb_2.SetFocus()
End Choose

end event

type em_custno from editmask within tabpage_3
boolean visible = false
integer x = 375
integer y = 388
integer width = 1888
integer height = 120
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "#-##-#"
end type

type ddlb_2 from dropdownlistbox within tabpage_3
boolean visible = false
integer x = 375
integer y = 388
integer width = 1888
integer height = 740
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string item[] = {"Internet","Mail","Phone"}
borderstyle borderstyle = stylelowered!
end type

type em_orderno from editmask within tabpage_3
boolean visible = false
integer x = 375
integer y = 388
integer width = 1888
integer height = 120
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "#-##-#-##"
end type

type gb_2 from groupbox within tabpage_3
boolean visible = false
integer x = 18
integer y = 48
integer width = 2624
integer height = 952
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
end type

type r_1 from rectangle within w_order_viewer
boolean visible = false
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 2990
integer y = 1568
integer width = 320
integer height = 168
end type

type r_2 from rectangle within w_order_viewer
boolean visible = false
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 2990
integer y = 1600
integer width = 320
integer height = 168
end type

type tv_1 from treeview within w_order_viewer
integer x = 2779
integer y = 248
integer width = 1266
integer height = 2024
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33159673
borderstyle borderstyle = stylelowered!
boolean deleteitems = true
boolean linesatroot = true
boolean hideselection = false
boolean tooltips = false
string picturename[] = {".\picture\ceo.png",".\picture\data_chooser.png",".\picture\client_account_template.png"}
long picturemaskcolor = 12632256
string statepicturename[] = {"AppIcon!"}
long statepicturemaskcolor = 12632256
end type

event selectionchanged;//====================================================================
// Event: selectionchanged()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	long	oldhandle		
//		value	long	newhandle		
//--------------------------------------------------------------------
// Returns: long [pbm_tvnselchanged]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

treeviewitem ltvi_cur , ltvi_parent
Long ll_level ,ll_row , ll_rowcnt, ll_Find
String  ls_CustNo,ls_OrderNo

GetItem(newhandle , ltvi_cur)

ll_level = ltvi_cur.Level

If ll_level = 1 Then
	ls_CustNo = ltvi_cur.Data
	//First level,current customer changed
	ll_rowcnt = tab_1.tabpage_1.dw_cust.RowCount()
	ll_Find = tab_1.tabpage_1.dw_cust.Find("fcustno='"+ls_CustNo+"'",1,ll_rowcnt)
	If ll_Find > 0 Then
		tab_1.tabpage_1.dw_cust.ScrollToRow(ll_Find)
	End If
	
	ll_rowcnt = tab_1.tabpage_2.dw_orderlist.RowCount()
	ll_Find = tab_1.tabpage_2.dw_orderlist.Find("fcustno='"+ls_CustNo+"'",1,ll_rowcnt)
	If ll_Find > 0 Then
		tab_1.tabpage_2.dw_orderlist.ScrollToRow(ll_Find)
	End If
	
ElseIf ll_level = 2 Then
	//Second level,current order changed
	ls_OrderNo = ltvi_cur.Data
	
	//First find current order's customer
	ll_row = tv_1.FindItem( ParentTreeItem!	, newhandle)
	GetItem(ll_row , ltvi_parent)
	
	ls_CustNo = ltvi_parent.Data
	
	//Sync Customer List
	ll_rowcnt = tab_1.tabpage_1.dw_cust.RowCount()
	ll_Find = tab_1.tabpage_1.dw_cust.Find("fcustno='"+ls_CustNo+"'",1,ll_rowcnt)
	If ll_Find > 0 Then
		tab_1.tabpage_1.dw_cust.ScrollToRow(ll_Find)
	End If
	
	//Sync OrderList
	ll_rowcnt = tab_1.tabpage_2.dw_orderlist.RowCount()
	ll_Find = tab_1.tabpage_2.dw_orderlist.Find("forderno='"+ls_OrderNo+"'",1,ll_rowcnt)
	If ll_Find > 0 Then
		tab_1.tabpage_2.dw_orderlist.ScrollToRow(ll_Find)
	End If
	
	//Sync OrderList
	ll_rowcnt = dw_Orders.RowCount()
	ll_Find = dw_Orders.Find("forderno='"+ls_OrderNo+"'",1,ll_rowcnt)
	If ll_Find > 0 Then
		dw_Orders.ScrollToRow(ll_Find)
	End If
	
	//Sync Order Detail
	ll_rowcnt = dw_OrderDetail.RowCount()
	ll_Find = dw_OrderDetail.Find("forderno='"+ls_OrderNo+"'",1,ll_rowcnt)
	If ll_Find > 0 Then
		dw_OrderDetail.ScrollToRow(ll_Find)
	End If
	
End If

end event

event itempopulate;//====================================================================
// Event: itempopulate()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	long	handle		
//--------------------------------------------------------------------
// Returns: long [pbm_tvnitempopulate]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

treeviewitem ltvi_cur
Boolean lb_ret
String  ls_No

GetItem(Handle , ltvi_cur)

ls_No = ltvi_cur.Data

lb_ret = uf_inittree(Handle, ls_No)

ltvi_cur.Children = lb_ret

SetItem(Handle, ltvi_cur)



end event

type p_bar_result_m from picture within w_order_viewer
integer x = 681
integer y = 1180
integer width = 1915
integer height = 120
boolean bringtotop = true
string picturename = ".\picture\titlebar_m.jpg"
boolean focusrectangle = false
end type

type p_bar_result_r from picture within w_order_viewer
integer x = 2505
integer y = 1180
integer width = 192
integer height = 120
boolean bringtotop = true
string picturename = ".\picture\titlebar_r.jpg"
boolean focusrectangle = false
end type

type p_bar_result from picture within w_order_viewer
integer x = 78
integer y = 1180
integer width = 649
integer height = 120
boolean bringtotop = true
boolean originalsize = true
string picturename = ".\picture\order_details.jpg"
boolean focusrectangle = false
end type

