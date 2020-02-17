$PBExportHeader$w_customer_select.srw
$PBExportComments$Select Customers
forward
global type w_customer_select from window
end type
type cb_select from commandbutton within w_customer_select
end type
type cb_7 from commandbutton within w_customer_select
end type
type mle_filter from multilineedit within w_customer_select
end type
type cb_2 from commandbutton within w_customer_select
end type
type cb_4 from commandbutton within w_customer_select
end type
type cb_9 from commandbutton within w_customer_select
end type
type dw_1 from datawindow within w_customer_select
end type
end forward

global type w_customer_select from window
integer width = 2592
integer height = 1476
boolean titlebar = true
string title = "Select Customer"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
event ue_open ( )
event type integer ue_setfilter ( string as_custfilter,  string as_orderfilter,  string as_productfilter )
cb_select cb_select
cb_7 cb_7
mle_filter mle_filter
cb_2 cb_2
cb_4 cb_4
cb_9 cb_9
dw_1 dw_1
end type
global w_customer_select w_customer_select

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

boolean ib_Retrieved=FALSE

end variables

event ue_open();//====================================================================
// Event: ue_open()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		None		
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

dw_1.event  ue_init()
dw_1.event  ue_retrieve()
end event

event type integer ue_setfilter(string as_custfilter, string as_orderfilter, string as_productfilter);//====================================================================
// Event: ue_setfilter()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		string	as_custfilter   		
//		string	as_orderfilter  		
//		string	as_productfilter		
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

IF as_CustFilter <>'' THEN
	dw_1.SetFilter(as_CustFilter)
	dw_1.filter()
	mle_filter.text = string(dw_1.rowcount())+" matches."
END IF
return 1
end event

on w_customer_select.create
this.cb_select=create cb_select
this.cb_7=create cb_7
this.mle_filter=create mle_filter
this.cb_2=create cb_2
this.cb_4=create cb_4
this.cb_9=create cb_9
this.dw_1=create dw_1
this.Control[]={this.cb_select,&
this.cb_7,&
this.mle_filter,&
this.cb_2,&
this.cb_4,&
this.cb_9,&
this.dw_1}
end on

on w_customer_select.destroy
destroy(this.cb_select)
destroy(this.cb_7)
destroy(this.mle_filter)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.cb_9)
destroy(this.dw_1)
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

dw_1.modify("datawindow.readonly=yes")
this.event   ue_open()
end event

type cb_select from commandbutton within w_customer_select
integer x = 1664
integer y = 1260
integer width = 521
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Select Customer"
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
string  ls_CustNo

li_Row = dw_1.getrow()
IF li_Row < 1 THEN return

ls_CustNo = dw_1.getitemstring(li_Row,'FCustNo')

closewithreturn(parent,ls_CustNo)
end event

type cb_7 from commandbutton within w_customer_select
integer x = 2217
integer y = 1260
integer width = 343
integer height = 104
integer taborder = 30
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

type mle_filter from multilineedit within w_customer_select
integer x = 1074
integer y = 1280
integer width = 411
integer height = 76
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

type cb_2 from commandbutton within w_customer_select
integer x = 14
integer y = 1260
integer width = 320
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

openwithparm(w_sort_single,dw_1)
end event

type cb_4 from commandbutton within w_customer_select
integer x = 709
integer y = 1260
integer width = 320
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

openwithparm(w_set_filter_customer,'w_customer_select')
end event

type cb_9 from commandbutton within w_customer_select
integer x = 361
integer y = 1260
integer width = 320
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

dw_1.SetFilter("")
dw_1.Filter()
dw_1.Event RowFocusChanged(dw_1.GetRow())

end event

type dw_1 from datawindow within w_customer_select
event ue_retrieve ( )
event ue_init ( )
event ue_update ( )
event type string ue_getcustno ( )
integer x = 9
integer y = 4
integer width = 2546
integer height = 1232
integer taborder = 10
string title = "none"
string dataobject = "d_customer_maintenance"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_retrieve();//====================================================================
// Event: ue_retrieve()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		None		
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

this.retrieve()
end event

event ue_init();//====================================================================
// Event: ue_init()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		None		
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
end event

event type string ue_getcustno();//====================================================================
// Event: ue_getcustno()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
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

integer   li_row

li_row  =  this.getrow()
IF li_Row < 1 THEN return ''
return   this.getitemstring(li_row,'fcustno')
end event

event doubleclicked;//====================================================================
// Event: doubleclicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		integer 	xpos		
//		integer 	ypos		
//		long    	row 		
//		dwobject	dwo 		
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

cb_Select.event clicked()
end event

event clicked;//====================================================================
// Event: clicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		integer 	xpos		
//		integer 	ypos		
//		long    	row 		
//		dwobject	dwo 		
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
this.selectrow(0,false)
this.selectrow(row,true)

end event

event rowfocuschanged;//====================================================================
// Event: rowfocuschanged()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		long	currentrow		
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

if  currentrow > 0 then 
	this.scrolltorow(currentrow)
	this.selectrow(0,false)
	this.selectrow(currentrow,true)
END IF
end event

