$PBExportHeader$n_cst_conversion.sru
$PBExportComments$PFC Conversion service class
forward
global type n_cst_conversion from nonvisualobject
end type
end forward

global type n_cst_conversion from nonvisualobject autoinstantiate
end type

forward prototypes
public function boolean of_boolean (string as_val)
public function string of_string (boolean ab_parm)
public function string of_string (toolbaralignment ae_alignment)
public function integer of_integer (boolean ab_arg)
public function string of_string (boolean ab_parm, string as_type)
public function string of_string (sqlpreviewtype a_sqlpreviewtype)
public function string of_string (ostypes ae_ostype)
public function integer of_sqlpreviewtype (string as_source, ref sqlpreviewtype a_sqlpreviewtype)
public function integer of_windowstate (string as_windowstate, ref windowstate aws_windowstate)
public function string of_string (windowstate aws_windowstate)
public function string of_string (icon ae_icon)
public function string of_string (button ae_button)
public function integer of_icon (string as_source, ref icon ae_icon)
public function integer of_button (string as_source, ref button ae_button)
public function integer of_ostype (string as_source, ref ostypes ae_ostype)
public function date of_date (string as_datetime)
public function string of_string (dwitemstatus ae_dwitemstatus)
public function integer of_toolbaralignment (string as_align, ref toolbaralignment ae_toolbaralign)
public function integer of_dwitemstatus (string as_status, ref dwitemstatus ae_dwitemstatus)
public function time of_time (string as_datetime)
public function boolean of_boolean (integer ai_val)
end prototypes

public function boolean of_boolean (string as_val);//====================================================================
// Function: of_boolean()
//--------------------------------------------------------------------
// Description: Converts a string value to a boolean value.
//--------------------------------------------------------------------
// Arguments: 
//		s_val			The string to be converted to a boolean value.	
//--------------------------------------------------------------------
// Returns:boolean
// 					The boolean value of the string.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Boolean lb_null
SetNull(lb_null)

//Check parameters
If IsNull(as_val) Then
	Return lb_null
End If

//Convert to uppercase
as_val = Upper(as_val)

Choose Case as_val
	Case 'TRUE', 'T', 'YES', 'Y', '1'
		Return True
	Case 'FALSE', 'F', 'NO', 'N', '0'
		Return False
End Choose

//Invalid input parameter
Return lb_null



end function

public function string of_string (boolean ab_parm);//====================================================================
// Function: of_string()
//--------------------------------------------------------------------
// Description: Returns the passed boolean value as a string.
//--------------------------------------------------------------------
//	Arguments:
//	ab_parm			The boolean value to be converted to a string.
//--------------------------------------------------------------------
//	Returns:  		string	
//						The string value of the passed boolean argument.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(ab_parm) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

Return of_String(ab_parm, 'TRUEFALSE')


end function

public function string of_string (toolbaralignment ae_alignment);//====================================================================
// Function: of_string()
//--------------------------------------------------------------------
// Description: Converts the toolbaralignment enumerated datatype to a 
//						readable string representation.
//--------------------------------------------------------------------
//	Arguments:
//	ae_alignment	The toolbaralignment value to be converted to a string.	
//--------------------------------------------------------------------
//	Returns:  		string		
//						A string representation of the toolbaralignment value.
//						If ae_alignment is NULL, the function returns NULL.
//						If ae_alignment is Invalid, the function returns '!'.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(ae_alignment) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

Choose Case ae_alignment

	Case alignattop!
		Return "Top"
		
	Case alignatbottom!
		Return "Bottom"
		
	Case alignatright!
		Return "Right"
		
	Case alignatleft!
		Return "Left"
		
	Case floating!
		Return "Floating"
		
End Choose

//Invalid parameter value
Return "!"

end function

public function integer of_integer (boolean ab_arg);//====================================================================
// Function: of_integer()
//--------------------------------------------------------------------
// Description: Converts a boolean value to an integer value.
//--------------------------------------------------------------------
// Arguments: 
//	ab_arg			The boolean argument to be converted to an integer value.
//--------------------------------------------------------------------
// Returns: integer
//						The integer representation of the boolean value.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================


