$PBExportHeader$w_mdi.srw
forward
global type w_mdi from window
end type
type mdi_1 from mdiclient within w_mdi
end type
type cb_1 from commandbutton within w_mdi
end type
type wb_1 from webbrowser within w_mdi
end type
type rbb_1 from ribbonbar within w_mdi
end type
end forward

global type w_mdi from window
integer width = 3543
integer height = 1608
boolean titlebar = true
string title = "Sales Application Demo"
string menuname = "m_mdi_none"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
windowtype windowtype = mdi!
windowstate windowstate = maximized!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
event ue_closesheet ( string as_winname )
event ue_opensheet ( string as_winname )
event ue_refresh_ribbonbar ( string as_windowclassname )
mdi_1 mdi_1
cb_1 cb_1
wb_1 wb_1
rbb_1 rbb_1
end type
global w_mdi w_mdi

type variables
string  is_opened_sheet[]

w_navigator  iw_navigator

window iw_tmp
String		is_Ribbonbar_XML_Name = "SalesApplicationDemo_RibbonBar.xml"

boolean ib_recent

string		is_Find

boolean		ib_LoadXML
end variables

forward prototypes
public subroutine wf_setstyle (string as_style)
public subroutine wf_refresh_ribbon ()
public subroutine wf_addrecentitem (string as_window)
public subroutine wf_init_ribbonbar (ribbonbar arbb, boolean ab_loadxml)
public subroutine wf_setsmallbutton_enable (ribbonbar arbb_ribbonbar, string as_tag, boolean abl_value)
public subroutine wf_setcombobox_enable (ribbonbar arbb_ribbonbar, string as_tag, boolean abl_value)
public subroutine wf_setlargebutton_enable (ribbonbar arbb_ribbonbar, string as_tag, boolean abl_value)
public subroutine wf_setcheckbox_enable (ribbonbar arbb_ribbonbar, string as_tag, boolean abl_value)
public function boolean wf_getlargebutton_text (ribbonbar arbb_ribbonbar, string as_tag, ref string as_text)
public function boolean wf_getcombobox_text (ribbonbar arbb_ribbonbar, string as_tag, ref string as_text)
public function boolean wf_getcheckbox_checked (ribbonbar arbb_ribbonbar, string as_tag, ref boolean abl_checked)
public subroutine wf_setcategory_enable (ribbonbar arbb_ribbonbar, string as_tag, boolean abl_value)
public function boolean wf_setcheckbox_checked (ribbonbar arbb_ribbonbar, string as_tag, boolean abl_checked)
public function boolean wf_setcombobox_text (ribbonbar arbb_ribbonbar, string as_tag, string as_value)
public subroutine wf_setactivecategory (ribbonbar arbb_ribbonbar, string as_tag)
public function RibbonPanelItem wf_setpanelitem_pro (string as_text, string as_tag, string as_picturename, boolean abl_enabled)
public function RibbonGroupItem wf_setgroupitem_pro (string as_tag, boolean abl_enabled, boolean abl_newline)
public function RibbonMenuItem wf_setmenuitem_pro (string as_text, string as_tag, string as_picturename, boolean abl_enabled, string as_clicked, string as_type)
public function RibbonMenu wf_setmenu_pro (any aa_menuitem_pro)
public function RibbonCheckBoxItem wf_setcheckboxitem_pro (string as_text, string as_tag, boolean abl_checked, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, boolean as_thirdstate, boolean as_threestate, string as_clicked, string as_selected)
public function ribboncomboboxitem wf_setcomboboxitem_pro (string as_text, string as_tag, string as_picturename, string as_label, boolean abl_allowedit, boolean abl_autoscale, boolean abl_autohscroll, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, boolean abl_hscrollbar, boolean abl_vscrollbar, integer ai_selectedindex, boolean abl_sorted, integer ai_boxheight, integer ai_boxwidth, integer ai_width, string as_modified, string as_selected, string as_selectionchanged)
public function boolean wf_getlargebutton_enable (ribbonbar arbb_ribbonbar, string as_tag)
public function boolean wf_getcheckbox_enabled (ribbonbar arbb_ribbonbar, string as_tag)
public subroutine wf_setlargebutton_text (ribbonbar arbb_ribbonbar, string as_tag, string as_text)
public function ribbonlargebuttonitem wf_setlargetbuttonitem_pro (string as_text, string as_tag, string as_pictruename, string as_clicked, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, string as_shortcut)
public function ribbonsmallbuttonitem wf_setsmallbuttonitem_pro (string as_text, string as_tag, string as_pictruename, string as_clicked, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, string as_shortcut)
public function ribbonTabbuttonItem wf_settabbuttonitem_pro (string as_text, string as_tag, string as_picturename, string as_clicked, string as_powertiptext, string as_powertipdescription, boolean abl_checked, boolean abl_enabled, boolean abl_visible, string as_shortcut)
public function ribbonTabButtonItem wf_settabbuttonitem_pro (string as_text, string as_picturename, string as_clicked, string as_shortcut)
end prototypes

event ue_closesheet(string as_winname);long i=0,ll_valid_count=0

window  lw_sheet

//add by liulihua begin
window	ls_ActiveSheet
ls_ActiveSheet	=	this.GetActiveSheet()
If	Not	IsValid(ls_ActiveSheet)	Then
	Event ue_refresh_ribbonbar("")
End	If
//add end---------------------------------//
end event

event ue_opensheet(string as_winname);boolean lb_opened=false
window  lw_sheet

if isvalid(w_navigator) and gb_auto_navigator then
	close(w_navigator)
end if
end event

event ue_refresh_ribbonbar(string as_windowclassname);rbb_1.event ue_ribbonbar_display_refresh(as_windowclassname) //add by liulihua
end event

public subroutine wf_setstyle (string as_style);//Setting report style as line style or 2D style
ribboncategoryitem  lrc_item
ribbonpanelitem lrp_item
ribbonsmallbuttonitem lrs_item
ribbongroupitem lrg_item1,lrg_item2
long ll_category,ll_panel,ll_smallbutton,ll_group1,ll_group2
int li_return,li_loop

li_return = rbb_1.getcategorybyindex( 4, lrc_item)
ll_category = lrc_item.itemhandle

li_return = rbb_1.GetChildItemByIndex( ll_category, 1, lrp_item)//modify by liulihua getpanelbyindex
ll_panel = lrp_item.itemhandle
//Get the group by index
rbb_1.GetChildItemByIndex( ll_panel, 2,lrg_item1) //modify by liulihua getgroupbyindex
rbb_1.GetChildItemByIndex( ll_panel, 3,lrg_item2) //modify by liulihua getgroupbyindex
li_return = rbb_1.getchilditemcount(lrg_item1.itemhandle)
//Get the itemhandle for group
ll_group1 = lrg_item1.itemhandle
ll_group2 = lrg_item2.itemhandle
//Get the smallbutton by index
rbb_1.GetChildItemByIndex(ll_group2, 1, lrs_item) //modify by liulihua getsmallbuttonbyindex function delete

if as_style = "2D BarStacked" then
	lrs_item.tag = "2D BarStacked"
	lrs_item.text = "2D Bar"
	lrs_item.picturename = ".\picture\2dbarstacked.png"
	lrs_item.clicked = "ue_rep_style"
	lrs_item.powertiptext="2D"
	lrs_item.powertipdescription="2D Bar Stacked"
	ll_smallbutton = lrs_item.itemhandle
	li_return = rbb_1.setsmallbutton( ll_smallbutton, lrs_item)
	//Enable smallbutton
	if not lrs_item.enabled then
		//group1
		for li_loop = 1 to 2
			rbb_1.GetChildItemByIndex(ll_group1, li_loop, lrs_item)//modify by liulihua getsmallbuttonbyindex
			ll_smallbutton = lrs_item.itemhandle
			lrs_item.enabled = true
			rbb_1.setsmallbutton( ll_smallbutton, lrs_item)
		next
		//group2
		for li_loop = 1 to 2
			rbb_1.GetChildItemByIndex(ll_group2, li_loop, lrs_item)//modify by liulihua getsmallbuttonbyindex
			ll_smallbutton = lrs_item.itemhandle
			lrs_item.enabled = true
			rbb_1.setsmallbutton( ll_smallbutton, lrs_item)
		next
	end if
elseif as_style = "2D Line" then
	lrs_item.tag = "2D Line"
	lrs_item.text = "2D Line"
	lrs_item.picturename = ".\picture\2dline.png"
	lrs_item.clicked = "ue_rep_style"
	lrs_item.powertiptext="2D"
	lrs_item.powertipdescription="2D Line"
	ll_smallbutton = lrs_item.itemhandle
	li_return = rbb_1.setsmallbutton( ll_smallbutton, lrs_item)
	//Enable smallbutton
	if not lrs_item.enabled then
		//group1
		for li_loop = 1 to 2
			rbb_1.GetChildItemByIndex(ll_group1, li_loop, lrs_item) //modify by liulihua getsmallbuttonbyindex
			ll_smallbutton = lrs_item.itemhandle
			lrs_item.enabled = true
			rbb_1.setsmallbutton( ll_smallbutton, lrs_item)
		next
		//group2
		for li_loop = 1 to 2
			rbb_1.GetChildItemByIndex(ll_group2, li_loop, lrs_item)//modify by liulihua getsmallbuttonbyindex
			ll_smallbutton = lrs_item.itemhandle
			lrs_item.enabled = true
			rbb_1.setsmallbutton( ll_smallbutton, lrs_item)
		next
	end if
else
	//Disable all smallbuttons except for Print and Refresh buttons
	//group1
		for li_loop = 1 to 2
			rbb_1.GetChildItemByIndex(ll_group1, li_loop, lrs_item)//modify by liulihua getsmallbuttonbyindex
			ll_smallbutton = lrs_item.itemhandle
			lrs_item.enabled = false
			rbb_1.setsmallbutton( ll_smallbutton, lrs_item)
		next
		//group2
		for li_loop = 1 to 2
			rbb_1.GetChildItemByIndex(ll_group2, li_loop, lrs_item)//modify by liulihua getsmallbuttonbyindex
			ll_smallbutton = lrs_item.itemhandle
			lrs_item.enabled = false
			rbb_1.setsmallbutton( ll_smallbutton, lrs_item)
		next
end if


end subroutine

public subroutine wf_refresh_ribbon ();//
window lw_tmp
lw_tmp = this.getactivesheet( )

if isvalid(lw_tmp) then
	if lw_tmp.classname() = "w_rpt_category_summary" then
		wf_setstyle("2D Line")
		iw_tmp = w_rpt_category_summary
	elseif lw_tmp.classname( ) = "w_rpt_order_type" then
		wf_setstyle("2D BarStacked")
		iw_tmp = w_rpt_order_type
	else
		wf_setstyle("None")
	end if
	//add by liulihua recode the current window name----------------------------------//
	gs_WindowClassname	=	lw_tmp.ClassName()
Else
	gs_WindowClassname	=	this.ClassName()
	// add by liulihua end------------------------------------------------------------------//
end if
end subroutine

public subroutine wf_addrecentitem (string as_window);//Insert an item as recent item
//Determine whether the first item is null
ribbonmenuitem  lrbm_item
ribbonapplicationbuttonitem lrapp_item
ribbonapplicationmenu lrapp_menu

//A window is removed from Recent panel if it is recently opened from it
if ib_recent then
	ib_recent = false
	return
end if

long ll_return
//Get button
ll_return = rbb_1.getapplicationbutton(lrapp_item)
if ll_return < 0 then return
//Get application menu
ll_return = lrapp_item.getmenu(lrapp_menu)
if ll_return <0 then return
//Get Recent menu
ll_return = lrapp_menu.getrecentitem( 1, lrbm_item)
if ll_return < 0  then return
if lrbm_item.text = "" then
	//Place the menu to the position of index 1
	lrbm_item.text = as_window
	lrbm_item.tag = as_window
	lrbm_item.picturename = "window!"
	lrbm_item.clicked = "ue_openlist"
	lrapp_menu.setrecentitem(1, lrbm_item)
else
	lrapp_menu.insertrecentitemfirst(  as_window, "ue_openlist")
end if
//Reset the buttons in menu
lrapp_item.setmenu( lrapp_menu)
rbb_1.setapplicationbutton( lrapp_item)


end subroutine

public subroutine wf_init_ribbonbar (ribbonbar arbb, boolean ab_loadxml);//wf_init_ribbonbar(ribbonbar) return none
If	ab_LoadXML Then
	arbb.ImportFromXMLFile(is_Ribbonbar_XML_Name) //function "LoadFile" is deleted LoadFromXML  ImportFromXMLFile 
	ib_LoadXML	=	True
	return
End	If

//add by liulihua begin-------------------------------------------------//

RibbonCategoryItem		lrbb_categoryItem
Long		ll_ItemHandle_Category,	ll_Itemhandle_Panel,ll_ItemHandle_Group
lrbb_categoryItem.Text	=	"Operation"
lrbb_categoryItem.Tag	=	"CategoryOperation"
lrbb_categoryItem.Enabled	=	True
	
