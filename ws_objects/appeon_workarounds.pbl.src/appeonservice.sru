$PBExportHeader$appeonservice.sru
forward
global type appeonservice from nonvisualobject
end type
end forward

global type appeonservice from nonvisualobject autoinstantiate
end type

type prototypes
Function long StringToInt(ref string as_hex) library "EonAXNVO.dll" alias for "StringToInt;Ansi"
Function long GetLocalIPAddr(ref string as_ip) library "EonAXNVO.dll" alias for "GetLocalIPAddr;Ansi"
Function int FreeMemory(long al_address) library "EonAXNVO.dll"

Function string GetWebPath(string as_filepath, ref long nRand, ref long address) library "EonAXNVO.dll" alias for "GetWebPath;Ansi"
end prototypes

type variables
private:
CONSTANT integer I_STRA_COUNT = 16
CONSTANT integer I_STRB_COUNT = 3
CONSTANT integer I_STRC_COUNT = 8
end variables

forward prototypes
public function string of_getfilepath ()
public function any of_getvalueany (string as_type, string as_value)
public function integer of_getipaddress (ref string as_ipaddress)
public function long of_fileread (readonly string as_filename, ref string as_data)
public function date of_date (readonly string as_datetime)
public subroutine of_decomposetoarray (readonly string as_data, readonly string as_delimiter, ref string as_array[])
public function integer of_getcolumntype (readonly string as_type)
public function integer of_getpbchanges (readonly string as_xml, ref str_a astr_obj)
public function integer of_getpbchanges (readonly string as_xml, ref str_b astr_obj, readonly string as_type)
public function long of_parsetoarray (readonly string as_source, readonly string as_delimiter, ref string as_array[])
public function dwitemstatus of_statusfromcode (readonly string as_status)
public function string of_statustocode (readonly dwitemstatus adw_status)
public function time of_time (readonly string as_datetime)
public subroutine of_globalreplace (ref string as_source, string as_old, readonly string as_new, boolean ab_ignorecase)
public function integer of_getfilepath (ref string as_filepath, ref string as_filename, string as_filetype, readonly string as_dataobject, boolean ab_flag)
end prototypes

public function string of_getfilepath ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonservice::of_getfilepath()
//------------------------------------------------------------------------------
// Description: 
// 			Gets EAServer path 
//	
// Arguments:(None)
//	
// Returns:  string - EAServer path it succeeds and space if error occurs
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_Pos
String ls_Path

ls_Path = Lower(GetLibraryList())

IF ls_Path = '' THEN RETURN ''

li_Pos = Pos(ls_Path, 'repository')

IF li_Pos > 0 THEN
	ls_Path = Left(ls_Path, li_Pos - 2)
ELSE
	ls_Path = ''
END IF

RETURN ls_Path




end function

