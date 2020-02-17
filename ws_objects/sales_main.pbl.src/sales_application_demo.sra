$PBExportHeader$sales_application_demo.sra
$PBExportComments$Generated Application Object
forward
global type sales_application_demo from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
//====================================================================
// Declare: Global Variables()
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

string   gs_user_no
boolean  gb_auto_navigator=true

String		gs_WindowClassname //add by liulihua

end variables

global type sales_application_demo from application
string appname = "sales_application_demo"
boolean toolbartext = true
string themepath = ".\theme190"
string themename = "Flat Design Blue"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 2
long richtexteditversion = 1
string richtexteditkey = ""
string appicon = ".\picture\Handshake.ico"
end type
global sales_application_demo sales_application_demo

on sales_application_demo.create
appname="sales_application_demo"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on sales_application_demo.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;//====================================================================
// Event: open()
//--------------------------------------------------------------------
// Description: Profile AppeonSample
//--------------------------------------------------------------------
// Arguments: 
//		string	commandline		
//--------------------------------------------------------------------
// Returns: (none)
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/30
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

SQLCA.DBMS = "ODBC"
SQLCA.AutoCommit = False
SQLCA.DBParm = "ConnectString='DSN=AppeonSample;UID=dba;PWD=sql'"
CONNECT;

If SQLCA.SQLCode <> 0 Then
	MessageBox('Alert',"Connection to database failed.")
	Halt CLOSE
	Return
End If

OPEN(w_logon)
//If Message.StringParm <> '1' Then
//	//	messagebox('Alert',"Connection to database failed.")
//	Halt CLOSE
//	Return
//End If
//
//OPEN(w_mdi)
end event

event close;Disconnect using SQLCA;
end event

