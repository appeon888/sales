$PBExportHeader$w_read_menu.srw
$PBExportComments$Temporary window
forward
global type w_read_menu from window
end type
type st_1 from statictext within w_read_menu
end type
type cb_2 from commandbutton within w_read_menu
end type
type cb_1 from commandbutton within w_read_menu
end type
type dw_1 from datawindow within w_read_menu
end type
end forward

global type w_read_menu from window
integer width = 2533
integer height = 1576
boolean titlebar = true
string title = "Read Menu"
string menuname = "m_customer_order"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_read_menu w_read_menu

forward prototypes
public function integer wf_readmenu (menu am, string as_prefix)
end prototypes

public function integer wf_readmenu (menu am, string as_prefix);//====================================================================
// Function: wf_readmenu()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		menu  	am       		
//		string	as_prefix		
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

Long  ll,ll_New
String  ls_Text,ls_menuno

For ll = 1 To UpperBound(am.Item[])
	ls_Text = am.Item[ll].Tag
	If ls_Text = '-' Then Continue
	ls_menuno = as_prefix+String(ll,'00')
	
	If ls_Text <> '' Then
		ll_New = dw_1.InsertRow(0)
		dw_1.ScrollToRow(ll_New)
		dw_1.SetItem(ll_New,'fmenuno',ls_menuno)
		dw_1.SetItem(ll_New,'fmenuname',ls_Text)
		INSERT INTO t_menu(fmenuno,fmenuname)
			Values(:ls_menuno,:ls_Text);
	End If
	If UpperBound(am.Item[ll].Item[]) > 0 Then
		wf_readmenu(am.Item[ll],ls_menuno)
	End If
Next
Return 1


end function

on w_read_menu.create
if this.MenuName = "m_customer_order" then this.MenuID = create m_customer_order
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_read_menu.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type st_1 from statictext within w_read_menu
integer x = 46
integer y = 72
integer width = 933
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "This window is used to initial system menus"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_read_menu
integer x = 1883
integer y = 364
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Decode"
end type

type cb_1 from commandbutton within w_read_menu
integer x = 1399
integer y = 276
integer width = 439
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Read Menu"
end type

event clicked;//====================================================================
// Event: clicked()
//--------------------------------------------------------------------
// Description: Set Right
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

Long  ll
menu  lm

// Profile AppeonSample25
DISCONNECT;

SQLCA.DBMS = "ODBC"
SQLCA.AutoCommit = False
SQLCA.DBParm = "ConnectString='DSN=AppeonSample25;UID=dba;PWD=sql',DisableBind=1"
CONNECT;

DELETE From T_MENU_MANAGE;
DELETE From T_MENU;
COMMIT;
For ll = 1 To UpperBound(Parent.MenuID.Item[])
	wf_readmenu(Parent.MenuID.Item[ll],String(ll,'00'))
Next

COMMIT;



end event

type dw_1 from datawindow within w_read_menu
integer x = 64
integer y = 220
integer width = 1289
integer height = 1172
integer taborder = 20
string title = "none"
string dataobject = "dw_manager_menu"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