ll_ItemHandle_Category	=	arbb.InsertCategoryFirst(lrbb_categoryItem)
If	ll_ItemHandle_Category <> -1	Then
	
	ll_Itemhandle_Panel	=	arbb.InsertPanelFirst( ll_ItemHandle_Category,  wf_SetPanelItem_pro( "Board",	"Board",	".\picture\orderview.png",	True))
	
	arbb.InsertLargeButtonFirst( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Order View",	"OrderView",	".\picture\orderview.png",	"ue_orderview",	True,	"",	"", "ctrl+shift+O"))
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Customer Maintenance",	"CustomerMaintenance",	".\picture\customermaintenance.png",	"ue_cus_maintenance",	True,	"",	"","ctrl+shift+c"))
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Report by order",	"Reportbyorder",	".\picture\ordertype.png",	"ue_rep_ordertype_button",	True,	"",	"","ctrl+shift+r"))
		
	ll_Itemhandle_Panel	=	arbb.InsertPanelLast( ll_ItemHandle_Category,  wf_SetPanelItem_pro( "Action",	"Action",	".\picture\Actions.png",	True))
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	True))
	
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro('',	"Retrieve",	"RefreshSmall!",	"ue_retrieve",	True,	"Refresh",	"Refresh the DataWindow data","ctrl+R") )
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro('',	"InsertRow",	".\picture\InsertRow.png",	"ue_insertrow",	True,	"Insert Row",	"Insert a row to add new data","ctrl+I") )
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	True))
	
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro('',	"ModifyRow",	"ModifySmall!",	"ue_modify",	True,	"",	"Modify the currently selected Row","ctrl+M") )
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro('',	"DeleteRow",	".\picture\DeleteRow.png",	"ue_DeleteRow",	True,	"",	"Delete the currently selected row; not commit to the database yet","ctrl+D") )
	
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Save Data",	"SaveData",	"SaveBig!",	"ue_SaveData",	True,	"Save Data",	"Save the specified DataWindow data","ctrl+S"))
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	False))
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"First",	".\picture\NavFirstSmall.png",	"ue_first",	True,	"",	"Scroll to first row","") )
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	False))
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"Prior",	".\picture\NavPrevSmall.png",	"ue_prior",	True,	"",	"Scroll to prior row","") )
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	False))
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"Next",	".\picture\NavNextSmall.png",	"ue_next",	True,	"",	"Scroll to next row","") )
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	False))
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"Last",	".\picture\NavLastSmall.png",	"ue_last",	True,	"",	"Scroll to last row","") )
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	True))
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"Sort",	"SortSmall!",	"ue_Sort",	True,	"",	"Sort","") )
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"Filter",	"FilterSmall!",	"ue_filter",	True,	"",	"Filter","") )
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"Find",	".\picture\Find.png",	"ue_find",	True,	"",	"Find","ctrl+F") )
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"FindNext",	".\picture\FindNext.png",	"ue_FindNext",	True,	"",	"Find Next","ctrl+N") )
	
	//Export PDF panel
	ll_Itemhandle_Panel	=	arbb.InsertPanelLast( ll_ItemHandle_Category,  wf_SetPanelItem_pro( "Export PDF",	"ExportPDF",	"ExportBig!",	True))
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Export Data",	"ExportData",	"ExportBig!",	"ue_ExportPDF",	True,	"Export data",	"Export the specified DataWindow data to PDF",""))
	
	//Set LargeButton and menu item
	RibbonLargeButtonItem	lrbb_LargeButtonItem
	Ribbonmenu		lrbb_Menu
	//Insert MenuItem
	lrbb_Menu.Insertitemlast( wf_SetMenuItem_Pro("Distill",	"Distill",	"AppSmall!",	True,	"ue_ExportMethod_Menu",	""))
	lrbb_Menu.Insertitemlast( wf_SetMenuItem_Pro("NativePDF",	"NativePDF",	".\picture\NativePdfSmall.png",	True,	"ue_ExportMethod_Menu",	""))
	//set large button properties
	lrbb_LargeButtonItem	=	wf_SetLargetButtonItem_Pro("NativePDF",	"ExportMethod",	".\picture\NativePdfBig.png",	"",	True,	"Method",	"Export PDF Method", "")
	lrbb_LargeButtonItem.DefaultCommand=False
	//set large button menu
	lrbb_LargeButtonItem.SetMenu(lrbb_Menu)
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, lrbb_LargeButtonItem)
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	False))
	//Insert CheckBox
	arbb.InsertCheckBoxLast(ll_ItemHandle_Group,wf_SetCheckboxItem_Pro("Distill Custom PostScript",	"DistillCustomPostScript",	False,	False,	"",	"",	False,	False,	"",	""))
	arbb.InsertCheckBoxLast(ll_ItemHandle_Group,wf_SetCheckboxItem_Pro("Print Using XSLFOP",	"PrintUsingXSLFOP",	False,	False,	"",	"",	False,	False,	"",	""))
	//Insert PDF Conformance list
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("NativePDFOperation",	True,	True))
	RibbonComboBoxItem		lrbb_ComboBoxItem
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"PDFConformance",	"",	"",	False,	False,	True,	True,	"PDF Conformance",	"DataWindow.Export.PDF.NativePDF.PDFStandard",	False,	False,	1,	False,	600,	500,	500,	"",	"",	"")
	lrbb_ComboBoxItem.InsertItem("0-None",1)
	lrbb_ComboBoxItem.InsertItem("1-PDF/A-1a",2)
	lrbb_ComboBoxItem.InsertItem("2-PDF/A-1b",3)
	lrbb_ComboBoxItem.InsertItem("3-PDF/A-3a",4)
	lrbb_ComboBoxItem.InsertItem("4-PDF/A-3b",5)
	lrbb_ComboBoxItem.InsertItem("5-PDF/A-3u",6)
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	arbb.InsertCheckBoxLast(ll_ItemHandle_Group,wf_SetCheckboxItem_Pro("Use Special Print Settings",	"UseSpecialPrintSettings",	False,	True,	"",	"",	False,	False,	"ue_exportpdf_printspecialset",	""))
	//Insert ExportPaperSize
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	True))
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"ExportPaperSize",	"",	"",	False,	False,	True,	True,	"Paper Size",	"Paper size setting for exporting with NativePDF",	False,	False,	1,	False,	600,	600,	600,	"",	"",	"")
	lrbb_ComboBoxItem.InsertItem("0-Default",1)
	lrbb_ComboBoxItem.InsertItem("1-A1 594 x 841 mm",2)
	lrbb_ComboBoxItem.InsertItem("2-A2 420 x 594 mm",3)
	lrbb_ComboBoxItem.InsertItem("3-A3 297 x 420 mm",4)
	lrbb_ComboBoxItem.InsertItem("4-A4 210 x 297 mm",5)
	lrbb_ComboBoxItem.InsertItem("5-Letter 8 1/2 x 11 in",6)
	lrbb_ComboBoxItem.InsertItem("6-Legal 8 1/2 x 14 in",7)	
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	//Insert Export Orientation
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"ExportOrientation",	"",	"",	False,	False,	True,	True,	"Orientaion",	"Paper orientation setting for exporting with NativePDF",	False,	False,	1,	False,	600,	600,	620,	"",	"",	"")
	lrbb_ComboBoxItem.InsertItem("0-Default",1)
	lrbb_ComboBoxItem.InsertItem("1-Landscape",2)
	lrbb_ComboBoxItem.InsertItem("2-Portrait",3)	
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	
	//Insert Print panel
	ll_Itemhandle_Panel	=	arbb.InsertPanelLast( ll_ItemHandle_Category,  wf_SetPanelItem_pro( "Print",	"PrintPanel",	"PreviewSmall!",	True))
	//Insert Preview buttion
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Print Preview",	"PrintPreview",	"PreviewBig!",	"ue_printpreview",	True,	"Preview data",	"Preview the DataWindow data for printing","ctrl+V"))
	//Insert orientation buttion
	lrbb_LargeButtonItem	=	wf_SetLargetButtonItem_Pro("Orientation",	"Orientation",	"OrientationBig!",	"",	True,	"Print Orientation",	"Set the print orientation","")
	lrbb_LargeButtonItem.DefaultCommand	=	False
	lrbb_Menu.DeleteItem(2)
	lrbb_Menu.DeleteItem(1)
	lrbb_Menu.Insertitemlast( wf_SetMenuItem_Pro("Default",	"Default",	".\picture\Default.png",	True,	"ue_orientation_menu",	""))
	lrbb_Menu.Insertitemlast( wf_SetMenuItem_Pro("Portrait",	"Portrait",	".\picture\Portrait.png",	True,	"ue_orientation_menu",	""))
	lrbb_Menu.Insertitemlast( wf_SetMenuItem_Pro("Landscape",	"Landscape",	".\picture\Landscape.png",	True,	"ue_orientation_menu",	""))
	lrbb_LargeButtonItem.SetMenu(lrbb_Menu)
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, lrbb_LargeButtonItem)
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	False))
	//Insert Print paper size list
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"PageSize",	"PageSizeSmall!",	"",	False,	False,	True,	True,	"Paper size",	"Choose the paper size from the dropdown list",	False,	True,	1,	False,	900,	650,	750,	"",	"",	"ue_selectionchanged_comb")
	lrbb_ComboBoxItem.InsertItem("0 -- Default paper size for the printer",1)
	lrbb_ComboBoxItem.InsertItem("1 -- Letter 8 1/2 x 11 in",2)
	lrbb_ComboBoxItem.InsertItem("2 -- LetterSmall 8 1/2 x 11 in",3)
	lrbb_ComboBoxItem.InsertItem("3 -- Tabloid 17 x 11 in",4)
	lrbb_ComboBoxItem.InsertItem("4 -- Ledger 17 x 11 in",5)
	lrbb_ComboBoxItem.InsertItem("5 -- Legal 8 1/2 x 14 in",6)
	lrbb_ComboBoxItem.InsertItem("6 -- Statement 5 1/2 x 8 1/2 in",7)
	lrbb_ComboBoxItem.InsertItem("7 -- Executive 7 1/4 x 10 1/2 in",8)
	lrbb_ComboBoxItem.InsertItem("8 -- A3 297 x 420 mm",9)
	lrbb_ComboBoxItem.InsertItem("9 --A4 210 x 297 mm",10)
	lrbb_ComboBoxItem.InsertItem("10 -- A4 Small 210 x 297 mm",11)
	lrbb_ComboBoxItem.InsertItem("11 -- A5 148 x 210 mm",12)
	lrbb_ComboBoxItem.InsertItem("12 -- B4 250 x 354 mm",13)
	lrbb_ComboBoxItem.InsertItem("13 -- B5 182 x 257 mm",14)	
	lrbb_ComboBoxItem.InsertItem("14 -- Folio 8 1/2 x 13 in",15)
	lrbb_ComboBoxItem.InsertItem("15 -- Quarto 215 x 275 mm",16)
	lrbb_ComboBoxItem.InsertItem("16 -- 10x14 in",17)
	lrbb_ComboBoxItem.InsertItem("17 -- 11x17 in",18)
	lrbb_ComboBoxItem.InsertItem("18 -- Note 8 1/2 x 11 in",19)
	lrbb_ComboBoxItem.InsertItem("19 -- Envelope #9 3 7/8 x 8 7/8",20)
	lrbb_ComboBoxItem.InsertItem("20 -- Envelope #10 4 1/8 x 9 1/2",21)
	lrbb_ComboBoxItem.InsertItem("21 -- Envelope #11 4 1/2 x 10 3/8",22)
	lrbb_ComboBoxItem.InsertItem("22 -- Envelope #12 4 x 11 1/276",23)
	lrbb_ComboBoxItem.InsertItem("23 -- Envelope #14 5 x 11 1/2",24)	
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"Zoom",	"ZoomSmall!",	"",	True,	False,	True,	True,	"Zoom",	"Preview zoom setting",	False,	False,	1,	True,	600,	250,	250,	"ue_Modified_comb",	"",	"ue_selectionchanged_comb")
	lrbb_ComboBoxItem.InsertItem("100%",1)
	lrbb_ComboBoxItem.InsertItem("75%",2)
	lrbb_ComboBoxItem.InsertItem("50%",3)
	lrbb_ComboBoxItem.InsertItem("25%",4)	
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	//Insert Ruler
	arbb.InsertCheckBoxLast(ll_ItemHandle_Group,wf_SetCheckboxItem_Pro("Ruler",	"ShowRuler",	False,	True,	"Rulers",	"Show rulers in preview",	False,	False,	"ue_preview_rulers",	""))
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("Margins",	True,	True))
	
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"MarginsTop",	".\picture\MarginsTop.png",	"",	True,	False,	True,	True,	"",	"",	False,	False,	1,	True,	600,	200,	300,	"ue_Modified_comb",	"",	"")
	lrbb_ComboBoxItem.InsertItem("50",1)		
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"MarginsBottom",	".\picture\MarginsBottom.png",	"",	True,	False,	True,	True,	"",	"",	False,	False,	1,	True,	600,	200,	300,	"ue_Modified_comb",	"",	"")
	lrbb_ComboBoxItem.InsertItem("50",1)		
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"MarginsLeft",	".\picture\MarginsLeft.png",	"",	True,	False,	True,	True,	"",	"",	False,	False,	1,	True,	600,	200,	300,	"ue_Modified_comb",	"",	"")
	lrbb_ComboBoxItem.InsertItem("50",1)		
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"MarginsRight",	".\picture\MarginsRight.png",	"",	True,	False,	True,	True,	"",	"",	False,	False,	1,	True,	600,	200,	300,	"ue_Modified_comb",	"",	"")
	lrbb_ComboBoxItem.InsertItem("50",1)		
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Print",	"Print",	".\picture\printbig.png",	"ue_print",	True,	"Print Data",	"Print preview datawidnow","ctrl+P"))
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Print Setup",	"PrintSetup",	"PrintSetupBig!",	"ue_print_setup",	True,	"Print setup",	"Open print option dialog before print",""))
	
End	If

//add end---------------------------------------------------------------//

//Instantiate RibbonBar based on menu
//File menu
long ll_handle,ll_category,ll_panel,ll_group
RibbonSmallButtonItem lrs_item
Ribbonmenu  lrm_menu
ribbonLargeButtonItem lrl_item
ribbongroupitem lrg_item
long ll_return,ll_tmp,ll_tmp2

//comment by liulihua this category deleted---------------------------------------------//
//ll_category = arbb.insertcategoryfirst("File") 
////orderview
//ll_panel = arbb.insertpanellast( ll_category, "OrderView","orderview.png")
//arbb.insertLargebuttonlast(ll_panel,"Orders","orderview.png","ue_orderview")
//arbb.insertLargebuttonLast(ll_panel,"Print","printbig.png","ue_orderview_print")
//
////Security Manager
//ll_panel = arbb.insertpanellast( ll_category, "Security Manager","security-manager-small.png")
//arbb.insertLargebuttonlast(ll_panel,"Security Groups","securitygroups.png","ue_sec_group")
//arbb.insertLargebuttonLast(ll_panel,"User Accounts","useraccounts.png","ue_sec_user")
////Change Password
//arbb.insertLargebuttonLast(ll_panel,"Change Password","changepassword.png","ue_sec_password")
//ll_handle = arbb.insertSmallbuttonLast(ll_panel,"Save As","saveas.png","ue_sec_saveas")
//arbb.getsmallbutton( ll_handle, lrs_item)
//lrs_item.enabled = false
//arbb.setsmallbutton(ll_handle, lrs_item)
////print
//lrs_item.enabled = false
//lrs_item.text = "Print"
//lrs_item.picturename = "printsmall.png"
//lrs_item.clicked = "ue_sec_print"
//lrs_item.powertiptext="Print"
//lrs_item.powertipdescription="Print is not enabled"
//arbb.insertSmallbuttonLast(ll_panel,lrs_item)
////Exit
//lrs_item.enabled = true
//lrs_item.text = "Exit"
//lrs_item.picturename = "exit.png"
//lrs_item.clicked = "ue_sec_exit"
//lrs_item.powertiptext="Exit"
//lrs_item.powertipdescription="exit sales demo"
//arbb.insertSmallbuttonLast(ll_panel,"Exit","exit.png","ue_sec_exit")
//comment end-----------------------------------------------------------------------//
//category  customer
lrbb_categoryItem.Text	=	"Customer"
lrbb_categoryItem.Tag	=	"CategoryCustomer"
lrbb_categoryItem.Enabled	=	True
ll_Category	=	arbb.InsertCategoryLast(lrbb_categoryItem)
//ll_category = arbb.insertcategorylast("Customer")//comment by liulihua repalce by prior row
ll_panel = arbb.insertpanellast( ll_category, "Customer",".\picture\Customer.png")
//LargeButton
arbb.insertLargebuttonlast(ll_panel,"New Customer",".\picture\newcustomer.png","ue_cus_new")

arbb.insertLargebuttonLast(ll_panel,"Customer Maintenance",".\picture\customermaintenance.png","ue_cus_maintenance")
arbb.insertLargebuttonLast(ll_panel,"Accounts Receivable",".\picture\accountsreceivable.png","ue_cus_account")

//category order
lrbb_categoryItem.Text	=	"Order&Product"
lrbb_categoryItem.Tag	=	"CategoryOrderProduct"
lrbb_categoryItem.Enabled	=	True
ll_Category	=	arbb.InsertCategoryLast(lrbb_categoryItem)

//ll_category = arbb.insertcategorylast("Order&Product")//comment by liulihua repalce by prior row
ll_panel = arbb.insertpanellast( ll_category, "Order",".\picture\ordertype.png")
//LargeButton
arbb.insertLargebuttonlast(ll_panel,"New Order",".\picture\neworder.png","ue_order_new")
arbb.insertLargebuttonLast(ll_panel,"Order Maintenance",".\picture\ordermaintenance.png","ue_order_maintenance")
arbb.insertLargebuttonLast(ll_panel,"Order Processing",".\picture\orderprocessing.png","ue_order_process")
arbb.insertLargebuttonLast(ll_panel,"Order Shipment",".\picture\ordershipment.png","ue_order_ship")
//product
ll_panel = arbb.insertpanellast( ll_category, "Product",".\picture\productcategory.png")
//LargeButton
arbb.insertLargebuttonlast(ll_panel,"New Product",".\picture\newproduct.png","ue_pro_new")
//Insert items in Catelog Manager group
lrm_menu.insertitemlast( "Categories", ".\picture\categories.png", "ue_pro_category")
lrm_menu.addseparatoritem( )
lrm_menu.insertitemlast("Products",".\picture\products.png","ue_pro_products")
lrl_item.text = "Catalog Manager"
lrl_item.picturename = ".\picture\catalogmanager.png"
lrl_item.clicked = ""
lrl_item.setmenu( lrm_menu)
arbb.insertLargebuttonLast(ll_panel,lrl_item)
arbb.insertLargebuttonlast(ll_panel,"View Catalog",".\picture\viewproductcatalog.png","ue_pro_viewcat")

//Report
lrbb_categoryItem.Text	=	"Report"
lrbb_categoryItem.Tag	=	"CategoryReport"
lrbb_categoryItem.Enabled	=	True
ll_Category	=	arbb.InsertCategoryLast(lrbb_categoryItem)

//ll_category = arbb.insertcategorylast("Report")//comment by liulihua repalce by prior row
ll_panel = arbb.insertpanellast( ll_category, "Report",".\picture\report small.png")
ll_return = lrm_menu.deleteitem(1)
ll_return = lrm_menu.deleteitem(2)
lrm_menu.insertitemlast( "By Order Type", ".\picture\ordertype.png", "ue_rep_ordertype")
lrm_menu.addseparatoritem( )
lrm_menu.insertitemlast("By Product Category",".\picture\productcategory.png","ue_rep_procat")
lrm_menu.addseparatoritem( )
lrm_menu.insertitemlast("By Customer",".\picture\customer.png","ue_rep_cus")
//Sales Reports
lrl_item.text = "Sales Reports"
lrl_item.picturename = ".\picture\salesreport.png"
lrl_item.clicked = ""
lrl_item.powertiptext="Report"
lrl_item.powertipdescription="Operations for report"
lrl_item.setmenu( lrm_menu)
arbb.insertLargebuttonLast(ll_panel,lrl_item)
//Add report styles
//Insert new group 1
ll_group = arbb.insertgrouplast(ll_panel)
ll_tmp = ll_group
lrs_item.tag = "2D Pie"
lrs_item.text = "2D Pie"
lrs_item.picturename = ".\picture\2dpie.png"
lrs_item.clicked = "ue_rep_style"
lrs_item.powertiptext="2D"
lrs_item.powertipdescription="2D Pie"
arbb.insertsmallbuttonlast(ll_group,lrs_item)

