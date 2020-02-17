$PBExportHeader$w_about.srw
$PBExportComments$About box for examples
forward
global type w_about from window
end type
type st_4 from statictext within w_about
end type
type st_3 from statictext within w_about
end type
type st_1 from statictext within w_about
end type
type st_2 from statictext within w_about
end type
end forward

global type w_about from window
integer x = 731
integer y = 940
integer width = 1925
integer height = 820
boolean titlebar = true
string title = "About"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
toolbaralignment toolbaralignment = alignatleft!
boolean center = true
st_4 st_4
st_3 st_3
st_1 st_1
st_2 st_2
end type
global w_about w_about

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

Integer	ii_Cntr
end variables

on w_about.create
this.st_4=create st_4
this.st_3=create st_3
this.st_1=create st_1
this.st_2=create st_2
this.Control[]={this.st_4,&
this.st_3,&
this.st_1,&
this.st_2}
end on

on w_about.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.st_2)
end on

event clicked;
Close(this)
end event

event open;//addition by liulihua begin
Date	ld_Today

ld_Today	=	Today()

st_3.Text = "Copyright (c) 2000-"+String(ld_Today,"YYYY")+" Appeon Corporation."
//addition end
end event

type st_4 from statictext within w_about
integer x = 73
integer y = 476
integer width = 1659
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = " All Rights Reserved."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_about
integer x = 73
integer y = 392
integer width = 1659
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Copyright (c) 2000-2013 Appeon Corporation."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_about
integer x = 73
integer y = 80
integer width = 1659
integer height = 112
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "Sales Application Demo"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_about
integer x = 73
integer y = 220
integer width = 1659
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Last Updated: Oct 18, 2019"
alignment alignment = center!
boolean focusrectangle = false
end type

