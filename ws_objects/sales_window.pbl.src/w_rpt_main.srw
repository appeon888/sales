$PBExportHeader$w_rpt_main.srw
forward
global type w_rpt_main from w_sheet
end type
type ddlb_style from dropdownlistbox within w_rpt_main
end type
type uo_1 from u_date_between within w_rpt_main
end type
type cb_close from commandbutton within w_rpt_main
end type
type cb_saveas from commandbutton within w_rpt_main
end type
type cb_print from commandbutton within w_rpt_main
end type
type dw_1 from datawindow within w_rpt_main
end type
type gb_1 from groupbox within w_rpt_main
end type
type cb_1 from commandbutton within w_rpt_main
end type
end forward

global type w_rpt_main from w_sheet
integer width = 4037
integer height = 2072
string title = "Customer Purchasing Behavior "
string menuname = "m_mdi_none"
long backcolor = 32039904
event ue_retrieve ( )
event ue_saveas ( )
event ue_print ( )
event ue_settings ( string as_action )
event ue_setdefault ( string as_type )
event ue_postopen ( )
event type integer ue_setinterface ( )
event ue_init_menu ( integer ai_reportindex,  boolean ab_includeautorefresh )
event ue_setautorefresh ( boolean ab_autorefresh )
ddlb_style ddlb_style
uo_1 uo_1
cb_close cb_close
cb_saveas cb_saveas
cb_print cb_print
dw_1 dw_1
gb_1 gb_1
cb_1 cb_1
end type
global w_rpt_main w_rpt_main

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
boolean   ib_AutoRefresh,ib_isGridInitialed=FALSE//Is grid report oprions initialed?
string   is_ReportStyle
integer   ii_FontSize
long   il_BackColor,il_TextColor

end variables

forward prototypes
public subroutine of_print ()
end prototypes

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

/*string  ls_DataObject

CHOOSE CASE is_ReportStyle 
	CASE '2d pie'
		ls_dataobject = 'd_rep_category_summary_2dpie'
	CASE '2d line'
		ls_dataobject = 'd_rep_category_summary_2dline'
	CASE '3d col'
		ls_dataobject = 'd_rep_category_summary_3dcol'
	CASE 'grid data'
		ls_dataobject = 'd_rep_category_summary_grid'
END CHOOSE

IF dw_1.dataobject <>ls_dataobject THEN
	dw_1.dataobject = ls_DataOBject
	dw_1.settransobject(SQLCA)
END IF
*/
Date  ld_From,ld_To

ld_From = uo_1.of_get_fromdate()
ld_To = uo_1.of_get_todate()
If ld_To  = 1900-01-01 Then
	ld_To = 2999-12-31
End If
If ld_From > ld_To Then
	MessageBox("Alert","Please set a valid Order Date scope.")
	Return
End If

dw_1.Retrieve(ld_From,ld_To)


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
	CASE 'date scope'
		this.event ue_setdefault('date')
	CASE 'year scope'
		this.event ue_setdefault("year")
	CASE 'grid report options'
		openwithparm(w_rpt_options,is_ReportStyle)
		str_rpt_options    lstr_parm
		int  li_Cnt,li_Count
		
		lstr_parm = message.powerobjectparm
		IF isnull(lstr_parm) THEN return
		ii_FontSize = lstr_parm.ffontsize
  		il_BackColor = lstr_Parm.fbackcolor
		il_TextColor = lstr_Parm.ftextcolor
		ib_isGridInitialed = true
		this.event ue_setinterface()		
		
	CASE ELSE//'2d pie','2d line','3d column','3d pie','grid data',
		is_ReportStyle = lower(as_action)
		li_Cnt = ddlb_style.event ue_selectitem(is_ReportStyle)
		IF ib_AutoRefresh THEN
			this.event ue_retrieve()
		END IF
		nvo_Util  lnv_util
		
		lnv_util.of_set_param( gs_user_no, this.title+"reportstyle", is_reportStyle)
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

IF as_type = 'date' THEN
	openwithparm(w_rpt_default_date,this.title)
	ls_Ret = message.stringparm
	IF ls_Ret = 'cancel' OR isnull(ls_Ret) THEN return
	uo_1.of_set_datescope(ls_Ret)
	IF ib_AutoRefresh THEN
		this.event ue_retrieve()
	END IF
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

IF li_Ret > 0 THEN 
	//Set date scope
	uo_1.of_set_datescope(istr_rpt_options.fdefaultdate)
	
	ib_AutoRefresh = istr_rpt_options.fautorefresh
	IF ddlb_style.visible THEN
		is_ReportStyle = istr_rpt_options.fReportStyle
	END IF
	ii_FontSize = istr_rpt_options.fFontSize
	il_BackColor = istr_rpt_options.fBackColor
	il_TextColor = istr_rpt_options.fTextColor

	ib_isGridInitialed = TRUE
END IF

//Set report style
IF is_ReportStyle='' OR isnull(is_ReportStyle) THEN
	is_ReportStyle = lower(ddlb_style.text(1))
	ddlb_style.selectitem(1)
	li_Cnt = 1
ELSE
	li_Cnt = ddlb_style.event ue_selectitem(is_ReportStyle)
END IF

//Set Menu
this.event ue_init_menu(li_Cnt,TRUE)

IF ib_AutoRefresh THEN
	ddlb_style.event selectionchanged(li_Cnt)
END IF

//Set FontSize,BackColor and Text Color
IF is_ReportStyle = 'grid data' and li_Ret > 0 THEN 
	this.event ue_setinterface()