lrs_item.tag = "3D Column"
lrs_item.text = "3D Column"
lrs_item.picturename = ".\picture\3dcolumn.png"
lrs_item.clicked = "ue_rep_style"
lrs_item.powertiptext="3D"
lrs_item.powertipdescription="3D Column"
arbb.insertsmallbuttonlast(ll_group,lrs_item)
//comment by liulihua use Operation category's menu
//lrs_item.text = "Print"
//lrs_item.picturename = ".\picture\printsmall.png"
//lrs_item.clicked = "ue_rep_print"
//lrs_item.powertiptext = ""
//lrs_item.powertipdescription=""
//arbb.insertsmallbuttonlast(ll_group,lrs_item)
//coment end

//Insert new group 2
lrg_item.newline = true
ll_group = arbb.insertgroup(ll_panel,ll_group,lrg_item)
ll_tmp2 = ll_group

lrs_item.tag = "2D BarStacked"
lrs_item.text = "2D Bar"
lrs_item.picturename = ".\picture\2dbarstacked.png"
lrs_item.clicked = "ue_rep_style"
lrs_item.powertiptext="2D"
lrs_item.powertipdescription="2D Bar Stacked"
arbb.insertsmallbuttonlast(ll_group,lrs_item)

lrs_item.tag = "Grid Data"
lrs_item.text = "Grid Data"
lrs_item.picturename = ".\picture\griddata.png"
lrs_item.clicked = "ue_rep_style"
lrs_item.powertiptext=""
lrs_item.powertipdescription=""
arbb.insertsmallbuttonlast(ll_group,lrs_item)

//comment by liulihua use Operation category's menu
//lrs_item.text = "Refresh"
//lrs_item.picturename = "refresh.png"
//lrs_item.clicked = "ue_rep_refresh"
//lrs_item.powertiptext="Refresh"
//lrs_item.powertipdescription="Refresh the current report!"
//arbb.insertsmallbuttonlast(ll_group,lrs_item)
//comment end
arbb.insertLargebuttonlast(ll_panel,wf_SetLargetButtonItem_Pro("Customer Report",	"",	".\picture\customerreport.png",	"ue_rep_Report",	True,	"",	"", "ctrl+Shift+L")) //add by liulihua add shortcut 2019-12-27

//arbb.insertLargebuttonlast(ll_panel,"Customer Report",".\picture\customerreport.png","ue_rep_Report")//comment by liulihua add shortcut 2019-12-27

//Insert Close button
//arbb.inserttabbuttonfirst( "Close", ".\picture\close12.png", "ue_close")//comment by liulihua add the shortcut 2019-12-27
arbb.inserttabbuttonfirst( wf_SetTabButtonItem_Pro("Close",		".\picture\close12.png",	 "ue_close",		"ctrl+E")	)//add by liulihua 2019-12-27

arbb.inserttabbuttonfirst( "About", ".\picture\help.png", "ue_about")
//Insert Ribbon collapse button
arbb.inserttabbuttonfirst( "Up", ".\picture\up.png", "ue_up")

//Insert ApplicationButton
ribbonapplicationbuttonitem  lrapp_item
ribbonapplicationmenu lrapp_menu
ribbonmenuitem lrm_item
long ll_index
lrapp_item.tag = "ApplicationButton"
lrapp_item.text = "Recent"
//Configurations for mastermenu
//Insert UserInfo
lrapp_menu.addmasterseparatoritem( )
lrm_item.tag = "UserInfo"
lrm_item.text = "User"
lrm_item.picturename = ".\picture\user.png"
ll_index = lrapp_menu.insertmasteritemlast(lrm_item)

//Add User Info
lrapp_menu.addmasterseparatoritem( ll_index)//Insert separator
//Insert User List
lrm_item.tag = "UserList"
lrm_item.text = "User List"
lrm_item.clicked = "ue_userinfo"
lrm_item.picturename = ".\picture\userlist.png"
lrapp_menu.insertmasteritemlast( ll_index,lrm_item)
//Insert Group
lrm_item.tag = "Group"
lrm_item.text = "Group"
lrm_item.clicked = "ue_userinfo"
lrm_item.picturename = ".\picture\group.png"
lrapp_menu.insertmasteritemlast( ll_index,lrm_item)
//Maintain login user information
lrapp_menu.addmasterseparatoritem( ll_index)//Insert separator
lrm_item.tag = "Password"
lrm_item.text = "Password"
lrm_item.clicked = "ue_userinfo"
lrm_item.picturename = ".\picture\password.png"
lrapp_menu.insertmasteritemlast( ll_index,lrm_item)
//signout
lrm_item.tag = "Signout"
lrm_item.text = "Sign Out"
lrm_item.clicked = "ue_userinfo"
lrm_item.picturename = ".\picture\signout.png"
lrapp_menu.insertmasteritemlast( ll_index,lrm_item)
lrapp_menu.addmasterseparatoritem( ll_index)//Insert separator
//Setting values for About and Close buttons
lrapp_menu.addmasterseparatoritem( )
lrm_item.tag = "About"
lrm_item.text = "About"
lrm_item.clicked = "ue_about2"
lrm_item.picturename = ".\picture\about.png"
lrapp_menu.insertmasteritemlast(lrm_item)
lrm_item.tag = "Close"
lrm_item.text = "Close"
lrm_item.clicked = "ue_close2"
lrm_item.picturename = ".\picture\close.png"
lrapp_menu.insertmasteritemlast(lrm_item)
lrapp_menu.addmasterseparatoritem( )
//add RecentMenu
lrapp_menu.setrecenttitle( "Recent Windows")
lrapp_menu.insertrecentitemlast( "", "")
//setmenu
lrapp_item.setmenu( lrapp_menu)
arbb.setapplicationbutton( lrapp_item)

arbb.SetActiveCategory(ll_ItemHandle_Category)


end subroutine

public subroutine wf_setsmallbutton_enable (ribbonbar arbb_ribbonbar, string as_tag, boolean abl_value);//Author: liulihua 2019-09-30
//wf_SetSmallButton_enable(ribbonbar	arbb_ribbonbar,	string		as_Tag,	boolean	abl_Value) return none
RibbonsmallbuttonItem		lrbbsb_button
Integer			li_Return

//small button
li_Return	=	arbb_ribbonbar.GetItemByTag(as_Tag, lrbbsb_button )
If li_Return =	1	Then
	lrbbsb_button.Enabled = abl_Value
	lrbbsb_button.visible = abl_Value
	arbb_ribbonbar.SetSmallButton(lrbbsb_button.ItemHandle, lrbbsb_button)
End	If

end subroutine

public subroutine wf_setcombobox_enable (ribbonbar arbb_ribbonbar, string as_tag, boolean abl_value);//Author: liulihua 2019-09-30
//wf_SetComboBox_enable( ribbonbar arbb_ribbonbar,	string	as_Tag,	boolean	abl_value) return none

If	Not IsValid(arbb_ribbonbar)	Then	Return

RibbonComboBoxItem		lrbbcb_ComboBox
Integer		li_Return
//paper.size
li_Return	=	arbb_ribbonbar.GetItemByTag(as_Tag,lrbbcb_ComboBox)
If	li_Return =	1	Then
	lrbbcb_ComboBox.Enabled = abl_Value
	lrbbcb_ComboBox.Visible = abl_Value
	arbb_ribbonbar.SetComboBox(lrbbcb_ComboBox.ItemHandle, lrbbcb_ComboBox)
End	If

end subroutine

public subroutine wf_setlargebutton_enable (ribbonbar arbb_ribbonbar, string as_tag, boolean abl_value);//Author: liulihua
//wf_SetLargeButton_enable(ribbonbar	arbb_largebutton,	string	as_Tag,	boolean	abl_value) return none

If	Not IsValid(arbb_ribbonbar)	Then	Return

RibbonLargeButtonItem		lrbblb_button
Integer		li_Return

li_Return	=	arbb_ribbonbar.GetItemByTag(as_Tag,lrbblb_button)
If	li_Return =	1	Then
	lrbblb_button.Enabled = abl_value
	arbb_ribbonbar.SetLargeButton(lrbblb_button.ItemHandle, lrbblb_button)
End	If

end subroutine

public subroutine wf_setcheckbox_enable (ribbonbar arbb_ribbonbar, string as_tag, boolean abl_value);//Author: liulihua 2019-09-30
//wf_SetCheckBox_enable( ribbonbar arbb_ribbonbar,	string	as_Tag,	boolean	abl_value) return none

If	Not IsValid(arbb_ribbonbar)	Then	Return

RibbonCheckBoxItem		lrbbcb_CheckBox
Integer		li_Return
//paper.size
li_Return	=	arbb_ribbonbar.GetItemByTag(as_Tag,lrbbcb_CheckBox)
If	li_Return =	1	Then
	lrbbcb_CheckBox.Enabled = abl_Value
	arbb_ribbonbar.SetCheckBox(lrbbcb_CheckBox.ItemHandle, lrbbcb_CheckBox)
End	If

end subroutine

public function boolean wf_getlargebutton_text (ribbonbar arbb_ribbonbar, string as_tag, ref string as_text);//Author: liulihua
//wf_GetLargeButton_Text(ribbonbar	arbb_largebutton,	string	as_Tag) return string

If	Not IsValid(arbb_ribbonbar)	Then	Return	False

RibbonLargeButtonItem		lrbblb_button
Integer		li_Return

//orientation
li_Return	=	arbb_ribbonbar.GetItemByTag(as_Tag,lrbblb_button)
If	li_Return =	1	Then
	as_Text=lrbblb_button.Text
	Return	True
Else	
	Return False
End	If

end function

public function boolean wf_getcombobox_text (ribbonbar arbb_ribbonbar, string as_tag, ref string as_text);//Author: liulihua 2019-09-30
//wf_GetComboBox_Text( ribbonbar arbb_ribbonbar,	string	as_Tag,	string	as_Text) return Boolean

If	Not IsValid(arbb_ribbonbar)	Then	Return	False

RibbonComboBoxItem		lrbbcb_ComboBox
Integer		li_Return

li_Return	=	arbb_ribbonbar.GetItemByTag(as_Tag,lrbbcb_ComboBox)
If	li_Return =	1	Then
	as_Text	=	lrbbcb_ComboBox.text
	Return	True
Else
	Return	False
End	If

end function

public function boolean wf_getcheckbox_checked (ribbonbar arbb_ribbonbar, string as_tag, ref boolean abl_checked);//Author: liulihua
//wf_getcheckbox_checked( ribbonbar arbb_ribbonbar,	string	as_Tag,	boolean	abl_Checked) return boolean

abl_Checked	=	False
If	Not IsValid(arbb_ribbonbar)	Then	Return	False

RibbonCheckBoxItem		lrbbcb_CheckBox
Integer		li_Return
//paper.size
li_Return	=	arbb_ribbonbar.GetItemByTag(as_Tag,lrbbcb_CheckBox)
If	li_Return =	1	Then
	abl_Checked	=	lrbbcb_CheckBox.Checked
	Return True
Else
	Return	False
End	If

end function

public subroutine wf_setcategory_enable (ribbonbar arbb_ribbonbar, string as_tag, boolean abl_value);//Author: liulihua 2019-10-08
//wf_SetCategory_enable(ribbonbar	arbb_ribbonbar,	string	as_Tag,	boolean	abl_value) return none

If	Not IsValid(arbb_ribbonbar)	Then	Return

RibbonCategoryItem		lrbbci_Category
Integer		li_Return

li_Return	=	arbb_ribbonbar.GetItemByTag(as_Tag,lrbbci_Category)
If	li_Return =	1	Then
	lrbbci_Category.Enabled = abl_value
	lrbbci_Category.Visible = abl_value
	arbb_ribbonbar.SetCategory(lrbbci_Category.ItemHandle, lrbbci_Category)
End	If

end subroutine

public function boolean wf_setcheckbox_checked (ribbonbar arbb_ribbonbar, string as_tag, boolean abl_checked);//Author: liulihua
//wf_SetCheckbox_checked( ribbonbar arbb_ribbonbar,	string	as_Tag,	boolean	abl_Checked) return boolean

If	Not IsValid(arbb_ribbonbar)	Then	Return	False

RibbonCheckBoxItem		lrbbcb_CheckBox
Integer		li_Return
//paper.size
li_Return	=	arbb_ribbonbar.GetItemByTag(as_Tag,lrbbcb_CheckBox)
If	li_Return =	1	Then
	lrbbcb_CheckBox.Checked	=	abl_Checked
	arbb_ribbonbar.SetCheckBox(lrbbcb_CheckBox.ItemHandle, lrbbcb_CheckBox)
	Return True
End	If
return False
end function

public function boolean wf_setcombobox_text (ribbonbar arbb_ribbonbar, string as_tag, string as_value);//Author: liulihua 2019-09-30
//wf_SetComboBox_Text( ribbonbar arbb_ribbonbar,	string	as_Tag,	string	as_value) return none

If	Not IsValid(arbb_ribbonbar)	Then	Return False

RibbonComboBoxItem		lrbbcb_ComboBox
Integer		li_Return
//paper.size
li_Return	=	arbb_ribbonbar.GetItemByTag(as_Tag,lrbbcb_ComboBox)
If	li_Return =	1	Then
	lrbbcb_ComboBox.Text = as_value
	arbb_ribbonbar.SetComboBox(lrbbcb_ComboBox.ItemHandle, lrbbcb_ComboBox)
	Return True
End	If

Return	False

end function

public subroutine wf_setactivecategory (ribbonbar arbb_ribbonbar, string as_tag);//Autor:liulihua
//wf_SetActiveCategory(ribbonbar	arbb_ribbonbar,	strign	as_Tag) return none

If	Not	IsValid(arbb_ribbonbar)	Then	Return

RibbonCategoryItem		lrbbci_Category
Integer		li_Return

li_Return	=	arbb_ribbonbar.GetItemByTag(as_Tag, lrbbci_Category )
If	li_Return	=	1	Then
	arbb_ribbonbar.SetActiveCategory(lrbbci_Category.ItemHandle)
End	If

end subroutine

public function RibbonPanelItem wf_setpanelitem_pro (string as_text, string as_tag, string as_picturename, boolean abl_enabled);//author:liulihua
//wf_SetPanelItem_pro( as_Text,	as_Tag,	as_PictureName,	abl_Enabled)	return RibbonPanelItem

RibbonPanelItem	lrbb_PanelItem

lrbb_PanelItem.Text	=	as_Text
lrbb_PanelItem.Tag	=	as_Tag
lrbb_PanelItem.PictureName	=	as_PictureName
lrbb_PanelItem.Enabled	=	abl_Enabled

Return		lrbb_PanelItem




end function

public function RibbonGroupItem wf_setgroupitem_pro (string as_tag, boolean abl_enabled, boolean abl_newline);//Author:liulihua
//wf_SetGroupItem_Pro(as_Tag,	abl_Enabled,	abl_NewLine)return RibbonGroupItem

RibbonGroupItem	lrbb_GrouItem

lrbb_GrouItem.Tag	=	as_Tag
lrbb_GrouItem.Enabled	=	abl_Enabled
lrbb_GrouItem.NewLine	=	abl_NewLine

Return	lrbb_GrouItem

end function

public function RibbonMenuItem wf_setmenuitem_pro (string as_text, string as_tag, string as_picturename, boolean abl_enabled, string as_clicked, string as_type);//Author:liulihua
//wf_SetMenuItem_Pro(as_Text,	as_Tag,	as_PictureName,	abl_Enabled,	as_Clicked,	as_Type	)	Return	RibbonMenuItem

RibbonMenuItem	lrbb_MenuItem

lrbb_MenuItem.Text	=	as_Text
lrbb_MenuItem.Tag	=	as_Tag
lrbb_MenuItem.PictureName	=	as_PictureName
lrbb_MenuItem.Enabled	=	abl_Enabled
lrbb_MenuItem.Clicked	=	as_Clicked
If	Trim(as_Type) <> ""	Then
	If	as_Type = "Separator!"	Then
		lrbb_MenuItem.ItemType	=	1
	Else
		lrbb_MenuItem.ItemType	=	0
	End	If
	
End	If

Return	lrbb_MenuItem
end function

public function RibbonMenu wf_setmenu_pro (any aa_menuitem_pro);//Author:liulihua
//wf_SetMenu_Pro()	Return RibbonMenu

RibbonMenu		lrbb_Menu



Return	lrbb_Menu

end function

public function RibbonCheckBoxItem wf_setcheckboxitem_pro (string as_text, string as_tag, boolean abl_checked, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, boolean as_thirdstate, boolean as_threestate, string as_clicked, string as_selected);//Author:liulihua
//wf_SetCheckboxItem_Pro(as_Text,	as_Tag,	abl_Checked,	abl_Enabled,	as_PowerTipsText,	as_PowerTipsDescription,	as_ThirdState,	as_ThreeState,	as_Clicked,	as_Selected) Return RibbonCheckBoxItem

