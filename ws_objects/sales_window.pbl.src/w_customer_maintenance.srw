$PBExportHeader$w_customer_maintenance.srw
forward
global type w_customer_maintenance from w_sheet
end type
type cb_7 from commandbutton within w_customer_maintenance
end type
type cb_1 from commandbutton within w_customer_maintenance
end type
type mle_filter from multilineedit within w_customer_maintenance
end type
type cb_2 from commandbutton within w_customer_maintenance
end type
type cb_4 from commandbutton within w_customer_maintenance
end type
type cb_9 from commandbutton within w_customer_maintenance
end type
type cb_5 from commandbutton within w_customer_maintenance
end type
type cb_6 from commandbutton within w_customer_maintenance
end type
type cb_update from commandbutton within w_customer_maintenance
end type
type dw_1 from u_dw within w_customer_maintenance
end type
end forward

global type w_customer_maintenance from w_sheet
integer width = 3447
integer height = 1668
string title = "Customer Maintenance"
long backcolor = 32039904
event ue_open ( )
event type integer ue_setfilter ( string as_custfilter,  string as_orderfilter,  string as_productfilter )
event type integer ue_save ( )
cb_7 cb_7
cb_1 cb_1
mle_filter mle_filter
cb_2 cb_2
cb_4 cb_4
cb_9 cb_9
cb_5 cb_5
cb_6 cb_6
cb_update cb_update
dw_1 dw_1
end type
global w_customer_maintenance w_customer_maintenance

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

string    is_last_col ,is_sort_type

boolean ib_Retrieved=FALSE,ib_changed = FALSE

end variables

event ue_open();//====================================================================
// Event: ue_open()
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

dw_1.event  ue_init()
dw_1.event  ue_retrieve()
end event

event type integer ue_setfilter(string as_custfilter, string as_orderfilter, string as_productfilter);//====================================================================
// Event: ue_setfilter()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	string	as_custfilter   		
//		value	string	as_orderfilter  		
//		value	string	as_productfilter		
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

//IF as_CustFilter <>'' THEN//comment by liulihua for filter all data
	dw_1.SetFilter(as_CustFilter)
	dw_1.filter()
	mle_filter.text = string(dw_1.rowcount())+" matches."
	dw_1.event rowfocuschanged(dw_1.getrow())
//END IF//comment by liulihua
return 1
end event

event type integer ue_save();//====================================================================
// Event: ue_save()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
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

string   ls_custno

if  dw_1.update() = 1 then
	commit;
	cb_update.enabled = FALSE
	ib_changed = FALSE
	return 1
ELSE
	rollback;
	messagebox('Warning','Failed to save the changes.',exclamation!)
	return -1
end if

end event

on w_customer_maintenance.create
int iCurrent
call super::create
this.cb_7=create cb_7
this.cb_1=create cb_1
this.mle_filter=create mle_filter
this.cb_2=create cb_2
this.cb_4=create cb_4
this.cb_9=create cb_9
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_update=create cb_update
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_7
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.mle_filter
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_4
this.Control[iCurrent+6]=this.cb_9
this.Control[iCurrent+7]=this.cb_5
this.Control[iCurrent+8]=this.cb_6
this.Control[iCurrent+9]=this.cb_update
this.Control[iCurrent+10]=this.dw_1
end on

on w_customer_maintenance.destroy
call super::destroy
destroy(this.cb_7)
destroy(this.cb_1)
destroy(this.mle_filter)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.cb_9)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_update)
destroy(this.dw_1)
end on

event open;call super::open;//====================================================================
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
this.x = 0
this.y = 0
this.event   ue_open()
end event

event closequery;//====================================================================
// Event: closequery()
//--------------------------------------------------------------------
// Description: If data in the DataWindow has been changed but not saved, prompt user to save it.
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_closequery]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Int	li_rc

If ib_changed Then
	li_rc = MessageBox ("Save Data", "Do you want to save changes to product before closing?", question!, yesnocancel!)
	
	// Yes
	If li_rc = 1 Then
		cb_update.TriggerEvent ("clicked")
		If ib_changed Then
			Return 1
		End If
	Else
		// Cancel
		If li_rc = 3 Then
			Return 1
		End If
	End If
End If

Return 0


end event

event resize;call super::resize;//this Resize code add by liulihua

dw_1.Height	=	newheight - (dw_1.y * 2) - cb_9.height - 10
dw_1.width	=	newwidth - (dw_1.x * 2)

cb_9.y	=	dw_1.y + dw_1.Height + 10
mle_filter.y	=	cb_9.y + 16
end event

type cb_7 from commandbutton within w_customer_maintenance
boolean visible = false
integer x = 3026
integer y = 1412
integer width = 343
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
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

Close(Parent)
end event

type cb_1 from commandbutton within w_customer_maintenance
boolean visible = false
integer x = 2295
integer y = 1412
integer width = 343
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Modify"
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
int  li_row
int  li_Ret
string  ls_custno

If ib_changed Then

	li_Ret = MessageBox("Save Data","Changes have not been saved.  Do you want to save changes before    ~r~n proceeding with the modify function?  Unsaved changes may be lost.",question!,yesnocancel!)
	If li_Ret = 1 Then
		If Parent.Event ue_save() < 1 Then Return
	ElseIf li_Ret = 3 Then
		Return
	End If
