$PBExportHeader$w_change_password.srw
forward
global type w_change_password from window
end type
type cb_2 from commandbutton within w_change_password
end type
type cb_1 from commandbutton within w_change_password
end type
type sle_confirm from singlelineedit within w_change_password
end type
type sle_new from singlelineedit within w_change_password
end type
type sle_old from singlelineedit within w_change_password
end type
type st_3 from statictext within w_change_password
end type
type st_2 from statictext within w_change_password
end type
type st_1 from statictext within w_change_password
end type
end forward

global type w_change_password from window
integer width = 2071
integer height = 672
boolean titlebar = true
string title = "Change Password"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
boolean center = true
cb_2 cb_2
cb_1 cb_1
sle_confirm sle_confirm
sle_new sle_new
sle_old sle_old
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_change_password w_change_password

on w_change_password.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_confirm=create sle_confirm
this.sle_new=create sle_new
this.sle_old=create sle_old
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.sle_confirm,&
this.sle_new,&
this.sle_old,&
this.st_3,&
this.st_2,&
this.st_1}
end on

on w_change_password.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_confirm)
destroy(this.sle_new)
destroy(this.sle_old)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

type cb_2 from commandbutton within w_change_password
integer x = 1554
integer y = 56
integer width = 466
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
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

string   ls_Old,ls_New,ls_Confirm,ls_DbPass,ls_Err

ls_Old = trim(sle_old.text)
ls_New = trim(sle_new.text)
ls_Confirm = trim(sle_confirm.text)

  SELECT fpassword
    INTO :ls_DBPass  
    FROM t_user  
   WHERE fuserno = :gs_User_No   ;
IF sqlca.sqlcode <> 0 THEN
	ls_Err = sqlca.sqlerrtext
	rollback;
	messagebox(parent.title,"Database connection error."+ls_Err)
	return
END IF
IF gf_simple_encode(ls_DbPass,'0') <> ls_Old THEN
	sle_Old.setfocus()
	messagebox("Password Incorrect",'The old password you entered is incorrect.',exclamation!)
	return
END IF

IF ls_New <> ls_confirm THEN
	sle_Confirm.setfocus()
	messagebox("Password Incorrect",'The new passwords you entered do not match.  Please enter the password again.',exclamation!)
	return
END IF
IF len(ls_New) > 10 THEN
	messagebox("Password Incorrect",'The password must be less than 10 characters.',exclamation!)
	sle_new.setfocus()
	return
END IF

ls_New = gf_simple_encode(ls_New,'1')

update t_user
set fpassword=:ls_New
WHERE fuserno = :gs_User_No ;
IF sqlca.sqlcode = 0 THEN
	commit;
	messagebox("Password Changed",'Your password has been changed. ')
ELSE
	ls_Err = sqlca.sqlerrtext
	rollback;
	messagebox(parent.title,"Failed to save new password to database.",exclamation!)
	return
END IF
closewithreturn(parent,'1')
end event

type cb_1 from commandbutton within w_change_password
integer x = 1554
integer y = 204
integer width = 466
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

closewithreturn(parent,'-1')
end event

type sle_confirm from singlelineedit within w_change_password
integer x = 603
integer y = 368
integer width = 910
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type sle_new from singlelineedit within w_change_password
integer x = 603
integer y = 216
integer width = 910
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type sle_old from singlelineedit within w_change_password
integer x = 603
integer y = 68
integer width = 910
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_change_password
integer x = 18
integer y = 380
integer width = 567
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Confirm Password:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_change_password
integer x = 46
integer y = 228
integer width = 539
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "New Password:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_change_password
integer x = 91
integer y = 80
integer width = 494
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Old Password:"
alignment alignment = right!
boolean focusrectangle = false
end type