RibbonCheckBoxItem	lrbb_CheckBoxItem

lrbb_CheckBoxItem.Text	=	as_Text
lrbb_CheckBoxItem.Tag	=	as_Tag
lrbb_CheckBoxItem.Checked	=	abl_Checked
lrbb_CheckBoxItem.Enabled	=	abl_Enabled
lrbb_CheckBoxItem.PowerTipText	=	as_PowerTipsText
lrbb_CheckBoxItem.PowerTipDescription	=	as_PowerTipsDescription
lrbb_CheckBoxItem.ThirdState	=	as_ThirdState
lrbb_CheckBoxItem.ThreeState	=	as_ThreeState
lrbb_CheckBoxItem.Clicked	=	as_Clicked
lrbb_CheckBoxItem.Selected	=	as_Selected


Return	lrbb_CheckBoxItem
end function

public function ribboncomboboxitem wf_setcomboboxitem_pro (string as_text, string as_tag, string as_picturename, string as_label, boolean abl_allowedit, boolean abl_autoscale, boolean abl_autohscroll, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, boolean abl_hscrollbar, boolean abl_vscrollbar, integer ai_selectedindex, boolean abl_sorted, integer ai_boxheight, integer ai_boxwidth, integer ai_width, string as_modified, string as_selected, string as_selectionchanged);//Author:liulihua
//wf_SetcomboBoxItem_Pro(as_Text,	as_Tag,	as_PictureName,	as_Label,	abl_AllowEdit,	abl_AutoScale,	abl_AutoHScroll,	abl_Enabled,	as_PowerTipsText,	as_PowerTipsDescription,	abl_HScrollBar,	abl_VScrollBar,	ai_SelectedIndex,	abl_Sorted,	ai_BoxHeight,	ai_Boxwidth,	ai_width,	as_Modified,	as_Selected,	as_SelectionChanged)	Return	RibbonComboBoxItem

RibbonComboBoxItem		lrbb_ComboBoxItem
lrbb_ComboBoxItem.Text =	as_Text
lrbb_ComboBoxItem.Tag	=	as_Tag
lrbb_ComboBoxItem.PictureName	=	as_PictureName
lrbb_ComboBoxItem.Label	=	as_Label
lrbb_ComboBoxItem.AllowEdit	=	abl_AllowEdit
lrbb_ComboBoxItem.AutoScale	=	abl_AutoScale
lrbb_ComboBoxItem.AutoHScroll	=	abl_AutoHScroll
lrbb_ComboBoxItem.Enabled	=	abl_Enabled
lrbb_ComboBoxItem.PowerTipText	=	as_PowerTipsText
lrbb_ComboBoxItem.PowerTipDescription	=	as_PowerTipsDescription
lrbb_ComboBoxItem.HScrollBar	=	abl_HScrollBar
lrbb_ComboBoxItem.VScrollBar	=	abl_VScrollBar
lrbb_ComboBoxItem.SelectItem(ai_SelectedIndex)
lrbb_ComboBoxItem.Sorted	=	abl_Sorted
lrbb_ComboBoxItem.BoxHeight	=	ai_BoxHeight
lrbb_ComboBoxItem.BoxWidth	=	ai_BoxWidth
lrbb_ComboBoxItem.Width	=	ai_Width
lrbb_ComboBoxItem.Modified	=	as_Modified
lrbb_ComboBoxItem.Selected	=	as_Selected
lrbb_ComboBoxItem.SelectionChanged	=	as_SelectionChanged

Return	lrbb_ComboBoxItem
end function

public function boolean wf_getlargebutton_enable (ribbonbar arbb_ribbonbar, string as_tag);//Author: liulihua
//wf_GetLargeButton_enable(ribbonbar	arbb_ribbonbar,	string	as_Tag) return Boolean

If	Not IsValid(arbb_ribbonbar)	Then	Return	False

RibbonLargeButtonItem		lrbblb_button
Integer		li_Return

li_Return	=	arbb_ribbonbar.GetItemByTag(as_Tag,lrbblb_button)
If	li_Return =	1	Then
	Return	lrbblb_button.Enabled
End	If

Return	False
end function

public function boolean wf_getcheckbox_enabled (ribbonbar arbb_ribbonbar, string as_tag);//Author: liulihua
//wf_getcheckbox_Enabled( ribbonbar arbb_ribbonbar,	string	as_Tag) return boolean

If	Not IsValid(arbb_ribbonbar)	Then	Return	False

RibbonCheckBoxItem		lrbbcb_CheckBox
Integer		li_Return
//paper.size
li_Return	=	arbb_ribbonbar.GetItemByTag(as_Tag,lrbbcb_CheckBox)
If	li_Return =	1	Then
	Return	lrbbcb_CheckBox.Enabled
Else
	Return	False
End	If

end function

public subroutine wf_setlargebutton_text (ribbonbar arbb_ribbonbar, string as_tag, string as_text);//Author: liulihua
//wf_SetLargeButton_Text(ribbonbar	arbb_ribbonbar,	string	as_Tag,	string	as_Text) return none

If	Not IsValid(arbb_ribbonbar)	Then	Return

RibbonLargeButtonItem		lrbblb_button
Integer		li_Return

li_Return	=	arbb_ribbonbar.GetItemByTag(as_Tag,lrbblb_button)
If	li_Return =	1	Then
	lrbblb_button.Text = as_Text
	arbb_ribbonbar.SetLargeButton(lrbblb_button.ItemHandle, lrbblb_button)
End	If
end subroutine

public function ribbonlargebuttonitem wf_setlargetbuttonitem_pro (string as_text, string as_tag, string as_pictruename, string as_clicked, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, string as_shortcut);//Author:liulihua
//wf_SetLargetButtonItem_Pro(as_Text,	as_Tag,	as_PictrueName,	as_Clicked,	abl_Enabled,	as_PowerTipsText,	as_PowerTipsDescription,	as_Shortcut) return RibbonLargeButtonItem

RibbonLargeButtonItem		lrbb_LargeButton

lrbb_LargeButton.Text	=	as_Text
lrbb_LargeButton.Tag		=	as_Tag
lrbb_LargeButton.PictureName	=	as_PictrueName
lrbb_LargeButton.Clicked		=	as_Clicked
lrbb_LargeButton.Enabled	=	abl_Enabled
lrbb_LargeButton.PowerTipText	=	as_PowerTipsText
lrbb_LargeButton.PowerTipDescription	=	as_PowerTipsDescription
lrbb_LargeButton.shortcut	=	as_Shortcut

Return	lrbb_LargeButton
end function

public function ribbonsmallbuttonitem wf_setsmallbuttonitem_pro (string as_text, string as_tag, string as_pictruename, string as_clicked, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, string as_shortcut);//Author:liulihua
//wf_SetSmallButtonItem_Pro(as_Text,	as_Tag,	as_PictrueName,	as_Clicked,	abl_Enabled,	as_PowerTipsText,	as_PowerTipsDescription,	as_shortCut) return RibbonLargeButtonItem

RibbonSmallButtonItem		lrbb_SmallButton

lrbb_SmallButton.Text	=	as_Text
lrbb_SmallButton.Tag		=	as_Tag
lrbb_SmallButton.PictureName	=	as_PictrueName
lrbb_SmallButton.Clicked		=	as_Clicked
lrbb_SmallButton.Enabled	=	abl_Enabled
lrbb_SmallButton.PowerTipText	=	as_PowerTipsText
lrbb_SmallButton.PowerTipDescription	=	as_PowerTipsDescription
lrbb_SmallButton.ShortCut	=	as_shortCut
Return	lrbb_SmallButton
end function

public function ribbonTabbuttonItem wf_settabbuttonitem_pro (string as_text, string as_tag, string as_picturename, string as_clicked, string as_powertiptext, string as_powertipdescription, boolean abl_checked, boolean abl_enabled, boolean abl_visible, string as_shortcut);//Author:liulihua
//wf_SetSmallButtonItem_Pro(as_Text,	as_Tag,	as_PictureName,	as_Clicked,	as_PowerTipText,	as_PowerTipDescription,	abl_Checked,	abl_Enabled,	abl_Visible,	as_ShortCut) return ribbonbarTabbuttonItem

ribbonTabbuttonItem		lrbb_TabButton

lrbb_TabButton.Text	=	as_Text
lrbb_TabButton.Tag		=	as_Tag
lrbb_TabButton.PictureName	=	as_PictureName
lrbb_TabButton.Clicked		=	as_Clicked
lrbb_TabButton.PowerTipText	=	as_PowerTipText
lrbb_TabButton.PowerTipDescription	=	as_PowertipDescription
lrbb_TabButton.Checked	=	abl_Checked
lrbb_TabButton.Enabled	=	abl_Enabled
lrbb_TabButton.Visible	=	abl_Visible
lrbb_TabButton.ShortCut	=	as_shortCut
Return	lrbb_TabButton
end function

public function ribbonTabButtonItem wf_settabbuttonitem_pro (string as_text, string as_picturename, string as_clicked, string as_shortcut);//Author:liulihua
//wf_SetTabButtonItem_Pro(as_Text,		as_PictureName,	as_Cliecked,		as_ShortCut) return ribbonbarTabbuttonItem

ribbonTabbuttonItem		lrbb_TabButton

lrbb_TabButton.Text	=	as_Text
//lrbb_TabButton.Tag		=	as_Tag
lrbb_TabButton.PictureName	=	as_PictureName
lrbb_TabButton.Clicked		=	as_Clicked
//lrbb_TabButton.PowerTipText	=	as_PowerTipText
//lrbb_TabButton.PowerTipDescription	=	as_PowertipDescription
//lrbb_TabButton.Checked	=	abl_Checked
//lrbb_TabButton.Enabled	=	abl_Enabled
//lrbb_TabButton.Visible	=	abl_Visible
lrbb_TabButton.ShortCut	=	as_shortCut
Return	lrbb_TabButton
end function

on w_mdi.create
if this.MenuName = "m_mdi_none" then this.MenuID = create m_mdi_none
this.mdi_1=create mdi_1
this.cb_1=create cb_1
this.wb_1=create wb_1
this.rbb_1=create rbb_1
this.Control[]={this.mdi_1,&
this.cb_1,&
this.wb_1,&
this.rbb_1}
end on

on w_mdi.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.cb_1)
destroy(this.wb_1)
destroy(this.rbb_1)
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

this.title = this.title + ' (User ID: '+gs_User_No+")"


nvo_security  lnv_Security

lnv_Security.of_setmenuright(this.menuid)

//add by liulihua
//Initiates RibbonBar menu. If the second argument is True, initiate it using XML; if the argument is False, initiate it using PowerScript
//The XML used to initiate the current RibbonBar is recorded in is_Ribbonbar_XML_Name
wf_init_ribbonbar(rbb_1,True)

end event

event resize;if isvalid(w_navigator) then
	w_navigator.x = (this.workspacewidth() - w_navigator.width)/2
	int  li_y=0
	
	if this.workspaceheight() > w_navigator.height then
			
		li_y = (this.workspaceheight() - w_navigator.height)/2 - 100
		
		if li_y < 100 then
			li_y=100
		end if
	end if
	w_navigator.y = li_y
	
end if
//
if newwidth <= 0 then
	newwidth = this.workspacewidth( )
end if
if newheight <=0 then
	newheight = this.workspaceheight( )
end if
//resize ribbonbar
rbb_1.move(0,newheight - this.workspaceheight()  )
rbb_1.width = newwidth
mdi_1.move(wb_1.X + wb_1.width,rbb_1.height +newheight -  this.workspaceheight())
mdi_1.resize(newwidth - (wb_1.X + wb_1.width),newheight - rbb_1.height - ( newheight - this.workspaceheight()))

wb_1.height	=	mdi_1.height
wb_1.x = 0
wb_1.Y = mdi_1.Y
end event

type mdi_1 from mdiclient within w_mdi
long BackColor=268435456
end type

type cb_1 from commandbutton within w_mdi
integer x = 261
integer y = 656
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

type wb_1 from webbrowser within w_mdi
integer x = 37
integer y = 512
integer width = 549
integer height = 576
string defaulturl = "www.appeon.com"
end type

type rbb_1 from ribbonbar within w_mdi
event ue_orderview ( long al_handle )
event ue_orderview_print ( long al_handle )
event ue_close ( long al_handle )
event ue_sec_group ( long al_handle )
event ue_sec_user ( long al_handle )
event ue_sec_password ( long al_handle )
event ue_sec_exit ( long al_handle )
event ue_cus_new ( long al_handle )
event ue_cus_maintenance ( long al_handle )
event ue_cus_account ( long al_handle )
event ue_order_new ( long al_handle )
event ue_order_maintenance ( long al_handle )
event ue_order_process ( long al_handle )
event ue_order_ship ( long al_handle )
event ue_pro_new ( long al_handle )
event ue_pro_category ( long al_handle,  long al_index,  long al_subindex )
event ue_pro_products ( long al_handle,  long al_index,  long al_subindex )
event ue_pro_viewcat ( long al_handle )
event ue_rep_ordertype ( long al_handle,  long al_index,  long al_subindex )
event ue_rep_procat ( long al_handle,  long al_index,  long al_subindex )
event ue_rep_cus ( long al_handle,  long al_index,  long al_subindex )
event ue_rep_report ( long al_handle )
event ue_about ( long al_handle )
event ue_rep_style ( long al_handle )
event ue_rep_print ( long al_handle )
event ue_up ( long al_handle )
event ue_rep_refresh ( long al_handle )
event ue_about2 ( long al_handle,  long al_index,  long al_subindex )
event ue_close2 ( long al_handle,  long al_index,  long al_subindex )
event ue_openlist ( long al_handle,  long al_index )
event ue_userinfo ( long al_handle,  long al_index,  long al_subindex )
event ue_sec_print ( )
event ue_retrieve ( long al_handle )
event ue_rep_ordertype_button ( long al_handle )
event ue_ribbonbar_display_refresh ( string as_windowclassname )
event ue_insertrow ( long al_handle )
event ue_deleterow ( long al_itemhandle )
event ue_savedata ( long al_handle )
event ue_sort ( long al_itemhandle )
event ue_filter ( long al_itemhandle )
event ue_first ( long al_itemhandle )
event ue_prior ( long al_itemhandle )
event ue_next ( long al_itemhandle )
event ue_last ( long al_itemhandle )
event ue_find ( long al_itemhandle )
event ue_findnext ( long al_itemhandle )
event ue_print ( long al_itemhandle )
event ue_printpreview ( long al_itemhandle )
event ue_orientation_menu ( long al_itemhandle,  long al_index,  long al_subindex )
event ue_selectionchanged_comb ( long al_itemhandle,  long al_index )
event ue_modified_comb ( long al_itemhandle )
event ue_preview_rulers ( long al_itemhandle )
event ue_print_setup ( long al_itemhandle )
event ue_exportpdf ( long al_itemhandle )
event ue_exportmethod_menu ( long al_itemhandle,  long al_index,  long al_subindex )
event ue_exportpdf_printspecialset ( long al_itemhandle )
event ue_print_set_ribbonbardisplayvalue ( datawindow adw_preview )
event ue_modify ( long al_itemhandle )
integer width = 3433
integer height = 460
long backcolor = 2500134
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer builtintheme = 2
end type

event ue_orderview(long al_handle);//
opensheet(w_order_viewer , parent , 0 , Original! )

end event

event ue_orderview_print(long al_handle);//
if isvalid(w_order_viewer) then
	w_order_viewer.wf_print()
end if
end event

event ue_close(long al_handle);//Close current active sheet window
window  lw_sheet

lw_sheet = parent.getactivesheet( )

if isvalid(lw_sheet) then
	close(lw_sheet)
else
	//Close all windows when sheet window is not available
	close(parent)
end if
end event

event ue_sec_group(long al_handle);//
open(w_group_list,parent)
end event

event ue_sec_user(long al_handle);//
open(w_user_list,parent)
end event

event ue_sec_password(long al_handle);//
open(w_change_password,parent)
end event

event ue_sec_exit(long al_handle);//close

close(parent)
end event

event ue_cus_new(long al_handle);//open the sheet window
opensheet(w_customer_new,parent,0,original!)

wf_SetActiveCategory(this,	"CategoryOperation") //add by liulihua when open this window need to display the Operation category
end event

event ue_cus_maintenance(long al_handle);//open the sheet window
opensheet(w_customer_maintenance,parent,0,original!)

wf_SetActiveCategory(this,	"CategoryOperation") //add by liulihua when open this window need to display the Operation category
end event

event ue_cus_account(long al_handle);//open the sheet window
opensheet(w_accounts_receivable,parent,0,original!)

wf_SetActiveCategory(this,	"CategoryOperation") //add by liulihua when open this window need to display the Operation category
end event

event ue_order_new(long al_handle);//open the sheet window
str_general		lstr_parm

