$PBExportHeader$w_logon.srw
$PBExportComments$登陆窗口
forward
global type w_logon from window
end type
type p_exit from picture within w_logon
end type
type p_login from picture within w_logon
end type
type sle_name from singlelineedit within w_logon
end type
type sle_pass from singlelineedit within w_logon
end type
type p_bg from picture within w_logon
end type
end forward

global type w_logon from window
integer width = 3031
integer height = 1672
windowtype windowtype = popup!
long backcolor = 22955568
boolean center = true
p_exit p_exit
p_login p_login
sle_name sle_name
sle_pass sle_pass
p_bg p_bg
end type
global w_logon w_logon

on w_logon.create
this.p_exit=create p_exit
this.p_login=create p_login
this.sle_name=create sle_name
this.sle_pass=create sle_pass
this.p_bg=create p_bg
this.Control[]={this.p_exit,&
this.p_login,&
this.sle_name,&
this.sle_pass,&
this.p_bg}
end on

on w_logon.destroy
destroy(this.p_exit)
destroy(this.p_login)
destroy(this.sle_name)
destroy(this.sle_pass)
destroy(this.p_bg)
end on

type p_exit from picture within w_logon
integer x = 795
integer y = 1204
integer width = 727
integer height = 136
boolean originalsize = true
string picturename = ".\picture\exit_btn.jpg"
boolean focusrectangle = false
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

 halt close


end event

type p_login from picture within w_logon
integer x = 1541
integer y = 1204
integer width = 727
integer height = 136
integer taborder = 10
string picturename = ".\picture\login_btn.jpg"
boolean focusrectangle = false
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
// CopyRight 2003----2013 Appeon Inc.
//====================================================================

String  ls_User,ls_Pass,ls_DBPass,ls_Err
Long  ll_ID
String ls_Mess = 'Please enter a valid user ID/password.'

If Trim(sle_name.Text) = '' Then
	sle_name.SetFocus()
	MessageBox('Login Not Valid',ls_Mess,exclamation!)
	Return
End If
ls_User = Trim(sle_name.Text)
ls_Pass  = Trim(sle_Pass.Text)

SELECT fpassword
	INTO :ls_DBPass
	FROM t_user
	Where t_user.fuserno = :ls_User   ;
If sqlca.SQLCode < 0 Then
	ls_Err = sqlca.SQLErrText
	ROLLBACK;
	MessageBox('Login Not Valid','Database connection error.'+ls_Err,exclamation!)
	Return
ElseIf sqlca.SQLCode = 100 Then
	sle_name.SetFocus()
	MessageBox('Login Not Valid',ls_Mess,exclamation!)
	Return
End If
//messagebox('',gf_simple_encode(ls_DbPass,'0'))
If gf_simple_encode(ls_DBPass,'0') <> ls_Pass Then
	sle_Pass.SetFocus()
	MessageBox('Login Not Valid',ls_Mess,exclamation!)
	Return
End If

gs_User_No = ls_User
//CloseWithReturn(Parent,'1')
if isvalid(w_mdi) then
	w_mdi.show()
else
	open(w_mdi)
end if
Close(Parent)

end event

type sle_name from singlelineedit within w_logon
integer x = 1266
integer y = 728
integer width = 896
integer height = 112
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33093880
string text = "administrator"
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

this.selecttext(1,6565)
end event

type sle_pass from singlelineedit within w_logon
integer x = 1266
integer y = 976
integer width = 896
integer height = 112
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33093880
string text = "appeon"
boolean password = true
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

this.selecttext(1,6565)
end event

type p_bg from picture within w_logon
integer width = 3086
integer height = 1708
boolean originalsize = true
string picturename = ".\picture\login_bg1.jpg"
boolean focusrectangle = false
end type

