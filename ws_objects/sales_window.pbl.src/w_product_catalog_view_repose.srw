$PBExportHeader$w_product_catalog_view_repose.srw
$PBExportComments$Response window
forward
global type w_product_catalog_view_repose from window
end type
type cb_print from commandbutton within w_product_catalog_view_repose
end type
type cb_saveas from commandbutton within w_product_catalog_view_repose
end type
type cb_close from commandbutton within w_product_catalog_view_repose
end type
type dw_1 from datawindow within w_product_catalog_view_repose
end type
end forward

global type w_product_catalog_view_repose from window
integer width = 3689
integer height = 2232
boolean titlebar = true
string title = "View Product Catalog"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
event ue_saveas ( )
event ue_print ( )
cb_print cb_print
cb_saveas cb_saveas
cb_close cb_close
dw_1 dw_1
end type
global w_product_catalog_view_repose w_product_catalog_view_repose

event ue_saveas();//====================================================================
// Event: ue_saveas()
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

dw_1.saveas()	
end event

event ue_print();//====================================================================
// Event: ue_print()
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

dw_1.print()
end event

on w_product_catalog_view_repose.create
this.cb_print=create cb_print
this.cb_saveas=create cb_saveas
this.cb_close=create cb_close
this.dw_1=create dw_1
this.Control[]={this.cb_print,&
this.cb_saveas,&
this.cb_close,&
this.dw_1}
end on

on w_product_catalog_view_repose.destroy
destroy(this.cb_print)
destroy(this.cb_saveas)
destroy(this.cb_close)
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

dw_1.setTransObject(sqlca)
dw_1.retrieve()


end event

type cb_print from commandbutton within w_product_catalog_view_repose
integer x = 2679
integer y = 2000
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

type cb_saveas from commandbutton within w_product_catalog_view_repose
boolean visible = false
integer x = 2683
integer y = 2000
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

type cb_close from commandbutton within w_product_catalog_view_repose
integer x = 3159
integer y = 2000
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

type dw_1 from datawindow within w_product_catalog_view_repose
integer x = 23
integer y = 32
integer width = 3611
integer height = 1928
integer taborder = 10
string title = "none"
string dataobject = "d_product_category_grp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