//Check parameters
If IsNull(ab_arg) Then
	Integer li_null
	SetNull(li_null)
	Return li_null
End If

If ab_arg Then
	//True
	Return 1
End If

//False
Return 0


end function

public function string of_string (boolean ab_parm, string as_type);//====================================================================
// Function: of_string()
//--------------------------------------------------------------------
// Description: Returns the passed boolean value as a string.
//--------------------------------------------------------------------
//	Arguments:
//	ab_parm			The boolean value to be converted to a string.
//	as_type			The string containing the desired return value
//						i.e., TrueFalse, TF, YesNo, YN, ZEROONE	
//--------------------------------------------------------------------
//	Returns:  		string	
//						The string value of the passed boolean argument.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns '!'.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

String ls_true, ls_false

//Check parameters
If IsNull(ab_parm) or IsNull(as_type) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

//Convert to uppercase
as_type = Upper(as_type)

//Check valid type and define true and false return values
Choose Case as_type
	Case 'TRUEFALSE'
		ls_true = 'TRUE'
		ls_false = 'FALSE'
	Case 'TF'
		ls_true = 'T'
		ls_false = 'F'
	Case 'YESNO'
		ls_true = 'YES'
		ls_false = 'NO'		
	Case 'YN'
		ls_true = 'Y'
		ls_false = 'N'
	Case 'ZEROONE'
		ls_true = '1'
		ls_false = '0'		
	Case Else
		Return '!'
End Choose
	
If ab_parm Then 
	Return ls_true
End If

Return ls_false

end function

public function string of_string (sqlpreviewtype a_sqlpreviewtype);//====================================================================
// Function: of_string()
//--------------------------------------------------------------------
// Description: Converts the sqlpreviewtype enumerated datatype to a 
//					 readable string representation.
//--------------------------------------------------------------------
//	Arguments:
//	a_sqlpreviewtype		The sqlpreviewtype that needs conversion.
//--------------------------------------------------------------------
//	Returns:  		string
//						A string representation of the sqlpreviewtype value.
//						If ae_alignment is NULL, the function returns NULL.
//						If ae_alignment is Invalid, the function returns '!'.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

If IsNull(a_sqlpreviewtype) Then
	String ls_null
	SetNull (ls_null)
	Return ls_null
End If

Choose Case a_sqlpreviewtype
	Case PreviewInsert!
		Return 'Insert'
		
	Case PreviewDelete!
		Return 'Delete'
		
	Case PreviewUpdate!
		Return 'Update'
		
	Case PreviewSelect!
		Return 'Retrieve'
		
End Choose

//Invalid parameter
Return '!'

end function

public function string of_string (ostypes ae_ostype);//====================================================================
// Function: of_string()
//--------------------------------------------------------------------
// Description: Converts the ostype enumerated datatype to a 
//					 readable string representation.
//--------------------------------------------------------------------
//	Arguments:
//	ae_ostype		The ostype that needs conversion.	
//--------------------------------------------------------------------
//	Returns:  		string
//						A string representation of the ostype value.
//						If ae_ostype is NULL, the function returns NULL.
//						If ae_ostype is Invalid, the function returns '!'.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

String ls_null

If IsNull(ae_ostype) Then
	SetNull (ls_null)
	Return ls_null
End If
	
Choose Case ae_ostype
	Case aix!
		Return 'aix'
	Case hpux!
		Return 'hpux'
	Case macintosh!
		Return 'macintosh'
	Case osf1!
		Return 'osf1'
	Case sol2!
		Return 'sol2'

	Case windows!
		Return 'windows'
	Case windowsnt!
		Return 'windowsnt'
End Choose

//Invalid parameter
Return '!'
end function