lstr_parm.faction = "new!"
opensheetwithParm(w_order_new ,lstr_parm, parent , 0 , Original! )

wf_SetActiveCategory(this,	"CategoryOperation") //add by liulihua when open this window need to display the Operation category
end event

event ue_order_maintenance(long al_handle);//open the sheet window
opensheet(w_order_main,parent,0,original!)

wf_SetActiveCategory(this,	"CategoryOperation") //add by liulihua when open this window need to display the Operation category
end event

event ue_order_process(long al_handle);//open the sheet window
opensheet(w_processing_order,parent,0,original!)

wf_SetActiveCategory(this,	"CategoryOperation") //add by liulihua when open this window need to display the Operation category
end event

event ue_order_ship(long al_handle);//open the sheet window
opensheet(w_ship_order,parent,0,original!)

wf_SetActiveCategory(this,	"CategoryOperation") //add by liulihua when open this window need to display the Operation category
end event

event ue_pro_new(long al_handle);//open the sheet window
w_product_new 		lwin_product_new
str_general			lstr_parm

lstr_parm.faction = "new!"
OpenSheetWithParm(lwin_product_new , lstr_parm,parent , 0 , Original! )

wf_SetActiveCategory(this,	"CategoryOperation") //add by liulihua when open this window need to display the Operation category
end event

event ue_pro_category(long al_handle, long al_index, long al_subindex);//open the sheet window
opensheet(w_product_category_edit,parent,0,original!)

wf_SetActiveCategory(this,	"CategoryOperation") //add by liulihua when open this window need to display the Operation category
end event

event ue_pro_products(long al_handle, long al_index, long al_subindex);//open the sheet window
opensheet(w_product_edit,parent,0,original!)

wf_SetActiveCategory(this,	"CategoryOperation") //add by liulihua when open this window need to display the Operation category
end event

event ue_pro_viewcat(long al_handle);//open the sheet window
opensheet(w_product_catalog_view,parent,0,original!)

wf_SetActiveCategory(this,	"CategoryOperation") //add by liulihua when open this window need to display the Operation category
end event

event ue_rep_ordertype(long al_handle, long al_index, long al_subindex);//ue_rep_ordertype()
//open the sheet window
str_rptparm		lstr_parm

lstr_parm.ftitle = 'Sales Report by Order Type'
lstr_parm.fdataobject = ""
opensheetWithParm(w_rpt_order_type,lstr_parm , parent , 0 , Original! )

iw_tmp = w_rpt_order_type

wf_setstyle("2D BarStacked")
end event

event ue_rep_procat(long al_handle, long al_index, long al_subindex);//open the sheet window
str_rptparm		lstr_parm

lstr_parm.ftitle = 'Sales Report by Product Category'
lstr_parm.fdataobject = ""

opensheetWithParm(w_rpt_category_summary,lstr_parm , parent , 0 , Original! )

iw_tmp = w_rpt_category_summary

wf_setstyle("2D Line")
end event

event ue_rep_cus(long al_handle, long al_index, long al_subindex);//open the sheet window
str_rptparm		lstr_parm

lstr_parm.ftitle = 'Sales Report by Customer'
lstr_parm.fdataobject = ""

opensheetWithParm(w_rpt_order_date_summary,lstr_parm , parent , 0 , Original! )

iw_tmp = w_rpt_order_date_summary

wf_setstyle("None")

wf_SetActiveCategory(this,	"CategoryOperation") //add by liulihua when open this window need to display the Operation category
end event

event ue_rep_report(long al_handle);//open the sheet window
str_rptparm		lstr_parm

lstr_parm.ftitle ="Customer Report"
lstr_parm.fdataobject = "d_rep_customers_summary"

opensheetWithParm(w_rpt_order_customer_summary,lstr_parm , parent , 0 , Original! )

iw_tmp = w_rpt_order_customer_summary
wf_setstyle("None")

wf_SetActiveCategory(this,	"CategoryOperation") //add by liulihua when open this window need to display the Operation category
end event

event ue_about(long al_handle);//Close current active sheet window
open(w_about)



end event

event ue_rep_style(long al_handle);//Close current active sheet window
//Get smallbutton item
ribbonsmallbuttonitem lrs_item

this.getsmallbutton( al_handle, lrs_item)

string ls_tag

ls_tag = lrs_item.tag

if isvalid (iw_tmp) then
	iw_tmp.dynamic event ue_Settings(lrs_item.tag)
end if



end event

event ue_rep_print(long al_handle);
if isvalid(iw_tmp) then
	iw_tmp.dynamic function of_print()
end if
end event

event ue_up(long al_handle);
ribbontabbuttonitem lrbb_item
int li_return
long ll_handle
string ls_pic

this.gettabbutton( al_handle, lrbb_item)

if this.isminimized( ) then
	//Minimized status
	ls_pic = ".\picture\up.png"
	lrbb_item.text = "Up"
	this.setminimized( false)
else
	//Normal status
	ls_pic = ".\picture\down.png"
	lrbb_item.text = "Down"
	this.setminimized( true)
end if
lrbb_item.picturename = ls_pic
this.settabbutton( al_handle,lrbb_item)

//resize window
parent.event resize( 0, parent.workspacewidth(), parent.workspaceheight())
end event

event ue_rep_refresh(long al_handle);//Close current active sheet window
window  lw_sheet

lw_sheet = parent.getactivesheet( )

if isvalid(lw_sheet) then
	lw_sheet.dynamic event ue_retrieve()
end if
end event

event ue_about2(long al_handle, long al_index, long al_subindex);//Close current active sheet window
open(w_about)
end event

event ue_close2(long al_handle, long al_index, long al_subindex);//close main window
close(parent)
end event

event ue_openlist(long al_handle, long al_index);//open sheet window
window lw_sheet
string ls_window
ribbonmenuitem  lrbm_item
ribbonapplicationbuttonitem lrapp_item
ribbonapplicationmenu lrapp_menu
long ll_return
//Get button
ll_return = this.getapplicationbutton(lrapp_item)
if ll_return < 0 then return
//Get application menu
ll_return = lrapp_item.getmenu(lrapp_menu)
if ll_return <0 then return
//Get Recent menu
ll_return = lrapp_menu.getrecentitem( al_index, lrbm_item)
if ll_return < 0 then
	messagebox("Failed","getrecentitem "+string(al_index)+" Failed.")
	return
end if
//open window
ls_window = lrbm_item.text
if ls_window = "" then
	messagebox("Failed","does not get the window name!")
	return
end if
ib_recent = true
//open sheet window
choose case ls_window
	case "w_order_new"
		this.triggerevent( "ue_order_new")
	case "w_product_new"
		this.triggerevent( "ue_pro_new")
	case "w_rpt_order_date_summary"
		this.triggerevent("ue_rep_cus")
	case "w_rpt_order_type"
		this.triggerevent( "ue_rep_ordertype")
	case "w_rpt_category_summary"
		this.triggerevent( "ue_rep_procat")
	case "w_rpt_order_customer_summary"
		this.triggerevent( "ue_rep_report")
	Case "w_print_preview"//add by liulihua 2019-12-31
		this.TriggerEvent("ue_printpreview")
	Case "w_customer_maintenance"//add by liulihua 2019-12-31
		this.TriggerEvent("ue_cus_maintenance")	
	Case "w_order_viewer"
		this.TriggerEvent("ue_orderview")
	Case "w_accounts_receivable"
		this.TriggerEvent("ue_cus_account")
	Case "w_order_main"
		this.TriggerEvent("ue_order_maintenance")
	Case	"w_processing_order"
		this.TriggerEvent("ue_order_process")
	Case	"w_ship_order"
		this.TriggerEvent("ue_order_ship")
	Case	"w_product_category_edit"
		this.TriggerEvent("ue_pro_category")
	Case	"w_product_edit"
		this.TriggerEvent("ue_pro_products")
	Case	"w_set_find"
		this.TriggerEvent("ue_find")
	Case	"w_customer_new"
		this.TriggerEvent("ue_cus_new")	
	Case	"w_product_new_response"
		this.TriggerEvent("ue_insertrow")
	Case	"w_product_catalog_view"
		this.TriggerEvent("ue_pro_viewcat")
	//liulihua add end 2019-12-31------------------------------------//
	case ""
		
	case else
		opensheet(lw_sheet,ls_window,parent,0,Original!)
end choose


end event

event ue_userinfo(long al_handle, long al_index, long al_subindex);ribbonmenuitem  lrbm_item,lrbm_subitem
ribbonapplicationbuttonitem lrapp_item
ribbonapplicationmenu lrapp_menu
long ll_return
//get button
ll_return = this.getapplicationbutton(lrapp_item)
if ll_return < 0 then return
//get application menu
ll_return = lrapp_item.getmenu(lrapp_menu)
if ll_return <0 then return

//get child menu
ll_return = lrapp_menu.getmasteritem( al_index, al_subindex, lrbm_subitem)
if ll_return < 0 then return
choose case lrbm_subitem.Tag
	case "UserList"
		triggerevent("ue_sec_user")
	case "Group"
		triggerevent("ue_sec_group")
	case "Password"
		triggerevent("ue_sec_password")
	case "Signout"
		f_open()
end choose
end event

event ue_retrieve(long al_handle);//Author: liulihua 2019-09-25
//Retrieve the first window's special datawindow data,
//In  this function retrieve datawindow is not have the retrieve parameter

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return
//Get the window's name
ls_ClassName	=	lw_ActiveSheet.classname( )

//a corrding the window name retrieve datawindow data
Choose Case ls_ClassName
		
	Case "w_order_viewer","w_accounts_receivable","w_product_category_edit","w_product_catalog_view","w_rpt_order_customer_summary"
		lw_ActiveSheet.dynamic event open()
	Case "w_customer_maintenance"
		lw_ActiveSheet.dynamic event ue_open()		
	Case "w_rpt_order_type","w_rpt_category_summary","w_rpt_order_date_summary"
		lw_ActiveSheet.dynamic event ue_retrieve()
	Case	"w_order_main"
		lw_ActiveSheet.dynamic event ue_postopen()
	Case	"w_processing_order"
		w_processing_order.Tab_Order.Tabpage_New.dw_1. event ue_retrieve()
		
	Case	"w_ship_order","w_product_edit"
		lw_ActiveSheet.dynamic event ue_refresh()
		
	Case else
		
End	Choose

end event

event ue_rep_ordertype_button(long al_handle);//ue_rep_ordertype_button()
//open the sheet window
str_rptparm		lstr_parm

lstr_parm.ftitle = 'Sales Report by Order Type'
lstr_parm.fdataobject = ""
opensheetWithParm(w_rpt_order_type,lstr_parm , parent , 0 , Original! )

iw_tmp = w_rpt_order_type

wf_setstyle("2D BarStacked")
end event

event ue_ribbonbar_display_refresh(string as_windowclassname);//ue_ribbonbar_display_refresh(String	as_windowClassname) return none
//Author: liulihua 2019-09-26

//check the parameter object is valid
If	Not	IsValid (this)	Then	Return

If	ib_LoadXML	Then
		
	Choose Case as_windowclassname
			
		Case "w_order_viewer","w_rpt_order_date_summary","w_rpt_order_customer_summary"
			this.ImportFromXMLFile("SalesApplicationDemo_RibbonBar_orderview.xml")
			Return
		Case "w_customer_maintenance","w_order_main","w_product_edit"
			this.ImportFromXMLFile("SalesApplicationDemo_RibbonBar_CustomerMaintenance.xml")
			Return
		Case else
			
	End	Choose
	
End	If

//Integer		li_Return
//Set categories enable
wf_SetCategory_enable(this,	"CategoryCustomer",		True)
wf_SetCategory_enable(this,	"CategoryOrderProduct",	True)
wf_SetCategory_enable(this,	"CategoryReport",			True)

//Set Operation category's child object
wf_SetLargeButton_enable(this,	"OrderView",	True)
wf_SetLargeButton_enable(this,	"CustomerMaintenance",	True)
wf_SetLargeButton_enable(this,	"Reportbyorder",	True)
		
//data operation begin set all the Action button enable
wf_SetSmallButton_enable(this,	"Retrieve",	True)

wf_SetSmallButton_enable(this,	"InsertRow",	True)

wf_SetSmallButton_enable(this,	"ModifyRow",	False) //almost window disable

wf_SetSmallButton_enable(this,	"DeleteRow",	True)
//large button
wf_SetLargeButton_enable(this,	"SaveData",	True)

//row scroll
wf_SetSmallButton_enable(this,	"First",	True)


wf_SetSmallButton_enable(this,	"Prior",	True)

wf_SetSmallButton_enable(this,	"Next",	True)

wf_SetSmallButton_enable(this,	"Last",	True)

//data sort
wf_SetSmallButton_enable(this,	"Sort",	True)

wf_SetSmallButton_enable(this,	"Filter",	True)

wf_SetSmallButton_enable(this,	"Find",	True)

wf_SetSmallButton_enable(this,	"FindNext",	True)

//Export PDF
wf_SetLargeButton_enable(this,	"ExportData",	True)
wf_SetLargeButton_enable(this,	"ExportMethod",	True)

//the print object is disable default except Print Preview, only open print Prview window open its enable-------//
wf_SetLargeButton_enable(this,	"PrintPreview",	True)

Boolean		lbl_Checked 
wf_getcheckbox_Checked( this,	"UseSpecialPrintSettings",	lbl_Checked )
If	wf_getcheckbox_Enabled( this,	"UseSpecialPrintSettings") And	lbl_Checked	Then
	//orientation
	wf_SetLargeButton_enable(this,	"Orientation",	True)
	
	//paper.size
	wf_SetComboBox_enable(this,	"PageSize",	True)

Else
	//orientation
	wf_SetLargeButton_enable(this,	"Orientation",	False)
	
	//paper.size
	wf_SetComboBox_enable(this,	"PageSize",	False)
End	If

//Zoom
wf_SetComboBox_enable(this,	"Zoom",	False)

//rulers
wf_SetCheckBox_enable(this,	"ShowRuler",	False) 

//Margins
wf_SetComboBox_enable(this,	"MarginsTop",	False)

wf_SetComboBox_enable(this,	"MarginsBottom",	False)

wf_SetComboBox_enable(this,	"MarginsLeft",	False)

wf_SetComboBox_enable(this,	"MarginsRight",	False)

wf_SetLargeButton_enable(this,	"Print",	False)

wf_SetLargeButton_enable(this,	"PrintSetup",	False)
//----------------------------------------------------------------------------------------------------------------------------//

