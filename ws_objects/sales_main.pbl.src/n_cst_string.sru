$PBExportHeader$n_cst_string.sru
$PBExportComments$PFC String service
forward
global type n_cst_string from nonvisualobject
end type
end forward

global type n_cst_string from nonvisualobject autoinstantiate
end type

type variables
end variables

forward prototypes
public function long of_parsetoarray (string as_source, string as_delimiter, ref string as_array[])
public function string of_gettoken (ref string as_source, string as_separator)
public function string of_padleft (string as_source, long al_length)
public function string of_padright (string as_source, long al_length)
public function boolean of_islower (string as_source)
public function boolean of_isupper (string as_source)
public function boolean of_iswhitespace (string as_source)
public function boolean of_isalpha (string as_source)
public function boolean of_isalphanum (string as_source)
public function string of_quote (string as_source)
public function boolean of_isspace (string as_source)
public function boolean of_ispunctuation (string as_source)
public function long of_lastpos (string as_source, string as_target, long al_start)
public function long of_lastpos (string as_source, string as_target)
public function string of_globalreplace (string as_source, string as_old, string as_new, boolean ab_ignorecase)
public function string of_globalreplace (string as_source, string as_old, string as_new)
public function long of_countoccurrences (string as_source, string as_target, boolean ab_ignorecase)
public function string of_righttrim (string as_source)
public function string of_lefttrim (string as_source)
public function string of_lefttrim (string as_source, boolean ab_remove_spaces)
public function string of_lefttrim (string as_source, boolean ab_remove_spaces, boolean ab_remove_nonprint)
public function string of_righttrim (string as_source, boolean ab_remove_spaces)
public function string of_righttrim (string as_source, boolean ab_remove_spaces, boolean ab_remove_nonprint)
public function string of_trim (string as_source)
public function string of_trim (string as_source, boolean ab_remove_spaces)
public function string of_trim (string as_source, boolean ab_remove_spaces, boolean ab_remove_nonprint)
public function string of_getkeyvalue (string as_source, string as_keyword, string as_separator)
public function integer of_setkeyvalue (ref string as_source, string as_keyword, string as_keyvalue, string as_separator)
public function string of_removenonprint (string as_source)
public function boolean of_isempty (string as_source)
public function boolean of_isprintable (string as_source)
public function boolean of_isformat (string as_source)
public function string of_removewhitespace (string as_source)
public function boolean of_iscomparisonoperator (string as_source)
public function boolean of_isarithmeticoperator (string as_source)
public function long of_countoccurrences (string as_source, string as_target)
public function long of_arraytostring (string as_source[], string as_delimiter, ref string as_ref_string)
public function long of_arraytostring (string as_source[], string as_delimiter, boolean ab_processempty, ref string as_ref_string)
public function string of_wordcap (string as_source)
end prototypes

public function long of_parsetoarray (string as_source, string as_delimiter, ref string as_array[]);//====================================================================
// Function: of_parsetoarray()
//--------------------------------------------------------------------
//	Description:  Parse a string into array elements using a delimeter string.
//--------------------------------------------------------------------
//	Arguments:
//	as_Source   The string to parse.
//	as_Delimiter   The delimeter string.
//	as_Array[]   The array to be filled with the parsed strings, passed by reference.
//--------------------------------------------------------------------
//	Returns:  long
//	The number of elements in the array.
//	If as_Source or as_Delimeter is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long		ll_DelLen, ll_Pos, ll_Count, ll_Start, ll_Length
String 	ls_holder

//Check for NULL
If IsNull(as_source) Or IsNull(as_delimiter) Then
	Long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Check for at leat one entry
If Trim (as_source) = '' Then
	Return 0
End If

//Get the length of the delimeter
ll_DelLen = Len(as_delimiter)

ll_Pos =  Pos(Upper(as_source), Upper(as_delimiter))

//Only one entry was found
If ll_Pos = 0 Then
	as_Array[1] = as_source
	Return 1
End If

//More than one entry was found - loop to get all of them
ll_Count = 0
ll_Start = 1
Do While ll_Pos > 0
	
	//Set current entry
	ll_Length = ll_Pos - ll_Start
	ls_holder = Mid (as_source, ll_Start, ll_Length)
	
	// Update array and counter
	ll_Count ++
	as_Array[ll_Count] = ls_holder
	
	//Set the new starting position
	ll_Start = ll_Pos + ll_DelLen
	
	ll_Pos =  Pos(Upper(as_source), Upper(as_delimiter), ll_Start)
Loop

//Set last entry
ls_holder = Mid (as_source, ll_Start, Len (as_source))

// Update array and counter if necessary
If Len (ls_holder) > 0 Then
	ll_Count++
	as_Array[ll_Count] = ls_holder
End If

//Return the number of entries found
Return ll_Count


end function

public function string of_gettoken (ref string as_source, string as_separator);//====================================================================
// Function: of_gettoken()
//--------------------------------------------------------------------
// Description: This function strips a source string (from the left) up 
//					 to the occurrence of a specified separator character.
//--------------------------------------------------------------------
//	Arguments:			as_source		The source string passed by reference
//							as_separator	Separator character in the source string which will be 
//												used to determine the length of characters to strip from
//												the left end of the source string.	
//--------------------------------------------------------------------
//	Returns:  			string
//							The token stripped off of the source string.
//							If the separator character does not appear in the string, 
//							the entire source string is returned.
//							Otherwise, it returns the token stripped off of the left
//							end of the source string (not including the separator character)
//							If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long 		ll_pos
String 	ls_ret

