$PBExportHeader$nvo_security.sru
$PBExportComments$Security Manager
forward
global type nvo_security from nonvisualobject
end type
end forward

global type nvo_security from nonvisualobject autoinstantiate
end type

forward prototypes
public function integer of_setmenuright_internal (menu am, datastore ads)
public subroutine of_setmenuright (menu am)
end prototypes

public function integer of_setmenuright_internal (menu am, datastore ads);//====================================================================
// Function: of_setmenuright_internal()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		menu     	am 		
//		datastore	ads		
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

Long  ll
String  ls_Tag

For ll = 1 To UpperBound(am.Item[])
	ls_Tag =  trim(am.Item[ll].Tag)
	If ls_Tag <> '' Then
		If ads.Find("fmenuname='"+ls_Tag+"'",1,ads.RowCount()) > 0 Then
			am.Item[ll].Enabled = True
		Else
			am.Item[ll].Enabled = False
		End If
	End If
	If UpperBound(am.Item[ll].Item[]) > 0 Then
		of_setmenuright_internal(am.Item[ll],ads)
	End If
Next
Return 1

end function

public subroutine of_setmenuright (menu am);//====================================================================
// Function: of_setmenuright()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		menu	am		
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

If Lower(gs_user_No) = 'administrator' Then
	Return
End If
If Not IsValid(am) Then Return

//Set Menu Right
Long  ll
datastore   lds

//IF lower(gs_User_no) = 'system' THEN return
lds = Create datastore
lds.DataObject = 'dw_user_rights_grid'
lds.SetTransObject(SQLCA)
lds.Retrieve(gs_user_No)

For ll = 1 To UpperBound(am.Item[])
	If UpperBound(am.Item[ll].Item[]) > 0 Then
		of_setmenuright_internal(am.Item[ll],lds)
	End If
Next
Destroy lds

end subroutine

on nvo_security.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_security.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

