$PBExportHeader$w_rpt_default_year.srw
$PBExportComments$Default year Setting for reports
forward
global type w_rpt_default_year from window
end type
type uo_1 from u_year_between within w_rpt_default_year
end type
type cb_2 from commandbutton within w_rpt_default_year
end type
type cb_1 from commandbutton within w_rpt_default_year
end type
type sle_2 from singlelineedit within w_rpt_default_year
end type
type sle_1 from singlelineedit within w_rpt_default_year
end type
type st_2 from statictext within w_rpt_default_year
end type
type st_1 from statictext within w_rpt_default_year
end type
type gb_1 from groupbox within w_rpt_default_year
end type
end forward

global type w_rpt_default_year from window
integer width = 2043
integer height = 728
boolean titlebar = true
string title = "Default Year Scope Setting"
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
uo_1 uo_1
cb_2 cb_2
cb_1 cb_1
sle_2 sle_2
sle_1 sle_1
st_2 st_2
st_1 st_1
gb_1 gb_1
end type
global w_rpt_default_year w_rpt_default_year

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

string  is_ReportName

end variables

on w_rpt_default_year.create
this.uo_1=create uo_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.uo_1,&
this.cb_2,&
this.cb_1,&
this.sle_2,&
this.sle_1,&
this.st_2,&
this.st_1,&
this.gb_1}
end on

on w_rpt_default_year.destroy
destroy(this.uo_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
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

is_ReportName = Message.StringParm

sle_1.Text = gs_user_no
sle_2.Text = is_ReportName

nvo_util  lnv_util
String    ls_Param
Date      ld_From,ld_To
Int       li_Pos

ls_Param = lnv_util.of_get_param( gs_user_no, is_ReportName+"year scope")
If ls_Param = '' Or IsNull(ls_Param) Then
	uo_1.of_set_fromyear(Year(Today()))
	uo_1.of_set_toyear(Year(Today()))
	Return
Else
	uo_1.of_set_yearscope(ls_Param )
End If



end event

type uo_1 from u_year_between within w_rpt_default_year
event destroy ( )
integer x = 110
integer y = 416
integer taborder = 20
end type

on uo_1.destroy
call u_year_between::destroy
end on

type cb_2 from commandbutton within w_rpt_default_year
integer x = 1518
integer y = 204
integer width = 448
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean cancel = true
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

type cb_1 from commandbutton within w_rpt_default_year
integer x = 1518
integer y = 36
integer width = 448
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Set as Default"
boolean default = true
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

nvo_util  lnv_util
String    ls_Param
Integer   li_From,li_To,li_Count

li_From = uo_1.of_get_fromyear()
li_To = uo_1.of_get_toyear()
If li_From > li_To Then
	MessageBox("Alert","Please set a valid year scope.")
	Return
End If

li_Count = li_To - li_From
If li_Count > 12 Then
	MessageBox("Alert","The secified Order Date scope is too long for this report. It must be less than 12 years.")
	Return
End If

ls_Param = String(li_From)+">>"+String(li_To)
lnv_util.of_set_param( gs_user_no, is_ReportName+"year scope",ls_Param)


CloseWithReturn(Parent,ls_Param)



end event

type sle_2 from singlelineedit within w_rpt_default_year
integer x = 475
integer y = 156
integer width = 933
integer height = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
boolean border = false
boolean displayonly = true
end type

type sle_1 from singlelineedit within w_rpt_default_year
integer x = 475
integer y = 20
integer width = 933
integer height = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
boolean border = false
boolean displayonly = true
end type

type st_2 from statictext within w_rpt_default_year
integer x = 55
integer y = 180
integer width = 485
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Current Report:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_rpt_default_year
integer x = 27
integer y = 44
integer width = 448
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Current User ID:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_rpt_default_year
integer x = 73
integer y = 320
integer width = 1339
integer height = 280
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Default Year Scope"
end type