//Check parameters
If IsNull(as_source) Or IsNull(as_separator) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

/////////////////////////////////////////////////////////////////////////////////
// Get the position of the separator
/////////////////////////////////////////////////////////////////////////////////
ll_pos = Pos(as_source, as_separator)

/////////////////////////////////////////////////////////////////////////////////
// Compute the length of the token to be stripped off of the source string.
/////////////////////////////////////////////////////////////////////////////////

// If no separator, the token to be stripped is the entire source string
If ll_pos = 0 Then
	ls_ret = as_source
	as_source = ""
Else
	// Otherwise, return just the token and strip it & the separator from the source string
	ls_ret = Mid(as_source, 1, ll_pos - 1)
	as_source = Right(as_source, Len(as_source) - (ll_pos+Len(as_separator)-1) )
End If

Return ls_ret

end function

public function string of_padleft (string as_source, long al_length);//====================================================================
// Function: of_padleft()
//--------------------------------------------------------------------
//	Description:  	Pad the original string with spaces on its left to make it of
//					   the desired length.
//--------------------------------------------------------------------
//	Arguments:
//	as_Source		The string being searched.
//	al_length		The desired length of the string.	
//--------------------------------------------------------------------
//	Returns:  		String
//						A string of length al_length wich contains as_source with
//						spaces added to its left.
//						If any argument's value is NULL, function returns NULL.
//						If al_length is less or equal to length of as_source, the 
//						function returns the original as_source.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

String	ls_return

//Check for Null Parameters.
If IsNull(as_source) Or IsNull(al_length) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

//Check for the lengths
If al_length <= Len(as_source) Then
	//Return the original string
	Return as_source
End If

//Create the left padded string
ls_return = Space(al_length - Len(as_source)) + as_source

//Return the left padded string
Return ls_return


end function

public function string of_padright (string as_source, long al_length);//====================================================================
// Function: of_padright()
//--------------------------------------------------------------------
//	Description:  	Pad the original string with spaces on its right to make it of
//					   the desired length.
//--------------------------------------------------------------------
//	Arguments:
//	as_Source		The string being searched.
//	al_length		The desired length of the string.		
//--------------------------------------------------------------------
//	Returns:  		String
//						A string of length al_length wich contains as_source with
//						spaces added to its right.
//						If any argument's value is NULL, function returns NULL.
//						If al_length is less or equal to length of as_source, the 
//						function returns the original as_source.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

String	ls_return

//Check for Null Parameters.
If IsNull(as_source) Or IsNull(al_length) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

//Check for the lengths
If al_length <= Len(as_source) Then
	//Return the original string
	Return as_source
End If

//Create the right padded string
ls_return = as_source + Space(al_length - Len(as_source))

//Return the right padded string
Return ls_return

end function

public function boolean of_islower (string as_source);//====================================================================
// Function: of_islower()
//--------------------------------------------------------------------
// Description: Determines whether a string contains only lowercase 
//					 characters.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The source string.		
//--------------------------------------------------------------------
//	Returns:  		Boolean
//						True if the string only contains lowercase characters. 
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Then
	Boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

If as_source = Lower(as_source) Then
	Return True
Else
	Return False
End If

end function

public function boolean of_isupper (string as_source);//====================================================================
// Function: of_isupper()
//--------------------------------------------------------------------
//	Description:  	Determines whether a string contains only uppercase 
//						characters.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The source string.	
//--------------------------------------------------------------------
//	Returns:  		Boolean
//						True if the string only contains uppercase characters. 
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Then
	Boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

If as_source = Upper(as_source) Then
	Return True
Else
	Return False
End If

end function

public function boolean of_iswhitespace (string as_source);//====================================================================
// Function: of_iswhitespace()
//--------------------------------------------------------------------
//	Description:  	Determines whether a string contains only White Space
//						characters. White Space characters include Newline, Tab,
//						Vertical tab, Carriage return, Formfeed, and Backspace.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The source string.		
//--------------------------------------------------------------------
//	Returns:  		Boolean
//						True if the string only contains White Space characters. 
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long 		ll_count = 0
Long 		ll_length
Char		lc_char[]
Integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	Boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length = 0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source


//Perform loop around all characters
//Quit loop if Non WhiteSpace character is found
Do While ll_count < ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	If li_ascii = 8	Or			/* BackSpae */		 		&
		li_ascii = 9 	Or			/* Tab */		 			&
		li_ascii = 10 Or			/* NewLine */				&
		li_ascii = 11 Or			/* Vertical Tab */		&
		li_ascii = 12 Or			/* Form Feed */			&
		li_ascii = 13 Or			/* Carriage Return */	&
		li_ascii = 32 Then		/* Space */
		//Character is a WhiteSpace.
		//Continue with the next character.
	Else
		/* Character is Not a White Space. */
		Return False
	End If
Loop

// Entire string is White Space.
Return True


end function

public function boolean of_isalpha (string as_source);//====================================================================
// Function: of_isalpha()
//--------------------------------------------------------------------
// Description: Determines whether a string contains only alphabetic
//						characters.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The source string.		
//--------------------------------------------------------------------
//	Returns:  		Boolean
//						True if the string only contains alphabetic characters. 
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long		ll_count = 0
Long		ll_length
Char		lc_char[]
Integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	Boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length = 0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters
//Quit loop if Non Alpha character is found
Do While ll_count < ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	// 'A'=65, 'Z'=90, 'a'=97, 'z'=122
	If li_ascii < 65 Or (li_ascii > 90 And li_ascii < 97) Or li_ascii > 122 Then
		/* Character is Not an Alpha */
		Return False
	End If
