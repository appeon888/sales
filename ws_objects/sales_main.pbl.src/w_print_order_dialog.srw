$PBExportHeader$w_print_order_dialog.srw
$PBExportComments$Print Order dialog
forward
global type w_print_order_dialog from window
end type
type cb_2 from commandbutton within w_print_order_dialog
end type
type cb_1 from commandbutton within w_print_order_dialog
end type
type st_current from statictext within w_print_order_dialog
end type
type sle_1 from singlelineedit within w_print_order_dialog
end type
type st_2 from statictext within w_print_order_dialog
end type
type st_1 from statictext within w_print_order_dialog
end type
type rb_3 from radiobutton within w_print_order_dialog
end type
type rb_2 from radiobutton within w_print_order_dialog
end type
type rb_1 from radiobutton within w_print_order_dialog
end type
type gb_1 from groupbox within w_print_order_dialog
end type
end forward

global type w_print_order_dialog from window
integer width = 1925
integer height = 704
boolean titlebar = true
string title = "Order Print Dialog"
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
st_current st_current
sle_1 sle_1
st_2 st_2
st_1 st_1
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
gb_1 gb_1
end type
global w_print_order_dialog w_print_order_dialog

on w_print_order_dialog.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_current=create st_current
this.sle_1=create sle_1
this.st_2=create st_2
this.st_1=create st_1
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_current,&
this.sle_1,&
this.st_2,&
this.st_1,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.gb_1}
end on

on w_print_order_dialog.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_current)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
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

String  ls_Param
nvo_util  lnv_util

ls_Param = Message.StringParm
If ls_Param = '-1' Then
	rb_1.Checked = True
	rb_2.Enabled = False
Else
	rb_2.Checked = True
	st_current.Text = "Order ID="+lnv_util.of_parse_orderno(ls_Param)
End If

end event

type cb_2 from commandbutton within w_print_order_dialog
integer x = 1399
integer y = 180
integer width = 448
integer height = 120
integer taborder = 30
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

type cb_1 from commandbutton within w_print_order_dialog
integer x = 1399
integer y = 36
integer width = 448
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

String  ls_Ret

If rb_1.Checked Then
	ls_Ret = 'all'
ElseIf rb_2.Checked Then
	ls_Ret = 'current'
Else
	ls_Ret = Trim(sle_1.Text)
	If ls_Ret = '' Then
		MessageBox('Alert','Please enter valid customer ID(s).')
		Return
	End If
	
	Int  li,li_Asc,li_AscOld
	
	For li = 1 To Len(ls_Ret)
		li_Asc = Asc(Mid(ls_Ret,li,1))
		If (li_Asc <> 44) And (li_Asc <> 45) And (li_Asc > 57 Or li_Asc < 48) Then
			MessageBox('Warning','Please enter valid order ID(s).',exclamation!)
			Return
		End If
		If (li_AscOld = 44 Or li_AscOld = 45) And(li_Asc = 44 Or li_Asc = 45) Then
			MessageBox('Warning','Please enter valid order ID(s).',exclamation!)
			Return
		End If
		li_AscOld = li_Asc
	Next
	
	//解析的ID范围，放入数组中
	Int   li_Pos1,li_Count
	String  ls_Temp,ls_Whole,ls_Custs[]
	nvo_util  lnv_util
	
	ls_Whole = ls_Ret+','
	
	Do While Len(ls_Whole) > 0
		li_Pos1 = Pos(ls_Whole,',')
		If li_Pos1 < 1 Then Exit
		ls_Temp = Left(ls_Whole,li_Pos1 - 1)
		li_Count ++
		ls_Custs[li_Count] = lnv_util.of_combine_orderno(ls_Temp)
		ls_Whole = Mid(ls_Whole,li_Pos1+1)
	Loop
	If UpperBound(ls_Custs) > 20 Then
		MessageBox('Alert','You can only print a maximum of 20 customers at one time.')
		Return
	End If
End If

CloseWithReturn(Parent,ls_Ret)


end event

type st_current from statictext within w_print_order_dialog
integer x = 503
integer y = 180
integer width = 727
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 32039904
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_print_order_dialog
integer x = 398
integer y = 296
integer width = 827
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 32039904
borderstyle borderstyle = stylelowered!
end type

event getfocus;//====================================================================
// Event: getfocus()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_ensetfocus]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

rb_3.checked = true
end event

type st_2 from statictext within w_print_order_dialog
integer x = 169
integer y = 464
integer width = 987
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "For example, 1-01-0-01, 1-02-1-02, etc."
boolean focusrectangle = false
end type

type st_1 from statictext within w_print_order_dialog
integer x = 169
integer y = 388
integer width = 1015
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "Enter order IDs separated by commas."
boolean focusrectangle = false
end type

type rb_3 from radiobutton within w_print_order_dialog
integer x = 91
integer y = 296
integer width = 283
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "Orders:"
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

sle_1.setfocus()
end event

type rb_2 from radiobutton within w_print_order_dialog
integer x = 91
integer y = 188
integer width = 494
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "Current order"
end type

type rb_1 from radiobutton within w_print_order_dialog
integer x = 91
integer y = 100
integer width = 457
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "All"
end type

type gb_1 from groupbox within w_print_order_dialog
integer x = 37
integer y = 16
integer width = 1321
integer height = 564
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "Opitions"
end type