End If

li_row = dw_1.GetRow()
If  li_row <= 0 Then Return
ls_custno  =  dw_1.GetItemString(li_row,'fcustno')
OpenWithParm(w_customer_modify,ls_custno)

li_row = dw_1.Find("fcustno='" + ls_custno + "'", 1, dw_1.RowCount())
if li_row>0 then dw_1.ScrollToRow(li_row)

end event

type mle_filter from multilineedit within w_customer_maintenance
integer x = 965
integer y = 1432
integer width = 457
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711935
long backcolor = 32039904
boolean border = false
end type

type cb_2 from commandbutton within w_customer_maintenance
boolean visible = false
integer x = 37
integer y = 1412
integer width = 283
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sort"
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

dw_1.event ue_sort()
end event

type cb_4 from commandbutton within w_customer_maintenance
boolean visible = false
integer x = 658
integer y = 1412
integer width = 283
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Filter"
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

openwithparm(w_set_filter_customer,"w_customer_maintenance",parent)
end event

type cb_9 from commandbutton within w_customer_maintenance
boolean visible = false
integer x = 347
integer y = 1412
integer width = 283
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Show All"
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

dw_1.SetFilter("")
dw_1.Filter()
mle_filter.Text = ''
dw_1.Event RowFocusChanged(dw_1.GetRow())

end event

type cb_5 from commandbutton within w_customer_maintenance
boolean visible = false
integer x = 1563
integer y = 1412
integer width = 343
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add"
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

opensheet(w_customer_new,w_mdi,0,original!)
end event

type cb_6 from commandbutton within w_customer_maintenance
boolean visible = false
integer x = 1929
integer y = 1412
integer width = 343
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Remove"
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

dw_1.event   ue_delete()
end event

type cb_update from commandbutton within w_customer_maintenance
boolean visible = false
integer x = 2661
integer y = 1412
integer width = 343
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Save"
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

parent.event ue_save()
end event

type dw_1 from u_dw within w_customer_maintenance
event ue_retrieve ( )
event ue_init ( )
event ue_delete ( )
event ue_update ( )
event type string ue_getcustno ( )
integer x = 37
integer y = 48
integer width = 3337
integer height = 1312
integer taborder = 10
string dataobject = "d_customer_maintenance"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_retrieve();//====================================================================
// Event: ue_retrieve()
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

this.retrieve()
end event

event ue_init();//====================================================================
// Event: ue_init()
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

this.settransobject(sqlca)
end event

event ue_delete();//====================================================================
// Event: ue_delete()
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

Integer  li_count
String     ls_custno
nvo_util  lnv_util

ls_custno  = This.Event  ue_getcustno()
If ls_custno = '' Then Return
If  MessageBox("Alert","Are you sure you want to delete the customer " + lnv_util.of_parse_custno(ls_custno) + '?', question!,yesno!) = 2 Then
	Return
End If

//Cannot delete the customer XXX.  Some order he made is in the Processing status
SELECT  count(*) INTO :li_count  FROM  t_orders
	Where  fcustno = :ls_custno ;
If  li_count > 0 Then
	MessageBox("Warning","You cannot delete the customer " + lnv_util.of_parse_custno(ls_custno) + ". The customer has placed orders.",exclamation!)
	Return
End If

This.DeleteRow(0)
cb_update.Enabled = True
ib_changed = True

end event

event type string ue_getcustno();//====================================================================
// Event: ue_getcustno()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: string
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

integer   li_row

li_row  =  this.getrow()
IF li_Row < 1 THEN return ''
return   this.getitemstring(li_row,'fcustno')
end event

event doubleclicked;//====================================================================
// Event: doubleclicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	integer 	xpos		
//		value	integer 	ypos		
//		value	long    	row 		
//		value	dwobject	dwo 		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnlbuttondblclk]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

string    ls_custno

if  row <=0 then return
cb_1.event clicked()
end event

event clicked;//====================================================================
// Event: clicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	integer 	xpos		
//		value	integer 	ypos		
//		value	long    	row 		
//		value	dwobject	dwo 		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnlbuttonclk]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

String  	ls_ret
Integer	li_pos

//the following  code   implement  the sort  function by  clicking  column head
ls_ret = f_sort_by_head(This, dwo.Name,is_last_col,is_sort_type)
If ls_ret <> '' Then
	li_pos = Pos(ls_ret,'$')
	is_last_col = Left(ls_ret,li_pos - 1)
	is_sort_type = Mid(ls_ret,li_pos + 1)
End If

If  row <= 0 Then Return
This.SelectRow(0,False)
This.SelectRow(row,True)
This.SetRow(row)


end event

event editchanged;//====================================================================
// Event: editchanged()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	long    	row 		
//		value	dwobject	dwo 		
//		value	string  	data		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnchanging]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

cb_update.enabled = TRUE
ib_changed = TRUE
end event

event itemchanged;//====================================================================
// Event: itemchanged()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		value	long    	row 		
//		value	dwobject	dwo 		
//		value	string  	data		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnitemchange]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

cb_update.enabled = TRUE
ib_changed = TRUE
end event

event constructor;call super::constructor;//====================================================================
// Event: constructor()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_constructor]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

ib_SelectRow = TRUE
end event