public function integer of_sqlpreviewtype (string as_source, ref sqlpreviewtype a_sqlpreviewtype);//====================================================================
// Function: of_sqlpreviewtype()
//--------------------------------------------------------------------
// Description: Converts a string value to a SQLPreviewType data type value.
//--------------------------------------------------------------------
// Arguments: 
//	as_source			The string value to be converted to SQLPreviewType
//							datatype value.
//	a_sqlpreviewtype	A SQLPreviewType variable passed by reference which will
//							hold the SQLPreviewType value that the string value was
//							converted to.
//--------------------------------------------------------------------
//	Returns: 		integer	 
//						1 if a successful conversion was made.
//						If as_source value is NULL, function returns NULL.
//						If as_source value is Invalid, function returns -1.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Then
	Integer li_null
	SetNull(li_null)
	Return li_null
End If

//Convert to lowercase
as_source = Lower (as_source)

If Pos (as_source, "insert") > 0 Then
	a_sqlpreviewtype = PreviewInsert!
	Return 1
ElseIf Pos (as_source, "delete") > 0 Then
	a_sqlpreviewtype = PreviewDelete!
	Return 1
ElseIf Pos (as_source, "update") > 0 Then
	a_sqlpreviewtype = PreviewUpdate!
	Return 1
ElseIf Pos (as_source, "retrieve") > 0 Or &
	Pos (as_source, "select") > 0 Then
	a_sqlpreviewtype = PreviewSelect!
	Return 1
End If

//Invalid parameter.
Return -1


end function

public function integer of_windowstate (string as_windowstate, ref windowstate aws_windowstate);//====================================================================
// Function: of_windowstate()
//--------------------------------------------------------------------
// Description: Converts a string value to a windowstate data type value.
//--------------------------------------------------------------------
//	Arguments:
//	as_windowstate		The string value to be converted to windowstate data type value.
//	aws_windowstate	A windowstate variable passed by reference which will hold the
//							windowstate value that the string value was converted to.	
//--------------------------------------------------------------------
//	Returns: 		integer	 
//						1 if a successful conversion was made.
//						If as_windowstate value is NULL, function returns NULL.
//						If as_windowstate value is Invalid, function returns -1.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Convert to lowercase
as_windowstate = Lower (as_windowstate)

//Check parameters
If IsNull(as_windowstate) Then
	Integer li_null
	SetNull(li_null)
	Return li_null
End If

If Pos (as_windowstate, "maximized") > 0 Then
	aws_windowstate = Maximized!
	Return 1
	
ElseIf Pos (as_windowstate, "minimized") > 0 Then
	aws_windowstate = Minimized!
	Return 1
	
ElseIf Pos (as_windowstate, "normal") > 0 Then
	aws_windowstate = Normal!
	Return 1
	
End If

//Invalid parameter.
Return -1


end function

public function string of_string (windowstate aws_windowstate);//====================================================================
// Function: of_string()
//--------------------------------------------------------------------
// Description: Converts the windowstate enumerated datatype to a 
//					 readable string representation.
//--------------------------------------------------------------------
//	Arguments:
//	aws_windowstate	The windowstate value to be converted to a string.		
//--------------------------------------------------------------------
//	Returns:  		string		
//						A string representation of the windowstate value.
//						If aws_windowstate is NULL, the function returns NULL.
//						If aws_windowstate is Invalid, the function returns '!'.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(aws_windowstate) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

Choose Case aws_windowstate

	Case Normal!
		Return "normal"
		
	Case Maximized!
		Return "maximized"
		
	Case Minimized!
		Return "minimized"
		
End Choose

//Invalid parameter value
Return "!"

end function

public function string of_string (icon ae_icon);//====================================================================
// Function: of_string()
//--------------------------------------------------------------------
// Description: Converts the icon enumerated datatype to a 
//						readable string representation.
//--------------------------------------------------------------------
//	Arguments:
//	ae_icon			The icon value to be converted to a string.		
//--------------------------------------------------------------------
//	Returns:  		string		
//						A string representation of the icon value.
//						If ae_icon is NULL, the function returns NULL.
//						If ae_icon is Invalid, the function returns '!'.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(ae_icon) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

