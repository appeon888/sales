$PBExportHeader$nvo_util.sru
$PBExportComments$Utility customer Class
forward
global type nvo_util from nonvisualobject
end type
end forward

global type nvo_util from nonvisualobject autoinstantiate
end type

forward prototypes
public function string of_combine_custno (string as_custno)
public function string of_combine_orderno (string as_custno)
public function string of_parse_custno (string as_custno)
public function string of_parse_orderno (string as_orderno)
public function string of_parse_sku (string as_custno)
public function integer of_print_customer (string as_custno)
public function integer of_print_packingslip (string as_orderno)
public function integer of_print_addresslabel (string as_orderno)
public function long of_choose_color ()
public function string of_get_param (string as_userid, string as_paramname)
public function integer of_set_param (string as_userid, string as_paramname, string as_paramvalue)
public function integer of_get_rptoptions (string as_reportname, ref str_rpt_options astr_rpt_options)
end prototypes

public function string of_combine_custno (string as_custno);//====================================================================
// Function: of_combine_custno()
//--------------------------------------------------------------------
// Description: 
//CustNo is like 0-00-0,but database data is like 0000
//This functino is used to parse database data in client format
//--------------------------------------------------------------------
// Arguments: 
//		string	as_custno		
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

If Len(as_custNo) <> 6 Then
	Return as_custNo
End If

Int  li
String  ls_Temp
String   lc

For li = 1 To Len(as_custNo)
	lc = Mid(as_custNo,li,1)
	If lc <> '-' Then
		ls_Temp += lc
	End If
Next
Return ls_Temp

end function

public function string of_combine_orderno (string as_custno);//====================================================================
// Function: of_combine_orderno()
//--------------------------------------------------------------------
// Description: 
//CustNo is like 0-00-0,but database data is like 0000
//This functino is used to parse database data in client format
//--------------------------------------------------------------------
// Arguments: 
//		string	as_custno		
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

If Len(as_custNo) <> 9 Then
	Return as_custNo
End If
Int  li
String  ls_Temp
String   lc

For li = 1 To Len(as_custNo)
	lc = Mid(as_custNo,li,1)
	If lc <> '-' Then
		ls_Temp += lc
	End If
Next
Return ls_Temp

end function

public function string of_parse_custno (string as_custno);//====================================================================
// Function: of_parse_custno()
//--------------------------------------------------------------------
// Description: 
//CustNo is like 0-00-0,but database data is like 0000
//This functino is used to parse database data in client format
//--------------------------------------------------------------------
// Arguments: 
//		string	as_custno		
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

If Len(as_custNo) <> 4 Then
	Return as_custNo
End If

Return   Left(as_custNo,1)+"-"+Mid(as_custNo,2,2)+"-"+Mid(as_custNo,4,1)

end function

public function string of_parse_orderno (string as_orderno);//====================================================================
// Function: of_parse_orderno()
//--------------------------------------------------------------------
// Description: 
//OrderNo is like 0-00-0-00,but database data is like 000000
//This functino is used to parse database data in client format
//--------------------------------------------------------------------
// Arguments: 
//		string	as_orderno		
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

If Len(as_OrderNo) <> 6 Then
	Return as_OrderNo
End If

Return   Left(as_OrderNo,1)+"-"+Mid(as_OrderNo,2,2)+"-"+Mid(as_OrderNo,4,1)+"-"+Mid(as_OrderNo,5)

end function

public function string of_parse_sku (string as_custno);//====================================================================
// Function: of_parse_sku()
//--------------------------------------------------------------------
// Description: 
//SKU is like a-000-00,but database data is like a00000
//This functino is used to parse database data in client format
//--------------------------------------------------------------------
// Arguments: 
//		string	as_custno		
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

If Len(as_custNo) <> 6 Then
	Return as_custNo
End If

Return   Left(as_custNo,1)+"-"+Mid(as_custNo,2,3)+"-"+Mid(as_custNo,5,2)

end function

public function integer of_print_customer (string as_custno);//====================================================================
// Function: of_print_customer()
//--------------------------------------------------------------------
// Description: Print one customer
//--------------------------------------------------------------------
// Arguments: 
//		string	as_custno		
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
Int  li_Ret
n_ds lds_print

If IsNull(as_CustNo) Or as_CustNo = '' Then Return -1

lds_print = Create n_ds
lds_print.DataObject = 'd_rep_cust_current'
lds_print.SetTransObject(sqlca)
lds_print.Retrieve(as_CustNo)

lds_print.Print()


if IsValid(lds_print) then 
	Destroy lds_print
end if

Return 0
end function

public function integer of_print_packingslip (string as_orderno);//====================================================================
// Function: of_print_packingslip()
//--------------------------------------------------------------------
// Description: Print one customer
//--------------------------------------------------------------------
// Arguments: 
//		string	as_orderno		
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

n_ds   lds_print
Int  li_Ret

If IsNull(as_orderno) Or as_orderno = '' Then Return -1

lds_print = Create n_ds
lds_print.DataObject = 'd_rep_order_packing_slip'
lds_print.SetTransObject(sqlca)
lds_print.Retrieve(as_orderno)

li_Ret = lds_print.Print()

Destroy lds_print

Return li_Ret