Loop

// Entire string is alpha.
Return True

end function

public function boolean of_isalphanum (string as_source);//====================================================================
// Function: of_isalphanum()
//--------------------------------------------------------------------
// Description: Determines whether a string contains only alphabetic and
//					 numeric characters.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The source string.		
//--------------------------------------------------------------------
//	Returns:  		Boolean
//						True if the string only contains alphabetic and Numeric
//						characters. 
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long     ll_count = 0
Long     ll_length
Char     lc_char[]
Integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	Boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length = 0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters.
//Quit loop if Non Alphanemeric character is found.
Do While ll_count < ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	// '0'= 48, '9'=57, 'A'=65, 'Z'=90, 'a'=97, 'z'=122
	If li_ascii < 48 Or (li_ascii > 57 And li_ascii < 65) Or &
		(li_ascii > 90 And li_ascii < 97) Or li_ascii > 122 Then
		/* Character is Not an AlphaNumeric */
		Return False
	End If
Loop

// Entire string is AlphaNumeric.
Return True



end function

public function string of_quote (string as_source);//====================================================================
// Function: of_quote()
//--------------------------------------------------------------------
//	Description:  	Enclose the original string in quotations.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The source string.		
//--------------------------------------------------------------------
//	Returns:  		String
//						The original string enclosed in quotations.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Then
	Return as_source
End If

// Enclosed original string in quotations.
Return '"' + as_source + '"'


end function

public function boolean of_isspace (string as_source);//====================================================================
// Function: of_isspace()
//--------------------------------------------------------------------
// Description: Determines whether a string contains only space characters.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The source string.		
//--------------------------------------------------------------------
//	Returns:  		Boolean
//						True if the string only contains space characters. 
//						False if the string is empty or if it contains other
//						non-space characters.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Then
	Boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Check for an empty string
If Len(as_source) = 0 Then
	Return False
End If

If Trim(as_source) = '' Then
	// Entire string is made of spaces.
	Return True
End If

//String is not made up entirely of spaces.
Return False



end function

public function boolean of_ispunctuation (string as_source);//====================================================================
// Function: of_ispunctuation()
//--------------------------------------------------------------------
// Description: Determines whether a string contains only punctuation
//					 characters.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The source string.		
//--------------------------------------------------------------------
//	Returns:  		Boolean
//						True if the string only contains punctuation characters.
//						If as_source is NULL, the function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long		ll_count = 0
Long		ll_length
Char		lc_char[]
Integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	Boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length = 0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters
//Quit loop if Non Punctuation character is found
Do While ll_count < ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	If li_ascii = 33 Or			/* '!' */		 &
		li_ascii = 34 Or			/* '"' */		 &
		li_ascii = 39 Or			/* ''' */		 &
		li_ascii = 44 Or			/* ',' */		 &
		li_ascii = 46 Or			/* '.' */		 &
		li_ascii = 58 Or			/* ':' */		 &
		li_ascii = 59 Or			/* ';' */		 &
		li_ascii = 63 Then 		/* '?' */
		//Character is a punctuation.
		//Continue with the next character.
	Else
		Return False
	End If
Loop

// Entire string is punctuation.
Return True


end function

public function long of_lastpos (string as_source, string as_target, long al_start);//====================================================================
// Function: of_lastpos()
//--------------------------------------------------------------------
//	Description: 	Search backwards through a string to find the last occurrence 
//						of another string.
//--------------------------------------------------------------------
//	Arguments:
//	as_Source		The string being searched.
//	as_Target		The being searched for.
//	al_start			The starting position, 0 means start at the end.	
//--------------------------------------------------------------------
//	Returns:  		Long	
//						The position of as_Target.
//						If as_Target is not found, function returns a 0.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long	ll_Cnt, ll_Pos

//Check for Null Parameters.
If IsNull(as_source) Or IsNull(as_target) Or IsNull(al_start) Then
	SetNull(ll_Cnt)
	Return ll_Cnt
End If

//Check for an empty string
If Len(as_source) = 0 Then
	Return 0
End If

// Check for the starting position, 0 means start at the end.
If al_start = 0 Then
	al_start = Len(as_source)
End If

//Perform find
For ll_Cnt = al_start To 1 Step -1
	ll_Pos = Pos(as_source, as_target, ll_Cnt)
	If ll_Pos = ll_Cnt Then
		//String was found
		Return ll_Cnt
	End If
Next

//String was not found
Return 0


end function

public function long of_lastpos (string as_source, string as_target);//====================================================================
// Function: of_lastpos()
//--------------------------------------------------------------------
//	Description:  Search backwards through a string to find the last occurrence of another string
//--------------------------------------------------------------------
//	Arguments:
//	as_Source		The string being searched.
//	as_Target		The string being searched for.	
//--------------------------------------------------------------------
//	Returns:  		Long	
//						The position of as_Target.
//						If as_Target is not found, function returns a 0.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check for Null Parameters.
If IsNull(as_source) Or IsNull(as_target) Then
	Long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Set the starting position and perform the search
Return of_LastPos (as_source, as_target, Len(as_source))


end function

public function string of_globalreplace (string as_source, string as_old, string as_new, boolean ab_ignorecase);//====================================================================
// Function: of_globalreplace()
//--------------------------------------------------------------------
// Description: Replace all occurrences of one string inside another with
//						a new string.
//--------------------------------------------------------------------
//	Arguments:
//	as_Source		The string being searched.
//	as_Old			The old string being replaced.
//	as_New			The new string.
// ab_IgnoreCase	A boolean stating to ignore case sensitivity.	
//--------------------------------------------------------------------
//	Returns:  		string
//						as_Source with all occurrences of as_Old replaced with as_New.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long	 ll_Start
Long	 ll_OldLen
Long	 ll_NewLen
String ls_Source