Choose Case ae_icon

	Case None!
		Return "None"
		
	Case Question!
		Return "Question"
		
	Case Information!
		Return "Information"
		
	Case StopSign!
		Return "StopSign"
		
	Case exclamation!
		Return "Exclamation"
		
End Choose

//Invalid parameter value
Return "!"

end function

public function string of_string (button ae_button);//====================================================================
// Function: of_string()
//--------------------------------------------------------------------
// Description: Converts the button enumerated datatype to a 
//					 readable string representation.
//--------------------------------------------------------------------
//	Arguments:
//	ae_button	The button value to be converted to a string.		
//--------------------------------------------------------------------
//	Returns:  		string		
//						A string representation of the button value.
//						If ae_button is NULL, the function returns NULL.
//						If ae_button is Invalid, the function returns '!'.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(ae_button) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

Choose Case ae_button

	Case OK!
		Return "OK"

	Case OKCancel!
		Return "OKCancel"

	Case YesNo!
		Return "YesNo"

	Case YesNoCancel!
		Return "YesNoCancel"

	Case RetryCancel!
		Return "RetryCancel"

	Case AbortRetryIgnore!
		Return "AbortRetryIgnore"
	
End Choose

//Invalid parameter value
Return "!"
end function

public function integer of_icon (string as_source, ref icon ae_icon);//====================================================================
// Function: of_icon()
//--------------------------------------------------------------------
//	Description:  Converts a string value to a icon data type value.
//--------------------------------------------------------------------
// Arguments: 
// as_source			The string value to be converted to Icon datatype value.
//	a_sqlpreviewtype	A icon variable passed by reference which will
//							hold the icon value that the string value was
//							converted to.
//--------------------------------------------------------------------
// Returns: iinteger	 
//						1 if a successful conversion was made.
//						If as_source value is NULL, function returns -1
//						If as_source value is Invalid, function returns -1
//
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Then
	Return -1
End If

//Convert to lowercase
as_source = Lower (as_source)

Choose Case as_source
	Case "none", "none!"
		ae_icon = None!
		
	Case "question", "question!"
		ae_icon = Question!
		
	Case "information", "information!"
		ae_icon = Information!
		
	Case "stopsign", "stopsign!"
		ae_icon = StopSign!
		
	Case "exclamation", "exclamation!"
		ae_icon = Exclamation!
		
	Case Else
		Return -1
End Choose

Return 1


end function

public function integer of_button (string as_source, ref button ae_button);//====================================================================
// Function: of_button()
//--------------------------------------------------------------------
// Description: Converts a string value to a button data type value.
//--------------------------------------------------------------------
// Arguments: 
//	as_source			The string value to be converted to button	datatype value.
//	a_sqlpreviewtype	A button variable passed by reference which will
//							hold the button value that the string value was
//							converted to.		
//--------------------------------------------------------------------
// Returns: integer	 
//						1 if a successful conversion was made.
//						If as_source value is NULL, function returns -1
//						If as_source value is Invalid, function returns -1
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Then
	Return -1
End If

//Convert to lowercase
as_source = Lower (as_source)

Choose Case as_source
	Case "ok", "ok!"
		ae_button = OK!
		
	Case "okcancel", "okcancel!"
		ae_button = OKCancel!
		
	Case "yesno", "yesno!"
		ae_button = YesNo!
		
	Case "yesnocancel", "yesnocancel!"
		ae_button = YesNoCancel!
		
	Case "retrycancel", "retrycancel!"
		ae_button = RetryCancel!
		
	Case "abortretryignore", "abortretryignore!"
		ae_button = AbortRetryIgnore!
		
	Case Else
		Return -1
End Choose

Return 1



end function

