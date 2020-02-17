$PBExportHeader$w_print_preview.srw
forward
global type w_print_preview from w_sheet
end type
type dw_preview from u_dw within w_print_preview
end type
end forward

global type w_print_preview from w_sheet
string tag = "Preview"
dw_preview dw_preview
end type
global w_print_preview w_print_preview

type variables
str_Print		istr_Print
end variables

on w_print_preview.create
int iCurrent
call super::create
this.dw_preview=create dw_preview
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_preview
end on

on w_print_preview.destroy
call super::destroy
destroy(this.dw_preview)
end on

event resize;call super::resize;dw_Preview.x = 8
dw_Preview.Y = 8
dw_Preview.Height	=	NewHeight - 16
dw_Preview.Width	=	NewWidth - 16
end event

event open;call super::open;istr_Print	=	Message.PowerObjectParm

dw_Preview.Dataobject = istr_Print.s_psr_name
dw_Preview.Object.DataWindow.Print.Preview="Yes"




end event

type dw_preview from u_dw within w_print_preview
integer x = 293
integer y = 160
integer width = 2779
integer height = 960
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
end type

