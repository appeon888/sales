$PBExportHeader$appeon_nvo_db_update.sru
forward
global type appeon_nvo_db_update from nonvisualobject
end type
end forward

global type appeon_nvo_db_update from nonvisualobject autoinstantiate
end type

forward prototypes
public subroutine of_autocommit ()
public subroutine of_autocommitrollback ()
public subroutine of_autorollback ()
public subroutine of_commitqueue ()
public subroutine of_imdcall ()
public subroutine of_startqueue ()
public function integer of_update (powerobject obj_1, powerobject obj_2)
public function integer of_update (powerobject obj_1, powerobject obj_2, powerobject obj_3)
public function integer of_update (powerobject obj_1, powerobject obj_2, powerobject obj_3, powerobject obj_4)
public function integer of_update (powerobject obj)
public function integer of_update (integer transactionflag, powerobject obj_1, powerobject obj_2)
public function integer of_update (integer transactionflag, powerobject obj_1, powerobject obj_2, powerobject obj_3)
public function integer of_update (integer transactionflag, powerobject obj_1, powerobject obj_2, powerobject obj_3, powerobject obj_4)
public subroutine of_startqueue (integer stopmode)
public function integer of_isvalid_dwo (powerobject obj)
end prototypes

public subroutine of_autocommit ();/***************************************
* Auto commit label
*
* Use case:
* of_AutoCommit()
* Insert into tab_1 ......
* Commit;
***************************************/
end subroutine

public subroutine of_autocommitrollback ();/***************************************
* Auto commit and rollback label
*
* Use case:
* of_AutoCommitRollback()
* Insert into tab_1 ......
* If SQLCA.SQLCODE = 0 Then
*    Commit;
* Else
*    Rollback;
* End if
***************************************/

end subroutine

public subroutine of_autorollback ();/***************************************
* Auto rollback label
*
* Use case:
* of_AutoRollback()
* Insert into tab_1 ......
* If SQLCA.SQLCODE = 0 Then
* Else
*    Rollback;
* End if
***************************************/
end subroutine

public subroutine of_commitqueue ();/***************************************
* Queue end label
*
***************************************/

end subroutine

public subroutine of_imdcall ();/***************************************
* Immediately send call to server
*
* Use case:
* of_ImdCall()
* Select ...
***************************************/
end subroutine

public subroutine of_startqueue ();/***************************************
* Queue start label
*
***************************************/
of_startQueue(0)
end subroutine

public function integer of_update (powerobject obj_1, powerobject obj_2);RETURN of_update(0,obj_1,obj_2)
end function

public function integer of_update (powerobject obj_1, powerobject obj_2, powerobject obj_3);RETURN of_update(0,obj_1,obj_2,obj_3)
end function

public function integer of_update (powerobject obj_1, powerobject obj_2, powerobject obj_3, powerobject obj_4);RETURN of_update(0,obj_1,obj_2,obj_3,obj_4)
end function

public function integer of_update (powerobject obj);IF of_isvalid_dwo(obj) <> 1 THEN
	RETURN -1
END IF

IF obj.DYNAMIC Update() = 1 THEN
	RETURN 1
ELSE
	ROLLBACK;
	RETURN -1
END IF
end function

public function integer of_update (integer transactionflag, powerobject obj_1, powerobject obj_2);IF of_isvalid_dwo(obj_1) <> 1 OR of_isvalid_dwo(obj_2) <> 1 THEN
	RETURN -1
END IF

IF of_update(obj_1) = 1 THEN
    IF of_update(obj_2) = 1 THEN
       COMMIT;
	   RETURN 1
    ELSE
	    RETURN -102
    END IF
ELSE
	RETURN -101
END IF
end function

public function integer of_update (integer transactionflag, powerobject obj_1, powerobject obj_2, powerobject obj_3);IF of_isvalid_dwo(obj_1) <> 1 OR of_isvalid_dwo(obj_2) <> 1 OR of_isvalid_dwo(obj_3) <> 1 THEN
	RETURN -1
END IF

IF of_update(obj_1) = 1 THEN
	IF of_update(obj_2) = 1 THEN
		IF  of_update(obj_3) = 1 THEN
			COMMIT;
			RETURN 1
		ELSE
			RETURN -103
		END IF
	ELSE
	   RETURN -102
	END IF
ELSE
	RETURN -101
END IF
end function

public function integer of_update (integer transactionflag, powerobject obj_1, powerobject obj_2, powerobject obj_3, powerobject obj_4);IF of_isvalid_dwo(obj_1) <> 1 OR of_isvalid_dwo(obj_2) <> 1 OR of_isvalid_dwo(obj_3) <> 1 OR of_isvalid_dwo(obj_4) <> 1 THEN
	RETURN -1
END IF
IF of_update(obj_1) = 1 THEN
	IF of_update(obj_2) = 1 THEN 
		IF of_update(obj_3) = 1 THEN
			IF of_update(obj_4) = 1 THEN
				COMMIT;
				RETURN 1
		   	ELSE
				RETURN -104
			END IF
		ELSE
			RETURN -103
		END IF
	ELSE
	   RETURN -102
	END IF
ELSE
	RETURN -101
END IF
end function

public subroutine of_startqueue (integer stopmode);/***************************************
* Queue start label
*
***************************************/

end subroutine

public function integer of_isvalid_dwo (powerobject obj);IF  (TypeOF(obj) <> DataWindow! AND TypeOF(obj) <> DataStore! AND TypeOF(obj) <> DataWindowChild!) THEN
	RETURN -1
End IF
RETURN 1
end function

on appeon_nvo_db_update.create
call super::create
TriggerEvent( this, "constructor" )
end on

on appeon_nvo_db_update.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