public function integer of_ostype (string as_source, ref ostypes ae_ostype);//====================================================================
// Function: of_ostype()
//--------------------------------------------------------------------
// Description: Converts a string value to an ostype data type value.
//--------------------------------------------------------------------
// Arguments: 
//	as_source			The string value to be converted to an ostype
//							datatype value.
//	ae_ostype			An ostypes variable passed by reference which will
//							hold the ostype value that the string value was
//							converted to.		
//--------------------------------------------------------------------
// Returns:       integer	 
//						1 if a successful conversion was made.
//						If as_source value is NULL, function returns NULL.
//						If as_source value is Invalid, function returns -1.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Then
	Return -1
End If

//Convert to lowercase
as_source = Lower (as_source)

Choose Case as_source
	Case "aix", "aix!"
		ae_ostype = AIX!
		
	Case "hpux", "hpux!"
		ae_ostype = HPUX!
		
	Case "macintosh", "macintosh!"
		ae_ostype = MACINTOSH!
		
	Case "osf1", "osf1!"
		ae_ostype = OSF1!
		
	Case "sol2", "sol2!"
		ae_ostype = SOL2!
		
	Case "windows", "windows!"
		ae_ostype = WINDOWS!
		
	Case "windowsnt", "windowsnt!"
		ae_ostype = WINDOWSNT!
		
	Case Else
		Return -1
End Choose

Return 1

end function

public function date of_date (string as_datetime);//====================================================================
// Function: of_date()
//--------------------------------------------------------------------
// Description: Converts a string whose value is a valid datetime to a date
//--------------------------------------------------------------------
// Arguments: 
//	as_datetime   Datetime value as a string	
//--------------------------------------------------------------------
// Returns: 
//	If as_datetime does not contain a valid datetime value, return date
//	is 1900-01-01.  If as_datetime is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Date	   ld_rc = 1900-01-01
Long	   ll_count
String	ls_datetime[]
n_cst_string	lnv_string

// Check arguments
If IsNull (as_datetime) Then
	SetNull (ld_rc)
	Return ld_rc
End If

// Validate datetime string ("1/1/95", "1/1/95 8:00", "1/1/95 8:00 PM")
ll_count = lnv_string.of_ParseToArray (as_datetime, " ", ls_datetime)
If ll_count <= 0 Or ll_count > 3 Then
	Return ld_rc
End If

// Date string passed in
If ll_count = 1 Then
	Return Date (as_datetime)
End If

// Datetime string passed in
If ll_count = 2 Or ll_count = 3 Then
	Return Date (ls_datetime[1])
End If

Return ld_rc



end function

public function string of_string (dwitemstatus ae_dwitemstatus);//====================================================================
// Function: of_string()
//--------------------------------------------------------------------
// Description: Converts the dwitemstatus enumerated datatype to a 
//						readable string representation.
//--------------------------------------------------------------------
// //	Arguments:
//	ae_dwitemstatus	The dwitemstatus that needs conversion.		
//--------------------------------------------------------------------
//	Returns:  		string
//						A string representation of the dwitemstatus value.
//						If ae_dwitemstatus is NULL or Invalid, the function returns '!'.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

If IsNull(ae_dwitemstatus) Then
	Return '!'
End If

Choose Case ae_dwitemstatus
	Case NotModified!
		Return 'NotModified'
	Case DataModified!
		Return 'DataModified'
	Case New!
		Return 'New'
	Case NewModified!
		Return 'NewModified'
End Choose

//Invalid parameter
Return '!'

end function

public function integer of_toolbaralignment (string as_align, ref toolbaralignment ae_toolbaralign);//====================================================================
// Function: of_toolbaralignment()
//--------------------------------------------------------------------
// Description: Converts a string value to a toolbaralignment data type value.
//--------------------------------------------------------------------
//	Arguments:
//	as_align				The string value to be converted to toolbaralignment data type value
//	ae_toolbaralign	A toolbaralignment variable passed by reference which will hold the
//							toolbaralignment value that the string value was converted to	
//--------------------------------------------------------------------
//	Returns: 		integer	 
//						1 if a successful conversion was made.
//						If as_align value is NULL, function returns NULL.
//						If as_align value is Invalid, function returns -1.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Convert to lowercase
as_align = Lower (as_align)

