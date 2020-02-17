$PBExportHeader$w_rpt_order_date_summary.srw
$PBExportComments$OrderDate Summary
forward
global type w_rpt_order_date_summary from w_sheet
end type
type uo_1 from u_year_between within w_rpt_order_date_summary
end type
type cb_1 from commandbutton within w_rpt_order_date_summary
end type
type cb_close from commandbutton within w_rpt_order_date_summary
end type
type cb_saveas from commandbutton within w_rpt_order_date_summary
end type
type cb_print from commandbutton within w_rpt_order_date_summary
end type
type dw_1 from datawindow within w_rpt_order_date_summary
end type
type gb_1 from groupbox within w_rpt_order_date_summary
end type
end forward

global type w_rpt_order_date_summary from w_sheet
boolean visible = false
integer width = 4037
integer height = 2072
string title = "Sales Report by Customer"
string menuname = "m_mdi_none"
long backcolor = 32039904
event ue_retrieve ( )
event ue_saveas ( )
event ue_print ( )
event ue_settings ( string as_action )
event ue_setdefault ( string as_type )
event ue_postopen ( )
event ue_setautorefresh ( boolean ab_autorefresh )
uo_1 uo_1
cb_1 cb_1
cb_close cb_close
cb_saveas cb_saveas
cb_print cb_print
dw_1 dw_1
gb_1 gb_1
end type
global w_rpt_order_date_summary w_rpt_order_date_summary

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

str_rptparm		istr_parm
str_rpt_options   istr_rpt_options
boolean   ib_AutoRefresh = false

end variables

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
// CopyRight 2003----???? Appeon Inc.
//====================================================================

integer  li_From,li_To,li_Count

li_From = uo_1.of_get_fromyear()
li_To = uo_1.of_get_toyear()
IF li_From > li_To THEN
	messagebox("Alert","Please set a valid year scope.")
	return
END IF

li_Count = li_to - li_from
IF li_Count > 12 THEN
	messagebox("Alert","The secified Order Date scope is too long for this report. It must be less than 12 years.")
	return	
END IF

dw_1.retrieve(li_from,li_To)
end event

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

event ue_settings(string as_action);//====================================================================
// Event: ue_settings()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_action		
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

string  ls_Ret

CHOOSE CASE lower(as_action)
	CASE 'year scope'
		this.event ue_setdefault("year")
END CHOOSE

return 

end event

event ue_setdefault(string as_type);//====================================================================
// Event: ue_setdefault()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_type		
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

string  ls_Ret

IF as_type = 'year' THEN
	openwithparm(w_rpt_default_year,this.title)
	ls_Ret = message.stringparm
	IF ls_Ret = 'cancel' OR isnull(ls_Ret) THEN return
	
	uo_1.of_set_yearscope(ls_Ret)
	IF ib_AutoRefresh THEN
		this.event ue_retrieve()
	END IF
ELSE
	//Nothing to do
END IF
end event

event ue_postopen();//====================================================================
// Event: ue_postopen()
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

//Set menu right
nvo_security  lnv_Security
lnv_Security.of_setmenuright(this.menuid)

nvo_util  lnv_util
int  li_Ret,li_Cnt

li_Ret = lnv_util.of_get_rptoptions( this.title, istr_rpt_options)
IF li_Ret < 0 THEN return

//Set date scope
uo_1.of_set_yearscope(istr_rpt_options.fdefaultyear)

ib_AutoRefresh = istr_rpt_options.fautorefresh
IF ib_AutoRefresh THEN
	this.event ue_retrieve()
END IF

//m_customer_order  lm
//
//lm = this.menuid
//
//lm.m_settings.m_autorefresh.checked = ib_AutoRefresh
//this.post show()
end event

event ue_setautorefresh(boolean ab_autorefresh);//====================================================================
// Event: ue_setautorefresh()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	boolean	ab_autorefresh		
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

nvo_util  lnv_util

ib_autorefresh = ab_autorefresh
lnv_util.of_set_param( gs_user_no, 'Report Options'+"autorefresh", string(ab_autorefresh))
return
end event

on w_rpt_order_date_summary.create
int iCurrent
call super::create
if this.MenuName = "m_mdi_none" then this.MenuID = create m_mdi_none
this.uo_1=create uo_1
this.cb_1=create cb_1
this.cb_close=create cb_close
this.cb_saveas=create cb_saveas
this.cb_print=create cb_print
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_saveas
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.gb_1
end on

on w_rpt_order_date_summary.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.cb_saveas)
destroy(this.cb_print)
destroy(this.dw_1)
destroy(this.gb_1)
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


istr_parm = Message.powerobjectparm

//set report window title & dataobject
This.title = istr_parm.ftitle
IF istr_parm.fdataobject <>'' THEN
	dw_1.dataObject = istr_parm.fdataobject
END IF

dw_1.settransObject(sqlca)
//Initial report style,DO NOT trigger selectionchanged event 

this.post event ue_postopen()

end event

event resize;//====================================================================
// Event: resize()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	unsignedlong	sizetype 		
//		value	integer     	newwidth 		
//		value	integer     	newheight		
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

dw_1.width = newwidth - 50
gb_1.width = dw_1.width
dw_1.height = newheight - dw_1.y - 20
//cb_close.x = newwidth - 400
end event

type uo_1 from u_year_between within w_rpt_order_date_summary
event destroy ( )
integer x = 69
integer y = 64
integer taborder = 50
end type

on uo_1.destroy
call u_year_between::destroy
end on

type cb_1 from commandbutton within w_rpt_order_date_summary
integer x = 1038
integer y = 72
integer width = 384
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Refresh"
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

parent.event ue_retrieve()
end event

type cb_close from commandbutton within w_rpt_order_date_summary
boolean visible = false
integer x = 3511
integer y = 72
integer width = 384
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

Close(parent)
end event

type cb_saveas from commandbutton within w_rpt_order_date_summary
boolean visible = false
integer x = 3104
integer y = 72
integer width = 384
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

type cb_print from commandbutton within w_rpt_order_date_summary
boolean visible = false
integer x = 3099
integer y = 72
integer width = 384
integer height = 120
integer taborder = 20
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

type dw_1 from datawindow within w_rpt_order_date_summary
integer x = 27
integer y = 232
integer width = 3877
integer height = 1592
integer taborder = 10
string dataobject = "d_rep_sales_summary_year_cross"
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

IF currentrow > 0 THEN
	this.selectrow(0,FALSE)
	this.selectrow(currentrow,TRUE)
END IF
end event

type gb_1 from groupbox within w_rpt_order_date_summary
integer x = 27
integer y = 12
integer width = 3895
integer height = 204
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

