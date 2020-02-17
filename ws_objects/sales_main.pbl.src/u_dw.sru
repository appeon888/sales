$PBExportHeader$u_dw.sru
$PBExportComments$DataWindow
forward
global type u_dw from datawindow
end type
end forward

global type u_dw from datawindow
integer width = 686
integer height = 400
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_sort ( )
end type
global u_dw u_dw

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

string   is_Processing
boolean  ib_SelectRow=FALSE//Only for grid and tabular datawindow
end variables

forward prototypes
public function string of_get_processing ()
public function integer of_set_dataobject (string as_dataobject)
public function integer of_set_rowselect (boolean ab_switch)
public function integer of_get_selectedrow ()
end prototypes

event ue_sort();//====================================================================
// Event: ue_sort()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		None		
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

openwithparm(w_sort_single,this)

end event

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

IF is_Processing ='' OR isnull(is_Processing) THEN
	is_Processing = this.describe("datawindow.processing")
END IF

return is_Processing

end function

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

IF as_DataObject  = '' or isnull(as_DataObject) THEN return -1
this.dataobject = as_dataObject
this.settransobject(SQLCA)
is_Processing = this.describe("datawindow.processing")
ib_SelectRow = is_Processing = '1'


return 1
end function

public function integer of_set_rowselect (boolean ab_switch);//====================================================================
// Function: of_set_rowselect()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		boolean	ab_switch		
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

ib_SelectRow = ab_switch

return 1
end function

public function integer of_get_selectedrow ();//====================================================================
// Function: of_get_selectedrow()
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

int  li_Row

FOR li_Row = 1 To this.rowcount()
	IF this.isselected(li_Row) THEN return li_Row
NEXT

return -1
end function

on u_dw.create
end on

on u_dw.destroy
end on

event constructor;//====================================================================
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

IF this.dataobject <>'' THEN
	is_Processing = this.describe("datawindow.processing")
	IF is_Processing = '1' THEN
		ib_SelectRow = TRUE
	END IF
END IF
end event

event retrieveend;//====================================================================
// Event: retrieveend()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		long	rowcount		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnretrieveend]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

IF rowcount = 1 THEN
	IF ib_SelectRow THEN
		this.selectrow(1,TRUE)
	END IF
END IF
end event

event rowfocuschanged;//====================================================================
// Event: rowfocuschanged()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		long	currentrow		
//--------------------------------------------------------------------
// Returns: long [pbm_dwnrowchange]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

IF currentrow > 0 THEN
	IF ib_SelectRow THEN
		this.selectrow(0,FALSE)
		this.selectrow(currentrow,TRUE)
	END IF
END IF
end event