//acorrding the current window set the Action button Enable/disable
Choose	Case as_windowClassName
	Case	"w_order_viewer","w_rpt_order_date_summary","w_rpt_order_customer_summary"
		//small button	
		wf_SetSmallButton_enable(this,	"InsertRow",	False)
		
		wf_SetSmallButton_enable(this,	"DeleteRow",	False)
		
		//largebutton
		wf_SetLargeButton_enable(this,	"SaveData",	False)
		
		//data sort
		wf_SetSmallButton_enable(this,	"Sort",	False)
	
		wf_SetSmallButton_enable(this,	"Filter",	False)
		
	Case	"w_rpt_order_type","w_product_catalog_view","w_rpt_category_summary"
		//data operation
		//small button	
		wf_SetSmallButton_enable(this,	"InsertRow",	False)
		
		wf_SetSmallButton_enable(this,	"DeleteRow",	False)
		
		//largebutton
		wf_SetLargeButton_enable(this,	"SaveData",	False)
		
		//data sort
		wf_SetSmallButton_enable(this,	"Sort",	False)
	
		wf_SetSmallButton_enable(this,	"Filter",	False)
			
		//row scroll
		wf_SetSmallButton_enable(this,	"First",	False)
		
		wf_SetSmallButton_enable(this,	"Prior",	False)
		
		wf_SetSmallButton_enable(this,	"Next",	False)
		
		wf_SetSmallButton_enable(this,	"Last",	False)
		
		wf_SetSmallButton_enable(this,	"Find",	False)
		
		wf_SetSmallButton_enable(this,	"FindNext",	False)
		
	Case	"w_customer_maintenance","w_order_main","w_product_edit"
		wf_SetSmallButton_enable(this,	"ModifyRow",	True)
		If	as_windowClassname = "w_order_main"	Then
			//largebutton
			wf_SetLargeButton_enable(this,	"SaveData",	False)
			wf_SetLargeButton_enable(this,	"PrintPreview",	False)
			
			wf_SetLargeButton_enable(this,	"ExportData",	False)
			wf_SetLargeButton_enable(this,	"ExportMethod",	False)
		End	If
		
	Case	"w_product_category_edit"
		//data sort
		wf_SetSmallButton_enable(this,	"Sort",	False)
	
		wf_SetSmallButton_enable(this,	"Filter",	False)
		
	Case	"w_customer_new","w_order_new","w_product_new"
		
		//small button	
		wf_SetSmallButton_enable(this,	"Retrieve",	False)
		
		wf_SetSmallButton_enable(this,	"InsertRow",	False)
		
		wf_SetSmallButton_enable(this,	"DeleteRow",	False)
		
		//data sort
		wf_SetSmallButton_enable(this,	"Sort",	False)
		
		//data filter
		wf_SetSmallButton_enable(this,	"Filter",	False)
		
		//data find
		wf_SetSmallButton_enable(this,	"Find",	False)
		
		wf_SetSmallButton_enable(this,	"FindNext",	False)
				
		//row scroll
		wf_SetSmallButton_enable(this,	"First",	False)
		
		wf_SetSmallButton_enable(this,	"Prior",	False)
		
		wf_SetSmallButton_enable(this,	"Next",	False)
				
		wf_SetSmallButton_enable(this,	"Last",	False)
		
	Case	"w_accounts_receivable","w_processing_order"
		//small button	
		wf_SetSmallButton_enable(this,	"InsertRow",	False)
		
		wf_SetSmallButton_enable(this,	"DeleteRow",	False)
		
		//largebutton
		wf_SetLargeButton_enable(this,	"SaveData",	False)
	Case	"w_ship_order"
		//small button	
		wf_SetSmallButton_enable(this,	"InsertRow",	False)
		
		wf_SetSmallButton_enable(this,	"DeleteRow",	False)
		
		//largebutton
		wf_SetLargeButton_enable(this,	"SaveData",	False)
		
		//data sort
		wf_SetSmallButton_enable(this,	"Sort",	False)
		
		//data filter
		wf_SetSmallButton_enable(this,	"Filter",	False)
		
	Case "w_print_preview"
		wf_SetCategory_enable(this,	"CategoryCustomer",		False)
		wf_SetCategory_enable(this,	"CategoryOrderProduct",	False)
		wf_SetCategory_enable(this,	"CategoryReport",			False)
		rbb_1.SetActiveCategoryByIndex(1)

		//disable board panel
		wf_SetLargeButton_enable(this,	"OrderView",	False)
		wf_SetLargeButton_enable(this,	"CustomerMaintenance",	False)
		wf_SetLargeButton_enable(this,	"Reportbyorder",	False)
		
		//data sort
		wf_SetSmallButton_enable(this,	"Sort",	False)
		
		//data filter
		wf_SetSmallButton_enable(this,	"Filter",	False)
		
		//data find
		wf_SetSmallButton_enable(this,	"Find",	False)
		
		wf_SetSmallButton_enable(this,	"FindNext",	False)
				
		//row scroll
		wf_SetSmallButton_enable(this,	"First",	False)
		
		wf_SetSmallButton_enable(this,	"Prior",	False)
		
		wf_SetSmallButton_enable(this,	"Next",	False)
				
		wf_SetSmallButton_enable(this,	"Last",	False)
		
		//data operate
		//data operation begin set all the Action button enable
		wf_SetSmallButton_enable(this,	"Retrieve",	False)
		
		wf_SetSmallButton_enable(this,	"InsertRow",	False)
		
		wf_SetSmallButton_enable(this,	"DeleteRow",	False)
		//large button
		wf_SetLargeButton_enable(this,	"SaveData",	False)
		
		//print button
		wf_SetLargeButton_enable(this,	"Orientation",	True)
		//paper.size
		wf_SetComboBox_enable(this,	"PageSize",	True)
		
		//Zoom
		wf_SetComboBox_enable(this,	"Zoom",	True)
		
		//rulers
		wf_SetCheckBox_enable(this,	"ShowRuler",	True) 
		
		//Margins
		wf_SetComboBox_enable(this,	"MarginsTop",	True)
		
		wf_SetComboBox_enable(this,	"MarginsBottom",	True)
		
		wf_SetComboBox_enable(this,	"MarginsLeft",	True)
		
		wf_SetComboBox_enable(this,	"MarginsRight",	True)
		
		wf_SetLargeButton_enable(this,	"Print",	True)
		
		wf_SetLargeButton_enable(this,	"PrintSetup",	True)
		
	Case Else
		
End	Choose
end event

event ue_insertrow(long al_handle);//Author: liulihua 2019-09-27
//Insert Row in special datawindow at the Active  window
//In  this function retrieve datawindow is not have the retrieve parameter

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return
//Get the window's name
ls_ClassName	=	lw_ActiveSheet.classname( )

//a corrding the window name retrieve datawindow data
Choose Case ls_ClassName
		
	Case "w_order_viewer"
		
	Case "w_customer_maintenance"
		//lw_ActiveSheet.dynamic ue_insert(Clicked!)
		w_customer_maintenance.cb_5.TriggerEvent(Clicked!)
		
	Case "w_rpt_order_type"
		
	Case	"w_order_main"
		w_order_main.cb_1.TriggerEvent(Clicked!)
		
	Case	"w_product_category_edit"
		w_product_category_edit.cb_insert.TriggerEvent(Clicked!)
	Case	"w_product_edit"
		w_product_edit.cb_insert.TriggerEvent(Clicked!)
	Case else
		
End	Choose
end event

event ue_deleterow(long al_itemhandle);//Author: liulihua 2019-09-27
//Delete Row in special datawindow at the Active  window
//In  this function retrieve datawindow is not have the retrieve parameter

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return
//Get the window's name
ls_ClassName	=	lw_ActiveSheet.classname( )

//a corrding the window name retrieve datawindow data
Choose Case ls_ClassName
		
	Case "w_order_viewer"
		
	Case "w_customer_maintenance"
		//lw_ActiveSheet.dynamic ue_insert(Clicked!)
		w_customer_maintenance.cb_6.TriggerEvent(Clicked!)
	Case "w_rpt_order_type"
		
	Case	"w_order_main"
		If	w_order_main.cb_5.Enabled=True	Then
			w_order_main.cb_5.TriggerEvent(Clicked!)
		End	If		
	Case	"w_product_category_edit"
		w_product_category_edit.cb_delete.TriggerEvent(Clicked!)
	Case	"w_product_edit"
		w_product_edit.cb_delete.TriggerEvent(Clicked!)
	Case else
		
End	Choose
end event

event ue_savedata(long al_handle);//this customer event add by liulihua 2019-09-27
//Delete Row in special datawindow at the Active  window
//In  this function retrieve datawindow is not have the retrieve parameter

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return
//Get the window's name
ls_ClassName	=	lw_ActiveSheet.classname( )

//a corrding the window name retrieve datawindow data
Choose Case ls_ClassName
		
	Case "w_order_viewer"
		
	Case "w_customer_maintenance"
		//lw_ActiveSheet.dynamic ue_insert(Clicked!)
		w_customer_maintenance.cb_update.TriggerEvent(Clicked!)
	Case	"w_customer_new"
		If	w_customer_new.cb_update.Enabled = True	Then
			w_customer_new.cb_update.TriggerEvent(Clicked!)
		End	If
	Case "w_rpt_order_type"
		
	Case	"w_order_new"
		w_order_new.cb_save.TriggerEvent(Clicked!)	
	Case	"w_product_new"
		w_product_new	lw_Product_New
		lw_Product_New	=	lw_ActiveSheet
		If	lw_Product_New.cb_update.Enabled Then
			lw_Product_New.cb_update.TriggerEvent(Clicked!)
		End	If
	Case	"w_product_category_edit"
		If	w_product_category_edit.cb_update.Enabled	Then
			w_product_category_edit.cb_update.TriggerEvent(Clicked!)
		End	If
	Case	"w_product_edit"
		If	w_product_edit.cb_update.Enabled	Then
			w_product_edit.cb_update.TriggerEvent(Clicked!)
		End	If
	Case else
		
End	Choose
end event

event ue_sort(long al_itemhandle);//Author:liulihua 2019-09-25
//sort the first window's special datawindow data,
//In  this function retrieve datawindow is not have the retrieve parameter

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return
//Get the window's name
ls_ClassName	=	lw_ActiveSheet.classname( )

//a corrding the window name retrieve datawindow data
Choose Case ls_ClassName
		
	Case "w_order_viewer"
		
	Case "w_customer_maintenance"
		w_customer_maintenance.cb_2.TriggerEvent(Clicked!)	
	Case "w_rpt_order_type"
		
	Case	"w_accounts_receivable"
		If	w_accounts_receivable.tab_1.SelectedTab = 1 Then
			w_accounts_receivable.tab_1.tabpage_1.cb_5.TriggerEvent(Clicked!)
		ElseIf	w_accounts_receivable.tab_1.SelectedTab = 2 Then
			w_accounts_receivable.tab_1.Tabpage_2.cb_3.TriggerEvent(Clicked!)
		End	If
		
	Case	"w_order_main"
		w_order_main.cb_sort.TriggerEvent(Clicked!)
	Case	"w_processing_order"
		If	w_processing_order.Tab_order.SelectedTab = 1 Then
			w_processing_order.Tab_order.Tabpage_New.cb_13.TriggerEvent(Clicked!)
		ElseIf	w_processing_order.Tab_order.SelectedTab = 2	Then
			w_processing_order.Tab_order.tabpage_processing.cb_2.TriggerEvent(Clicked!)
		End	If
	Case	"w_product_edit"
		w_product_edit.cb_2.TriggerEvent(Clicked!)
		
	Case else
		
End	Choose

end event

event ue_filter(long al_itemhandle);//Author: liulihua 2019-09-25
//filter the first window's special datawindow data,
//In  this function retrieve datawindow is not have the retrieve parameter

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return
//Get the window's name
ls_ClassName	=	lw_ActiveSheet.classname( )

//a corrding the window name retrieve datawindow data
Choose Case ls_ClassName
		
	Case "w_order_viewer"
		
	Case "w_customer_maintenance"
		w_customer_maintenance.cb_4.TriggerEvent(Clicked!)	
	Case "w_rpt_order_type"
		
	Case	"w_accounts_receivable"
		If	w_accounts_receivable.tab_1.SelectedTab = 1 Then
			w_accounts_receivable.tab_1.tabpage_1.cb_12.TriggerEvent(Clicked!)
		ElseIf	w_accounts_receivable.tab_1.SelectedTab = 2 Then
			w_accounts_receivable.tab_1.Tabpage_2.cb_9.TriggerEvent(Clicked!)
		End	If
		
	Case	"w_order_main"
		w_order_main.cb_filter.TriggerEvent(Clicked!)
	
	Case	"w_processing_order"
		If	w_processing_order.Tab_order.SelectedTab = 1 Then
			w_processing_order.Tab_order.Tabpage_New.cb_14.TriggerEvent(Clicked!)
		ElseIf	w_processing_order.Tab_order.SelectedTab = 2	Then
			w_processing_order.Tab_order.tabpage_processing.cb_3.TriggerEvent(Clicked!)
		End	If
	Case	"w_product_edit"
		w_product_edit.cb_4.TriggerEvent(Clicked!)
		
	Case else
		
End	Choose

end event

event ue_first(long al_itemhandle);//Author: liulihua 2019-09-25
//scroll row of active window's specify datawindow data,

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return
//Get the window's name
ls_ClassName	=	lw_ActiveSheet.classname( )

Datawindow		ldw_Scroll_DataWindow
Long			ll_GetRow

//a corrding the window name retrieve datawindow data
Choose Case ls_ClassName
		
	Case "w_order_viewer"
		ldw_Scroll_DataWindow=w_order_viewer.tab_1.tabpage_1.dw_cust
	Case "w_customer_maintenance"
		ldw_Scroll_DataWindow=w_customer_maintenance.dw_1
	Case "w_rpt_order_type"
		
	Case	"w_accounts_receivable"
		ldw_Scroll_DataWindow=w_accounts_receivable.tab_1.tabpage_1.dw_custlist
		
	Case	"w_order_main"
		ldw_Scroll_DataWindow=w_order_main.dw_cust
	Case	"w_processing_order"
		If	w_processing_order.Tab_order.SelectedTab = 1 Then
			ldw_Scroll_DataWindow	=	w_processing_order.Tab_order.Tabpage_New.dw_1
		ElseIf	w_processing_order.Tab_order.SelectedTab = 2	Then
			ldw_Scroll_DataWindow	=	w_processing_order.Tab_order.tabpage_processing.dw_2
		End	If
	Case	"w_ship_order"
		ldw_Scroll_DataWindow	=	w_ship_order.dw_1
		
	Case	"w_product_category_edit"
		ldw_Scroll_DataWindow	=	w_product_category_edit.dw_product_category
	
	Case	"w_product_edit"
		ldw_Scroll_DataWindow	=	w_product_edit.dw_product
	Case	"w_rpt_order_customer_summary"
		ldw_Scroll_DataWindow	=	w_rpt_order_customer_summary.dw_1
	Case	"w_rpt_order_date_summary"
		ldw_Scroll_DataWindow	=	w_rpt_order_date_summary.dw_1
		
	Case else
		
End	Choose

//if scroll datawindow is not set object then return
If	Not	IsValid(ldw_Scroll_DataWindow)	Then	Return

ll_GetRow	=	ldw_Scroll_DataWindow.GetRow()

If	ll_GetRow	> 1	Then
	
	ldw_Scroll_DataWindow.ScrollToRow(1)
	
End	If

end event

event ue_prior(long al_itemhandle);//Author: liulihua 2019-09-25
//scroll row of active window's specify datawindow data,

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return
//Get the window's name
ls_ClassName	=	lw_ActiveSheet.classname( )

Datawindow		ldw_Scroll_DataWindow
Long			ll_GetRow

//a corrding the window name retrieve datawindow data
Choose Case ls_ClassName
		
	Case "w_order_viewer"
		ldw_Scroll_DataWindow=w_order_viewer.tab_1.tabpage_1.dw_cust
	Case "w_customer_maintenance"
		ldw_Scroll_DataWindow=w_customer_maintenance.dw_1
	Case "w_rpt_order_type"
	
	Case	"w_accounts_receivable"
		ldw_Scroll_DataWindow=w_accounts_receivable.tab_1.tabpage_1.dw_custlist
	Case	"w_order_main"
		ldw_Scroll_DataWindow=w_order_main.dw_cust
	Case	"w_processing_order"
		If	w_processing_order.Tab_order.SelectedTab = 1 Then
			ldw_Scroll_DataWindow	=	w_processing_order.Tab_order.Tabpage_New.dw_1
		ElseIf	w_processing_order.Tab_order.SelectedTab = 2	Then
			ldw_Scroll_DataWindow	=	w_processing_order.Tab_order.tabpage_processing.dw_2
		End	If
	Case	"w_ship_order"
		ldw_Scroll_DataWindow	=	w_ship_order.dw_1
	Case	"w_product_category_edit"
		ldw_Scroll_DataWindow	=	w_product_category_edit.dw_product_category
	Case	"w_product_edit"
		ldw_Scroll_DataWindow	=	w_product_edit.dw_product
	Case	"w_rpt_order_customer_summary"
		ldw_Scroll_DataWindow	=	w_rpt_order_customer_summary.dw_1
	Case	"w_rpt_order_date_summary"
		ldw_Scroll_DataWindow	=	w_rpt_order_date_summary.dw_1
		
	Case else
		
End	Choose

//if not set the datawindow of scroll then return
If	Not	IsValid(ldw_Scroll_DataWindow)	Then	Return

ll_GetRow	=	ldw_Scroll_DataWindow.GetRow()

If	ll_GetRow	> 1	Then	
	ldw_Scroll_DataWindow.ScrollToRow(ll_GetRow - 1)
End	If

end event

event ue_next(long al_itemhandle);//Author: liulihua 2019-09-25
//scroll row of active window's specify datawindow data,


string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return
//Get the window's name
ls_ClassName	=	lw_ActiveSheet.classname( )

Datawindow		ldw_Scroll_DataWindow
Long			ll_GetRow

//a corrding the window name retrieve datawindow data
Choose Case ls_ClassName
		
	Case "w_order_viewer"
		ldw_Scroll_DataWindow=w_order_viewer.tab_1.tabpage_1.dw_cust
	Case "w_customer_maintenance"
		ldw_Scroll_DataWindow=w_customer_maintenance.dw_1
	Case "w_rpt_order_type"
	
	Case	"w_accounts_receivable"
		ldw_Scroll_DataWindow=w_accounts_receivable.tab_1.tabpage_1.dw_custlist
	Case	"w_order_main"
		ldw_Scroll_DataWindow=w_order_main.dw_cust
	Case	"w_processing_order"
		If	w_processing_order.Tab_order.SelectedTab = 1 Then
			ldw_Scroll_DataWindow	=	w_processing_order.Tab_order.Tabpage_New.dw_1
		ElseIf	w_processing_order.Tab_order.SelectedTab = 2	Then
			ldw_Scroll_DataWindow	=	w_processing_order.Tab_order.tabpage_processing.dw_2
		End	If
	Case	"w_ship_order"
		ldw_Scroll_DataWindow	=	w_ship_order.dw_1
	Case	"w_product_category_edit"
		ldw_Scroll_DataWindow	=	w_product_category_edit.dw_product_category
	
	Case	"w_product_edit"
		ldw_Scroll_DataWindow	=	w_product_edit.dw_product
	Case	"w_rpt_order_customer_summary"
		ldw_Scroll_DataWindow	=	w_rpt_order_customer_summary.dw_1
	Case	"w_rpt_order_date_summary"
		ldw_Scroll_DataWindow	=	w_rpt_order_date_summary.dw_1
		
	Case else
		
