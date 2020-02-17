$PBExportHeader$w_printsetup.srw
forward
global type w_printsetup from window
end type
type st_1 from statictext within w_printsetup
end type
type cb_cancel from commandbutton within w_printsetup
end type
type cb_setup from commandbutton within w_printsetup
end type
type cb_ok from commandbutton within w_printsetup
end type
type lb_list from listbox within w_printsetup
end type
end forward

global type w_printsetup from window
integer width = 1966
integer height = 768
boolean titlebar = true
string title = "Printer Setup"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_cancel cb_cancel
cb_setup cb_setup
cb_ok cb_ok
lb_list lb_list
end type
global w_printsetup w_printsetup

type variables
DataStore ids_Printers
string    is_OldPrinter
integer   ii_Return = 0//Cancel
end variables

forward prototypes
public function string of_getprinter (integer ai_row, boolean ab_flag)
end prototypes

public function string of_getprinter (integer ai_row, boolean ab_flag);string ls_Printer

if ab_flag then
	ls_Printer = ids_Printers.GetItemString(ai_row,"PrinterName")
	ls_Printer += "~t" + ids_Printers.GetItemString(ai_row,"DriverName")
	ls_Printer += "~t" + ids_Printers.GetItemString(ai_row,"PrinterPort")
else
	ls_Printer = ids_Printers.GetItemString(ai_row,"PrinterName")
	ls_Printer += " on "
	ls_Printer += ids_Printers.GetItemString(ai_row,"PrinterPort")	
end if

Return ls_Printer
end function

on w_printsetup.create
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_setup=create cb_setup
this.cb_ok=create cb_ok
this.lb_list=create lb_list
this.Control[]={this.st_1,&
this.cb_cancel,&
this.cb_setup,&
this.cb_ok,&
this.lb_list}
end on

on w_printsetup.destroy
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_setup)
destroy(this.cb_ok)
destroy(this.lb_list)
end on

event open;string  ls_Printer
string  ls_PrinterList
string  ls_CurrentPrinter
integer i,li_Current
integer li_RowCount



ids_Printers = Create DataStore
ids_Printers.DataObject = "d_printerlist"
ls_PrinterList = PrintGetPrinters()
ids_Printers.ImportString(ls_PrinterList)

li_RowCount = ids_Printers.RowCount()
if li_RowCount<=0 then Return

ls_CurrentPrinter = PrintGetPrinter()
is_OldPrinter = ls_CurrentPrinter
for i = 1 to li_RowCount  
    ls_Printer = of_GetPrinter(i,false)
	 lb_list.AddItem(ls_Printer)
	 if of_GetPrinter(i,true)=ls_CurrentPrinter then li_Current = i
next
if li_Current=0 then li_Current = 1
lb_list.SelectItem(li_Current)
lb_list.SetFocus()

end event

event close;if IsValid(ids_Printers) then Destroy ids_Printers
CloseWithReturn(this,ii_Return)
end event

event closequery;integer li_Index
string  ls_NewPrinter

li_Index = lb_list.SelectedIndex()
if li_Index<=0 then Return

ls_NewPrinter = of_GetPrinter(li_Index,true)	
if ii_Return=1 then
	PrintSetPrinter(ls_NewPrinter)
else
	PrintSetPrinter(is_OldPrinter)
end if

end event

type st_1 from statictext within w_printsetup
integer x = 37
integer y = 24
integer width = 210
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32039904
string text = "Printer:"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_printsetup
integer x = 1449
integer y = 228
integer width = 448
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_setup from commandbutton within w_printsetup
integer x = 1449
integer y = 492
integer width = 448
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Setup..."
boolean cancel = true
end type

event clicked;integer li_Index
string  ls_Printer

li_Index = lb_list.SelectedIndex()
if li_Index<=0 then Return

ls_Printer = of_GetPrinter(li_Index,true)
PrintSetPrinter(ls_Printer)
PrintSetupPrinter()
end event

type cb_ok from commandbutton within w_printsetup
integer x = 1449
integer y = 88
integer width = 448
integer height = 120
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
boolean default = true
end type

event clicked;ii_Return = 1
Close(Parent)
end event

type lb_list from listbox within w_printsetup
integer x = 37
integer y = 100
integer width = 1358
integer height = 524
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