//Check parameters
If IsNull(as_source) Or IsNull(as_old) Or IsNull(as_new) Or IsNull(ab_ignorecase) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

//Get the string lenghts
ll_OldLen = Len(as_old)
ll_NewLen = Len(as_new)

//Should function respect case.
If ab_ignorecase Then
	as_old = Lower(as_old)
	ls_Source = Lower(as_source)
Else
	ls_Source = as_source
End If

//Search for the first occurrence of as_Old
ll_Start = Pos(ls_Source, as_old)

Do While ll_Start > 0
	// replace as_Old with as_New
	as_source = Replace(as_source, ll_Start, ll_OldLen, as_new)
	
	//Should function respect case.
	If ab_ignorecase Then
		ls_Source = Lower(as_source)
	Else
		ls_Source = as_source
	End If
	
	// find the next occurrence of as_Old
	ll_Start = Pos(ls_Source, as_old, (ll_Start + ll_NewLen))
Loop

Return as_source


end function

public function string of_globalreplace (string as_source, string as_old, string as_new);//====================================================================
// Function: of_globalreplace()
//--------------------------------------------------------------------
// Description: Replace all occurrences of one string inside another with
//						a new string.
//--------------------------------------------------------------------
//	Arguments:
//	as_Source		The string being searched.
//	as_Old			The old string being replaced.
//	as_New			The new string. 		
//--------------------------------------------------------------------
//Returns:  		string
//						as_Source with all occurrences of as_Old replaced with as_New.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Or IsNull(as_old) Or IsNull(as_new) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

//The default is to ignore Case
as_source = of_GlobalReplace (as_source, as_old, as_new, True)

Return as_source



end function

public function long of_countoccurrences (string as_source, string as_target, boolean ab_ignorecase);//====================================================================
// Function: of_countoccurrences()
//--------------------------------------------------------------------
// Description: Count the occurrences of one string within another.
//--------------------------------------------------------------------
//	Arguments:
//	as_Source		The string in which to search.
//	as_Target		The string to search for.
//	ab_IgnoreCase	A boolean stating to ignore case sensitivity.		
//--------------------------------------------------------------------
//	Returns: 		long
//						The number of occurrences of as_Target in as_source.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long	ll_Count, ll_Pos, ll_Len

//Check for parameters
If IsNull(as_source) Or IsNull(as_target) Or IsNull(ab_ignorecase) Then
	Long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Should function ignore case?
If ab_ignorecase Then
	as_source = Lower(as_source)
	as_target = Lower(as_target)
End If

ll_Len = Len(as_target)
ll_Count = 0

ll_Pos = Pos(as_source, as_target)

Do While ll_Pos > 0
	ll_Count ++
	ll_Pos = Pos(as_source, as_target, (ll_Pos + ll_Len))
Loop

Return ll_Count


end function

public function string of_righttrim (string as_source);//====================================================================
// Function: of_righttrim()
//--------------------------------------------------------------------
//	Description: 	Removes desired characters from the right end of a string.
//						The options depending on the parameters are:
//							Remove spaces from the end of a string.
//							Remove nonprintable characters from the end of a string.
//							Remove spaces and nonprintable characters from the end 
//							of a string. 
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The string to be trimmed.		
//--------------------------------------------------------------------
//	Returns:  		string
//						as_source with all desired characters removed from the right end 
//						of the string.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

// Remove spaces=True, NonPrintCharacters=False
Return of_RightTrim (as_source, True, False)

end function

public function string of_lefttrim (string as_source);//====================================================================
// Function: of_lefttrim()
//--------------------------------------------------------------------
//	Description: 	Removes desired characters from the left end of a string.
//						The options depending on the parameters are:
//							Remove spaces from the beginning of a string.
//							Remove nonprintable characters from the beginning of a string.
//							Remove spaces and nonprintable characters from the 
//							beginning of a string.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The string to be trimmed.		
//--------------------------------------------------------------------
//	Returns:  		string
//						as_source with all desired characters removed from the left end 
//						of the string.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

// Remove spaces=True, NonPrintCharacters=False
Return of_LeftTrim (as_source, True, False)

end function

public function string of_lefttrim (string as_source, boolean ab_remove_spaces);//====================================================================
// Function: of_lefttrim()
//--------------------------------------------------------------------
//	Description: 	Removes desired characters from the left end of a string.
//						The options depending on the parameters are:
//							Remove spaces from the beginning of a string.
//							Remove nonprintable characters from the beginning of a string.
//							Remove spaces and nonprintable characters from the 
//							beginning of a string.
//--------------------------------------------------------------------
//	Arguments:
//	as_source			The string to be trimmed.
//	ab_remove_spaces	A boolean stating if spaces should be removed.
//--------------------------------------------------------------------
//	Returns:  		string
//						as_source with all desired characters removed from the left end 
//						of the string.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Or IsNull(ab_remove_spaces) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If


// Remove spaces=ab_remove_spaces, NonPrintCharacters=False
Return of_LeftTrim (as_source, ab_remove_spaces, False)

end function

