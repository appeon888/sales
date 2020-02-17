$PBExportHeader$u_year_between.sru
$PBExportComments$Select a year scope
forward
global type u_year_between from userobject
end type
type em_to from editmask within u_year_between
end type
type st_2 from statictext within u_year_between
end type
type em_from from editmask within u_year_between
end type
type st_1 from statictext within u_year_between
end type
end forward

global type u_year_between from userobject
integer width = 960
integer height = 124
long backcolor = 32039904
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
em_to em_to
st_2 st_2
em_from em_from
st_1 st_1
end type
global u_year_between u_year_between

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
string  is_Format = '0000'

end variables

forward prototypes
public function integer of_get_fromyear ()
public function integer of_get_toyear ()
public function integer of_get_year (ref integer ai_from, ref integer ai_to)
public function integer of_set_fromyear (integer ai_yearfrom)
public function integer of_set_toyear (integer ai_yearto)
public function integer of_set_yearscope (string as_defaultyear)
end prototypes

public function integer of_get_fromyear ();//====================================================================
// Function: of_get_fromyear()
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

Return  Integer(em_from.Text)

end function

public function integer of_get_toyear ();//====================================================================
// Function: of_get_toyear()
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

Return  Integer(em_to.Text)

end function

public function integer of_get_year (ref integer ai_from, ref integer ai_to);//====================================================================
// Function: of_get_year()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		ref	integer	ai_from		
//		ref	integer	ai_to  		
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

ai_from = integer(em_from.text)
ai_to = integer(em_to.text)

return 1
end function

public function integer of_set_fromyear (integer ai_yearfrom);//====================================================================
// Function: of_set_fromyear()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		integer	ai_yearfrom		
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

em_from.text = string(ai_yearfrom)

return 1
end function

public function integer of_set_toyear (integer ai_yearto);//====================================================================
// Function: of_set_toyear()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		integer	ai_yearto		
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

em_to.text = string(ai_yearto)

return 1
end function

public function integer of_set_yearscope (string as_defaultyear);//====================================================================
// Function: of_set_yearscope()
//--------------------------------------------------------------------
// Description: set year scope from a string
//--------------------------------------------------------------------
// Arguments: 
//		string	as_defaultyear		
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

Integer li_From,li_To
Int  li_Pos

If IsNull(as_defaultyear) Or as_defaultyear = '' Then Return -1

li_Pos = Pos(as_defaultyear,'>>')
li_From = Integer(Mid(as_defaultyear,1,li_Pos - 1))
li_To = Integer(Mid(as_defaultyear,li_Pos + 2))
This.of_set_fromyear(li_From)
This.of_set_toyear(li_To)


Return 1

end function

on u_year_between.create
this.em_to=create em_to
this.st_2=create st_2
this.em_from=create em_from
this.st_1=create st_1
this.Control[]={this.em_to,&
this.st_2,&
this.em_from,&
this.st_1}
end on

on u_year_between.destroy
destroy(this.em_to)
destroy(this.st_2)
destroy(this.em_from)
destroy(this.st_1)
end on

type em_to from editmask within u_year_between
integer x = 690
integer y = 20
integer width = 251
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "0000"
end type

type st_2 from statictext within u_year_between
integer x = 613
integer y = 32
integer width = 78
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32039904
string text = "to"
boolean focusrectangle = false
end type

type em_from from editmask within u_year_between
integer x = 338
integer y = 20
integer width = 251
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "0000"
end type

type st_1 from statictext within u_year_between
integer x = 23
integer y = 32
integer width = 338
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32039904
string text = "Year from:"
boolean focusrectangle = false
end type

