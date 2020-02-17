$PBExportHeader$w_set_filter_product.srw
$PBExportComments$Set Filter  statement--Product
forward
global type w_set_filter_product from window
end type
type cb_2 from commandbutton within w_set_filter_product
end type
type cb_1 from commandbutton within w_set_filter_product
end type
type dw_3 from datawindow within w_set_filter_product
end type
type gb_3 from groupbox within w_set_filter_product
end type
end forward

global type w_set_filter_product from window
integer width = 2235
integer height = 744
boolean titlebar = true
string title = "Set Product Filter"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
event type integer ue_getfilter ( )
cb_2 cb_2
cb_1 cb_1
dw_3 dw_3
gb_3 gb_3
end type
global w_set_filter_product w_set_filter_product

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
string  is_ProductFilter

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

If dw_3.AcceptText() < 0 Then Return -1
ls_Operator = dw_3.GetItemString(1,'foperator')

li_Count = Integer(dw_3.Describe("datawindow.column.count"))
For li_cnt = 1 To li_Count
	ls_ColName = dw_3.Describe("#"+String(li_cnt)+".name")
	If ls_ColName = 'foperator' Then Continue
	ls_Data = String(dw_3.Object.Data[1,li_cnt])
	ls_Data = Trim(ls_Data)
	If ls_Data = '' Or IsNull(ls_Data) Then Continue
	If ls_ColName = 'funit_price' Then
		ls_Temp = " ( "+ls_ColName +" "+ls_Operator+" "+ls_Data+" ) "
	Else
		ls_Temp = " ( "+ls_ColName +" = '"+ls_Data+"' ) "
	End If
	If is_ProductFilter = '' Then
		is_ProductFilter = ls_Temp
	Else
		is_ProductFilter += " AND "+ls_Temp
	End If
Next
//comment by liulihua begin
//If  is_ProductFilter = '' Then
//	MessageBox('Alert','Please set the filter criteria.')
//	Return -1
//End If
//comment end
Return 1

end event

on w_set_filter_product.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_3=create dw_3
this.gb_3=create gb_3
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_3,&
this.gb_3}
end on

on w_set_filter_product.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.gb_3)
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

is_CallType = message.stringparm

dw_3.settransobject(SQLCA)
dw_3.insertrow(0)

end event

type cb_2 from commandbutton within w_set_filter_product
integer x = 1714
integer y = 488
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

type cb_1 from commandbutton within w_set_filter_product
integer x = 1216
integer y = 488
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

IF parent.event ue_getfilter() < 0 THEN return

w_product_edit.event ue_setfilter(is_ProductFilter)

close(parent)
end event

type dw_3 from datawindow within w_set_filter_product
integer x = 87
integer y = 100
integer width = 2021
integer height = 312
integer taborder = 30
string title = "none"
string dataobject = "d_product_filter"
boolean border = false
boolean livescroll = true
end type

type gb_3 from groupbox within w_set_filter_product
integer x = 41
integer y = 32
integer width = 2117
integer height = 416
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Product"
end type

