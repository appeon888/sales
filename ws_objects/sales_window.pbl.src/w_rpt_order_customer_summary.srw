$PBExportHeader$w_rpt_order_customer_summary.srw
$PBExportComments$Customer Summary
forward
global type w_rpt_order_customer_summary from w_rpt_main
end type
end forward

global type w_rpt_order_customer_summary from w_rpt_main
integer height = 1996
string title = "Customer Report"
string menuname = ""
end type
global w_rpt_order_customer_summary w_rpt_order_customer_summary

on w_rpt_order_customer_summary.create
int iCurrent
call super::create
end on

on w_rpt_order_customer_summary.destroy
call super::destroy
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

is_ReportStyle = 'grid data'

end event

event ue_setinterface;//====================================================================
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

//string ls_Temp
//
//ls_Temp = string(il_TextColor)
//dw_1.modify("t_1.color="+ls_Temp)
//dw_1.modify("t_2.color="+ls_Temp)
//dw_1.modify("compute_1.color="+ls_Temp)
//dw_1.modify("compute_2.color="+ls_Temp)
//dw_1.modify("compute_3.color="+ls_Temp)
//dw_1.modify("compute_4.color="+ls_Temp)
//dw_1.modify("compute_5.color="+ls_Temp)
//dw_1.modify("compute_6.color="+ls_Temp)
//dw_1.modify("compute_7.color="+ls_Temp)
//dw_1.modify("compute_8.color="+ls_Temp)
//dw_1.modify("compute_9.color="+ls_Temp)
//dw_1.modify("compute_10.color="+ls_Temp)
//dw_1.modify("compute_11.color="+ls_Temp)
//dw_1.modify("compute_12.color="+ls_Temp)
//dw_1.modify("compute_13.color="+ls_Temp)
//dw_1.modify("compute_14.color="+ls_Temp)
//dw_1.modify("compute_15.color="+ls_Temp)


return 1
end event

event ue_init_menu;call super::ue_init_menu;//====================================================================
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
//

return 
end event

type ddlb_style from w_rpt_main`ddlb_style within w_rpt_order_customer_summary
boolean visible = false
end type

type uo_1 from w_rpt_main`uo_1 within w_rpt_order_customer_summary
end type

type cb_close from w_rpt_main`cb_close within w_rpt_order_customer_summary
boolean visible = false
end type

type cb_saveas from w_rpt_main`cb_saveas within w_rpt_order_customer_summary
end type

type cb_print from w_rpt_main`cb_print within w_rpt_order_customer_summary
boolean visible = false
end type

type dw_1 from w_rpt_main`dw_1 within w_rpt_order_customer_summary
string dataobject = "d_rep_customers_summary"
end type

type gb_1 from w_rpt_main`gb_1 within w_rpt_order_customer_summary
end type

type cb_1 from w_rpt_main`cb_1 within w_rpt_order_customer_summary
integer x = 1445
end type

