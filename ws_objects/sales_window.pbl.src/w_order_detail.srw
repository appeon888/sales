$PBExportHeader$w_order_detail.srw
forward
global type w_order_detail from window
end type
type dw_order from datawindow within w_order_detail
end type
type tab_1 from tab within w_order_detail
end type
type tabpage_1 from userobject within tab_1
end type
type dw_cust from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_cust dw_cust
end type
type tabpage_2 from userobject within tab_1
end type
type dw_product from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_product dw_product
end type
type tab_1 from tab within w_order_detail
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_2 from commandbutton within w_order_detail
end type
type p_1 from picture within w_order_detail
end type
type p_2 from picture within w_order_detail
end type
type p_3 from picture within w_order_detail
end type
end forward

global type w_order_detail from window
integer width = 3205
integer height = 1932
boolean titlebar = true
string title = "Order Detail"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
event ue_open ( )
dw_order dw_order
tab_1 tab_1
cb_2 cb_2
p_1 p_1
p_2 p_2
p_3 p_3
end type
global w_order_detail w_order_detail

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

string  is_CustNo,is_OrderNo
end variables

on w_order_detail.create
this.dw_order=create dw_order
this.tab_1=create tab_1
this.cb_2=create cb_2
this.p_1=create p_1
this.p_2=create p_2
this.p_3=create p_3
this.Control[]={this.dw_order,&
this.tab_1,&
this.cb_2,&
this.p_1,&
this.p_2,&
this.p_3}
end on

on w_order_detail.destroy
destroy(this.dw_order)
destroy(this.tab_1)
destroy(this.cb_2)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.p_3)
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

String    ls_parm
Integer  li_pos


ls_parm  = Message.StringParm

li_pos  =  Pos(ls_parm,'$')

is_custno  = Left(ls_parm,li_pos - 1)
is_orderno = Mid(ls_parm,li_pos + 1)

//retrieve data
tab_1.tabpage_1.dw_cust.Event  ue_retrieve(is_custno)
dw_order.Event ue_retrieve(is_orderno)
tab_1.tabpage_2.dw_product.Event ue_retrieve(is_orderno)
//set the readonly  property  of  datawindow
tab_1.tabpage_1.dw_cust.Object.datawindow.Readonly = True
dw_order.Object.datawindow.Readonly = True
tab_1.tabpage_2.dw_product.Object.datawindow.Readonly = True



end event

type dw_order from datawindow within w_order_detail
event ue_retrieve ( string as_orderno )
integer x = 46
integer y = 132
integer width = 3109
integer height = 496
integer taborder = 20
string title = "none"
string dataobject = "d_order_info"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_retrieve(string as_orderno);//====================================================================
// Event: ue_retrieve()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_orderno		
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
this.retrieve(as_orderno)
end event

type tab_1 from tab within w_order_detail
event create ( )
event destroy ( )
integer x = 37
integer y = 644
integer width = 3127
integer height = 1048
integer taborder = 20
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

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3090
integer height = 920
long backcolor = 32039904
string text = "Customer Details"
long tabbackcolor = 32039904
string picturename = "Custom076!"
long picturemaskcolor = 536870912
dw_cust dw_cust
end type

on tabpage_1.create
this.dw_cust=create dw_cust
this.Control[]={this.dw_cust}
end on

on tabpage_1.destroy
destroy(this.dw_cust)
end on

type dw_cust from datawindow within tabpage_1
event ue_retrieve ( string as_custno )
integer x = 18
integer y = 16
integer width = 3054
integer height = 884
integer taborder = 40
string title = "none"
string dataobject = "d_customer_info"
borderstyle borderstyle = stylelowered!
end type

event ue_retrieve(string as_custno);//====================================================================
// Event: ue_retrieve()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_custno		
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
this.retrieve(as_custno)
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3090
integer height = 920
long backcolor = 32039904
string text = "Product Details"
long tabtextcolor = 33554432
long tabbackcolor = 32039904
string picturename = "PlaceColumn!"
long picturemaskcolor = 536870912
dw_product dw_product
end type

on tabpage_2.create
this.dw_product=create dw_product
this.Control[]={this.dw_product}
end on

on tabpage_2.destroy
destroy(this.dw_product)
end on

type dw_product from u_dw within tabpage_2
event ue_retrieve ( string as_orderno )
integer x = 18
integer y = 16
integer width = 3054
integer height = 884
integer taborder = 30
string dataobject = "d_product_info"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_retrieve(string as_orderno);//====================================================================
// Event: ue_retrieve()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_orderno		
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
this.retrieve(as_orderno)
end event

type cb_2 from commandbutton within w_order_detail
integer x = 2706
integer y = 1716
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

type p_1 from picture within w_order_detail
integer x = 37
integer y = 20
integer width = 2743
integer height = 120
boolean bringtotop = true
boolean originalsize = true
string picturename = ".\picture\Order-Information2.jpg"
boolean focusrectangle = false
end type

type p_2 from picture within w_order_detail
integer x = 2583
integer y = 20
integer width = 425
integer height = 120
boolean bringtotop = true
boolean originalsize = true
string picturename = ".\picture\titlebar_m2.jpg"
boolean focusrectangle = false
end type

type p_3 from picture within w_order_detail
integer x = 2958
integer y = 20
integer width = 192
integer height = 120
boolean bringtotop = true
boolean originalsize = true
string picturename = ".\picture\titlebar_r2.jpg"
boolean focusrectangle = false
end type

