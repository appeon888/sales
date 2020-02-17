$PBExportHeader$w_set_filter_order.srw
$PBExportComments$Set Filter  statement
forward
global type w_set_filter_order from window
end type
type cb_2 from commandbutton within w_set_filter_order
end type
type cb_1 from commandbutton within w_set_filter_order
end type
type dw_2 from datawindow within w_set_filter_order
end type
type gb_2 from groupbox within w_set_filter_order
end type
end forward

global type w_set_filter_order from window
integer width = 2235
integer height = 816
boolean titlebar = true
string title = "Set Order Filter"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
event type integer ue_getfilter ( )
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
gb_2 gb_2
end type
global w_set_filter_order w_set_filter_order

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

If is_CustFIlter = '' And is_ProductFilter = '' And is_OrderFilter = '' Then
	MessageBox('Alert','Please set the filter criteria.')
	Return -1
End If

Return 1

end event

on w_set_filter_order.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.gb_2=create gb_2
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_2,&
this.gb_2}
end on

on w_set_filter_order.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
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
dw_2.SetTransObject(SQLCA)
dw_2.InsertRow(0)
Choose Case Lower(is_CallType)
	Case 'w_accounts_receivable'
		dw_2.Object.fpaid.protect = '1'
End Choose


end event

type cb_2 from commandbutton within w_set_filter_order
integer x = 1719
integer y = 556
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

type cb_1 from commandbutton within w_set_filter_order
integer x = 1225
integer y = 556
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
		w_processing_order.Post Event ue_setfilter(is_CustFilter,is_OrderFilter,is_ProductFilter)
	Case 'w_order_main'
		w_order_main.Post Event ue_setfilter(is_CustFilter,is_OrderFilter,is_ProductFilter)
End Choose

CLOSE(Parent)

end event

type dw_2 from datawindow within w_set_filter_order
integer x = 64
integer y = 88
integer width = 2002
integer height = 368
integer taborder = 20
string title = "none"
string dataobject = "d_order_filter"
boolean border = false
boolean livescroll = true
end type

type gb_2 from groupbox within w_set_filter_order
integer x = 41
integer y = 32
integer width = 2117
integer height = 472
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