END IF

end event

event type integer ue_setinterface();//====================================================================
// Event: ue_setinterface()
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

int  li_Cnt,li_Count
string  ls_Name

IF dw_1.describe("datawindow.processing") <>'1' THEN return -1
li_Count = integer(dw_1.describe( "datawindow.column.count"))

FOR li_Cnt = 1 TO li_Count
	ls_Name = dw_1.describe("#"+string(li_Cnt)+".name")
	dw_1.modify(ls_Name+".background.color="+string(il_BackColor))
	dw_1.modify(ls_Name+"_t.background.color="+string(il_BackColor))
	dw_1.modify(ls_Name+".color="+string(il_TextColor))
	dw_1.modify(ls_Name+"_t.color="+string(il_TextColor))
//	dw_1.modify(ls_Name+".font.height="+string(ii_FontSize))
//	dw_1.modify(ls_Name+"_t.font.height="+string(ii_FontSize))
NEXT
dw_1.modify("datawindow.color="+string(il_BackColor))
dw_1.modify("datawindow.zoom="+string(ii_FontSize*10))


return 1
end event

event ue_init_menu(integer ai_reportindex, boolean ab_includeautorefresh);//====================================================================
// Event: ue_init_menu()
//--------------------------------------------------------------------
// Description: Set Menu
//--------------------------------------------------------------------
// Arguments: 
//		value	integer	ai_reportindex       		
//		value	boolean	ab_includeautorefresh		
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
		
//
//m_customer_order  lm
//
//lm = this.menuid
//lm.m_settings.m_defaultsettings.m_reportstyle.m_item1.checked = (ai_reportindex = 1)
//lm.m_settings.m_defaultsettings.m_reportstyle.m_item2.checked = (ai_reportindex = 2)
//lm.m_settings.m_defaultsettings.m_reportstyle.m_item3.checked = (ai_reportindex = 3)
//lm.m_settings.m_defaultsettings.m_reportstyle.m_item4.checked = (ai_reportindex = 4)
//IF ab_includeautorefresh THEN
//	lm.m_settings.m_autorefresh.checked = ib_AutoRefresh
//END IF


return 
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
lnv_util.of_set_param( gs_user_no, 'Report Options'+"autorefresh", String(ab_autorefresh))
Return

end event

public subroutine of_print ();printsetup()
dw_1.print()
end subroutine

on w_rpt_main.create
int iCurrent
call super::create
if this.MenuName = "m_mdi_none" then this.MenuID = create m_mdi_none
this.ddlb_style=create ddlb_style
this.uo_1=create uo_1
this.cb_close=create cb_close
this.cb_saveas=create cb_saveas
this.cb_print=create cb_print
this.dw_1=create dw_1
this.gb_1=create gb_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_style
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_saveas
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.cb_1
end on

on w_rpt_main.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_style)
destroy(this.uo_1)
destroy(this.cb_close)
destroy(this.cb_saveas)
destroy(this.cb_print)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.cb_1)
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

event close;call super::close;//属性ribbonbar
if isvalid(w_mdi) then
	w_mdi.post wf_refresh_ribbon()
end if
end event

type ddlb_style from dropdownlistbox within w_rpt_main
event type integer ue_selectitem ( string as_style )
integer x = 1431
integer y = 72
integer width = 567
integer height = 860
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
string item[] = {"2D Pie","2D Line","3D Column","Grid Data"}
borderstyle borderstyle = stylelowered!
end type

event type integer ue_selectitem(string as_style);//====================================================================
// Event: ue_selectitem()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_style		
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

int  li_Cnt

FOR li_Cnt =1 TO this.totalitems( )
	IF lower(this.text(li_Cnt)) = as_style THEN
		this.selectitem(li_Cnt)
		return li_Cnt
	END IF
NEXT

return -1
end event

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
// CopyRight 2003----???? Appeon Inc.
//====================================================================

is_ReportStyle = lower(this.text)
IF ib_AutoRefresh THEN
	parent.event ue_retrieve()
END IF
	//Set Menu
Parent.event ue_init_menu(index,FALSE)
nvo_Util  lnv_util

lnv_util.of_set_param( gs_user_no, parent.title+"reportstyle", is_reportStyle)


end event

type uo_1 from u_date_between within w_rpt_main
integer x = 64
integer y = 56
integer width = 1458
integer taborder = 40
end type

on uo_1.destroy
call u_date_between::destroy
end on

type cb_close from commandbutton within w_rpt_main
integer x = 3520
integer y = 60
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

type cb_saveas from commandbutton within w_rpt_main
boolean visible = false
integer x = 3118
integer y = 60
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

type cb_print from commandbutton within w_rpt_main
integer x = 3109
integer y = 60
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

type dw_1 from datawindow within w_rpt_main
integer x = 27
integer y = 228
integer width = 3886
integer height = 1588
integer taborder = 10
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

event retrieveend;//====================================================================
// Event: retrieveend()
//--------------------------------------------------------------------
// Description: Set FontSize,BackColor and Text Color
//--------------------------------------------------------------------
// Arguments: 
//		value	long	rowcount		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnretrieveend]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

IF is_ReportStyle = 'grid data' and ib_isGridInitialed THEN 
	parent.event ue_setinterface()
END IF

end event

type gb_1 from groupbox within w_rpt_main
integer x = 27
integer y = 8
integer width = 3904
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

type cb_1 from commandbutton within w_rpt_main
integer x = 2016
integer y = 60
integer width = 384
integer height = 120
integer taborder = 30
boolean bringtotop = true
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