public function string of_lefttrim (string as_source, boolean ab_remove_spaces, boolean ab_remove_nonprint);//====================================================================
// Function: of_lefttrim()
//--------------------------------------------------------------------
//	Description: 	Removes desired characters from the left end of a string.
//						The options depending on the parameters are:
//							Remove spaces from the beginning of a string.
//							Remove nonprintable characters from the beginning of a string.
//							Remove spaces and nonprintable characters from the beginning of a string.
//--------------------------------------------------------------------
//	Arguments:
//	as_source				The string to be trimmed.
//	ab_remove_spaces		A boolean stating if spaces should be removed.
//	ab_remove_nonprint	A boolean stating if nonprint characters should be removed.	
//--------------------------------------------------------------------
//	Returns:  		string
//						as_source with all desired characters removed from the left end of the string.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Char		lc_char
Boolean	lb_char
Boolean	lb_printable_char

//Check parameters
If IsNull(as_source) Or IsNull(ab_remove_spaces) Or IsNull(ab_remove_nonprint) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

If ab_remove_spaces And ab_remove_nonprint Then
	// Remove spaces and nonprintable characters from the beginning of a string.
	Do While Len (as_source) > 0 And Not lb_char
		lc_char = as_source
		If of_IsPrintable(lc_char) And Not of_IsSpace(lc_char) Then
			lb_char = True
		Else
			as_source = Mid (as_source, 2)
		End If
	Loop
	Return as_source
ElseIf ab_remove_nonprint Then
	// Remove nonprintable characters from the beginning of a string.
	Do While Len (as_source) > 0 And Not lb_printable_char
		lc_char = as_source
		If of_IsPrintable(lc_char) Then
			lb_printable_char = True
		Else
			as_source = Mid (as_source, 2)
		End If
	Loop
	Return as_source
ElseIf ab_remove_spaces Then
	//Remove spaces from the beginning of a string.
	Return LeftTrim(as_source)
End If

Return as_source



end function

public function string of_righttrim (string as_source, boolean ab_remove_spaces);//====================================================================
// Function: of_righttrim()
//--------------------------------------------------------------------
//	Description: 	Removes desired characters from the right end of a string.
//						The options depending on the parameters are:
//							Remove spaces from the end of a string.
//							Remove nonprintable characters from the end of a string.
//							Remove spaces and nonprintable characters from the end 
//							of a string.
//--------------------------------------------------------------------
//	Arguments:
//	as_source			The string to be trimmed.
//	ab_remove_spaces	A boolean stating if spaces should be removed.	
//--------------------------------------------------------------------
//	Returns:  		string
//						as_source with all desired characters removed from the right end 
//						of the string.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Or IsNull(ab_remove_spaces) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

// Remove spaces=ab_remove_spaces, NonPrintCharacters=False
Return of_RightTrim (as_source, ab_remove_spaces, False)

end function

public function string of_righttrim (string as_source, boolean ab_remove_spaces, boolean ab_remove_nonprint);//====================================================================
// Function: of_righttrim()
//--------------------------------------------------------------------
//	Description: 	Removes desired characters from the right end of a string.
//						The options depending on the parameters are:
//							Remove spaces from the end of a string.
//							Remove nonprintable characters from the end of a string.
//							Remove spaces and nonprintable characters from the end of
//							a string.
//--------------------------------------------------------------------
//	Arguments:
//	as_source				The string to be trimmed.
//	ab_remove_spaces		A boolean stating if spaces should be removed.
//	ab_remove_nonprint	A boolean stating if nonprint characters should be removed.		
//--------------------------------------------------------------------
//	Returns:  		string
//						as_source with all desired characters removed from the right
//						end of the string.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================



Boolean	lb_char
Char		lc_char
Boolean	lb_printable_char

//Check parameters
If IsNull(as_source) Or IsNull(ab_remove_spaces) Or IsNull(ab_remove_nonprint) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

If ab_remove_spaces And ab_remove_nonprint Then
	// Remove spaces and nonprintable characters from the end of a string.
	Do While Len (as_source) > 0 And Not lb_char
		lc_char = Right (as_source, 1)
		If of_IsPrintable(lc_char) And Not of_IsSpace(lc_char) Then
			lb_char = True
		Else
			as_source = Left (as_source, Len (as_source) - 1)
		End If
	Loop
	Return as_source
	
ElseIf ab_remove_nonprint Then
	// Remove nonprintable characters from the end of a string.
	Do While Len (as_source) > 0 And Not lb_printable_char
		lc_char = Right (as_source, 1)
		If of_IsPrintable(lc_char) Then
			lb_printable_char = True
		Else
			as_source = Left (as_source, Len (as_source) - 1)
		End If
	Loop
	Return as_source
	
ElseIf ab_remove_spaces Then
	//Remove spaces from the end of a string.
	Return RightTrim(as_source)
End If

Return as_source

end function

public function string of_trim (string as_source);//====================================================================
// Function: of_trim()
//--------------------------------------------------------------------
//	Description: 	Removes desired characters from the left and right end of 
//						a string.
//						The options depending on the parameters are:
//							Remove spaces from the beginning and end of a string.
//							Remove nonprintable characters from the beginning and 
//							end of a string.
//							Remove spaces and nonprintable characters from the 
//							beginning and end of a string.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The string to be trimmed.
//--------------------------------------------------------------------
//	Returns:  		string
//						as_source with all desired characters removed from the left end 
//						of the string.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

// Remove Spaces=True, NonPrintCharacters=False
Return of_Trim (as_source, True, False)


end function