public function any of_getvalueany (string as_type, string as_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetValueAny
//
//	Access:    public
//
//	Arguments:
//		as_type			: The type of value
//   as_value		   : The string value
//
//	Returns:  any	
//	  The any value
//
//	Description:  
//	
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
Any 	la_value
Date	ld_val
Time	ltm_val

CHOOSE CASE Lower ( Left ( as_type , 5 ) )

	CASE "char(", "char" //  CHARACTER DATATYPE
		la_value = as_value
		
	CASE "date" //  DATE DATATYPE
		la_value =  Date (as_value)
		
	CASE "datet" //  DATETIME DATATYPE
		ld_val = of_Date (as_value)
		IF Pos ( as_value, " " ) > 0 THEN
			/*  There was a time entered  */
			ltm_val = of_Time (as_value)
		ELSE
			ltm_val = Time ( "00:00:00" )
		END IF
		la_value = DateTime (ld_val, ltm_val)
		
	CASE "decim" //  DECIMAL DATATYPE
		la_value  = Dec (as_value)
		
	CASE "numbe", "doubl" //  NUMBER DATATYPE	
		la_value = Double (as_value)
	CASE "real" //  REAL DATATYPE	
		la_value = Real (as_value)
	CASE "long", "ulong" //  LONG/INTEGER DATATYPE	
		la_value = Long (as_value)
	CASE "time", "times" //  TIME DATATYPE
		la_value = Time ( as_value )
END CHOOSE

RETURN la_value

end function

public function integer of_getipaddress (ref string as_ipaddress);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetIPAddress
//
//	Access:  public
//
//	Arguments:		
//	ref string	as_IPAddress:
//
//	Returns:  integer
//
//	Description:  
// Gets Local host IP Address
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//////////////////////////////////////////////////////////////////////////////
long ll_return

as_IPADDress = space(255)
ll_return = GetLocalIPAddr(ref as_IPAddress)

/*
as_IPAddress = GetLocalIPAddr()
as_IPAddress = trim(as_IPAddress)
*/
if ll_Return = 1 then 
	return 1
else
	return -1
end if


end function

public function long of_fileread (readonly string as_filename, ref string as_data);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  of_FileRead
//	Arguments:		as_FileName				The name of the file to read.
//						as_Data				The data from the file, passed by reference.
//	Returns:			Long - The size of the blob read, returns -1 if an error occurrs.
//	Description:	Open, read into a string, and close a file.  Handles files > 32,765 bytes.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	Version
//						5.0   Initial version
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////

Integer		li_FileNo, li_Reads, li_Cnt
Long			ll_FileLen
String		ls_CurData

ll_FileLen = FileLength(as_FileName)

li_FileNo = FileOpen(as_FileName, StreamMode!, Read!)
IF li_FileNo < 0 THEN RETURN -1

// Determine the number of reads required to read the entire file
IF ll_FileLen > 32765 THEN
	IF Mod(ll_FileLen, 32765) = 0 THEN
		li_Reads = ll_FileLen / 32765
	ELSE
		li_Reads = (ll_FileLen / 32765) + 1
	END IF
ELSE
	li_Reads = 1
END IF

// Empty the string argument
as_Data = ls_CurData

// Read the file and build the string with data from the file
FOR li_Cnt = 1 TO li_Reads
	IF FileRead(li_FileNo, ls_CurData) = -1 THEN
		RETURN -1
	ELSE
		as_Data = as_Data + ls_CurData
	END IF
NEXT

FileClose(li_FileNo)


RETURN ll_FileLen



end function

public function date of_date (readonly string as_datetime);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Date
//
//	Access:  public  
//    
//	Arguments:
//	as_datetime   Datetime value as a string
//
//	Returns:  date
//	If as_datetime does not contain a valid datetime value, return date
//	is 1900-01-01.  If as_datetime is NULL, function returns NULL.
//
//	Description:
//	Converts a string whose value is a valid datetime to a date
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
// 5.0.04	Enhanced to handle to more cases.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Date	ld_rc = 1900-01-01
Long	ll_count
String	ls_datetime[]


// Check arguments
IF IsNull (as_datetime) THEN
	SetNull (ld_rc)
	RETURN ld_rc
END IF

// Validate datetime string ("1/1/95", "1/1/95 8:00", "1/1/95 8:00 PM")
ll_count = of_ParseToArray (as_datetime, " ", ls_datetime)
IF ll_count <= 0 OR ll_count > 3 THEN
	RETURN ld_rc
END IF

// Date string passed in
IF ll_count = 1 THEN
	RETURN Date (as_datetime)
END IF

// Datetime string passed in
IF ll_count = 2 OR ll_count = 3 THEN
	RETURN Date (ls_datetime[1])
END IF

RETURN ld_rc



end function

public subroutine of_decomposetoarray (readonly string as_data, readonly string as_delimiter, ref string as_array[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_decomposeToArray
//
//	Access: 			public
//
//	Arguments: 		
// 	as_data 			string
//		as_delimiter	string
//		as_array[]		string
//
//	Returns:  		
//		none
//	Description:  
//		Splits the string and assigns the value to the array.
//
//////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
Long		ll_startPos = 1, ll_endPos = 1, ll_row = 1

ll_endPos 	 = Pos(as_data, as_delimiter)

DO WHILE ll_endPos <> 0
	as_array[ll_row]  = 	Mid(as_data, ll_startPos, ll_endPos - ll_startPos)
	ll_startPos 		 = 	ll_endPos + 1
	ll_endPos 			 = 	Pos(as_data, as_delimiter, ll_startPos)
	ll_row ++
LOOP

as_array[ll_row] 		 = 	Mid(as_data,ll_startPos)


end subroutine

public function integer of_getcolumntype (readonly string as_type);//
//	Function:  of_GetColumnType
//
//	Access:    public
//
//	Arguments:
//		string as_type	
//
//	Returns:  integer	
//	  The type of column
//
//	Description:  
//	  	Gets the type of column.  
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
int li_ret

choose case as_type   
	case 'char' 
		li_ret = 1    
	case 'number' 
		li_ret = 2
	case 'date'
		li_ret = 3
	case 'time'
		li_ret = 4
	case 'datetime'
		li_ret = 5
	case 'decimal'
		li_ret = 6
	case 'real'
		li_ret = 7
	case 'long'
		li_ret = 8
end choose
	
return li_ret
end function

public function integer of_getpbchanges (readonly string as_xml, ref str_a astr_obj);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonservice::of_getpbchanges()
//------------------------------------------------------------------------------
// Description: 
// 		Parses the string and converts the string information into relevant structure.  
//			In the first part of the string, every eight bytes refer to the length of a section
//	
// Arguments: 
//		readonly	string	as_xml  		
//		ref     	str_a 	astr_obj		
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_i
Long ll_Start[], ll_Len[], ll_Pos = 0
String	ls_temp, ls_PbSyntax

FOR li_i = 1 TO I_STRA_COUNT
	ls_temp = MidA(as_xml,li_i*8 - 7,8)
	
	//convert hex to dec
	ll_Len[li_i] = StringToInt(ls_temp)
	
	IF li_i = 1 THEN
		ll_Start[1] = 8*I_STRA_COUNT + 1
	ELSE
		ll_Start[li_i] = ll_Start[li_i - 1] + ll_Len[li_i - 1]
	END IF
NEXT

astr_obj.s_type = MidA(as_xml,ll_Start[1],ll_len[1])
astr_obj.s_dataobject = MidA(as_xml,ll_Start[2],ll_len[2])
astr_obj.s_pbsyntax = MidA(as_xml,ll_Start[3],ll_len[3])
astr_obj.s_matchtype = MidA(as_xml,ll_Start[4],ll_len[4])
astr_obj.l_SetCount = long(MidA(as_xml,ll_Start[5],ll_len[5])) - 1
astr_obj.s_rowset = MidA(as_xml,ll_Start[6],ll_len[6])

//primary
astr_obj.s_pdata = MidA(as_xml,ll_Start[7],ll_len[7])
astr_obj.s_pstate = MidA(as_xml,ll_Start[8],ll_len[8])
astr_obj.s_pflag = MidA(as_xml,ll_Start[9],ll_len[9])

//filter
astr_obj.s_fdata = MidA(as_xml,ll_Start[10],ll_len[10])
astr_obj.s_fstate = MidA(as_xml,ll_Start[11],ll_len[11])
astr_obj.s_fflag = MidA(as_xml,ll_Start[12],ll_len[12])

//delete
astr_obj.s_ddata = MidA(as_xml,ll_Start[13],ll_len[13])
astr_obj.s_dstate = MidA(as_xml,ll_Start[14],ll_len[14])
astr_obj.s_dflag = MidA(as_xml,ll_Start[15],ll_len[15])

//web syntax
astr_obj.s_fullstate = MidA(as_xml,ll_Start[16],ll_len[16])

RETURN 1

end function

public function integer of_getpbchanges (readonly string as_xml, ref str_b astr_obj, readonly string as_type);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonservice::of_getpbchanges()
//------------------------------------------------------------------------------
// Description: 
// 		Parses the string and converts the string information into relevant structure.  
//			In the first part of the string, every eight bytes refer to the length of a section
//	
// Arguments: 
//		readonly	string	as_xml  		
//		ref     	str_b 	astr_obj		
//		readonly	string	as_type 		B or C
//	
// Returns:  integer-Returns 1 if it succeeds and -1 if an error occurs 
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_i,ll_count
Long ll_Start[],ll_Len[]
String	ls_temp
Blob		lbolb_tmp
boolean lb_c

lbolb_tmp = Blob(as_xml, EncodingANSI!)

lb_c = ('43' = as_type or 'C' = Upper(as_type))
if lb_c then
	ll_count = I_STRC_COUNT
else
	ll_count = I_STRB_COUNT
end if

FOR li_i = 1 TO ll_count
	ls_temp = MidA(as_xml,li_i*8 - 7,8)
	
	//convert hex to dec
	ll_Len[li_i] = StringToInt(ls_temp)
	
	IF li_i = 1 THEN
		ll_Start[1] = 8*ll_count + 1
	ELSE
		ll_Start[li_i] = ll_Start[li_i - 1] + ll_Len[li_i - 1]
	END IF
NEXT

astr_obj.s_type = MidA(as_xml,ll_Start[1],ll_len[1])
astr_obj.s_dataobject = MidA(as_xml,ll_Start[2],ll_len[2])
astr_obj.s_fullstate = MidA(as_xml,ll_Start[3],ll_len[3])
if lb_c then
	astr_obj.s_url = MidA(as_xml,ll_Start[4],ll_len[4])
	astr_obj.i_count = long(MidA(as_xml,ll_Start[5],ll_len[5]))
	astr_obj.s_sql = MidA(as_xml,ll_Start[6],ll_len[6])
	astr_obj.s_filter = MidA(as_xml,ll_Start[7],ll_len[7])
	astr_obj.s_sort = MidA(as_xml,ll_Start[8],ll_len[8])
end if

RETURN 1

end function

public function long of_parsetoarray (readonly string as_source, readonly string as_delimiter, ref string as_array[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ParseToArray
//
//	Access:  public
//
//	Arguments:
//	as_Source   The string to parse.
//	as_Delimiter   The delimeter string.
//	as_Array[]   The array to be filled with the parsed strings, passed by reference.
//
//	Returns:  long
//	The number of elements in the array.
//	If as_Source or as_Delimeter is NULL, function returns NULL.
//
//	Description:  Parse a string into array elements using a delimeter string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.02   Fixed problem when delimiter is last character of string.

//	   Ref array and return code gave incorrect results.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Long		ll_DelLen, ll_Pos, ll_Count, ll_Start, ll_Length
String 	ls_holder

//Check for NULL
IF IsNull(as_source) OR IsNull(as_delimiter) THEN
	Long ll_null
	SetNull(ll_null)
	RETURN ll_null
END IF

//Check for at leat one entry
IF Trim (as_source) = '' THEN
	RETURN 0
END IF

//Get the length of the delimeter
ll_DelLen = Len(as_delimiter)

ll_Pos =  Pos(Upper(as_source), Upper(as_delimiter))

//Only one entry was found
IF ll_Pos = 0 THEN
	as_Array[1] = as_source
	RETURN 1
END IF

//More than one entry was found - loop to get all of them
ll_Count = 0
ll_Start = 1
DO WHILE ll_Pos > 0
	
	//Set current entry
	ll_Length = ll_Pos - ll_Start
	ls_holder = Mid (as_source, ll_Start, ll_Length)
	
	// Update array and counter
	ll_Count ++
	as_Array[ll_Count] = ls_holder
	
	//Set the new starting position
	ll_Start = ll_Pos + ll_DelLen
	
	ll_Pos =  Pos(Upper(as_source), Upper(as_delimiter), ll_Start)
LOOP

//Set last entry
ls_holder = Mid (as_source, ll_Start, Len (as_source))

// Update array and counter if necessary
IF Len (ls_holder) > 0 THEN
	ll_Count++
	as_Array[ll_Count] = ls_holder
END IF

//Return the number of entries found
RETURN ll_Count


end function

public function dwitemstatus of_statusfromcode (readonly string as_status);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_statusfromcode
//
//	Access:  public
//
//	Arguments:		
//	string	as_status
//
//	Returns:  DWItemStatus
//
//
//	Description:  
// Gets the DWItemStatus from code
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//////////////////////////////////////////////////////////////////////////////
//0-notmodified;1-datamodified;2-new;3-newmodified
dwitemstatus	ldwi_null

CHOOSE CASE as_status
	CASE '1'
		RETURN DataModified!
	CASE '3'
		RETURN NewModified!
	CASE '2'
		RETURN New!
	CASE '0'
		RETURN NotModified!
	CASE ELSE
		SetNull(ldwi_null)
		RETURN ldwi_null
END CHOOSE

end function

public function string of_statustocode (readonly dwitemstatus adw_status);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_StatusToCode
//
//	Access:  public
//
//	Arguments:		
//	DWItemStatus adw_status
//
//	Returns:  string
//
//
//	Description:  
// Gets the code from DWItemStatus
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//////////////////////////////////////////////////////////////////////////////
//0-notmodified;1-datamodified;2-new;3-newmodified
String ls_null

CHOOSE CASE adw_status
	CASE DataModified!
		RETURN '1'
	CASE NewModified!
		RETURN '3'
	CASE New!
		RETURN '2'
	CASE NotModified!
		RETURN '0'
	CASE ELSE
		SetNull(ls_null)
		RETURN ls_null
END CHOOSE

end function

public function time of_time (readonly string as_datetime);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Time
//
//	Access:  public
//
//	Arguments:
//	as_datetime   Datetime value as a string
//
//	Returns:  time
//	If as_datetime does not contain a valid datetime value, return time
//	is 00:00:00.000000.  If as_datetime is NULL, function returns NULL.
//
//	Description:
//	Converts a string whose value is a valid datetime to a time value
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
// 5.0.04 	Enhanced to handle more cases.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Time	ltm_rc = 00:00:00.000000
Long	ll_count
String	ls_datetime[]


// Check arguments
IF IsNull (as_datetime) THEN
	SetNull (ltm_rc)
	RETURN ltm_rc
END IF

// Validate datetime string
ll_count = of_ParseToArray (as_datetime, " ", ls_datetime)
IF ll_count <= 0 OR ll_count > 3 THEN
	RETURN ltm_rc
END IF

// Date string passed in ("8:00pm")
IF ll_count = 1 THEN
	RETURN Time (as_datetime)
END IF

// Datetime string passed in ("1/1/95 8:00pm")
IF ll_count = 2 THEN
	RETURN Time (ls_datetime[2])
END IF

// Datetime string passed in ("1/1/95 8:00 pm")
IF ll_count = 3 THEN
	RETURN Time (ls_datetime[2]+' '+ls_datetime[3])
END IF

RETURN ltm_rc

end function

public subroutine of_globalreplace (ref string as_source, string as_old, readonly string as_new, boolean ab_ignorecase);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GlobalReplace
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Old			The old string being replaced.
//	as_New			The new string.
// ab_IgnoreCase	A boolean stating to ignore case sensitivity.
//
//	Returns:  		string
//						as_Source with all occurrences of as_Old replaced with as_New.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Replace all occurrences of one string inside another with
//						a new string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 2000-2006 appeon, Inc. and its subsidiaries.  All rights reserved.
//////////////////////////////////////////////////////////////////////////////

Long	ll_Start
Long	ll_OldLen
Long	ll_NewLen
String ls_Source

//Check parameters
IF IsNull(as_source) OR IsNull(as_old) OR IsNull(as_new) OR IsNull(ab_ignorecase) THEN
	String ls_null
	SetNull(ls_null)
	as_source = ls_null
	RETURN
END IF

//Get the string lenghts
ll_OldLen = Len(as_old)
ll_NewLen = Len(as_new)

//Should function respect case.
IF ab_ignorecase THEN
	as_old = Lower(as_old)
	ls_Source = Lower(as_source)
ELSE
	ls_Source = as_source
END IF

//Search for the first occurrence of as_Old
ll_Start = Pos(ls_Source, as_old)

DO WHILE ll_Start > 0
	// replace as_Old with as_New
	as_source = Replace(as_source, ll_Start, ll_OldLen, as_new)
	
	//Should function respect case.
	IF ab_ignorecase THEN
		ls_Source = Lower(as_source)
	ELSE
		ls_Source = as_source
	END IF
	
	// find the next occurrence of as_Old
	ll_Start = Pos(ls_Source, as_old, (ll_Start + ll_NewLen))
LOOP


end subroutine

public function integer of_getfilepath (ref string as_filepath, ref string as_filename, string as_filetype, readonly string as_dataobject, boolean ab_flag);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonservice::of_getfilepath()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		reference	string 	as_filepath  		
//		reference	string 	as_filename  		
//		value    	string 	as_filetype  		
//		readonly 	string 	as_dataobject		
//		value    	boolean	ab_flag      		
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-06
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

String ls_Path, ls_WebPath
Long ll_Address, ll_nRand

// get EAServer path
ls_Path = of_GetFilePath()
// ls_Path = "C:\Program Files\Sybase\EAServer" 

// Client
ls_WebPath = ""
IF ls_Path <> "" THEN
	ls_WebPath = GetWebPath(ls_Path, REF ll_nRand, REF ll_Address)
	FreeMemory(ll_Address)
END IF

// Replace '/' with '\'
ls_Path = Trim(ls_WebPath)
of_GlobalReplace(ls_Path, '/', '\', TRUE)

CHOOSE CASE Lower(as_filetype)
	CASE 'txt'
		as_filename = as_dataobject + "_" + String(ll_nRand) + ".txt"
		DO WHILE FileExists(ls_Path + as_filename)
			as_filename = as_dataobject + "_" + String(cpu()) + ".txt"
		LOOP
		IF ls_Path <> '' THEN
			as_filepath = ls_Path + "\" + as_filename
		ELSE
			as_filepath = as_filename
		END IF
	CASE 'wmf'
		IF ls_Path = '' THEN RETURN -1
		ls_Path += "\imagefile\"
		//if ls_path no exists ,create it
		IF NOT DirectoryExists (ls_Path) THEN CreateDirectory (ls_Path)
		
		IF ab_flag THEN
			// only one wmf file
			
			as_filename = as_dataobject + "_" + String(ll_nRand)
			DO WHILE FileExists(ls_Path + as_filename + ".wmf")
				as_filename = as_dataobject + "_" + String(cpu())
			LOOP
			as_filepath = ls_Path + as_filename
			
		ELSE
			// multi wmf file
			as_filename = as_dataobject + "_" + String(ll_nRand)
			DO WHILE FileExists(ls_Path + as_filename + "_1.wmf")
				as_filename = as_dataobject + "_" + String(cpu())
			LOOP
			as_filepath = ls_Path + as_filename
		END IF
	CASE ELSE
		RETURN -1
END CHOOSE

RETURN 1





end function

on appeonservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on appeonservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

