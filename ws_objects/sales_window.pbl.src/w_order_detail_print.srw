$PBExportHeader$w_order_detail_print.srw
$PBExportComments$With Print
forward
global type w_order_detail_print from w_order_detail
end type
type cb_3 from commandbutton within w_order_detail_print
end type
type cb_1 from commandbutton within w_order_detail_print
end type
end forward

global type w_order_detail_print from w_order_detail
cb_3 cb_3
cb_1 cb_1
end type
global w_order_detail_print w_order_detail_print

on w_order_detail_print.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_1
end on

on w_order_detail_print.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_1)
end on

type dw_order from w_order_detail`dw_order within w_order_detail_print
end type

type tab_1 from w_order_detail`tab_1 within w_order_detail_print
end type

type tabpage_1 from w_order_detail`tabpage_1 within tab_1
end type

type dw_cust from w_order_detail`dw_cust within tabpage_1
end type

type tabpage_2 from w_order_detail`tabpage_2 within tab_1
end type

type dw_product from w_order_detail`dw_product within tabpage_2
end type

type cb_2 from w_order_detail`cb_2 within w_order_detail_print
end type

type p_1 from w_order_detail`p_1 within w_order_detail_print
end type

type p_2 from w_order_detail`p_2 within w_order_detail_print
end type

type p_3 from w_order_detail`p_3 within w_order_detail_print
end type

type cb_3 from commandbutton within w_order_detail_print
integer x = 745
integer y = 1708
integer width = 681
integer height = 120
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Print Address Label"
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

nvo_util   lnv_util

lnv_util.of_print_addresslabel(is_OrderNo)



end event

type cb_1 from commandbutton within w_order_detail_print
integer x = 37
integer y = 1708
integer width = 681
integer height = 120
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Print Packing Slip"
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

nvo_util   lnv_util

lnv_util.of_print_packingslip(is_OrderNo)



end event