end function

public function integer of_print_addresslabel (string as_orderno);//====================================================================
// Function: of_print_addresslabel()
//--------------------------------------------------------------------
// Description: Print one customer
//--------------------------------------------------------------------
// Arguments: 
//		string	as_orderno		
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

n_ds   lds_print
Int  li_Ret

If IsNull(as_orderno) Or as_orderno = '' Then Return -1

lds_print = Create n_ds
lds_print.DataObject = 'd_ship_label'
lds_print.SetTransObject(sqlca)
lds_print.Retrieve(as_orderno)

li_Ret = lds_print.Print()	

Destroy lds_print

Return li_Ret




end function

public function long of_choose_color ();//====================================================================
// Function: of_choose_color()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

String  ls_Ret

OPEN(w_choose_color)
ls_Ret = Message.StringParm
If ls_Ret = 'cancel' Then Return -1
If Not IsNumber(ls_Ret) Then Return -1

Return Long(ls_Ret)


end function

public function string of_get_param (string as_userid, string as_paramname);//====================================================================
// Function: of_get_param()
//--------------------------------------------------------------------
// Description: Get user parameter value from database
//--------------------------------------------------------------------
// Arguments: 
//		string	as_userid   		
//		string	as_paramname		
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

String ls_ParamValue

SELECT "fparam_value"
	INTO :ls_ParamValue
	FROM "t_user_settings"
	WHERE ( "fuserno" = :as_userid ) AND
	( "fparam_name" = :as_paramname )   ;
	
Return ls_ParamValue


end function

public function integer of_set_param (string as_userid, string as_paramname, string as_paramvalue);//====================================================================
// Function: of_set_param()
//--------------------------------------------------------------------
// Description: Save user paramter into database
//--------------------------------------------------------------------
// Arguments: 
//		string	as_userid    		
//		string	as_paramname 		
//		string	as_paramvalue		
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

Int  li_Count

SELECT count(*)
	INTO :li_Count
	FROM "t_user_settings"
	WHERE ( "fuserno" = :as_userid ) AND
	( "fparam_name" = :as_paramname )   ;
	
If li_Count > 0 Then
	UPDATE "t_user_settings"
		SET "fparam_value" = :as_ParamValue
		WHERE ( "fuserno" = :as_userid ) AND
		( "fparam_name" = :as_paramname )   ;
Else
	INSERT INTO "t_user_settings"
		( "fuserno",
		"fparam_name",
		"fparam_value")
		VALUES ( :as_userid,
		:as_paramname,
		:as_ParamValue);
End If

If sqlca.SQLCode = 0 Then
	COMMIT;
	Return 1
Else
	ROLLBACK;
	Return -1
End If




end function

public function integer of_get_rptoptions (string as_reportname, ref str_rpt_options astr_rpt_options);//====================================================================
// Function: of_get_rptoptions()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		      	string	as_reportname  		
//		ref   	str_rpt_options	astr_rpt_options		
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

String     ls_Param,ls_Value,ls_Type
datastore  lds_Set
Int        li,li_Count

//Get settings from database
lds_Set = Create datastore
lds_Set.DataObject =  'd_user_settings'
lds_Set.SetTransObject(SQLCA)

li_Count  = lds_Set.Retrieve(gs_User_No,as_reportname)
If li_Count < 1 Then Return -1

astr_rpt_options.ffontsize = 10
astr_rpt_options.ftextcolor = 0
astr_rpt_options.fbackcolor = RGB(255,255,255)

For li = 1  To li_Count
	ls_Param = lds_Set.Object.fparam_name[li]
	ls_Value = lds_Set.Object.fparam_value[li]
	Choose Case Lower(ls_Param)
		Case "report options"+"fontsize"
			If (Not IsNull(ls_Value)) And ls_Value <> '' And IsNumber(ls_Value) Then
				astr_rpt_options.ffontsize = Integer(ls_Value)
			End If
			
		Case 'report options'+'textcolor'
			If (Not IsNull(ls_Value)) And ls_Value <> '' And IsNumber(ls_Value) Then
				astr_rpt_options.ftextcolor = Long(ls_Value)
			End If
			
		Case  'report options'+'backcolor'
			If (Not IsNull(ls_Value)) And ls_Value <> '' And IsNumber(ls_Value) Then
				astr_rpt_options.fbackcolor = Long(ls_Value)
			End If
			
		Case 'report options'+'autorefresh'
			astr_rpt_options.fautorefresh = Lower(ls_Value) = 'true'
			
		Case Lower(as_reportname) + 'date scope'
			If (Not IsNull(ls_Value)) And ls_Value <> ''Then
			astr_rpt_options.fdefaultdate = ls_Value
		End If
		
	Case Lower(as_reportname) + 'year scope'
		If (Not IsNull(ls_Value)) And ls_Value <> ''  Then
			astr_rpt_options.fdefaultyear = ls_Value
		End If
		
	Case Lower(as_reportname) + 'reportstyle'
		If (Not IsNull(ls_Value)) And ls_Value <> ''  Then
			astr_rpt_options.freportstyle = ls_Value
		End If
		
End Choose
Next

Destroy lds_Set

Return 1



end function

event constructor;//
end event

on nvo_util.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_util.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