public function string of_trim (string as_source, boolean ab_remove_spaces);//====================================================================
// Function: of_trim()
//--------------------------------------------------------------------
//	Description: 	Removes desired characters from the left and right end of 
//						a string.
//						The options depending on the parameters are:
//							Remove spaces from the beginning and end of a string.
//							Remove nonprintable characters from the beginning and 
//							end of a string.
//							Remove spaces and nonprintable characters from the 
//							beginning and end of a string.
//--------------------------------------------------------------------
//	Arguments:
//	as_source			The string to be trimmed.
//	ab_remove_spaces	A boolean stating if spaces should be removed.	
//--------------------------------------------------------------------
//	Returns:  		string
//						as_source with all desired characters removed from the left end 
//						of the string.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Or IsNull(ab_remove_spaces) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

// Remove Spaces=ab_remove_spaces, NonPrintCharacters=False
Return of_Trim (as_source, ab_remove_spaces, False)


end function

public function string of_trim (string as_source, boolean ab_remove_spaces, boolean ab_remove_nonprint);//====================================================================
// Function: of_trim()
//--------------------------------------------------------------------
//	Description: 	Removes desired characters from the left and right end of 
//						a string.
//						The options depending on the parameters are:
//							Remove spaces from the beginning and end of a string.
//							Remove nonprintable characters from the beginning and 
//							end of a string.
//							Remove spaces and nonprintable characters from the 
//							beginning and end of a string.
//--------------------------------------------------------------------
//	Arguments:
//	as_source				The string to be trimmed.
//	ab_remove_spaces		A boolean stating if spaces should be removed.
//	ab_remove_nonprint	A boolean stating if nonprint characters should be removed.		
//--------------------------------------------------------------------
//	Returns:  		string
//						as_source with all desired characters removed from the left and 
//						right end of the string.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

//Check parameters
If IsNull(as_source) Or IsNull(ab_remove_spaces) Or IsNull(ab_remove_nonprint) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

If ab_remove_spaces And ab_remove_nonprint Then
	// Remove spaces and nonprintable characters from the beginning and end 
	// of a string.
	as_source = of_LeftTrim (as_source, ab_remove_spaces, ab_remove_nonprint)
	as_source = of_RightTrim(as_source, ab_remove_spaces, ab_remove_nonprint)
	
ElseIf ab_remove_nonprint Then
	// Remove nonprintable characters from the beginning and end
	// of a string.
	as_source = of_LeftTrim (as_source, ab_remove_spaces, ab_remove_nonprint)
	as_source = of_RightTrim(as_source, ab_remove_spaces, ab_remove_nonprint)
	
ElseIf ab_remove_spaces Then
	//Remove spaces from the beginning and end of a string.
	as_source = Trim(as_source)
	
End If

Return as_source

end function

public function string of_getkeyvalue (string as_source, string as_keyword, string as_separator);//====================================================================
// Function: of_getkeyvalue()
//--------------------------------------------------------------------
// Description: Gets the value portion of a keyword=value pair from a string.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The string to be searched.
//	as_keyword		The keyword to be searched for.
//	as_separator	The separator character used in the source string.		
//--------------------------------------------------------------------
//	Returns:  		string	
//						The value found for the keyword.
//						If no matching keyword is found, an empty string is returned.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Boolean	lb_done = False
Integer	li_keyword, li_separator, li_equal
String	ls_keyvalue, ls_source, ls_exact

//Check parameters
If IsNull(as_source) Or IsNull(as_keyword) Or IsNull(as_separator) Then
	String ls_null
	SetNull (ls_null)
	Return ls_null
End If

//Initialize key value
ls_keyvalue = ''

Do While Not lb_done
	li_keyword = Pos (Lower(as_source), Lower(as_keyword))
	If li_keyword > 0 Then
		ls_source = as_source
		as_source = LeftTrim(Right(as_source, Len(as_source) - (li_keyword + Len(as_keyword) - 1)))
		// see if this is an exact match.  Either the match will be at the start of the string or
		// the match will be after a separator character.  So check for both cases
		li_equal = li_keyword - Len(as_separator)
		If li_equal > 0 Then
			// not the start so see if this is a compound occurance separated by the separator string
			ls_exact = Mid(ls_source, li_equal, Len(as_separator))
			If ls_exact <> as_separator Then
				// not the separator string so continue looking
				Continue
			End If
		End If
		
		If Left(as_source, 1) = "=" Then
			li_separator = Pos (as_source, as_separator, 2)
			If li_separator > 0 Then
				ls_keyvalue = Mid(as_source, 2, li_separator - 2)
			Else
				ls_keyvalue = Mid(as_source, 2)
			End If
			ls_keyvalue = Trim(ls_keyvalue)
			lb_done = True
		End If
	Else
		lb_done = True
	End If
Loop

Return ls_keyvalue

end function

public function integer of_setkeyvalue (ref string as_source, string as_keyword, string as_keyvalue, string as_separator);//====================================================================
// Function: of_setkeyvalue()
//--------------------------------------------------------------------
//	Description:	Sets the value portion of a keyword=value pair from a string 
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The string to have the set performed on.  Passed by reference.
//							Format:  keyword = value; ...
//	as_keyword		The keyword to set a value for.
//	as_keyvalue		The new value for the specified keyword.
//	as_separator	The separator character used in the source string.
//--------------------------------------------------------------------
//	Returns:			integer
//						1 Successful operation.
//						-1 The specified keywork did not exist in the source string.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Integer	li_found = -1
Integer	li_keyword, &
	li_separator, &
	li_equal
String	ls_temp

//Check paramemeters
If IsNull(as_source) Or IsNull(as_keyword) Or IsNull(as_keyvalue) Or IsNull(as_separator) Then
	Integer li_null
	SetNull (li_null)
	Return li_null
