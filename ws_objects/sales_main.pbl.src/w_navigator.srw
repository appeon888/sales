$PBExportHeader$w_navigator.srw
forward
global type w_navigator from window
end type
type dw_1 from datawindow within w_navigator
end type
end forward

global type w_navigator from window
integer width = 3515
integer height = 1388
windowtype windowtype = popup!
long backcolor = 16776960
string icon = "AppIcon!"
boolean center = true
event ue_opensheet ( string as_name )
dw_1 dw_1
end type
global w_navigator w_navigator

event ue_opensheet(string as_name);str_rptparm		lstr_parm

this.hide()
choose case as_name
	//------------Customer--------------------------
	case "t_customer_new"
		opensheet(w_customer_new,parentwindow(),0,original!)
	case "t_customer_maintanance"
		opensheet(w_customer_maintenance,parentwindow(),0,original!)
	case "t_customer_account"
		opensheet(w_accounts_receivable,parentwindow(),0,original!)

	//--------------Product------------------------
	case "t_product_category"
		opensheet(w_product_category_edit,parentwindow(),0,original!)
		
	case "t_product_product"
		opensheet(w_product_edit,parentwindow(),0,original!)

	//------------Order-------------------------------
	case "t_order_viewer"
		opensheet(w_order_viewer,parentwindow(),0,original!)
		
		
	case "t_order_new"
		str_general		astr_parm
		astr_parm.faction = "new!"
		opensheetwithParm(w_order_new ,astr_parm, parentwindow (), 0 , Original! )
		
	case "t_order_maintanance"
		opensheet(w_order_main,parentwindow(),0,original!)
		
	case "t_order_processing"
		opensheet(w_processing_order,parentwindow(),0,original!)
	case "t_order_shipment"
		opensheet(w_ship_order,parentwindow(),0,original!)
	
	//------------Report--------------------------------
	case "t_report_byordertype"
		lstr_parm.ftitle = 'Sales Report by Order Type'
		lstr_parm.fdataobject = ""

		opensheetWithParm(w_rpt_order_type,lstr_parm , parentwindow() , 0 , Original! )
		
	case "t_report_bycategory"
		lstr_parm.ftitle = 'Sales Report by Product Category'
		lstr_parm.fdataobject = ""
		
		opensheetWithParm(w_rpt_category_summary,lstr_parm , parentwindow() , 0 , Original! )
		
	case "t_report_bycustomer"
		lstr_parm.ftitle = 'Sales Report by Customer'
		lstr_parm.fdataobject = ""
		
		opensheetWithParm(w_rpt_order_date_summary,lstr_parm , parentwindow() , 0 , Original! )
	case "t_report_customer"
		lstr_parm.ftitle = 'Customer Report'
		lstr_parm.fdataobject = "d_rep_customers_summary"
		
		opensheetWithParm(w_rpt_order_customer_summary,lstr_parm , parentwindow() , 0 , Original! )

	//--------------Other-------------------------
	case "t_appeon"
		 Inet  iinet_base
		GetContextService("Internet", iinet_base)

		iinet_base.HyperlinkToURL("http://www.appeon.com")
	case "t_exit"
		//halt close
		close(this)
end choose
end event

on w_navigator.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_navigator.destroy
destroy(this.dw_1)
end on

event open;this.title = 'Navigator'
if gb_auto_navigator then
	dw_1.setitem(1,"fisauto",1)
else
	dw_1.setitem(1,"fisauto",0)
end if
parentwindow().triggerevent("resize")
this.show()
end event

type dw_1 from datawindow within w_navigator
integer width = 3561
integer height = 1432
integer taborder = 20
string title = "none"
string dataobject = "d_navigator"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if isnull(dwo) or (not isvalid(dwo)) then return

parent.event ue_opensheet(dwo.name)
end event

event itemchanged;if dwo.name='fisauto' then
	gb_auto_navigator = (data='1')
end if
end event

