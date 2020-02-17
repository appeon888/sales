$PBExportHeader$w_set_filter_cust_order.srw
$PBExportComments$Set Filter  statement,Customer and Order
forward
global type w_set_filter_cust_order from window
end type
type cb_2 from commandbutton within w_set_filter_cust_order
end type
type cb_1 from commandbutton within w_set_filter_cust_order
end type
type dw_2 from datawindow within w_set_filter_cust_order
end type
type dw_1 from datawindow within w_set_filter_cust_order
end type
type gb_1 from groupbox within w_set_filter_cust_order
end type
type gb_2 from groupbox within w_set_filter_cust_order
end type
end forward

global type w_set_filter_cust_order from window
integer width = 2752
integer height = 1300
boolean titlebar = true
string title = "Set Customer and Order Filter"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
event type integer ue_getfilter ( )
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
end type
global w_set_filter_cust_order w_set_filter_cust_order

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

string   is_CallType
string   is_CustFilter,is_OrderFilter,is_ProductFilter

end variables

event type integer ue_getfilter();//====================================================================
// Event: ue_getfilter()
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

Int   li_cnt,li_Count
String  ls_ColName,ls_Data,ls_Operator,ls_Temp

If dw_1.AcceptText() < 0 Then Return -1
li_Count = Integer(dw_1.Describe("datawindow.column.count"))
For li_cnt = 1 To li_Count
	ls_ColName = dw_1.Describe("#"+String(li_cnt)+".name")
	ls_Data = String(dw_1.Object.Data[1,li_cnt])
	ls_Data = Trim(ls_Data)
	If ls_Data = '' Or IsNull(ls_Data) Then Continue
	If is_CustFIlter = '' Then
		is_CustFIlter = " ( "+ls_ColName +" = '"+ls_Data+"' ) "
	Else
		is_CustFIlter += " AND ( "+ls_ColName +" = '"+ls_Data+"' ) "
	End If
Next

If dw_2.AcceptText() < 0 Then Return -1
ls_Operator = dw_2.GetItemString(1,'foperator')

li_Count = Integer(dw_2.Describe("datawindow.column.count"))
For li_cnt = 1 To li_Count
	ls_ColName = dw_2.Describe("#"+String(li_cnt)+".name")
	If ls_ColName = 'foperator' Then Continue
	ls_Data = String(dw_2.Object.Data[1,li_cnt])
	ls_Data = Trim(ls_Data)
	If ls_Data = '' Or IsNull(ls_Data) Then Continue
	If ls_ColName = 'famount' Then
		ls_Temp = " ( "+ls_ColName +" "+ls_Operator+" "+ls_Data+" ) "
	Else
		ls_Temp = " ( "+ls_ColName +" = '"+ls_Data+"' ) "
	End If
	If is_OrderFilter = '' Then
		is_OrderFilter = ls_Temp
	Else
		is_OrderFilter += " AND "+ls_Temp
	End If
Next

//comment by liulihua for filter all data
//If is_CustFIlter = '' And is_ProductFilter = '' And is_OrderFilter = '' Then
//	MessageBox('Alert','Please set the filter criteria.')
//	Return -1
//End If
//comment end
Return 1

end event

on w_set_filter_cust_order.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_2,&
this.dw_1,&
this.gb_1,&
this.gb_2}
end on

on w_set_filter_cust_order.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
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

is_CallType = Message.StringParm
dw_1.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
dw_1.InsertRow(0)
dw_2.InsertRow(0)
Choose Case Lower(is_CallType)
	Case 'w_accounts_receivable'
		dw_1.Object.fpaymentdue.protect = '1'
		dw_2.Object.fpaid.protect = '1'
	Case 'w_order_main'
		dw_1.Object.fhasorders.protect = '1'
End Choose


end event

type cb_2 from commandbutton within w_set_filter_cust_order
integer x = 2226
integer y = 236
integer width = 448
integer height = 120
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean cancel = true
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

closewithreturn(parent,'cancel')
end event

type cb_1 from commandbutton within w_set_filter_cust_order
integer x = 2226
integer y = 76
integer width = 448
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Set"
boolean default = true
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

If Parent.Event ue_getfilter() < 0 Then Return
Choose Case Lower(is_CallType)
	Case 'w_accounts_receivable'
		w_accounts_receivable.Post Event ue_setfilter(is_CustFilter,is_OrderFilter,is_ProductFilter)
	Case 'w_customer_maintenance'
		w_customer_maintenance.Post Event ue_setfilter(is_CustFilter,is_OrderFilter,is_ProductFilter)
	Case 'w_customer_select'
		w_customer_select.Post Event ue_setfilter(is_CustFilter,is_OrderFilter,is_ProductFilter)
	Case 'w_ship_order'
		w_ship_order.Post Event ue_setfilter(is_CustFilter,is_OrderFilter,is_ProductFilter)
	Case 'w_processing_order'
		w_processing_order.dynamic Post Event ue_setfilter(is_CustFilter,is_OrderFilter,is_ProductFilter)
	Case 'w_order_main'
		w_order_main.Post Event ue_setfilter(is_CustFilter,is_OrderFilter,is_ProductFilter)
End Choose

CLOSE(Parent)

end event

type dw_2 from datawindow within w_set_filter_cust_order
integer x = 64
integer y = 736
integer width = 2002
integer height = 364
integer taborder = 20
string title = "none"
string dataobject = "d_order_filter"
boolean border = false
boolean livescroll = true
end type

type dw_1 from datawindow within w_set_filter_cust_order
integer x = 78
integer y = 88
integer width = 2021
integer height = 500
integer taborder = 10
string title = "none"
string dataobject = "d_cust_filter"
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within w_set_filter_cust_order
integer x = 41
integer y = 32
integer width = 2117
integer height = 600
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Customer"
end type

type gb_2 from groupbox within w_set_filter_cust_order
integer x = 41
integer y = 672
integer width = 2117
integer height = 496
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Order"
end type