End If

Do
	li_keyword = Pos (Lower(as_source), Lower(as_keyword), li_keyword + 1)
	If li_keyword > 0 Then
		ls_temp = LeftTrim (Right (as_source, Len(as_source) - (li_keyword + Len(as_keyword) - 1)))
		If Left (ls_temp, 1) = "=" Then
			li_equal = Pos (as_source, "=", li_keyword + 1)
			li_separator = Pos (as_source, as_separator, li_equal + 1)
			If li_separator > 0 Then
				as_source = Left(as_source, li_equal) + as_keyvalue + as_separator + Right(as_source, Len(as_source) - li_separator)
			Else
				as_source = Left(as_source, li_equal) + as_keyvalue
			End If
			li_found = 1
		End If
	End If
Loop While li_keyword > 0

Return li_found

end function

public function string of_removenonprint (string as_source);//====================================================================
// Function: of_removenonprint()
//--------------------------------------------------------------------
//	Description: 	Removes all nonprint characters. 
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The string from which all nonprint characters are to
//						be removed.	
//--------------------------------------------------------------------
//	Returns:  		string
//						as_source with all desired characters removed.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Char		lch_char
Long		ll_pos = 1
Long		ll_loop
String	ls_source
Long		ll_source_len

//Check parameters
If IsNull(as_source) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

ls_source = as_source
ll_source_len = Len(ls_source)

// Remove nonprintable characters 
For ll_loop = 1 To ll_source_len
	lch_char = Mid(ls_source, ll_pos, 1)
	If of_IsPrintable(lch_char) Then
		ll_pos ++
	Else
		ls_source = Replace(ls_source, ll_pos, 1, "")
	End If
Next

Return ls_source


end function

public function boolean of_isempty (string as_source);//====================================================================
// Function: of_isempty()
//--------------------------------------------------------------------
// Description: Determines whether a string has a lenght of 0 or is NULL.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The source string.		
//--------------------------------------------------------------------
//	Returns:  		Boolean
//						True if the string has a lenght of 0 or is NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

If IsNull(as_source) Or Len(as_source) = 0 Then
	//String is empty
	Return True
End If

//String is Not empty
Return False

end function

public function boolean of_isprintable (string as_source);//====================================================================
// Function: of_isprintable()
//--------------------------------------------------------------------
// Description: Determines whether a string is composed entirely of 
//					 Printable characters.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The source string.	
//--------------------------------------------------------------------
//	Returns:  		Boolean
//						True if the string only contains Printable characters.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long		ll_count = 0
Long		ll_length
Char		lc_char[]
Integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	Boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length = 0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters
//Quit loop if NonPrintable character is found
Do While ll_count < ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	// 'space'=32, '~'=126
	If li_ascii < 32 Or li_ascii > 126 Then
		/* Not a printable character */
		Return False
	End If
Loop

// Entire string is of printable characters.
Return True



end function

public function boolean of_isformat (string as_source);//====================================================================
// Function: of_isformat()
//--------------------------------------------------------------------
// Description: Determines whether a string contains only Formatting
//					 characters.  Format characters for this function
//					 are all printable characters that are not AlphaNumeric.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The source string.	
//--------------------------------------------------------------------
//	Returns:  		Boolean
//						True if the string only contains Formatting characters.
//						If as_source is NULL, the function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long		ll_count = 0
Long		ll_length
Char		lc_char[]
Integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	Boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length = 0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters
//Quit loop if Non Operator character is found
Do While ll_count < ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	If (li_ascii >= 33 And li_ascii <= 47) Or &
		(li_ascii >= 58 And li_ascii <= 64) Or &
		(li_ascii >= 91 And li_ascii <= 96) Or &
		(li_ascii >= 123 And li_ascii <= 126) Then
		//Character is a Format.
		//Continue with the next character.
	Else
		Return False
	End If
Loop

// Entire string is made of Format characters.
Return True


end function

public function string of_removewhitespace (string as_source);//====================================================================
// Function: of_removewhitespace()
//--------------------------------------------------------------------
//	Description: 	Removes all WhiteSpace characters.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The string from which all WhiteSpace characters are to
//						be removed.		
//--------------------------------------------------------------------
//	Returns:  		string
//						as_source with all desired characters removed.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Char		lch_char
Long		ll_pos = 1
Long		ll_loop
String	ls_source
Long		ll_source_len

//Check parameters
If IsNull(as_source) Then
	String ls_null
	SetNull(ls_null)
	Return ls_null
End If

ls_source = as_source
ll_source_len = Len(ls_source)

// Remove WhiteSpace characters 
For ll_loop = 1 To ll_source_len
	lch_char = Mid(ls_source, ll_pos, 1)
	If Not of_IsWhiteSpace(lch_char) Then
		ll_pos ++
	Else
		ls_source = Replace(ls_source, ll_pos, 1, "")
	End If
Next

Return ls_source



end function

public function boolean of_iscomparisonoperator (string as_source);//====================================================================
// Function: of_iscomparisonoperator()
//--------------------------------------------------------------------
// Description: Determines whether a string contains only Comparison
//						Operator characters.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The source string.	
//--------------------------------------------------------------------
//	Returns:  		Boolean
//						True if the string only contains Comparison Operator
//						characters.
//						If as_source is NULL, the function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long		ll_count = 0
Long		ll_length
Char		lc_char[]
Integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	Boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length = 0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters
//Quit loop if Non Operator character is found
Do While ll_count < ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	If li_ascii = 60 Or			/* < less than */	 &
		li_ascii = 61 Or			/* = equal */		 &
		li_ascii = 62 Then		/* > greater than */
		//Character is an Comparison Operator.
		//Continue with the next character.
	Else
		Return False
	End If