//Check parameters
If IsNull(as_align) Then
	Integer li_null
	SetNull(li_null)
	Return li_null
End If

If Pos (as_align, "top") > 0 Then
	ae_toolbaralign = alignattop!
	Return 1
	
ElseIf Pos (as_align, "bottom") > 0 Then
	ae_toolbaralign = alignatbottom!
	Return 1
	
ElseIf Pos (as_align, "left") > 0 Then
	ae_toolbaralign = alignatleft!
	Return 1
	
ElseIf Pos (as_align, "right") > 0 Then
	ae_toolbaralign = alignatright!
	Return 1
	
ElseIf Pos (as_align, "floating") > 0 Then
	ae_toolbaralign = floating!
	Return 1
	
End If

//Invalid parameter.
Return -1

end function

public function integer of_dwitemstatus (string as_status, ref dwitemstatus ae_dwitemstatus);//====================================================================
// Function: of_dwitemstatus()
//--------------------------------------------------------------------
// Description: Converts a string value to a dwItemStatus data type value.
//--------------------------------------------------------------------
// Arguments: 
//	as_status			The string value to be converted to dwItemStatus data type value
//	ae_dwItemStatus	A dwItemStatus variable passed by reference which will hold the
//							dwItemStatus value that the string value was converted to	
//--------------------------------------------------------------------
// Returns: integer	 
//						1 if a successful conversion was made.
//						If as_status value is Invalid, function returns -1.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Convert to lowercase
as_status = Lower (as_status)

//Check parameters
If IsNull(as_status) Then
	Return -1
End If

Choose Case as_status
	Case "notmodified", "notmodified!"
		ae_dwItemStatus = NotModified!
		Return 1
	Case "datamodified", "datamodified!"
		ae_dwItemStatus = DataModified!
		Return 1
	Case "new", "new!"
		ae_dwItemStatus = New!
		Return 1
	Case "newmodified", "newmodified!"
		ae_dwItemStatus = NewModified!
		Return 1
End Choose

//Invalid parameter.
Return -1

end function

public function time of_time (string as_datetime);//====================================================================
// Function: of_time()
//--------------------------------------------------------------------
// Description: Converts a string whose value is a valid datetime to a time value
//--------------------------------------------------------------------
//	Arguments:
//	as_datetime   Datetime value as a string	
//--------------------------------------------------------------------
//	Returns:  time
//	If as_datetime does not contain a valid datetime value, return time
//	is 00:00:00.000000.  If as_datetime is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Time	   ltm_rc = 00:00:00.000000
Long	   ll_count
String	ls_datetime[]
n_cst_string	lnv_string

// Check arguments
If IsNull (as_datetime) Then
	SetNull (ltm_rc)
	Return ltm_rc
End If

// Validate datetime string
ll_count = lnv_string.of_ParseToArray (as_datetime, " ", ls_datetime)
If ll_count <= 0 Or ll_count > 3 Then
	Return ltm_rc
End If

// Date string passed in ("8:00pm")
If ll_count = 1 Then
	Return Time (as_datetime)
End If

// Datetime string passed in ("1/1/95 8:00pm")
If ll_count = 2 Then
	Return Time (ls_datetime[2])
End If

// Datetime string passed in ("1/1/95 8:00 pm")
If ll_count = 3 Then
	Return Time (ls_datetime[2]+' '+ls_datetime[3])
End If

Return ltm_rc

end function

public function boolean of_boolean (integer ai_val);//====================================================================
// Function: of_boolean()
//--------------------------------------------------------------------
// Description: Converts a integer value to a boolean.
//--------------------------------------------------------------------
// Arguments: 
//		ai_val			The integer to be converted to a boolean		
//--------------------------------------------------------------------
// Returns: boolean
//						The boolean representation of the integer value.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(ai_val) Or (ai_val > 1) Or (ai_val < 0) Then
	Boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

If ai_val = 1 Then
	Return True
End If

Return False


end function

on n_cst_conversion.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_conversion.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

