$PBExportHeader$u_date_between.sru
$PBExportComments$Select a date scope
forward
global type u_date_between from userobject
end type
type em_to from editmask within u_date_between
end type
type st_2 from statictext within u_date_between
end type
type em_from from editmask within u_date_between
end type
type st_1 from statictext within u_date_between
end type
end forward

global type u_date_between from userobject
integer width = 1445
integer height = 148
long backcolor = 32039904
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
em_to em_to
st_2 st_2
em_from em_from
st_1 st_1
end type
global u_date_between u_date_between

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

string  is_Format = 'mm/dd/yyyy'

end variables

forward prototypes
public function date of_get_fromdate ()
public function date of_get_todate ()
public function integer of_set_fromdate (date ad_datefrom)
public function integer of_set_todate (date ad_dateto)
public function integer of_set_format (string as_format)
public function integer of_get_date (ref date ad_from, ref date ad_to)
public function integer of_set_datescope (string as_defaultdate)
end prototypes

public function date of_get_fromdate ();//====================================================================
// Function: of_get_fromdate()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: date
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//return  date(em_from.text)
 
date ld_from
 
em_from.GetData(ld_from)
Return ld_from
end function

public function date of_get_todate ();//====================================================================
// Function: of_get_todate()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: date
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//return  date(em_to.text)

date ld_to
 
em_to.GetData(ld_to)
Return ld_to
end function

public function integer of_set_fromdate (date ad_datefrom);//====================================================================
// Function: of_set_fromdate()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		date	ad_datefrom		
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

em_from.text = string(ad_datefrom,is_Format)

return 1
end function

public function integer of_set_todate (date ad_dateto);//====================================================================
// Function: of_set_todate()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		date	ad_dateto		
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

em_to.text = string(ad_dateto,is_Format)

return 1
end function

public function integer of_set_format (string as_format);//====================================================================
// Function: of_set_format()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		string	as_format		
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

Choose Case Lower(as_format)
	Case 'mm/dd/yyyy','yyyy-mm-dd','mm/dd/yy','yy-mm-dd','mm.dd.yy','mm.dd.yyyy'
		If em_from.SetMask(datemask!,as_format) > 0 And em_to.SetMask(datemask!,as_format) > 0 Then
			is_Format = as_format
			Return 1
		End If
	Case Else
		MessageBox("Warning",'Unsupported date format '+as_format,exclamation!)
		Return -1
End Choose

Return -1

end function

public function integer of_get_date (ref date ad_from, ref date ad_to);//====================================================================
// Function: of_get_date()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		ref	date	ad_from		
//		ref	date	ad_to  		
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

em_from.getdata(ad_from)
em_to.getdata(ad_to)

return 1
end function

public function integer of_set_datescope (string as_defaultdate);//====================================================================
// Function: of_set_datescope()
//--------------------------------------------------------------------
// Description: set date scope from a string
//--------------------------------------------------------------------
// Arguments: 
//		string	as_defaultdate		
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

Date ld_From,ld_To
Int  li_Pos

If IsNull(as_defaultdate) Or as_defaultdate = '' Then Return -1

li_Pos = Pos(as_defaultdate,'>>')
ld_From = Date(Mid(as_defaultdate,1,li_Pos - 1))
ld_To = Date(Mid(as_defaultdate,li_Pos + 2))
//This.of_set_fromdate(ld_From)
//This.of_set_todate(ld_To)
em_from.text = Mid(as_defaultdate,1,li_Pos - 1)
em_to.text = Mid(as_defaultdate,li_Pos + 2)

Return 1

end function

on u_date_between.create
this.em_to=create em_to
this.st_2=create st_2
this.em_from=create em_from
this.st_1=create st_1
this.Control[]={this.em_to,&
this.st_2,&
this.em_from,&
this.st_1}
end on

on u_date_between.destroy
destroy(this.em_to)
destroy(this.st_2)
destroy(this.em_from)
destroy(this.st_1)
end on

type em_to from editmask within u_date_between
integer x = 882
integer y = 12
integer width = 466
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
boolean spin = true
end type

type st_2 from statictext within u_date_between
integer x = 805
integer y = 32
integer width = 73
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "to"
boolean focusrectangle = false
end type

type em_from from editmask within u_date_between
integer x = 315
integer y = 12
integer width = 466
integer height = 104
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
boolean spin = true
end type

type st_1 from statictext within u_date_between
integer x = 23
integer y = 32
integer width = 311
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32039904
string text = "Date from:"
boolean focusrectangle = false
end type