Loop

// Entire string is made of Comparison Operators.
Return True


end function

public function boolean of_isarithmeticoperator (string as_source);//====================================================================
// Function: of_isarithmeticoperator()
//--------------------------------------------------------------------
// Description: Determines whether a string contains only Arithmetic
//					 Operator characters.
//--------------------------------------------------------------------
//	Arguments:
//	as_source		The source string.		
//--------------------------------------------------------------------
//	Returns:  		Boolean
//						True if the string only contains Arithmetic Operator
//						characters.
//						If as_source is NULL, the function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long		ll_count = 0
Long		ll_length
Char		lc_char[]
Integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	Boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length = 0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters
//Quit loop if Non Operator character is found
Do While ll_count < ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	If li_ascii = 40 Or			/* ( left parenthesis */	 &
		li_ascii = 41 Or			/* ) right parenthesis */	 &
		li_ascii = 43 Or			/* + addition */				 &
		li_ascii = 45 Or			/* - subtraction */			 &
		li_ascii = 42 Or			/* * multiplication */		 &
		li_ascii = 47 Or			/* / division */				 &
		li_ascii = 94 Then		/* ^ power */
		//Character is an operator.
		//Continue with the next character.
	Else
		Return False
	End If
Loop

// Entire string is made of arithmetic operators.
Return True



end function

public function long of_countoccurrences (string as_source, string as_target);//====================================================================
// Function: of_countoccurrences()
//--------------------------------------------------------------------
// Description: Count the occurrences of one string within another.
//--------------------------------------------------------------------
//	Arguments:
//	as_Source		The string in which to search.
//	as_Target		The string to search for.		
//--------------------------------------------------------------------
//	Returns: 		long
//						The number of occurrences of as_Target in as_source.
//						If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long	ll_Count

//Check for parameters
If IsNull(as_source) Or IsNull(as_target) Then
	Long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Default is to ignore case.
ll_Count = of_CountOccurrences (as_source, as_target, True)

Return ll_Count


end function

public function long of_arraytostring (string as_source[], string as_delimiter, ref string as_ref_string);//====================================================================
// Function: of_arraytostring()
//--------------------------------------------------------------------
// Description: Create a single string from an array of strings separated by
//					 the passed delimeter.
//					 Note: Function will not include on the single string any 
//							 array entries which match an empty string.
//--------------------------------------------------------------------
//	Arguments:
//	as_source[]		The array of string to be moved into a single string.
//	as_Delimiter	The delimeter string.
//	as_ref_string	The string to be filled with the array of strings,
//						passed by reference.	
//--------------------------------------------------------------------
//	Returns:  		long
//						1 for a successful transfer.
//						-1 if a problem was found.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================


Return of_arraytostring(as_source[], as_delimiter, False, as_ref_string)


end function

public function long of_arraytostring (string as_source[], string as_delimiter, boolean ab_processempty, ref string as_ref_string);//====================================================================
// Function: of_arraytostring()
//--------------------------------------------------------------------
// Description: Create a single string from an array of strings separated by
//					 the passed delimeter.
//--------------------------------------------------------------------
//	Arguments:
//	as_source[]		 The array of string to be moved into a single string.
//	as_Delimiter	 The delimeter string.
//	ab_processempty Whether to process empty string as_source members.
//	as_ref_string	 The string to be filled with the array of strings,
//						 passed by reference.	
//--------------------------------------------------------------------
//	Returns:  		long
//						1 for a successful transfer.
//						-1 if a problem was found.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Long		ll_Count, ll_ArrayUpBound

//Get the array size
ll_ArrayUpBound = UpperBound(as_source[])

//Check parameters
If IsNull(as_delimiter) Or (Not ll_ArrayUpBound > 0) Then
	Return -1
End If

//Reset the Reference string
as_ref_string = ''

If Not ab_processempty Then
	For ll_Count = 1 To ll_ArrayUpBound
		// Do not include any entries that match an empty string 
		If as_source[ll_Count] <> '' Then
			If Len(as_ref_string) = 0 Then
				//Initialize string
				as_ref_string = as_source[ll_Count]
			Else
				//Concatenate to string
				as_ref_string = as_ref_string + as_delimiter + as_source[ll_Count]
			End If
		End If
	Next
Else
	For ll_Count = 1 To ll_ArrayUpBound
		// Include any entries that match an empty string 
		If ll_Count = 1 Then
			//Initialize string
			as_ref_string = as_source[ll_Count]
		Else
			//Concatenate to string
			as_ref_string = as_ref_string + as_delimiter + as_source[ll_Count]
		End If
	Next
End If
Return 1



end function

public function string of_wordcap (string as_source);//====================================================================
// Function: of_wordcap()
//--------------------------------------------------------------------
//	Description:  	Sets the first letter of each word in a string to a capital 
//						letter and all other letters to lowercase (for example, 
//						ROBERT E. LEE would be Robert E. Lee).
//--------------------------------------------------------------------
//	Arguments:		as_source		The source string.		
//--------------------------------------------------------------------
//	Returns:  		String			Returns string with the first letter of each word set to
//											uppercase and the remaining letters lowercase if it succeeds
//											and NULL if an error occurs.
//											If any argument's value is NULL, function returns NULL.
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Return WordCap ( as_source )

end function

on n_cst_string.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_string.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