End	Choose

//if not set the datawindow of scroll then return
If	Not	IsValid(ldw_Scroll_DataWindow)	Then	Return

ll_GetRow	=	ldw_Scroll_DataWindow.GetRow()

If	ll_GetRow	<	ldw_Scroll_DataWindow.RowCount()	Then	
	ldw_Scroll_DataWindow.ScrollToRow(ll_GetRow + 1)
End	If

end event

event ue_last(long al_itemhandle);//Author: liulihua 2019-09-25
//scroll row of active window's specify datawindow data,

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return
//Get the window's name
ls_ClassName	=	lw_ActiveSheet.classname( )

Datawindow		ldw_Scroll_DataWindow
Long			ll_GetRow

//a corrding the window name retrieve datawindow data
Choose Case ls_ClassName
		
	Case "w_order_viewer"
		ldw_Scroll_DataWindow=w_order_viewer.tab_1.tabpage_1.dw_cust
	Case "w_customer_maintenance"
		ldw_Scroll_DataWindow=w_customer_maintenance.dw_1
	Case "w_rpt_order_type"
	
	Case	"w_accounts_receivable"
		ldw_Scroll_DataWindow=w_accounts_receivable.tab_1.tabpage_1.dw_custlist
	Case	"w_order_main"
		ldw_Scroll_DataWindow=w_order_main.dw_cust
	Case	"w_processing_order"
		If	w_processing_order.Tab_order.SelectedTab = 1 Then
			ldw_Scroll_DataWindow	=	w_processing_order.Tab_order.Tabpage_New.dw_1
		ElseIf	w_processing_order.Tab_order.SelectedTab = 2	Then
			ldw_Scroll_DataWindow	=	w_processing_order.Tab_order.tabpage_processing.dw_2
		End	If
	Case	"w_ship_order"
		ldw_Scroll_DataWindow	=	w_ship_order.dw_1
	Case	"w_product_category_edit"
		ldw_Scroll_DataWindow	=	w_product_category_edit.dw_product_category
	Case	"w_product_edit"
		ldw_Scroll_DataWindow	=	w_product_edit.dw_product
	Case	"w_rpt_order_customer_summary"
		ldw_Scroll_DataWindow	=	w_rpt_order_customer_summary.dw_1
	Case	"w_rpt_order_date_summary"
		ldw_Scroll_DataWindow	=	w_rpt_order_date_summary.dw_1
	Case else
		
End	Choose

//if not set the datawindow of scroll then return
If	Not	IsValid(ldw_Scroll_DataWindow)	Then	Return

ll_GetRow	=	ldw_Scroll_DataWindow.GetRow()

If	ll_GetRow	<	ldw_Scroll_DataWindow.RowCount()	Then
	
	ldw_Scroll_DataWindow.ScrollToRow(ldw_Scroll_DataWindow.RowCount())
	
End	If
end event

event ue_find(long al_itemhandle);//Author: liulihua 2019-09-25
//find the text in specify datawindow

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return
//Get the window's name
ls_ClassName	=	lw_ActiveSheet.classname( )

Datawindow		ldw_Find_DataWindow

//a corrding the window name retrieve datawindow data
Choose Case ls_ClassName
		
	Case "w_order_viewer"
		ldw_Find_DataWindow=w_order_viewer.tab_1.tabpage_1.dw_cust
	Case "w_customer_maintenance"
		ldw_Find_DataWindow=w_customer_maintenance.dw_1
	Case "w_rpt_order_type"
		
	Case	"w_accounts_receivable"
		ldw_Find_DataWindow=w_accounts_receivable.tab_1.tabpage_1.dw_custlist
	Case	"w_order_main"
		ldw_Find_DataWindow=w_order_main.dw_cust
	Case	"w_processing_order"
		If	w_processing_order.Tab_order.SelectedTab = 1 Then
			ldw_Find_DataWindow	=	w_processing_order.Tab_order.Tabpage_New.dw_1
		ElseIf	w_processing_order.Tab_order.SelectedTab = 2	Then
			ldw_Find_DataWindow	=	w_processing_order.Tab_order.tabpage_processing.dw_2
		End	If
	Case	"w_ship_order"
		ldw_Find_DataWindow	=	w_ship_order.dw_1
	Case	"w_product_category_edit"
		ldw_Find_DataWindow	=	w_product_category_edit.dw_product_category
	Case	"w_product_edit"
		ldw_Find_DataWindow	=	w_product_edit.dw_product
	Case	"w_rpt_order_customer_summary"
		ldw_Find_DataWindow	=	w_rpt_order_customer_summary.dw_1
	Case	"w_rpt_order_date_summary"
		ldw_Find_DataWindow	=	w_rpt_order_date_summary.dw_1
	Case else
		
End	Choose

//if scroll datawindow is not set object then return
If	Not	IsValid(ldw_Find_DataWindow)	Then	Return

str_find		lstr_Find
lstr_Find.s_FindType="1" //1:find;2:find next
lstr_Find.dw_FindDatawindow = ldw_Find_DataWindow

OpenWithParm ( w_set_find, lstr_Find )

is_Find = Message.stringParm

lw_ActiveSheet.Event Activate()
end event

event ue_findnext(long al_itemhandle);//Author: liulihua 2019-09-25
//find the text in specify datawindow

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return
//Get the window's name
ls_ClassName	=	lw_ActiveSheet.classname( )

Datawindow		ldw_Find_DataWindow

//a corrding the window name retrieve datawindow data
Choose Case ls_ClassName
		
	Case "w_order_viewer"
		ldw_Find_DataWindow=w_order_viewer.tab_1.tabpage_1.dw_cust
	Case "w_customer_maintenance"
		ldw_Find_DataWindow=w_customer_maintenance.dw_1
	Case "w_rpt_order_type"
	
	Case	"w_accounts_receivable"
		ldw_Find_DataWindow=w_accounts_receivable.tab_1.tabpage_1.dw_custlist
	Case	"w_order_main"
		ldw_Find_DataWindow=w_order_main.dw_cust
	Case	"w_processing_order"
		If	w_processing_order.Tab_order.SelectedTab = 1 Then
			ldw_Find_DataWindow	=	w_processing_order.Tab_order.Tabpage_New.dw_1
		ElseIf	w_processing_order.Tab_order.SelectedTab = 2	Then
			ldw_Find_DataWindow	=	w_processing_order.Tab_order.tabpage_processing.dw_2
		End	If
	Case	"w_ship_order"
		ldw_Find_DataWindow	=	w_ship_order.dw_1
		
	Case	"w_product_category_edit"
		ldw_Find_DataWindow	=	w_product_category_edit.dw_product_category
	Case	"w_product_edit"
		ldw_Find_DataWindow	=	w_product_edit.dw_product
	Case	"w_rpt_order_customer_summary"
		ldw_Find_DataWindow	=	w_rpt_order_customer_summary.dw_1
	Case	"w_rpt_order_date_summary"
		ldw_Find_DataWindow	=	w_rpt_order_date_summary.dw_1
		
	Case else
		
End	Choose

//if scroll datawindow is not set object then return
If	Not	IsValid(ldw_Find_DataWindow)	Then	Return

str_find		lstr_Find
lstr_Find.s_FindType="2" //1:find;2:find next
lstr_Find.dw_FindDatawindow = ldw_Find_DataWindow
lstr_Find.s_FindText = is_Find

OpenWithParm ( w_set_find, lstr_Find )

lw_ActiveSheet.Event Activate()
end event

event ue_print(long al_itemhandle);//Author: liulihua 2019-09-29
//Print sepcify datawindow

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return

//a corrding the window name retrieve datawindow data
Choose Case lw_ActiveSheet.classname( )
		
	Case "w_rpt_order_type"
		
	Case	"w_print_preview"
		w_print_preview.dw_preview.print()
		
	Case else
		
End	Choose

end event

event ue_printpreview(long al_itemhandle);//Author: liulihua
//open the print view window and set print properties then print

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return
//Get the window's name
ls_ClassName	=	lw_ActiveSheet.classname( )

n_ds		lds_print
Datawindow		ldw_print
String			ls_PSR_Name
Integer		li_Return
str_Print		lstr_Print

//the different window have different datawindow parameter
Choose Case ls_ClassName
		
	Case "w_order_viewer"
		
		If	w_order_viewer.dw_custdetail.Getrow() > 0 Then
			lds_print	=	Create	n_ds
			lds_print.DataObject = "d_rep_cust_current"
			lds_print.SetTransObject(sqlca)
			lds_print.Retrieve(w_order_viewer.dw_custdetail.GetItemString(w_order_viewer.dw_custdetail.GetRow(), "fcustno" ))	
			lstr_Print.s_PSR_Name = "rpt_orderview.PSR"	
			//lstr_Print.s_Dataobject	=	"d_rep_cust_current"	
			li_Return=lds_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)			
		Else
			Return
		End	If
		
	Case "w_customer_maintenance"
		ldw_print=w_customer_maintenance.dw_1
		lstr_Print.s_PSR_Name = "rpt_maintenance.PSR"	
		ldw_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)
	Case "w_rpt_order_type"
		ldw_print=w_rpt_order_type.dw_1
		lstr_Print.s_PSR_Name = "rpt_order_type.PSR"	
		ldw_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)
	Case "w_rpt_category_summary"
		ldw_print=w_rpt_category_summary.dw_1
		lstr_Print.s_PSR_Name = "rpt_category_summary.PSR"	
		ldw_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)
	Case	"w_rpt_order_date_summary"
		ldw_print=w_rpt_order_date_summary.dw_1
		lstr_Print.s_PSR_Name = "rpt_order_date_summary.PSR"	
		ldw_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)
		
	Case	"w_accounts_receivable"
		ldw_print	=	w_accounts_receivable.tab_1.tabpage_1.dw_custlist
		lstr_Print.s_PSR_Name = "rpt_accounts_recervable.PSR"	
		ldw_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)
	Case	"w_customer_new"
		ldw_print	=	w_customer_new.dw_1
		lstr_Print.s_PSR_Name = "rpt_Customer_new.PSR"	
		ldw_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)
	Case	"w_order_new"
		ldw_print=w_order_new.dw_cust_order
		lstr_Print.s_PSR_Name = "rpt_Order_new.PSR"	
		ldw_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)
	Case	"w_processing_order"
		If	w_processing_order.Tab_order.SelectedTab = 1 Then
			ldw_print	=	w_processing_order.Tab_order.Tabpage_New.dw_1
		ElseIf	w_processing_order.Tab_order.SelectedTab = 2	Then
			ldw_print	=	w_processing_order.Tab_order.tabpage_processing.dw_2
		End	If
		lstr_Print.s_PSR_Name = "rpt_processing_order.PSR"	
		ldw_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)
	Case	"w_ship_order"
		ldw_print=w_ship_order.dw_1
		lstr_Print.s_PSR_Name = "rpt_ship_order.PSR"	
		ldw_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)
	Case	"w_product_new"
		w_product_new	lw_Product_New
		lw_Product_New	=	lw_ActiveSheet
		ldw_print	=	lw_Product_New.dw_product
		lstr_Print.s_PSR_Name = "rpt_product_new.PSR"	
		ldw_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)
	Case	"w_product_category_edit"
		ldw_print	=	w_product_category_edit.dw_product_category
		lstr_Print.s_PSR_Name = "rpt_category_edit.PSR"	
		ldw_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)
	Case	"w_product_edit"
		ldw_print	=	w_product_edit.dw_product
		lstr_Print.s_PSR_Name = "rpt_product_edit.PSR"	
		ldw_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)
	Case	"w_product_catalog_view"
		ldw_print	=	w_product_catalog_view.dw_1	
		lstr_Print.s_PSR_Name = "rpt_product_catalog_view.PSR"	
		ldw_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)
	Case	"w_rpt_order_customer_summary"
		ldw_print	=	w_rpt_order_customer_summary.dw_1
		lstr_Print.s_PSR_Name = "rpt_order_customer_summary.PSR"	
		ldw_print.SaveAs(lstr_Print.s_PSR_Name,PSReport!,True)
	
	Case Else
		Return
End	Choose



OpenSheetWithParm(w_print_preview , lstr_Print, parent , 0 , Layered! )

this.Post Event ue_Print_Set_RibbonbarDisplayValue(w_print_preview.dw_Preview)
end event

event ue_orientation_menu(long al_itemhandle, long al_index, long al_subindex);//Author: liulihua 2019-09-30
//ue_Orientation_Menu (Long al_ItemHandle, Long al_Index, Long al_SubIndex) return none 

RibbonMenu		lrbb_ribbonMenu
RibbonMenuItem 	lrbbMI_MenuItem
RibbonLargeButtonItem		lrrblb_LargeButton
Integer		li_Return
String		ls_Orientation_Value
li_Return=this.GetMenuByButtonHandle(al_ItemHandle, lrbb_ribbonMenu)
If	li_Return	=	1	Then
	lrbb_ribbonMenu.GetItem(al_index,lrbbMI_MenuItem)
	//Set the large button text
	//get the Orientation largebutton item
	this.GetLargeButton( al_itemhandle, lrrblb_LargeButton )
	Choose case lrbbMI_MenuItem.Text
			
		Case "Default"
			lrrblb_LargeButton.Text = "Orientation"
			ls_Orientation_Value = "0"
		Case "Portrait"
			lrrblb_LargeButton.Text = "Portrait"
			ls_Orientation_Value = "2"
		Case "Landscape"
			lrrblb_LargeButton.Text = "Landscape"
			ls_Orientation_Value = "1"
		Case Else
			return
	End	Choose
	//set orientation button text
	this.SetLargeButton(lrrblb_LargeButton.ItemHandle, lrrblb_LargeButton)
	
	//set the datawindow's Print Orientation property
	//Get the First window  in MDI 
	window lw_ActiveSheet
	lw_ActiveSheet = parent.GetActiveSheet()
	
	//check the GetActiveSheet return window is valid
	If	Not	IsValid(lw_ActiveSheet)	Then Return
	
	//a corrding the window name retrieve datawindow data
	Choose Case lw_ActiveSheet.classname( )
			
		Case "w_order_viewer"			
		Case "w_customer_maintenance"				
		Case "w_rpt_order_type"
		Case "w_print_preview"
			w_print_preview.dw_preview.Object.DataWindow.Print.Orientation= ls_Orientation_Value
			
		Case else
			
	End	Choose
End	If

end event

event ue_selectionchanged_comb(long al_itemhandle, long al_index);//Author: liulihua
//ue_selectionchanged_comb(long al_ItemHandle long al_Index) return none

window lw_ActiveSheet
Datawindow		ldw_Preview

lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	Not	IsValid(lw_ActiveSheet)	Then Return
RibbonComboBoxItem		lrbbcb_combox
If	this.GetComboBox( al_itemhandle,	lrbbcb_combox ) <> 1 Then Return

//a corrding the window name retrieve datawindow data
Choose Case lw_ActiveSheet.classname( )		
	
	Case "w_print_preview"		
		ldw_Preview=w_print_preview.dw_preview//
		
	Case else
		
End	Choose

If	Not	IsValid(ldw_Preview)	Then	Return

Integer		li_Pos
String			ls_Zoom

Choose	Case	lrbbcb_combox.Tag
		
	Case "PageSize"	
		ldw_Preview.Object.DataWindow.Print.Paper.Size= left( lrbbcb_combox.Text ,Pos( lrbbcb_combox.Text," ") - 1)
	Case "Zoom"
		//filter &
		li_Pos		=	Pos( lrbbcb_combox.Text,"%")
		If	li_Pos	<	1	Then
			ls_zoom	=	lrbbcb_combox.Text
		Else
			ls_zoom	=	Left(lrbbcb_combox.Text, li_Pos - 1 )
		End	If
		//check the input data
		If	IsNumber(ls_zoom) Then
			ldw_Preview.Object.DataWindow.Print.Preview.zoom= ls_zoom
		End	If
	Case ""
		
	Case Else
		
End Choose
		
end event

event ue_modified_comb(long al_itemhandle);//Author: liulihua
//ue_Modified_comb(long	al_ItemHandle) return none

window lw_ActiveSheet
Datawindow		ldw_Preview

lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	Not	IsValid(lw_ActiveSheet)	Then Return
RibbonComboBoxItem		lrbbcb_CombBox
Integer			li_Pos
String			ls_ModifyValue

If	this.GetComboBox( al_itemhandle,	lrbbcb_CombBox ) <> 1 Then Return

