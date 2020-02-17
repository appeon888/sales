$PBExportHeader$w_rpt_options.srw
$PBExportComments$Report Op[tions
forward
global type w_rpt_options from window
end type
type cb_4 from commandbutton within w_rpt_options
end type
type cb_3 from commandbutton within w_rpt_options
end type
type rb_size3 from radiobutton within w_rpt_options
end type
type rb_size2 from radiobutton within w_rpt_options
end type
type rb_size1 from radiobutton within w_rpt_options
end type
type cb_2 from commandbutton within w_rpt_options
end type
type st_2 from statictext within w_rpt_options
end type
type cb_1 from commandbutton within w_rpt_options
end type
type st_1 from statictext within w_rpt_options
end type
type gb_1 from groupbox within w_rpt_options
end type
type gb_2 from groupbox within w_rpt_options
end type
type gb_3 from groupbox within w_rpt_options
end type
end forward

global type w_rpt_options from window
integer width = 1879
integer height = 924
boolean titlebar = true
string title = "Grid Report Options"
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
cb_4 cb_4
cb_3 cb_3
rb_size3 rb_size3
rb_size2 rb_size2
rb_size1 rb_size1
cb_2 cb_2
st_2 st_2
cb_1 cb_1
st_1 st_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_rpt_options w_rpt_options

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

str_rpt_options    istr_rpt_options

end variables

on w_rpt_options.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.rb_size3=create rb_size3
this.rb_size2=create rb_size2
this.rb_size1=create rb_size1
this.cb_2=create cb_2
this.st_2=create st_2
this.cb_1=create cb_1
this.st_1=create st_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.cb_4,&
this.cb_3,&
this.rb_size3,&
this.rb_size2,&
this.rb_size1,&
this.cb_2,&
this.st_2,&
this.cb_1,&
this.st_1,&
this.gb_1,&
this.gb_2,&
this.gb_3}
end on

on w_rpt_options.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.rb_size3)
destroy(this.rb_size2)
destroy(this.rb_size1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
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

nvo_util   lnv_util
String     ls_Param,ls_Value,ls_Type
datastore  lds_Set
Int        li

//IF current datawindow is read-only,then
/*ls_Type = message.stringparm
IF ls_Type <>'grid data' THEN
	cb_1.enabled = FALSE
	cb_2.enabled = FALSE
	rb_size1.enabled = FALSE
	rb_size2.enabled = FALSE
	rb_size3.enabled = FALSE
END IF
*/

//Get settings from database and set as default
lds_Set = Create datastore
lds_Set.DataObject =  'd_user_settings'
lds_Set.SetTransObject(SQLCA)
lds_Set.Retrieve(gs_User_No,"Report Options")
For li = 1  To lds_Set.RowCount()
	ls_Param = lds_Set.Object.fparam_name[li]
	ls_Value = lds_Set.Object.fparam_value[li]
	Choose Case Lower(ls_Param)
		Case "report options"+"fontsize"
			If (Not IsNull(ls_Value)) And ls_Value <> '' And IsNumber(ls_Value) Then
				If ls_Value = '20' Then
					rb_size1.Checked = True
				ElseIf ls_Value = '15' Then
					rb_size2.Checked = True
				Else
					rb_size3.Checked = True
				End If
				istr_rpt_options.ffontsize  = Integer(ls_Value)
			End If
		Case 'report options'+'textcolor'
			If (Not IsNull(ls_Value)) And ls_Value <> '' And IsNumber(ls_Value) Then
				st_1.BackColor = Long(ls_Value)
				istr_rpt_options.ftextcolor  = Long(ls_Value)
			End If
		Case  'report options'+'backcolor'
			If (Not IsNull(ls_Value)) And ls_Value <> '' And IsNumber(ls_Value) Then
				st_2.BackColor = Long(ls_Value)
				istr_rpt_options.fbackcolor  = Long(ls_Value)
			End If
	End Choose
Next

Destroy  lds_Set

end event

type cb_4 from commandbutton within w_rpt_options
integer x = 1376
integer y = 212
integer width = 450
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

string   ls_Null

setnull(ls_Null)
closewithreturn(parent,ls_Null)
end event

type cb_3 from commandbutton within w_rpt_options
integer x = 1371
integer y = 56
integer width = 450
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
str_rpt_options    lstr_parm
Int  li_Cnt,li_Count
nvo_util  lnv_util

If rb_size1.Checked Then
	lstr_parm.ffontsize = 20
ElseIf rb_size2.Checked Then
	lstr_parm.ffontsize = 15
Else
	lstr_parm.ffontsize = 10
End If
lstr_parm.fbackcolor = st_2.BackColor
lstr_parm.ftextcolor = st_1.BackColor

//Save setting to database
If istr_rpt_options.ffontsize <> lstr_parm.ffontsize Then
	lnv_util.of_set_param( gs_user_no, "Report Options"+"fontsize", String(lstr_parm.ffontsize))
End If
If istr_rpt_options.ftextcolor <> lstr_parm.ftextcolor Then
	lnv_util.of_set_param( gs_user_no, "Report Options"+"textcolor", String(lstr_parm.ftextcolor))
End If
If istr_rpt_options.fbackcolor <> lstr_parm.fbackcolor Then
	lnv_util.of_set_param( gs_user_no, "Report Options"+"backcolor", String(lstr_parm.fbackcolor))
End If

CloseWithReturn(Parent,lstr_parm)

end event

type rb_size3 from radiobutton within w_rpt_options
integer x = 887
integer y = 636
integer width = 343
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "Small"
end type

type rb_size2 from radiobutton within w_rpt_options
integer x = 503
integer y = 636
integer width = 343
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "Medium"
end type

type rb_size1 from radiobutton within w_rpt_options
integer x = 114
integer y = 636
integer width = 343
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "Large"
end type

type cb_2 from commandbutton within w_rpt_options
integer x = 663
integer y = 372
integer width = 498
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Choose Color"
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

OPEN(w_choose_color)

String  ls_Ret

ls_Ret = Message.StringParm
If ls_Ret = 'cancel' Or IsNull(ls_Ret) Then Return
st_2.BackColor = Long(ls_Ret)

end event

type st_2 from statictext within w_rpt_options
integer x = 114
integer y = 372
integer width = 475
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 16711680
boolean border = true
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_rpt_options
integer x = 663
integer y = 116
integer width = 498
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Choose Color"
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

open(w_choose_color)

string  ls_Ret

ls_Ret = message.stringparm
IF ls_Ret = 'cancel' OR isnull(ls_Ret) THEN return
st_1.backcolor = long(ls_Ret)

end event

type st_1 from statictext within w_rpt_options
integer x = 114
integer y = 120
integer width = 475
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 255
boolean border = true
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_rpt_options
integer x = 50
integer y = 20
integer width = 1216
integer height = 240
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Text Color"
end type

type gb_2 from groupbox within w_rpt_options
integer x = 50
integer y = 276
integer width = 1216
integer height = 240
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Background Color"
end type

type gb_3 from groupbox within w_rpt_options
integer x = 50
integer y = 532
integer width = 1216
integer height = 240
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Font Size"
end type

