$PBExportHeader$uo_test.sru
forward
global type uo_test from userobject
end type
type cb_1 from commandbutton within uo_test
end type
end forward

global type uo_test from userobject
integer width = 1623
integer height = 1276
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_1 cb_1
end type
global uo_test uo_test

on uo_test.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on uo_test.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within uo_test
integer x = 503
integer y = 476
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