//a corrding the window name retrieve datawindow data
Choose Case lw_ActiveSheet.classname( )		
	
	Case "w_print_preview"
		ldw_Preview = w_print_preview.dw_preview
		
		
	Case else
		
End	Choose

If	Not IsValid(ldw_Preview)	Then	Return

ls_ModifyValue	=	lrbbcb_CombBox.Text

Choose	Case	lrbbcb_CombBox.Tag
		
	Case	"Zoom"
		//filter &
		li_Pos		=	Pos( lrbbcb_CombBox.Text,"%")
		If	li_Pos	>	0	Then			
			ls_ModifyValue	=	Left(lrbbcb_CombBox.Text, li_Pos - 1 )
		End	If
		//check the input data
		If	IsNumber(ls_ModifyValue) Then
			w_print_preview.dw_preview.Object.DataWindow.Print.Preview.zoom= ls_ModifyValue		
		End	If
		
	Case	"MarginsTop"
		If	IsNumber(ls_ModifyValue) Then
			
			w_print_preview.dw_preview.Modify("DataWindow.Print.Margin.Top='"+ls_ModifyValue+"'")
		End	If
	Case	"MarginsBottom"
		If	IsNumber(ls_ModifyValue) Then
			
			w_print_preview.dw_preview.Modify("DataWindow.Print.Margin.Bottom='"+ls_ModifyValue+"'")
		End	If
	Case	"MarginsLeft"
		If	IsNumber(ls_ModifyValue) Then
			
			w_print_preview.dw_preview.Modify("DataWindow.Print.Margin.Left='"+ls_ModifyValue+"'")
		End	If
	Case	"MarginsRight"
		If	IsNumber(ls_ModifyValue) Then
			
			w_print_preview.dw_preview.Modify("DataWindow.Print.Margin.Right='"+ls_ModifyValue+"'")
		End	If
		
	Case	Else
		
End	Choose


end event

event ue_preview_rulers(long al_itemhandle);//Author: liulihua
//ue_preview_rulers(long	al_ItemHandle)	Return none

window lw_ActiveSheet
Datawindow		ldw_Preview

lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	Not	IsValid(lw_ActiveSheet)	Then Return
RibbonCheckBoxItem		lrbbcb_Checkbox
If	this.GetCheckBox( al_itemhandle,	lrbbcb_Checkbox ) <> 1 Then Return

//a corrding the window name retrieve datawindow data
Choose Case lw_ActiveSheet.classname( )		
	
	Case "w_print_preview"		
		w_print_preview.dw_preview.object.datawindow.print.preview.Rulers	= lrbbcb_Checkbox.Checked
	Case else
		
End	Choose
end event

event ue_print_setup(long al_itemhandle);//Author: liulihua 2019-09-29
//Print sepcify datawindow
//ue_print_setup(long	al_ItemHandle) return none

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return

//a corrding the window name retrieve datawindow data
Choose Case lw_ActiveSheet.classname( )
		
	Case "w_rpt_order_type"
		
	Case	"w_print_preview"
		w_print_preview.dw_preview.print(False,True)
		
	Case else
		
End	Choose
end event

event ue_exportpdf(long al_itemhandle);//Author: liulihua
//ue_ExportPDF(long	al_ItemHandle)	return	none

//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return

Datawindow		ldw_SaveAs

//a corrding the window name retrieve datawindow data
Choose Case lw_ActiveSheet.classname( )
		
	Case "w_order_viewer"
		ldw_SaveAs=w_order_viewer.tab_1.tabpage_1.dw_cust
	Case "w_customer_maintenance"
		ldw_SaveAs=w_customer_maintenance.dw_1
	Case "w_rpt_order_type"
		ldw_SaveAs=w_rpt_order_type.dw_1
	Case "w_rpt_category_summary"
		ldw_SaveAs=w_rpt_category_summary.dw_1
	Case	"w_rpt_order_date_summary"
		ldw_SaveAs=w_rpt_order_date_summary.dw_1
	Case	"w_print_preview"		
		ldw_SaveAs	=	w_print_preview.dw_preview
	Case	"w_accounts_receivable"
		ldw_SaveAs	=	w_accounts_receivable.tab_1.tabpage_1.dw_custlist
	Case	"w_customer_new"
		ldw_SaveAs	=	w_customer_new.dw_1
	Case	"w_processing_order"
		If	w_processing_order.Tab_order.SelectedTab = 1 Then
			ldw_SaveAs	=	w_processing_order.Tab_order.Tabpage_New.dw_1
		ElseIf	w_processing_order.Tab_order.SelectedTab = 2	Then
			ldw_SaveAs	=	w_processing_order.Tab_order.tabpage_processing.dw_2
		End	If
	Case	"w_ship_order"
		ldw_SaveAs=w_ship_order.dw_1
	Case	"w_order_new"
		ldw_SaveAs=w_order_new.dw_cust_order
	Case	"w_product_new"
		w_product_new	lw_Product_New
		lw_Product_New	=	lw_ActiveSheet
		ldw_SaveAs	=	lw_Product_New.dw_product
	Case	"w_product_category_edit"
		ldw_SaveAs	=	w_product_category_edit.dw_product_category
	Case	"w_product_edit"
		ldw_SaveAs	=	w_product_edit.dw_product
	Case	"w_product_catalog_view"
		ldw_SaveAs	=	w_product_catalog_view.dw_1
	Case	"w_rpt_order_customer_summary"
		ldw_SaveAs	=	w_rpt_order_customer_summary.dw_1
	Case else
		
End	Choose

//check datawindow's valid
If	Not	IsValid(ldw_SaveAs)	Then	Return
String		ls_Property_Value
boolean		lbl_Checked
Integer		li_Return
//Get the ribbonbar export properties value
//Get method
If	wf_GetLargeButton_Text(This,	"ExportMethod", ls_Property_Value)	Then
	If	ls_Property_Value	= "Distill"	Then
		ldw_SaveAs.Object.DataWindow.Export.PDF.Method=Distill!
		ldw_SaveAs.object.datawindow.printer = "Ghostscript PDF"
		//get distill custom PostScript
		wf_getcheckbox_checked( This,	"DistillCustomPostScript",	lbl_Checked)
		If	lbl_Checked	Then
			ldw_SaveAs.Object.DataWindow.Export.PDF.Distill.CustomPostScript="1"
		Else
			ldw_SaveAs.Object.DataWindow.Export.PDF.Distill.CustomPostScript="0"
		End	If
		//get print using xslfop
		wf_getcheckbox_checked( This,	"PrintUsingXSLFOP",	lbl_Checked)
		If	lbl_Checked	Then
			ldw_SaveAs.Object.DataWindow.Export.PDF.XSLFOP.Print="1"
		Else
			ldw_SaveAs.Object.DataWindow.Export.PDF.XSLFOP.Print="0"
		End	If
		
	ElseIf	ls_Property_Value	=	"NativePDF"	Then
		
		ldw_SaveAs.Object.DataWindow.Export.PDF.Method=NativePDF!
		//get PDF Conformance if Native PDF
		wf_GetComboBox_Text(This,	"PDFConformance",	ls_Property_Value)
		ldw_SaveAs.Object.DataWindow.Export.PDF.NativePDF.PDFStandard=Left(ls_Property_Value,1)
		//Get Use Special Print Settings
		wf_getcheckbox_checked( This,	"UseSpecialPrintSettings",	lbl_Checked)
		If	Not lbl_Checked	Then
			ldw_SaveAs.Object.DataWindow.Export.PDF.NativePDF.UsePrintSpec = "No"			
			//get paper size
			wf_getComboBox_Text( This,	"ExportPaperSize",	ls_Property_Value)
			//set paper size
			ldw_SaveAs.Object.DataWindow.Export.PDF.NativePDF.CustomSize=Left(ls_Property_Value,1)
			//get orientation			
			wf_getComboBox_Text( This,	"ExportOrientation",	ls_Property_Value)
			//set orientation
			ldw_SaveAs.Object.DataWindow.Export.PDF.NativePDF.CustomOrientation=Left(ls_Property_Value,1)
		Else
			ldw_SaveAs.Object.DataWindow.Export.PDF.NativePDF.UsePrintSpec = "Yes"
			
			//paper size
			wf_GetComboBox_Text( This,	"PageSize",	ls_Property_Value)
			ldw_SaveAs.Object.DataWindow.Print.Paper.Size= left( ls_Property_Value ,Pos( ls_Property_Value," ") - 1)
			
			wf_GetLargeButton_Text(This,	"Orientation",ls_Property_Value)
			Choose	Case ls_Property_Value				
				Case "Default"					
					ldw_SaveAs.Object.DataWindow.Print.Orientation = "0"
				Case "Portrait"					
					ldw_SaveAs.Object.DataWindow.Print.Orientation = "2"
				Case "Landscape"
					ldw_SaveAs.Object.DataWindow.Print.Orientation = "1"
				Case	Else
					
			End	Choose
			//paper orientation
			
		End	If
		
	Else
		Return
	End	If
	
End	If

//save as data
li_Return	=	ldw_SaveAs.SaveAs("",PDF!, True)
If IsNull(li_Return)	Or	li_Return	=	-1	Then
	MessageBox("failed","Save as data failed!")
End	If

end event

event ue_exportmethod_menu(long al_itemhandle, long al_index, long al_subindex);//Author: liulihua 2019-09-30
//ue_ExportMethod_Menu (Long al_ItemHandle, Long al_Index, Long al_SubIndex) return none 

RibbonMenu		lrbb_ribbonMenu
RibbonMenuItem 	lrbbMI_MenuItem
RibbonLargeButtonItem		lrrblb_LargeButton
Integer		li_Return
String		ls_Orientation_Value
Boolean		lbl_Checked

li_Return=this.GetMenuByButtonHandle(al_ItemHandle, lrbb_ribbonMenu)
If	li_Return	=	1	Then
	lrbb_ribbonMenu.GetItem(al_index,lrbbMI_MenuItem)
	//Set the large button text
	//get the Orientation largebutton item
	this.GetLargeButton( al_itemhandle, lrrblb_LargeButton )
	Choose case lrbbMI_MenuItem.Text
			
		Case "Distill"
			lrrblb_LargeButton.Text = "Distill"
			lrrblb_LargeButton.PictureName="AppSmall!"
			this.SetLargeButton(lrrblb_LargeButton.ItemHandle, lrrblb_LargeButton)
			//set the NativePDF properties disabled
			wf_SetComboBox_enable( This,	"PDFConformance",	False)
			wf_SetCheckBox_enable( This,	"UseSpecialPrintSettings",	False)
			wf_SetComboBox_enable( This,	"ExportPaperSize",	False)
			wf_SetComboBox_enable( This,	"ExportOrientation",	False)
			//set the distill prperties enalbe
			wf_SetCheckBox_enable( This,	"DistillCustomPostScript",	True)
			wf_SetCheckBox_enable( This,	"PrintUsingXSLFOP",	True)
			
			If	Not	wf_GetLargeButton_enable(this,	"Print")	Then
				wf_SetLargeButton_enable( This,	"Orientation",	False)
				wf_SetComboBox_enable( This,	"PageSize",	False)
			End	If
			
		Case "NativePDF"
			lrrblb_LargeButton.Text = "NativePDF"
			lrrblb_LargeButton.PictureName=".\picture\NativePdfBig.png"
			this.SetLargeButton(lrrblb_LargeButton.ItemHandle, lrrblb_LargeButton)
			//set the distill properties disable
			wf_SetCheckBox_enable( This,	"DistillCustomPostScript",	False)
			wf_SetCheckBox_enable( This,	"PrintUsingXSLFOP",	False)
			//set the native properties enabl
			wf_SetComboBox_enable( This,	"PDFConformance",	True)
			wf_SetCheckBox_enable( This,		"UseSpecialPrintSettings",	True)
			wf_GetCheckbox_checked( This,	"UseSpecialPrintSettings",	lbl_Checked) 
			If Not	lbl_Checked	Then				
				wf_SetComboBox_enable( This,	"ExportPaperSize",	True)
				wf_SetComboBox_enable( This,	"ExportOrientation",	True)
			Else
				wf_SetComboBox_enable( This,	"ExportPaperSize",	False)
				wf_SetComboBox_enable( This,	"ExportOrientation",	False)
				
				wf_SetLargeButton_enable( This,	"Orientation",	True)
				wf_SetComboBox_enable( This,	"PageSize",	True)
				
			End	If
		Case Else
			Return
	End	Choose
		
End	If
end event

event ue_exportpdf_printspecialset(long al_itemhandle);//Author:liulihua
//ue_ExportPDF_PrintSpecialSet(long	al_ItemHandle)	return noe

RibboncheckBoxItem		lrbbcb_Checkbox
If	This.GetCheckBox(al_ItemHandle,	lrbbcb_Checkbox) <>	1	Then	Return

If	Not	lrbbcb_Checkbox.Checked	Then
	wf_SetComboBox_enable( This,	"ExportPaperSize",	True)
	wf_SetComboBox_enable( This,	"ExportOrientation",	True)
	
	If	Not	wf_GetLargeButton_enable(this,	"Print")	Then
		wf_SetLargeButton_enable( This,	"Orientation",	False)
		wf_SetComboBox_enable( This,	"PageSize",	False)
	End	If
	
Else
	wf_SetComboBox_enable( This,	"ExportPaperSize",	False)
	wf_SetComboBox_enable( This,	"ExportOrientation",	False)
	wf_SetLargeButton_enable( This,	"Orientation",	True)
	wf_SetComboBox_enable( This,	"PageSize",	True)
	//
End	If

end event

event ue_print_set_ribbonbardisplayvalue(datawindow adw_preview);//Author:liulihua
//ue_Print_Set_RibbonbarDisplayValue(datawindow	adw_Preview)	return none

//
If	Not IsValid(adw_Preview)	Then	Return

String		ls_Value

ls_Value	=	adw_Preview.Describe("DataWindow.Print.Preview.Zoom")
If	Trim(ls_Value) <> "!"	Then
	wf_SetComboBox_Text( this,	"Zoom",	ls_Value)
End	If

ls_Value	=	w_print_preview.dw_preview.Describe("DataWindow.Print.Margin.Top"	)
If	Trim(ls_Value)  <> "!"	Then
	wf_SetComboBox_Text( this,	"MarginsTop",	ls_Value)
End	If

			
ls_Value	=	w_print_preview.dw_preview.Describe("DataWindow.Print.Margin.Bottom"	)
If	Trim(ls_Value)  <> "!"	Then
	wf_SetComboBox_Text( this,	"MarginsBottom",	ls_Value)
End	If

ls_Value	=	w_print_preview.dw_preview.Describe("DataWindow.Print.Margin.Left"		)
If	Trim(ls_Value)  <> "!"	Then
	wf_SetComboBox_Text( this,	"MarginsLeft",	ls_Value)
End	If
			
ls_Value	=	w_print_preview.dw_preview.Describe("DataWindow.Print.Margin.Right"	)
If	Trim(ls_Value)  <> "!"	Then
	wf_SetComboBox_Text( this,	"MarginsRight",	ls_Value)
End	If

If	Trim(Lower(adw_Preview.Describe("DataWindow.Print.Preview.Rulers")) )= "yes"	Then
	wf_SetCheckbox_checked(this,	"ShowRuler",	True)	
Else
	wf_SetCheckbox_checked(this,	"ShowRuler",	False)	
End	If

Choose	Case	adw_Preview.Describe("DataWindow.Print.Orientation")
		
	Case	"0"
		wf_SetLargeButton_Text(This,	"Orientation",	"Orientation")
	Case	"1"
		wf_SetLargeButton_Text(This,	"Orientation",	"Portrait")
	Case	"2"
		wf_SetLargeButton_Text(This,	"Orientation",	"Landscape")
	Case	Else
		
End	Choose

end event

event ue_modify(long al_itemhandle);//Author: liulihua 2019-10-10
//Modify the specify row data

string	ls_ClassName
//Get the First window  in MDI 
window lw_ActiveSheet
lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	IsNull(lw_ActiveSheet)	Then Return
If	Not	IsValid(lw_ActiveSheet)	Then Return
//Get the window's name
ls_ClassName	=	lw_ActiveSheet.classname( )

//a corrding the window name retrieve datawindow data
Choose Case ls_ClassName
		
	Case "w_order_viewer"
		
	Case "w_customer_maintenance"
		//lw_ActiveSheet.dynamic ue_insert(Clicked!)
		w_customer_maintenance.cb_1.TriggerEvent(Clicked!)
		
	Case "w_rpt_order_type"
		
	Case	"w_order_main"
		If	w_order_main.cb_3.Enabled = True	Then
			w_order_main.cb_3.TriggerEvent(Clicked!)
		End	If
	Case	"w_product_edit"
		w_product_edit.cb_1.TriggerEvent(Clicked!)
	Case else
		
End	Choose
end event

