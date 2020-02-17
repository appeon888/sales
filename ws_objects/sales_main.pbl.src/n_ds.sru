$PBExportHeader$n_ds.sru
$PBExportComments$Datastore
forward
global type n_ds from datastore
end type
end forward

global type n_ds from datastore
end type
global n_ds n_ds

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

string  is_Processing
end variables

forward prototypes
public function integer of_set_dataobject (string as_dataobject)
public function string of_get_processing ()
end prototypes

public function integer of_set_dataobject (string as_dataobject);//====================================================================
// Function: of_set_dataobject()
//--------------------------------------------------------------------
// Description: Dynamic change dataobject for a datawindow
//--------------------------------------------------------------------
// Arguments: 
//		string	as_dataobject		
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

If as_DataObject  = '' Or IsNull(as_DataObject) Then Return -1

This.DataObject = as_DataObject
This.SetTransObject(SQLCA)

is_Processing = This.Describe("datawindow.processing")

Return 1

end function

public function string of_get_processing ();//====================================================================
// Function: of_get_processing()
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

If is_Processing = '' Or IsNull(is_Processing) Then
	is_Processing = This.Describe("datawindow.processing")
End If

Return is_Processing


end function

on n_ds.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_ds.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

