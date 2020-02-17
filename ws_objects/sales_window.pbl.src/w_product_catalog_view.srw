$PBExportHeader$w_product_catalog_view.srw
forward
global type w_product_catalog_view from w_sheet
end type
type cb_saveas from commandbutton within w_product_catalog_view
end type
type cb_close from commandbutton within w_product_catalog_view
end type
type dw_1 from datawindow within w_product_catalog_view
end type
type cb_print from commandbutton within w_product_catalog_view
end type
end forward

global type w_product_catalog_view from w_sheet
integer width = 3072
integer height = 2204
string title = "View Product Catalog"
string menuname = "m_mdi_none"
long backcolor = 32039904
event ue_saveas ( )
event ue_print ( )
cb_saveas cb_saveas
cb_close cb_close
dw_1 dw_1
cb_print cb_print
end type
global w_product_catalog_view w_product_catalog_view

event ue_saveas();//====================================================================
// Event: ue_saveas()
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

dw_1.saveas()	
end event

event ue_print();//====================================================================
// Event: ue_print()
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

dw_1.print()
end event

on w_product_catalog_view.create
int iCurrent
call super::create
if this.MenuName = "m_mdi_none" then this.MenuID = create m_mdi_none
this.cb_saveas=create cb_saveas
this.cb_close=create cb_close
this.dw_1=create dw_1
this.cb_print=create cb_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_saveas
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_print
end on

on w_product_catalog_view.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_saveas)
destroy(this.cb_close)
destroy(this.dw_1)
destroy(this.cb_print)
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

dw_1.setTransObject(sqlca)
dw_1.retrieve()


//Set menu right
nvo_security  lnv_Security

lnv_Security.of_setmenuright(this.menuid)


end event

event resize;//====================================================================
// Event: resize()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		unsignedlong	sizetype 		
//		integer     	newwidth 		
//		integer     	newheight		
//--------------------------------------------------------------------
// Returns: long [pbm_size]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

cb_print.y = newheight - cb_print.height - 20
cb_saveas.y = cb_print.y
cb_close.y = cb_print.y

cb_close.x = newwidth - cb_close.width - 20
cb_saveas.x = cb_close.x - cb_saveas.width - 40
cb_print.x = cb_saveas.x//cb_saveas.x - cb_print.width - 40

dw_1.width = newwidth - 50
dw_1.height = cb_print.y - dw_1.y - 20

end event

type cb_saveas from commandbutton within w_product_catalog_view
boolean visible = false
integer x = 2071
integer y = 1868
integer width = 448
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save As"
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

dw_1.saveas( )
end event

type cb_close from commandbutton within w_product_catalog_view
boolean visible = false
integer x = 2551
integer y = 1868
integer width = 448
integer height = 120
integer taborder = 20
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

Close(parent)
end event

type dw_1 from datawindow within w_product_catalog_view
integer x = 32
integer y = 32
integer width = 2967
integer height = 1792
integer taborder = 10
string title = "none"
string dataobject = "d_product_category_grp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_print from commandbutton within w_product_catalog_view
boolean visible = false
integer x = 2071
integer y = 1868
integer width = 448
integer height = 120
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Print"
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

dw_1.print()
end event

