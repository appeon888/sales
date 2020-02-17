$PBExportHeader$w_set_find.srw
forward
global type w_set_find from w_sheet
end type
type st_1 from statictext within w_set_find
end type
type cb_ok from commandbutton within w_set_find
end type
type sle_1 from singlelineedit within w_set_find
end type
end forward

global type w_set_find from w_sheet
string tag = "Find"
integer width = 1577
integer height = 648
boolean titlebar = true
string title = "Find"
boolean controlmenu = true
windowtype windowtype = response!
windowstate windowstate = normal!
boolean center = true
st_1 st_1
cb_ok cb_ok
sle_1 sle_1
end type
global w_set_find w_set_find

type variables
PowerObject		ipbo_Message
str_Find			istr_Find
end variables

on w_set_find.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_ok=create cb_ok
this.sle_1=create sle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.sle_1
end on

on w_set_find.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.sle_1)
end on

event open;call super::open;

ipbo_Message = Message.PowerObjectParm

If	ipbo_Message.Typeof() = structure!	Then
	
	istr_Find	= ipbo_Message
	If	istr_Find.s_FindType = "1"	Then
		cb_OK.Text = "Find"
	End	If
	
	If	istr_Find.s_FindType = "2"	Then
		cb_OK.Text = "Find Next"
		sle_1.Text = istr_Find.s_findText
	End	If
	
End	If


end event

event closequery;call super::closequery;CloseWithReturn ( this, sle_1.Text )
end event

type st_1 from statictext within w_set_find
integer x = 110
integer y = 160
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "find value:"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_set_find
integer x = 951
integer y = 224
integer width = 366
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
boolean default = true
end type

event clicked;
If	Not IsValid(istr_Find)	Then	Return

Datawindow	ldw_Find
Long		ll_Find,ll_ColCount
String		ls_Find='1=2'
String		ls_ColType
Integer	li_For

ldw_Find	=	istr_Find.dw_FindDatawindow

ll_ColCount =Long( ldw_Find.Object.DataWindow.Column.Count)
For	li_For = 1	To	ll_ColCount
	ls_ColType	=	ldw_Find.Describe("#" + String(li_For) + ".Coltype")	
	If Left(lower(ls_ColType),4) <> "char" and Left( Lower(ls_ColType),7) <> "varchar" Then
		ls_Find += " or pos(string(#"+string(li_For)+"),'"+sle_1.Text+"') > 0 "	
	Else
		ls_Find += " or pos(#"+string(li_For)+",'"+sle_1.Text+"') > 0 "
	End	If
Next

If	istr_Find.s_FindType = "2"	Then
	ll_Find	=	ldw_Find.Find(ls_Find,ldw_Find.GetRow() + 1,ldw_Find.RowCount())
Else
	ll_Find	=	ldw_Find.Find(ls_Find,1,ldw_Find.RowCount())
End	If
If	ll_Find >	0	Then
	ldw_Find.ScrollToRow(ll_Find)
End	If

end event

type sle_1 from singlelineedit within w_set_find
integer x = 110
integer y = 224
integer width = 805
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

