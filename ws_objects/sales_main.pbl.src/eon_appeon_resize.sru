$PBExportHeader$eon_appeon_resize.sru
forward
global type eon_appeon_resize from nonvisualobject
end type
end forward

global type eon_appeon_resize from nonvisualobject
end type
global eon_appeon_resize eon_appeon_resize

type variables
Public:
boolean  ib_init
boolean ib_zoom = false
boolean ib_fontresize = false
boolean ib_stopall = false
int  ii_borderwidth,ii_borderheight
int ii_fonttype = 1// 1,use height;2,use width;3, Use the min; 4, Use the max
int  ii_type = 1  //1, Use the rate of height to zoom datawindow; 2, Use the rate of width to zoom datawindow; 3, Use the min; 4, Use the max
decimal{3} idec_maxrate


Protected:
constant string  DRAGOBJECT = 'dragobject!'
constant string  LINE = 'line!'
constant string  OVAL = 'oval!'
constant string  RECTANGLE = 'rectangle!'
constant string  ROUNDRECTANGLE = 'roundrectangle!'
constant string  MDICLIENT = 'mdiclient!'



end variables

forward prototypes
public function string of_typeof (windowobject awo_control)
public function string of_gettag (windowobject awo)
public subroutine of_init (userobject au_uo, integer ai_width, integer ai_height, boolean ab_recursion)
public subroutine of_init (window aw_window, boolean ab_recursion)
public subroutine of_init_object (windowobject awo, integer ai_parentwidth, integer ai_parentheight, boolean ab_recursion)
public function boolean of_resizable (windowobject awo)
public subroutine of_stringtoarray (string as_input, ref string as_array[], string as_flag)
public subroutine of_stop (windowobject awo)
public subroutine of_start (windowobject awo)
public function boolean of_registered (windowobject awo)
public subroutine of_fontresize (boolean ab_resize, integer ai_type)
public subroutine of_zoom (boolean ab_zoom, integer ai_type)
public subroutine of_resize (userobject au_uo, integer ai_newwidth, integer ai_newheight, boolean ab_recursion)
public subroutine of_resize (window aw_window, integer ai_newwidth, integer ai_newheight, boolean ab_recursion)
public subroutine of_init (userobject au_uo, boolean ab_recursion)
public subroutine of_resize (datawindow adw, integer ai_newwidth, integer ai_newheight, decimal ad_maxrate)
public subroutine of_resize (datawindow adw, integer ai_newwidth, integer ai_newheight, boolean ab_zoom, integer ai_type, decimal ad_maxrate)
public subroutine of_getscale (string as_input, ref string as_flag, ref string as_xscale, ref string as_yscale, ref string as_wscale, ref string as_hscale)
public subroutine of_getscale (string as_input, ref string as_flag, ref string as_xscale, ref string as_yscale, ref string as_wscale, ref string as_hscale, ref string as_width, ref string as_height)
public subroutine of_getscale (string as_input, ref string as_flag, ref string as_xscale, ref string as_yscale, ref string as_wscale, ref string as_hscale, ref string as_width, ref string as_height, ref string as_fontsize)
public subroutine of_init_object (windowobject awo, decimal ad_xscale, decimal ad_yscale, decimal ad_wscale, decimal ad_hscale)
public subroutine of_pause ()
public subroutine of_recover ()
public subroutine of_zoom (boolean ab_zoom, integer ai_type, decimal adec_rate)
public function long of_orginterval_x (windowobject awo)
public function long of_orginterval_y (windowobject awo)
public function long of_orginterval_w (windowobject awo)
public function long of_orginterval_h (windowobject awo)
public subroutine of_setflag (windowobject awo, string as_flag)
public subroutine of_internal_resize (ref dragobject awo, string as_flag, integer ai_newwidth, integer ai_newheight, string as_xbl, string as_ybl, string as_wbl, string as_hbl)
public subroutine of_init_object (windowobject awo, boolean ab_recursion)
public subroutine of_refresh_object (dragobject ado)
end prototypes

public function string of_typeof (windowobject awo_control);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_TypeOf
//
//	Access:  		protected
//
//	Arguments:		
//	awo_control		The window object for which a type is needed.
//
//	Returns:  		string
//						Describes the type of the object.
//						'!' if an error occurs.
//
//	Description:  	Determines on the type of an object for the purposes of 
//						getting to its attributes.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Changed to use new constants.
// 7.0	Added new controls hprogressbar!, htrackbar!, vprogressbar!,
//			vtrackbar!, picturehyperlink!, statichyperlink!
//10 Added new controls monthcalendar!
//11 Added new datatype windowobject!,new controls  datepicker!
//////////////////////////////////////////////////////////////////////////////
//
// Copyright © 2017 Appeon Limited and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
//If IsNull(awo_control) or (not IsValid(awo_control)) Then
//	messagebox('','1')
//	Return '!'
//End If

//Validate and set typeof value
Choose Case awo_control.TypeOf()
	Case  checkbox!, commandbutton!, datawindow!, dropdownlistbox!, dropdownpicturelistbox!, &
			editmask!, graph!, groupbox!, hprogressbar!, hscrollbar!, htrackbar!, listbox!,  &
			listview!, multilineedit!, olecontrol!, olecustomcontrol!, omcontrol!, omcustomcontrol!,  &
			omembeddedcontrol!, picture!, picturebutton!, picturehyperlink!, picturelistbox!,  &
			radiobutton!, richtextedit!, singlelineedit!, statichyperlink!, statictext!,  &
			tab!, treeview!, userobject!, vprogressbar!, vscrollbar!, vtrackbar!, monthcalendar!, datepicker!, inkpicture!, inkedit!, animation!

		Return DRAGOBJECT
	Case  line!
		Return LINE
	Case  oval!
		Return OVAL
	Case  rectangle!
		Return RECTANGLE
	Case  roundrectangle!
		Return ROUNDRECTANGLE
	Case  mdiclient!
		Return MDICLIENT
End Choose

Return '!'
end function

public function string of_gettag (windowobject awo);string ls_tag
long ll_pos
ls_tag = awo.tag

ll_pos = pos(ls_tag,'/')

do while ll_pos > 0
	ls_tag = mid(ls_tag,ll_pos+1)
	ll_pos = pos(ls_tag,'/')
loop


return ls_tag
end function

public subroutine of_init (userobject au_uo, integer ai_width, integer ai_height, boolean ab_recursion);Integer li_controls,i
Long ll_width,ll_height
String ls_xscale,ls_yscale,ls_wscale,ls_hscale,ls_textsize,ls_width,ls_height,ls_parentw,ls_parenth,ls_x,ls_y
String ls_register,ls_resize,ls_flag
long ll_index
ls_register = '1'
ls_resize = '1'
ls_flag = '1111'
dragobject ldo_obj
windowobject lwo
userobject luo_tmp
datawindow ldw_obj
checkbox     lcbx_obj
radiobutton    lrb_obj
commandbutton lcb_obj
picturebutton lpb_obj
datepicker  ldp_obj
monthcalendar lmc_obj
treeview  ltv_obj
dropdownpicturelistbox  lddplb_obj
listbox  llb_obj
picturelistbox lplb_obj
listview llv_obj
dropdownlistbox lddlb_obj
groupbox lgb_obj
editmask lem_obj
multilineedit lmle_obj
singlelineedit lsle_obj
statichyperlink lshl_obj
statictext lst_obj
line         lln_obj
oval        lov_obj
rectangle   lrec_obj
roundrectangle  lrrec_obj
userobject   luo_obj
tab         lt_obj
mdiclient              lmdi_obj
if isnull(ai_width) or isnull(ai_height) or ai_width = 0 or ai_height = 0 then return
ll_width=ai_width
ll_height=ai_height
ls_parentw=string(ai_width)
ls_parenth=string(ai_height)
ib_init = true
li_controls=upperbound(au_uo.control[])
FOR i=1 TO li_controls
	lwo = au_uo.control[i]
	if of_registered(lwo) then continue
	CHOOSE CASE of_typeof(au_uo.control[i])
		CASE DRAGOBJECT
			ldo_obj=au_uo.control[i]
			ls_width = string(ldo_obj.width)
			ls_height = string(ldo_obj.height)
			ls_x = string(ldo_obj.x)
			ls_y = string(ldo_obj.y)
			CHOOSE CASE au_uo.control[i].typeof()
				CASE tab!
					lt_obj=ldo_obj
					ls_xscale=string(round(lt_obj.x/ll_width,3))
					ls_yscale=string(round(lt_obj.y/ll_height,3))
					ls_wscale=string(round(lt_obj.width/ll_width,3))
					ls_hscale=string(round(lt_obj.height/ll_height,3))
					ls_textsize = string(lt_obj.textsize)
					lt_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lt_obj.tag
					if ab_recursion then
						for ll_index = 1 to upperbound(lt_obj.control)
							luo_tmp = lt_obj.control[ll_index]
							of_init(luo_tmp,lt_obj.width,lt_obj.height,true)
						next
					end if
				CASE userobject!
					luo_obj=ldo_obj
					ls_xscale=string(round(luo_obj.x/ll_width,3))
					ls_yscale=string(round(luo_obj.y/ll_height,3))
					ls_wscale=string(round(luo_obj.width/ll_width,3))
					ls_hscale=string(round(luo_obj.height/ll_height,3))
					luo_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+luo_obj.tag
					luo_tmp =  luo_obj
					if ab_recursion then
						of_init(luo_tmp,luo_tmp.width,luo_tmp.height,true)
					end if
				CASE 	datawindow!
					ldw_obj =ldo_obj
					ls_xscale=string(round(ldw_obj.x/ll_width,3))
					ls_yscale=string(round(ldw_obj.y/ll_height,3))
					ls_wscale=string(round(ldw_obj.width/ll_width,3))
					ls_hscale=string(round(ldw_obj.height/ll_height,3))
					ldw_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+string(ldw_obj.width)+'/'+string(ldw_obj.height)+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ldw_obj.tag
				CASE checkbox!
					lcbx_obj = ldo_obj
					ls_xscale=string(round(lcbx_obj.x/ll_width,3))
					ls_yscale=string(round(lcbx_obj.y/ll_height,3))
					ls_wscale=string(round(lcbx_obj.width/ll_width,3))
					ls_hscale=string(round(lcbx_obj.height/ll_height,3))
					ls_width = string(lcbx_obj.width)
					ls_height = string(lcbx_obj.height)
					ls_textsize = string(lcbx_obj.textsize)
					lcbx_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lcbx_obj.tag
				CASE radiobutton!
					lrb_obj = ldo_obj
					ls_xscale=string(round(lrb_obj.x/ll_width,3))
					ls_yscale=string(round(lrb_obj.y/ll_height,3))
					ls_wscale=string(round(lrb_obj.width/ll_width,3))
					ls_hscale=string(round(lrb_obj.height/ll_height,3))
					ls_width = string(lrb_obj.width)
					ls_height = string(lrb_obj.height)
					ls_textsize = string(lrb_obj.textsize)
					lrb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lrb_obj.tag
				CASE commandbutton!
					lcb_obj = ldo_obj
					ls_xscale=string(round(lcb_obj.x/ll_width,3))
					ls_yscale=string(round(lcb_obj.y/ll_height,3))
					ls_wscale=string(round(lcb_obj.width/ll_width,3))
					ls_hscale=string(round(lcb_obj.height/ll_height,3))
					ls_width = string(lcb_obj.width)
					ls_height = string(lcb_obj.height)
					ls_textsize = string(lcb_obj.textsize)
					lcb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lcb_obj.tag
				CASE picturebutton!
					lpb_obj = ldo_obj
					ls_xscale=string(round(lpb_obj.x/ll_width,3))
					ls_yscale=string(round(lpb_obj.y/ll_height,3))
					ls_wscale=string(round(lpb_obj.width/ll_width,3))
					ls_hscale=string(round(lpb_obj.height/ll_height,3))
					ls_width = string(lpb_obj.width)
					ls_height = string(lpb_obj.height)
					ls_textsize = string(lpb_obj.textsize)
					lpb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lpb_obj.tag
				CASE datepicker!
					ldp_obj = ldo_obj
					ls_xscale=string(round(ldp_obj.x/ll_width,3))
					ls_yscale=string(round(ldp_obj.y/ll_height,3))
					ls_wscale=string(round(ldp_obj.width/ll_width,3))
					ls_hscale=string(round(ldp_obj.height/ll_height,3))
					ls_width = string(ldp_obj.width)
					ls_height = string(ldp_obj.height)
					ls_textsize = string(ldp_obj.textsize)
					ldp_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+ldp_obj.tag
				CASE monthcalendar!
					lmc_obj = ldo_obj
					ls_xscale=string(round(lmc_obj.x/ll_width,3))
					ls_yscale=string(round(lmc_obj.y/ll_height,3))
					ls_wscale=string(round(lmc_obj.width/ll_width,3))
					ls_hscale=string(round(lmc_obj.height/ll_height,3))
					ls_width = string(lmc_obj.width)
					ls_height = string(lmc_obj.height)
					ls_textsize = string(lmc_obj.textsize)
					lmc_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lmc_obj.tag
				CASE treeview!
					ltv_obj = ldo_obj
					ls_xscale=string(round(ltv_obj.x/ll_width,3))
					ls_yscale=string(round(ltv_obj.y/ll_height,3))
					ls_wscale=string(round(ltv_obj.width/ll_width,3))
					ls_hscale=string(round(ltv_obj.height/ll_height,3))
					ls_width = string(ltv_obj.width)
					ls_height = string(ltv_obj.height)
					ls_textsize = string(ltv_obj.textsize)
					ltv_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+ltv_obj.tag
				CASE dropdownpicturelistbox!
					lddplb_obj = ldo_obj
					ls_xscale=string(round(lddplb_obj.x/ll_width,3))
					ls_yscale=string(round(lddplb_obj.y/ll_height,3))
					ls_wscale=string(round(lddplb_obj.width/ll_width,3))
					ls_hscale=string(round(lddplb_obj.height/ll_height,3))
					ls_width = string(lddplb_obj.width)
					ls_height = string(lddplb_obj.height)
					ls_textsize = string(lddplb_obj.textsize)
					lddplb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lddplb_obj.tag
				CASE picturelistbox!
					lplb_obj = ldo_obj
					ls_xscale=string(round(lplb_obj.x/ll_width,3))
					ls_yscale=string(round(lplb_obj.y/ll_height,3))
					ls_wscale=string(round(lplb_obj.width/ll_width,3))
					ls_hscale=string(round(lplb_obj.height/ll_height,3))
					ls_width = string(lplb_obj.width)
					ls_height = string(lplb_obj.height)
					ls_textsize = string(lplb_obj.textsize)
					lplb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lplb_obj.tag
				CASE listview!
					llv_obj = ldo_obj
					ls_xscale=string(round(llv_obj.x/ll_width,3))
					ls_yscale=string(round(llv_obj.y/ll_height,3))
					ls_wscale=string(round(llv_obj.width/ll_width,3))
					ls_hscale=string(round(llv_obj.height/ll_height,3))
					ls_width = string(llv_obj.width)
					ls_height = string(llv_obj.height)
					ls_textsize = string(llv_obj.textsize)
					llv_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+llv_obj.tag
				CASE dropdownlistbox!
					lddlb_obj = ldo_obj
					ls_xscale=string(round(lddlb_obj.x/ll_width,3))
					ls_yscale=string(round(lddlb_obj.y/ll_height,3))
					ls_wscale=string(round(lddlb_obj.width/ll_width,3))
					ls_hscale=string(round(lddlb_obj.height/ll_height,3))
					ls_width = string(lddlb_obj.width)
					ls_height = string(lddlb_obj.height)
					ls_textsize = string(lddlb_obj.textsize)
					lddlb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lddlb_obj.tag
				CASE listbox!
					llb_obj = ldo_obj
					ls_xscale=string(round(llb_obj.x/ll_width,3))
					ls_yscale=string(round(llb_obj.y/ll_height,3))
					ls_wscale=string(round(llb_obj.width/ll_width,3))
					ls_hscale=string(round(llb_obj.height/ll_height,3))
					ls_width = string(llb_obj.width)
					ls_height = string(llb_obj.height)
					ls_textsize = string(llb_obj.textsize)
					llb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+llb_obj.tag
				CASE groupbox!
					lgb_obj = ldo_obj
					ls_xscale=string(round(lgb_obj.x/ll_width,3))
					ls_yscale=string(round(lgb_obj.y/ll_height,3))
					ls_wscale=string(round(lgb_obj.width/ll_width,3))
					ls_hscale=string(round(lgb_obj.height/ll_height,3))
					ls_width = string(lgb_obj.width)
					ls_height = string(lgb_obj.height)
					ls_textsize = string(lgb_obj.textsize)
					lgb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lgb_obj.tag
				CASE editmask!
					lem_obj = ldo_obj
					ls_xscale=string(round(lem_obj.x/ll_width,3))
					ls_yscale=string(round(lem_obj.y/ll_height,3))
					ls_wscale=string(round(lem_obj.width/ll_width,3))
					ls_hscale=string(round(lem_obj.height/ll_height,3))
					ls_width = string(lem_obj.width)
					ls_height = string(lem_obj.height)
					ls_textsize = string(lem_obj.textsize)
					lem_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lem_obj.tag
				CASE multilineedit!
					lmle_obj = ldo_obj
					ls_xscale=string(round(lmle_obj.x/ll_width,3))
					ls_yscale=string(round(lmle_obj.y/ll_height,3))
					ls_wscale=string(round(lmle_obj.width/ll_width,3))
					ls_hscale=string(round(lmle_obj.height/ll_height,3))
					ls_width = string(lmle_obj.width)
					ls_height = string(lmle_obj.height)
					ls_textsize = string(lmle_obj.textsize)
					lmle_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lmle_obj.tag
				CASE singlelineedit!
					lsle_obj = ldo_obj
					ls_xscale=string(round(lsle_obj.x/ll_width,3))
					ls_yscale=string(round(lsle_obj.y/ll_height,3))
					ls_wscale=string(round(lsle_obj.width/ll_width,3))
					ls_hscale=string(round(lsle_obj.height/ll_height,3))
					ls_width = string(lsle_obj.width)
					ls_height = string(lsle_obj.height)
					ls_textsize = string(lsle_obj.textsize)
					lsle_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lsle_obj.tag
				CASE statichyperlink!
					lshl_obj = ldo_obj
					ls_xscale=string(round(lshl_obj.x/ll_width,3))
					ls_yscale=string(round(lshl_obj.y/ll_height,3))
					ls_wscale=string(round(lshl_obj.width/ll_width,3))
					ls_hscale=string(round(lshl_obj.height/ll_height,3))
					ls_width = string(lshl_obj.width)
					ls_height = string(lshl_obj.height)
					ls_textsize = string(lshl_obj.textsize)
					lshl_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lshl_obj.tag
				CASE statictext!
					lst_obj = ldo_obj
					ls_xscale=string(round(lst_obj.x/ll_width,3))
					ls_yscale=string(round(lst_obj.y/ll_height,3))
					ls_wscale=string(round(lst_obj.width/ll_width,3))
					ls_hscale=string(round(lst_obj.height/ll_height,3))
					ls_width = string(lst_obj.width)
					ls_height = string(lst_obj.height)
					ls_textsize = string(lst_obj.textsize)
					lst_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lst_obj.tag
				CASE ELSE
					ls_xscale=string(round(ldo_obj.x/ll_width,3))
					ls_yscale=string(round(ldo_obj.y/ll_height,3))
					ls_wscale=string(round(ldo_obj.width/ll_width,3))
					ls_hscale=string(round(ldo_obj.height/ll_height,3))
					ldo_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+ldo_obj.tag
			END CHOOSE
		CASE LINE
			lln_obj=au_uo.control[i]
			ls_xscale=string(round(lln_obj.beginx/ll_width,3))
			ls_yscale=string(round(lln_obj.beginy/ll_height,3))
			ls_wscale=string(round(lln_obj.endx/ll_width,3))
			ls_hscale=string(round(lln_obj.endy/ll_height,3))
			ls_x = string(lln_obj.beginx)
			ls_y = string(lln_obj.beginy)
			ls_width = string(lln_obj.endx)
			ls_height = string(lln_obj.endy)
			lln_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lln_obj.tag
		CASE OVAL
			lov_obj = au_uo.control[i]
			ls_xscale=string(round(lov_obj.x/ll_width,3))
			ls_yscale=string(round(lov_obj.y/ll_height,3))
			ls_wscale=string(round(lov_obj.width/ll_width,3))
			ls_hscale=string(round(lov_obj.height/ll_height,3))
			ls_x = string(lov_obj.x)
			ls_y = string(lov_obj.y)
			ls_width = string(lov_obj.width)
			ls_height = string(lov_obj.height)
			lov_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lov_obj.tag
		CASE RECTANGLE
			lrec_obj = au_uo.control[i]
			ls_xscale=string(round(lrec_obj.x/ll_width,3))
			ls_yscale=string(round(lrec_obj.y/ll_height,3))
			ls_wscale=string(round(lrec_obj.width/ll_width,3))
			ls_hscale=string(round(lrec_obj.height/ll_height,3))
			ls_x = string(lrec_obj.x)
			ls_y = string(lrec_obj.y)
			ls_width = string(lrec_obj.width)
			ls_height = string(lrec_obj.height)
			lrec_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lrec_obj.tag
		CASE ROUNDRECTANGLE
			lrrec_obj = au_uo.control[i]
			ls_xscale=string(round(lrrec_obj.x/ll_width,3))
			ls_yscale=string(round(lrrec_obj.y/ll_height,3))
			ls_wscale=string(round(lrrec_obj.width/ll_width,3))
			ls_hscale=string(round(lrrec_obj.height/ll_height,3))
			ls_x = string(lrrec_obj.x)
			ls_y = string(lrrec_obj.y)
			ls_width = string(lrrec_obj.width)
			ls_height = string(lrrec_obj.height)
			lrrec_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lrrec_obj.tag
		CASE MDICLIENT
			lmdi_obj = au_uo.control[i]
			ls_xscale=string(round(lmdi_obj.x/ll_width,3))
			ls_yscale=string(round(lmdi_obj.y/ll_height,3))
			ls_wscale=string(round(lmdi_obj.width/ll_width,3))
			ls_hscale=string(round(lmdi_obj.height/ll_height,3))
			ls_x = string(lmdi_obj.x)
			ls_y = string(lmdi_obj.y)
			ls_width = string(lmdi_obj.width)
			ls_height = string(lmdi_obj.height)
			lmdi_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lmdi_obj.tag
	END CHOOSE
NEXT

end subroutine

public subroutine of_init (window aw_window, boolean ab_recursion);//
Integer li_controls,i
Long ll_width,ll_height
String ls_xscale,ls_yscale,ls_wscale,ls_hscale,ls_textsize,ls_width,ls_height
string ls_register,ls_resize,ls_flag
string ls_x,ls_y,ls_parentw,ls_parenth
ls_register = '1'
ls_resize = '1'
ls_flag = "1111"
long ll_index
windowobject lwo
dragobject ldo_obj
userobject luo_tmp
datawindow  ldw_obj
checkbox     lcbx_obj
radiobutton    lrb_obj
commandbutton lcb_obj
picturebutton lpb_obj
datepicker  ldp_obj
monthcalendar lmc_obj
treeview  ltv_obj
dropdownpicturelistbox  lddplb_obj
listbox  llb_obj
picturelistbox lplb_obj
listview llv_obj
dropdownlistbox lddlb_obj
groupbox lgb_obj
editmask lem_obj
multilineedit lmle_obj
singlelineedit lsle_obj
statichyperlink lshl_obj
statictext lst_obj
line         lln_obj
oval        lov_obj
rectangle   lrec_obj
roundrectangle  lrrec_obj
userobject   luo_obj
tab         lt_obj
mdiclient              lmdi_obj
//ll_width=aw_window.width 
//ll_height=aw_window.height
ii_borderwidth = aw_window.width - aw_window.workspacewidth()
ii_borderheight = aw_window.height - aw_window.workspaceheight()
ll_width=aw_window.workspacewidth()
ll_height=aw_window.workspaceheight()
ls_parentw = string(ll_width)
ls_parenth = string(ll_height)
ib_init = true
li_controls=upperbound(aw_window.control[])

FOR i=1 TO li_controls
	lwo = aw_window.control[i]
	if of_registered(lwo) then continue
	CHOOSE CASE of_typeof(aw_window.control[i])
		CASE DRAGOBJECT
			ldo_obj=aw_window.control[i]
			ls_width = string(ldo_obj.width)
			ls_height = string(ldo_obj.height)
			ls_x = string(ldo_obj.x)
			ls_y = string(ldo_obj.y)
			CHOOSE CASE aw_window.control[i].typeof()
				CASE tab!
					lt_obj=ldo_obj
					ls_xscale=string(round(lt_obj.x/ll_width,3))
					ls_yscale=string(round(lt_obj.y/ll_height,3))
					ls_wscale=string(round(lt_obj.width/ll_width,3))
					ls_hscale=string(round(lt_obj.height/ll_height,3))
					ls_textsize = string(lt_obj.textsize)
					lt_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lt_obj.tag
					if ab_recursion then
						for ll_index = 1 to upperbound(lt_obj.control)
							luo_tmp = lt_obj.control[ll_index]
							of_init(luo_tmp,lt_obj.width,lt_obj.height,true)
						next
					end if
				CASE userobject!
					luo_obj=ldo_obj
					ls_xscale=string(round(luo_obj.x/ll_width,3))
					ls_yscale=string(round(luo_obj.y/ll_height,3))
					ls_wscale=string(round(luo_obj.width/ll_width,3))
					ls_hscale=string(round(luo_obj.height/ll_height,3))
					luo_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+luo_obj.tag
					luo_tmp =  luo_obj
					if ab_recursion then
						of_init(luo_tmp,luo_tmp.width,luo_tmp.height,true)
					end if
				CASE 	datawindow!
					ldw_obj =ldo_obj
					ls_xscale=string(round(ldw_obj.x/ll_width,3))
					ls_yscale=string(round(ldw_obj.y/ll_height,3))
					ls_wscale=string(round(ldw_obj.width/ll_width,3))
					ls_hscale=string(round(ldw_obj.height/ll_height,3))
					ldw_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+string(ldw_obj.width)+'/'+string(ldw_obj.height)+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ldw_obj.tag
				CASE checkbox!
					lcbx_obj = ldo_obj
					ls_xscale=string(round(lcbx_obj.x/ll_width,3))
					ls_yscale=string(round(lcbx_obj.y/ll_height,3))
					ls_wscale=string(round(lcbx_obj.width/ll_width,3))
					ls_hscale=string(round(lcbx_obj.height/ll_height,3))
					ls_width = string(lcbx_obj.width)
					ls_height = string(lcbx_obj.height)
					ls_textsize = string(lcbx_obj.textsize)
					lcbx_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lcbx_obj.tag
				CASE radiobutton!
					lrb_obj = ldo_obj
					ls_xscale=string(round(lrb_obj.x/ll_width,3))
					ls_yscale=string(round(lrb_obj.y/ll_height,3))
					ls_wscale=string(round(lrb_obj.width/ll_width,3))
					ls_hscale=string(round(lrb_obj.height/ll_height,3))
					ls_width = string(lrb_obj.width)
					ls_height = string(lrb_obj.height)
					ls_textsize = string(lrb_obj.textsize)
					lrb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lrb_obj.tag
				CASE commandbutton!
					lcb_obj = ldo_obj
					ls_xscale=string(round(lcb_obj.x/ll_width,3))
					ls_yscale=string(round(lcb_obj.y/ll_height,3))
					ls_wscale=string(round(lcb_obj.width/ll_width,3))
					ls_hscale=string(round(lcb_obj.height/ll_height,3))
					ls_width = string(lcb_obj.width)
					ls_height = string(lcb_obj.height)
					ls_textsize = string(lcb_obj.textsize)
					lcb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lcb_obj.tag
				CASE picturebutton!
					lpb_obj = ldo_obj
					ls_xscale=string(round(lpb_obj.x/ll_width,3))
					ls_yscale=string(round(lpb_obj.y/ll_height,3))
					ls_wscale=string(round(lpb_obj.width/ll_width,3))
					ls_hscale=string(round(lpb_obj.height/ll_height,3))
					ls_width = string(lpb_obj.width)
					ls_height = string(lpb_obj.height)
					ls_textsize = string(lpb_obj.textsize)
					lpb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lpb_obj.tag
				CASE datepicker!
					ldp_obj = ldo_obj
					ls_xscale=string(round(ldp_obj.x/ll_width,3))
					ls_yscale=string(round(ldp_obj.y/ll_height,3))
					ls_wscale=string(round(ldp_obj.width/ll_width,3))
					ls_hscale=string(round(ldp_obj.height/ll_height,3))
					ls_width = string(ldp_obj.width)
					ls_height = string(ldp_obj.height)
					ls_textsize = string(ldp_obj.textsize)
					ldp_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+ldp_obj.tag
				CASE monthcalendar!
					lmc_obj = ldo_obj
					ls_xscale=string(round(lmc_obj.x/ll_width,3))
					ls_yscale=string(round(lmc_obj.y/ll_height,3))
					ls_wscale=string(round(lmc_obj.width/ll_width,3))
					ls_hscale=string(round(lmc_obj.height/ll_height,3))
					ls_width = string(lmc_obj.width)
					ls_height = string(lmc_obj.height)
					ls_textsize = string(lmc_obj.textsize)
					lmc_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lmc_obj.tag
				CASE treeview!
					ltv_obj = ldo_obj
					ls_xscale=string(round(ltv_obj.x/ll_width,3))
					ls_yscale=string(round(ltv_obj.y/ll_height,3))
					ls_wscale=string(round(ltv_obj.width/ll_width,3))
					ls_hscale=string(round(ltv_obj.height/ll_height,3))
					ls_width = string(ltv_obj.width)
					ls_height = string(ltv_obj.height)
					ls_textsize = string(ltv_obj.textsize)
					ltv_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+ltv_obj.tag
				CASE dropdownpicturelistbox!
					lddplb_obj = ldo_obj
					ls_xscale=string(round(lddplb_obj.x/ll_width,3))
					ls_yscale=string(round(lddplb_obj.y/ll_height,3))
					ls_wscale=string(round(lddplb_obj.width/ll_width,3))
					ls_hscale=string(round(lddplb_obj.height/ll_height,3))
					ls_width = string(lddplb_obj.width)
					ls_height = string(lddplb_obj.height)
					ls_textsize = string(lddplb_obj.textsize)
					lddplb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lddplb_obj.tag
				CASE picturelistbox!
					lplb_obj = ldo_obj
					ls_xscale=string(round(lplb_obj.x/ll_width,3))
					ls_yscale=string(round(lplb_obj.y/ll_height,3))
					ls_wscale=string(round(lplb_obj.width/ll_width,3))
					ls_hscale=string(round(lplb_obj.height/ll_height,3))
					ls_width = string(lplb_obj.width)
					ls_height = string(lplb_obj.height)
					ls_textsize = string(lplb_obj.textsize)
					lplb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lplb_obj.tag
				CASE listview!
					llv_obj = ldo_obj
					ls_xscale=string(round(llv_obj.x/ll_width,3))
					ls_yscale=string(round(llv_obj.y/ll_height,3))
					ls_wscale=string(round(llv_obj.width/ll_width,3))
					ls_hscale=string(round(llv_obj.height/ll_height,3))
					ls_width = string(llv_obj.width)
					ls_height = string(llv_obj.height)
					ls_textsize = string(llv_obj.textsize)
					llv_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+llv_obj.tag
				CASE dropdownlistbox!
					lddlb_obj = ldo_obj
					ls_xscale=string(round(lddlb_obj.x/ll_width,3))
					ls_yscale=string(round(lddlb_obj.y/ll_height,3))
					ls_wscale=string(round(lddlb_obj.width/ll_width,3))
					ls_hscale=string(round(lddlb_obj.height/ll_height,3))
					ls_width = string(lddlb_obj.width)
					ls_height = string(lddlb_obj.height)
					ls_textsize = string(lddlb_obj.textsize)
					lddlb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lddlb_obj.tag
				CASE listbox!
					llb_obj = ldo_obj
					ls_xscale=string(round(llb_obj.x/ll_width,3))
					ls_yscale=string(round(llb_obj.y/ll_height,3))
					ls_wscale=string(round(llb_obj.width/ll_width,3))
					ls_hscale=string(round(llb_obj.height/ll_height,3))
					ls_width = string(llb_obj.width)
					ls_height = string(llb_obj.height)
					ls_textsize = string(llb_obj.textsize)
					llb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+llb_obj.tag
				CASE groupbox!
					lgb_obj = ldo_obj
					ls_xscale=string(round(lgb_obj.x/ll_width,3))
					ls_yscale=string(round(lgb_obj.y/ll_height,3))
					ls_wscale=string(round(lgb_obj.width/ll_width,3))
					ls_hscale=string(round(lgb_obj.height/ll_height,3))
					ls_width = string(lgb_obj.width)
					ls_height = string(lgb_obj.height)
					ls_textsize = string(lgb_obj.textsize)
					lgb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lgb_obj.tag
				CASE editmask!
					lem_obj = ldo_obj
					ls_xscale=string(round(lem_obj.x/ll_width,3))
					ls_yscale=string(round(lem_obj.y/ll_height,3))
					ls_wscale=string(round(lem_obj.width/ll_width,3))
					ls_hscale=string(round(lem_obj.height/ll_height,3))
					ls_width = string(lem_obj.width)
					ls_height = string(lem_obj.height)
					ls_textsize = string(lem_obj.textsize)
					lem_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lem_obj.tag
				CASE multilineedit!
					lmle_obj = ldo_obj
					ls_xscale=string(round(lmle_obj.x/ll_width,3))
					ls_yscale=string(round(lmle_obj.y/ll_height,3))
					ls_wscale=string(round(lmle_obj.width/ll_width,3))
					ls_hscale=string(round(lmle_obj.height/ll_height,3))
					ls_width = string(lmle_obj.width)
					ls_height = string(lmle_obj.height)
					ls_textsize = string(lmle_obj.textsize)
					lmle_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lmle_obj.tag
				CASE singlelineedit!
					lsle_obj = ldo_obj
					ls_xscale=string(round(lsle_obj.x/ll_width,3))
					ls_yscale=string(round(lsle_obj.y/ll_height,3))
					ls_wscale=string(round(lsle_obj.width/ll_width,3))
					ls_hscale=string(round(lsle_obj.height/ll_height,3))
					ls_width = string(lsle_obj.width)
					ls_height = string(lsle_obj.height)
					ls_textsize = string(lsle_obj.textsize)
					lsle_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lsle_obj.tag
				CASE statichyperlink!
					lshl_obj = ldo_obj
					ls_xscale=string(round(lshl_obj.x/ll_width,3))
					ls_yscale=string(round(lshl_obj.y/ll_height,3))
					ls_wscale=string(round(lshl_obj.width/ll_width,3))
					ls_hscale=string(round(lshl_obj.height/ll_height,3))
					ls_width = string(lshl_obj.width)
					ls_height = string(lshl_obj.height)
					ls_textsize = string(lshl_obj.textsize)
					lshl_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lshl_obj.tag
				CASE statictext!
					lst_obj = ldo_obj
					ls_xscale=string(round(lst_obj.x/ll_width,3))
					ls_yscale=string(round(lst_obj.y/ll_height,3))
					ls_wscale=string(round(lst_obj.width/ll_width,3))
					ls_hscale=string(round(lst_obj.height/ll_height,3))
					ls_width = string(lst_obj.width)
					ls_height = string(lst_obj.height)
					ls_textsize = string(lst_obj.textsize)
					lst_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lst_obj.tag
				CASE ELSE
					ls_xscale=string(round(ldo_obj.x/ll_width,3))
					ls_yscale=string(round(ldo_obj.y/ll_height,3))
					ls_wscale=string(round(ldo_obj.width/ll_width,3))
					ls_hscale=string(round(ldo_obj.height/ll_height,3))
					ldo_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+ldo_obj.tag
			END CHOOSE
		CASE LINE
			lln_obj=aw_window.control[i]
			ls_xscale=string(round(lln_obj.beginx/ll_width,3))
			ls_yscale=string(round(lln_obj.beginy/ll_height,3))
			ls_wscale=string(round(lln_obj.endx/ll_width,3))
			ls_hscale=string(round(lln_obj.endy/ll_height,3))
			ls_x = string(lln_obj.beginx)
			ls_y = string(lln_obj.beginy)
			ls_width = string(lln_obj.endx)
			ls_height = string(lln_obj.endy)
			lln_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lln_obj.tag
		CASE OVAL
			lov_obj = aw_window.control[i]
			ls_xscale=string(round(lov_obj.x/ll_width,3))
			ls_yscale=string(round(lov_obj.y/ll_height,3))
			ls_wscale=string(round(lov_obj.width/ll_width,3))
			ls_hscale=string(round(lov_obj.height/ll_height,3))
			ls_x = string(lov_obj.x)
			ls_y = string(lov_obj.y)
			ls_width = string(lov_obj.width)
			ls_height = string(lov_obj.height)
			lov_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lov_obj.tag
		CASE RECTANGLE
			lrec_obj = aw_window.control[i]
			ls_xscale=string(round(lrec_obj.x/ll_width,3))
			ls_yscale=string(round(lrec_obj.y/ll_height,3))
			ls_wscale=string(round(lrec_obj.width/ll_width,3))
			ls_hscale=string(round(lrec_obj.height/ll_height,3))
			ls_x = string(lrec_obj.x)
			ls_y = string(lrec_obj.y)
			ls_width = string(lrec_obj.width)
			ls_height = string(lrec_obj.height)
			lrec_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lrec_obj.tag
		CASE ROUNDRECTANGLE
			lrrec_obj = aw_window.control[i]
			ls_xscale=string(round(lrrec_obj.x/ll_width,3))
			ls_yscale=string(round(lrrec_obj.y/ll_height,3))
			ls_wscale=string(round(lrrec_obj.width/ll_width,3))
			ls_hscale=string(round(lrrec_obj.height/ll_height,3))
			ls_x = string(lrrec_obj.x)
			ls_y = string(lrrec_obj.y)
			ls_width = string(lrrec_obj.width)
			ls_height = string(lrrec_obj.height)
			lrrec_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lrrec_obj.tag
		CASE MDICLIENT
			lmdi_obj = aw_window.control[i]
			ls_xscale=string(round(lmdi_obj.x/ll_width,3))
			ls_yscale=string(round(lmdi_obj.y/ll_height,3))
			ls_wscale=string(round(lmdi_obj.width/ll_width,3))
			ls_hscale=string(round(lmdi_obj.height/ll_height,3))
			ls_x = string(lmdi_obj.x)
			ls_y = string(lmdi_obj.y)
			ls_width = string(lmdi_obj.width)
			ls_height = string(lmdi_obj.height)
			lmdi_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lmdi_obj.tag
	END CHOOSE
NEXT



end subroutine

public subroutine of_init_object (windowobject awo, integer ai_parentwidth, integer ai_parentheight, boolean ab_recursion);
Long ll_width,ll_height
String ls_xscale,ls_yscale,ls_wscale,ls_hscale,ls_textsize,ls_width,ls_height
string ls_register,ls_resize,ls_flag,ls_array[]
string ls_x,ls_y,ls_parentw,ls_parenth
ls_register = '1'
ls_resize = '1'
ls_flag = '1111'
long ll_index
if isnull(ai_parentwidth) or isnull(ai_parentheight) or ai_parentwidth = 0 or ai_parentheight = 0 then return
dragobject ldo_obj
userobject luo_tmp
datawindow  ldw_obj
checkbox     lcbx_obj
radiobutton    lrb_obj
commandbutton lcb_obj
picturebutton lpb_obj
datepicker  ldp_obj
monthcalendar lmc_obj
treeview  ltv_obj
dropdownpicturelistbox  lddplb_obj
listbox  llb_obj
picturelistbox lplb_obj
listview llv_obj
dropdownlistbox lddlb_obj
groupbox lgb_obj
editmask lem_obj
multilineedit lmle_obj
singlelineedit lsle_obj
statichyperlink lshl_obj
statictext lst_obj
line         lln_obj
oval        lov_obj
rectangle   lrec_obj
roundrectangle  lrrec_obj
userobject   luo_obj
tab         lt_obj
mdiclient              lmdi_obj
window  lw_1
ll_width=ai_parentwidth
ll_height=ai_parentheight
ib_init = true
ls_parentw = string(ai_parentwidth)
ls_parenth = string(ai_parentheight)
if of_registered(awo) then
	of_stringtoarray(awo.tag,ls_array,'/')
	ls_resize = ls_array[2]
	ls_flag = ls_array[3]
	ls_parentw = ls_array[12]
	ls_parenth = ls_array[13]
	awo.tag = of_gettag(awo)
end if
	CHOOSE CASE of_typeof(awo)
		CASE DRAGOBJECT
			ldo_obj=awo
			ls_width = string(ldo_obj.width)
			ls_height = string(ldo_obj.height)
			ls_x = string(ldo_obj.x)
			ls_y = string(ldo_obj.y)
			CHOOSE CASE awo.typeof()
				CASE tab!
					lt_obj=ldo_obj
					ls_xscale=string(round(lt_obj.x/ll_width,3))
					ls_yscale=string(round(lt_obj.y/ll_height,3))
					ls_wscale=string(round(lt_obj.width/ll_width,3))
					ls_hscale=string(round(lt_obj.height/ll_height,3))
					ls_textsize = string(lt_obj.textsize)
					lt_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lt_obj.tag
					if ab_recursion then
						for ll_index = 1 to upperbound(lt_obj.control)
							luo_tmp = lt_obj.control[ll_index]
							of_init(luo_tmp,lt_obj.width,lt_obj.height,true)
						next
					end if
				CASE userobject!
					luo_obj=ldo_obj
					ls_xscale=string(round(luo_obj.x/ll_width,3))
					ls_yscale=string(round(luo_obj.y/ll_height,3))
					ls_wscale=string(round(luo_obj.width/ll_width,3))
					ls_hscale=string(round(luo_obj.height/ll_height,3))
					luo_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+luo_obj.tag
					luo_tmp =  luo_obj
					if ab_recursion then
						of_init(luo_tmp,luo_tmp.width,luo_tmp.height,true)
					end if
				CASE 	datawindow!
					ldw_obj =ldo_obj
					ls_xscale=string(round(ldw_obj.x/ll_width,3))
					ls_yscale=string(round(ldw_obj.y/ll_height,3))
					ls_wscale=string(round(ldw_obj.width/ll_width,3))
					ls_hscale=string(round(ldw_obj.height/ll_height,3))
					ldw_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+string(ldw_obj.width)+'/'+string(ldw_obj.height)+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ldw_obj.tag
				CASE checkbox!
					lcbx_obj = ldo_obj
					ls_xscale=string(round(lcbx_obj.x/ll_width,3))
					ls_yscale=string(round(lcbx_obj.y/ll_height,3))
					ls_wscale=string(round(lcbx_obj.width/ll_width,3))
					ls_hscale=string(round(lcbx_obj.height/ll_height,3))
					ls_width = string(lcbx_obj.width)
					ls_height = string(lcbx_obj.height)
					ls_textsize = string(lcbx_obj.textsize)
					lcbx_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lcbx_obj.tag
				CASE radiobutton!
					lrb_obj = ldo_obj
					ls_xscale=string(round(lrb_obj.x/ll_width,3))
					ls_yscale=string(round(lrb_obj.y/ll_height,3))
					ls_wscale=string(round(lrb_obj.width/ll_width,3))
					ls_hscale=string(round(lrb_obj.height/ll_height,3))
					ls_width = string(lrb_obj.width)
					ls_height = string(lrb_obj.height)
					ls_textsize = string(lrb_obj.textsize)
					lrb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lrb_obj.tag
				CASE commandbutton!
					lcb_obj = ldo_obj
					ls_xscale=string(round(lcb_obj.x/ll_width,3))
					ls_yscale=string(round(lcb_obj.y/ll_height,3))
					ls_wscale=string(round(lcb_obj.width/ll_width,3))
					ls_hscale=string(round(lcb_obj.height/ll_height,3))
					ls_width = string(lcb_obj.width)
					ls_height = string(lcb_obj.height)
					ls_textsize = string(lcb_obj.textsize)
					lcb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lcb_obj.tag
				CASE picturebutton!
					lpb_obj = ldo_obj
					ls_xscale=string(round(lpb_obj.x/ll_width,3))
					ls_yscale=string(round(lpb_obj.y/ll_height,3))
					ls_wscale=string(round(lpb_obj.width/ll_width,3))
					ls_hscale=string(round(lpb_obj.height/ll_height,3))
					ls_width = string(lpb_obj.width)
					ls_height = string(lpb_obj.height)
					ls_textsize = string(lpb_obj.textsize)
					lpb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lpb_obj.tag
				CASE datepicker!
					ldp_obj = ldo_obj
					ls_xscale=string(round(ldp_obj.x/ll_width,3))
					ls_yscale=string(round(ldp_obj.y/ll_height,3))
					ls_wscale=string(round(ldp_obj.width/ll_width,3))
					ls_hscale=string(round(ldp_obj.height/ll_height,3))
					ls_width = string(ldp_obj.width)
					ls_height = string(ldp_obj.height)
					ls_textsize = string(ldp_obj.textsize)
					ldp_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+ldp_obj.tag
				CASE monthcalendar!
					lmc_obj = ldo_obj
					ls_xscale=string(round(lmc_obj.x/ll_width,3))
					ls_yscale=string(round(lmc_obj.y/ll_height,3))
					ls_wscale=string(round(lmc_obj.width/ll_width,3))
					ls_hscale=string(round(lmc_obj.height/ll_height,3))
					ls_width = string(lmc_obj.width)
					ls_height = string(lmc_obj.height)
					ls_textsize = string(lmc_obj.textsize)
					lmc_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lmc_obj.tag
				CASE treeview!
					ltv_obj = ldo_obj
					ls_xscale=string(round(ltv_obj.x/ll_width,3))
					ls_yscale=string(round(ltv_obj.y/ll_height,3))
					ls_wscale=string(round(ltv_obj.width/ll_width,3))
					ls_hscale=string(round(ltv_obj.height/ll_height,3))
					ls_width = string(ltv_obj.width)
					ls_height = string(ltv_obj.height)
					ls_textsize = string(ltv_obj.textsize)
					ltv_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+ltv_obj.tag
				CASE dropdownpicturelistbox!
					lddplb_obj = ldo_obj
					ls_xscale=string(round(lddplb_obj.x/ll_width,3))
					ls_yscale=string(round(lddplb_obj.y/ll_height,3))
					ls_wscale=string(round(lddplb_obj.width/ll_width,3))
					ls_hscale=string(round(lddplb_obj.height/ll_height,3))
					ls_width = string(lddplb_obj.width)
					ls_height = string(lddplb_obj.height)
					ls_textsize = string(lddplb_obj.textsize)
					lddplb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lddplb_obj.tag
				CASE picturelistbox!
					lplb_obj = ldo_obj
					ls_xscale=string(round(lplb_obj.x/ll_width,3))
					ls_yscale=string(round(lplb_obj.y/ll_height,3))
					ls_wscale=string(round(lplb_obj.width/ll_width,3))
					ls_hscale=string(round(lplb_obj.height/ll_height,3))
					ls_width = string(lplb_obj.width)
					ls_height = string(lplb_obj.height)
					ls_textsize = string(lplb_obj.textsize)
					lplb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lplb_obj.tag
				CASE listview!
					llv_obj = ldo_obj
					ls_xscale=string(round(llv_obj.x/ll_width,3))
					ls_yscale=string(round(llv_obj.y/ll_height,3))
					ls_wscale=string(round(llv_obj.width/ll_width,3))
					ls_hscale=string(round(llv_obj.height/ll_height,3))
					ls_width = string(llv_obj.width)
					ls_height = string(llv_obj.height)
					ls_textsize = string(llv_obj.textsize)
					llv_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+llv_obj.tag
				CASE dropdownlistbox!
					lddlb_obj = ldo_obj
					ls_xscale=string(round(lddlb_obj.x/ll_width,3))
					ls_yscale=string(round(lddlb_obj.y/ll_height,3))
					ls_wscale=string(round(lddlb_obj.width/ll_width,3))
					ls_hscale=string(round(lddlb_obj.height/ll_height,3))
					ls_width = string(lddlb_obj.width)
					ls_height = string(lddlb_obj.height)
					ls_textsize = string(lddlb_obj.textsize)
					lddlb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lddlb_obj.tag
				CASE listbox!
					llb_obj = ldo_obj
					ls_xscale=string(round(llb_obj.x/ll_width,3))
					ls_yscale=string(round(llb_obj.y/ll_height,3))
					ls_wscale=string(round(llb_obj.width/ll_width,3))
					ls_hscale=string(round(llb_obj.height/ll_height,3))
					ls_width = string(llb_obj.width)
					ls_height = string(llb_obj.height)
					ls_textsize = string(llb_obj.textsize)
					llb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+llb_obj.tag
				CASE groupbox!
					lgb_obj = ldo_obj
					ls_xscale=string(round(lgb_obj.x/ll_width,3))
					ls_yscale=string(round(lgb_obj.y/ll_height,3))
					ls_wscale=string(round(lgb_obj.width/ll_width,3))
					ls_hscale=string(round(lgb_obj.height/ll_height,3))
					ls_width = string(lgb_obj.width)
					ls_height = string(lgb_obj.height)
					ls_textsize = string(lgb_obj.textsize)
					lgb_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lgb_obj.tag
				CASE editmask!
					lem_obj = ldo_obj
					ls_xscale=string(round(lem_obj.x/ll_width,3))
					ls_yscale=string(round(lem_obj.y/ll_height,3))
					ls_wscale=string(round(lem_obj.width/ll_width,3))
					ls_hscale=string(round(lem_obj.height/ll_height,3))
					ls_width = string(lem_obj.width)
					ls_height = string(lem_obj.height)
					ls_textsize = string(lem_obj.textsize)
					lem_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lem_obj.tag
				CASE multilineedit!
					lmle_obj = ldo_obj
					ls_xscale=string(round(lmle_obj.x/ll_width,3))
					ls_yscale=string(round(lmle_obj.y/ll_height,3))
					ls_wscale=string(round(lmle_obj.width/ll_width,3))
					ls_hscale=string(round(lmle_obj.height/ll_height,3))
					ls_width = string(lmle_obj.width)
					ls_height = string(lmle_obj.height)
					ls_textsize = string(lmle_obj.textsize)
					lmle_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lmle_obj.tag
				CASE singlelineedit!
					lsle_obj = ldo_obj
					ls_xscale=string(round(lsle_obj.x/ll_width,3))
					ls_yscale=string(round(lsle_obj.y/ll_height,3))
					ls_wscale=string(round(lsle_obj.width/ll_width,3))
					ls_hscale=string(round(lsle_obj.height/ll_height,3))
					ls_width = string(lsle_obj.width)
					ls_height = string(lsle_obj.height)
					ls_textsize = string(lsle_obj.textsize)
					lsle_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lsle_obj.tag
				CASE statichyperlink!
					lshl_obj = ldo_obj
					ls_xscale=string(round(lshl_obj.x/ll_width,3))
					ls_yscale=string(round(lshl_obj.y/ll_height,3))
					ls_wscale=string(round(lshl_obj.width/ll_width,3))
					ls_hscale=string(round(lshl_obj.height/ll_height,3))
					ls_width = string(lshl_obj.width)
					ls_height = string(lshl_obj.height)
					ls_textsize = string(lshl_obj.textsize)
					lshl_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lshl_obj.tag
				CASE statictext!
					lst_obj = ldo_obj
					ls_xscale=string(round(lst_obj.x/ll_width,3))
					ls_yscale=string(round(lst_obj.y/ll_height,3))
					ls_wscale=string(round(lst_obj.width/ll_width,3))
					ls_hscale=string(round(lst_obj.height/ll_height,3))
					ls_width = string(lst_obj.width)
					ls_height = string(lst_obj.height)
					ls_textsize = string(lst_obj.textsize)
					lst_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lst_obj.tag
				CASE ELSE
					ls_xscale=string(round(ldo_obj.x/ll_width,3))
					ls_yscale=string(round(ldo_obj.y/ll_height,3))
					ls_wscale=string(round(ldo_obj.width/ll_width,3))
					ls_hscale=string(round(ldo_obj.height/ll_height,3))
					ldo_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+ldo_obj.tag
			END CHOOSE
		CASE LINE
			lln_obj=awo
			ls_xscale=string(round(lln_obj.beginx/ll_width,3))
			ls_yscale=string(round(lln_obj.beginy/ll_height,3))
			ls_wscale=string(round(lln_obj.endx/ll_width,3))
			ls_hscale=string(round(lln_obj.endy/ll_height,3))
			ls_x = string(lln_obj.beginx)
			ls_y = string(lln_obj.beginy)
			ls_width = string(lln_obj.endx)
			ls_height = string(lln_obj.endy)
			lln_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lln_obj.tag
		CASE OVAL
			lov_obj = awo
			ls_xscale=string(round(lov_obj.x/ll_width,3))
			ls_yscale=string(round(lov_obj.y/ll_height,3))
			ls_wscale=string(round(lov_obj.width/ll_width,3))
			ls_hscale=string(round(lov_obj.height/ll_height,3))
			ls_x = string(lov_obj.x)
			ls_y = string(lov_obj.y)
			ls_width = string(lov_obj.width)
			ls_height = string(lov_obj.height)
			lov_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lov_obj.tag
		CASE RECTANGLE
			lrec_obj = awo
			ls_xscale=string(round(lrec_obj.x/ll_width,3))
			ls_yscale=string(round(lrec_obj.y/ll_height,3))
			ls_wscale=string(round(lrec_obj.width/ll_width,3))
			ls_hscale=string(round(lrec_obj.height/ll_height,3))
			ls_x = string(lrec_obj.x)
			ls_y = string(lrec_obj.y)
			ls_width = string(lrec_obj.width)
			ls_height = string(lrec_obj.height)
			lrec_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lrec_obj.tag
		CASE ROUNDRECTANGLE
			lrrec_obj = awo
			ls_xscale=string(round(lrrec_obj.x/ll_width,3))
			ls_yscale=string(round(lrrec_obj.y/ll_height,3))
			ls_wscale=string(round(lrrec_obj.width/ll_width,3))
			ls_hscale=string(round(lrrec_obj.height/ll_height,3))
			ls_x = string(lrrec_obj.x)
			ls_y = string(lrrec_obj.y)
			ls_width = string(lrrec_obj.width)
			ls_height = string(lrrec_obj.height)
			lrrec_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lrrec_obj.tag
		CASE MDICLIENT
			lmdi_obj = awo
			ls_xscale=string(round(lmdi_obj.x/ll_width,3))
			ls_yscale=string(round(lmdi_obj.y/ll_height,3))
			ls_wscale=string(round(lmdi_obj.width/ll_width,3))
			ls_hscale=string(round(lmdi_obj.height/ll_height,3))
			ls_x = string(lmdi_obj.x)
			ls_y = string(lmdi_obj.y)
			ls_width = string(lmdi_obj.width)
			ls_height = string(lmdi_obj.height)
			lmdi_obj.tag=ls_register+'/'+ls_resize+'/'+ls_flag+"/"+ls_xscale+'/'+ls_yscale+'/'+ls_wscale+'/'+ls_hscale+'/'+ls_width+'/'+ls_height+'/'+ls_x+'/'+ls_y+'/'+ls_parentw+'/'+ls_parenth+'/'+ls_textsize+'/'+lmdi_obj.tag
	END CHOOSE



end subroutine

public function boolean of_resizable (windowobject awo);string ls_tag,ls_flag[]
int li_pos
ls_tag = awo.tag
of_stringtoarray(ls_tag,ls_flag,'/')

if upperbound(ls_flag) <2 then
	return False
elseif ls_flag[2] = '1' then
	return true
else
	return false
end if


end function

public subroutine of_stringtoarray (string as_input, ref string as_array[], string as_flag);String ls_buff
Integer li_len,i

ls_buff = as_input

IF ls_buff='' OR isnull(ls_buff) THEN RETURN

i=1
li_len=len(ls_buff)

DO WHILE Pos(ls_buff,as_flag)<>0
	as_array[i]=Left(ls_buff,Pos(ls_buff,as_flag) - 1)
	i++
	li_len=Len(ls_buff)
	ls_buff=Right(ls_buff,li_len - (Pos(ls_buff,as_flag)))
LOOP

IF Trim(ls_buff)='' THEN
	i=i - 1
ELSE
	as_array[i]=ls_buff
END IF
end subroutine

public subroutine of_stop (windowobject awo);if not of_resizable(awo) then return

string ls_tag

ls_tag = awo.tag

ls_tag = left(ls_tag,2)+'0'+mid(ls_tag,4)

awo.tag = ls_tag
end subroutine

public subroutine of_start (windowobject awo);if  of_resizable(awo) then return
if  not ib_init then return

string ls_tag

ls_tag = awo.tag

ls_tag = left(ls_tag,2)+'1'+mid(ls_tag,4)

awo.tag = ls_tag
end subroutine

public function boolean of_registered (windowobject awo);string ls_tag,ls_flag[]
int li_pos
ls_tag = awo.tag
of_stringtoarray(ls_tag,ls_flag,'/')

if upperbound(ls_flag) <4 then
	return False
elseif ls_flag[1] = '1' then
	return true
else
	return false
end if
end function

public subroutine of_fontresize (boolean ab_resize, integer ai_type);ib_fontresize = ab_resize

ii_fonttype = ai_type

end subroutine

public subroutine of_zoom (boolean ab_zoom, integer ai_type);of_zoom(ab_zoom,ai_type,3)
end subroutine

public subroutine of_resize (userobject au_uo, integer ai_newwidth, integer ai_newheight, boolean ab_recursion);//x: 0/no   1/scale  2/fixtoright  
//y: 0/no   1/scale  2/fixtobottom 
//width: 0/no   1/scale  2/scalefixtoright  3/scalefixtoleft 4/scaletoright 5/scaletoleft
//height: 0/no   1/scale  2/scalefixtobottom  3/scalefixtotop 4/scaletobottom 5/scaletotop
Integer li_controls,i
int  li_font
String ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize,ls_flag
decimal{6}  ld_rate
long ll_index,ll_interval
tab ltb_tmp
dragobject  ldo_obj
userobject luo_tmp
windowobject lwo
datawindow  ldw_obj
checkbox     lcbx_obj
radiobutton    lrb_obj
commandbutton lcb_obj
picturebutton lpb_obj
datepicker  ldp_obj
monthcalendar lmc_obj
treeview  ltv_obj
dropdownpicturelistbox  lddplb_obj
listbox  llb_obj
picturelistbox lplb_obj
listview llv_obj
dropdownlistbox lddlb_obj
groupbox lgb_obj
editmask lem_obj
multilineedit lmle_obj
singlelineedit lsle_obj
statichyperlink lshl_obj
statictext lst_obj
line         lln_obj
oval        lov_obj
rectangle   lrec_obj
roundrectangle  lrrec_obj
userobject   luo_obj
tab         lt_obj
mdiclient              lmdi_obj
long ll_oldwidth
long ll_oldheight
//ai_newwidth = au_uo.width
//ai_newheight = au_uo.height
if ib_stopall then return
li_controls=upperbound(au_uo.Control[])
FOR i=1 TO li_controls
	ll_oldwidth = 0
	ll_oldheight = 0
	if not of_resizable(au_uo.control[i]) then continue
	CHOOSE CASE 	of_typeof(au_uo.control[i])
		CASE DRAGOBJECT
			ldo_obj = au_uo.control[i]
			CHOOSE CASE ldo_obj.TypeOf()
				CASE datawindow!
					ldw_obj=ldo_obj
					of_getscale(ldw_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height)
					of_internal_resize(ldw_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldwidth = long(ls_width)
					ll_oldheight = long(ls_height)
					if ib_zoom then
						choose case ii_type
							case 1
								ld_rate = ldw_obj.height/ll_oldheight
							case 2
								ld_rate = ldw_obj.width/ll_oldwidth
							case 3
								ld_rate = min(ldw_obj.width/ll_oldwidth,ldw_obj.height/ll_oldheight)
							case 4
								ld_rate = max(ldw_obj.width/ll_oldwidth,ldw_obj.height/ll_oldheight)
						end choose
						if ld_rate > idec_maxrate then
							ld_rate = idec_maxrate
						end if
						if not isvalid(ldw_obj.object) then continue
						if ldw_obj.object.datawindow.processing = '3' or ldw_obj.object.datawindow.processing = '6' or ldw_obj.object.datawindow.processing = '7' then continue
						ldw_obj.object.datawindow.zoom = string(integer(ld_rate * 100))	
					end if
				CASE tab!
					ltb_tmp=ldo_obj
					of_getscale(ltb_tmp.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(ltb_tmp,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = ltb_tmp.height/ll_oldheight
							case 2
								ld_rate = ltb_tmp.width/ll_oldwidth
							case 3
								ld_rate = min(ltb_tmp.width/ll_oldwidth,ltb_tmp.height/ll_oldheight)
							case 4
								ld_rate = max(ltb_tmp.width/ll_oldwidth,ltb_tmp.height/ll_oldheight)
						end choose
						ltb_tmp.textsize = Ceiling(li_font*ld_rate)
					end if	
					for ll_index = 1 to upperbound(ltb_tmp.control)
						luo_tmp = ltb_tmp.control[ll_index]
						if not isvalid(luo_tmp) then continue
						if ab_recursion then
							of_resize(luo_tmp,ltb_tmp.width,ltb_tmp.height,true)
						end if
					next					
				CASE userobject!
					luo_obj=ldo_obj
					of_getscale(luo_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					of_internal_resize(luo_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					luo_tmp = luo_obj
					if ab_recursion then
						of_resize(luo_tmp,luo_tmp.width,luo_tmp.height,true)
					end if
				CASE checkbox!
					lcbx_obj = ldo_obj
					of_getscale(lcbx_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lcbx_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lcbx_obj.height/ll_oldheight
							case 2
								ld_rate = lcbx_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lcbx_obj.width/ll_oldwidth,lcbx_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lcbx_obj.width/ll_oldwidth,lcbx_obj.height/ll_oldheight)
						end choose
						lcbx_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE radiobutton!
					lrb_obj = ldo_obj
					of_getscale(lrb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lrb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lrb_obj.height/ll_oldheight
							case 2
								ld_rate = lrb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lrb_obj.width/ll_oldwidth,lrb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lrb_obj.width/ll_oldwidth,lrb_obj.height/ll_oldheight)
						end choose
						lrb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE commandbutton!
					lcb_obj = ldo_obj
					of_getscale(lcb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lcb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lcb_obj.height/ll_oldheight
							case 2
								ld_rate = lcb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lcb_obj.width/ll_oldwidth,lcb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lcb_obj.width/ll_oldwidth,lcb_obj.height/ll_oldheight)
						end choose
						lcb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE picturebutton!
					lpb_obj = ldo_obj
					of_getscale(lpb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lpb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lpb_obj.height/ll_oldheight
							case 2
								ld_rate = lpb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lpb_obj.width/ll_oldwidth,lpb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lpb_obj.width/ll_oldwidth,lpb_obj.height/ll_oldheight)
						end choose
						lpb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE datepicker!
					ldp_obj = ldo_obj
					of_getscale(ldp_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(ldp_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = ldp_obj.height/ll_oldheight
							case 2
								ld_rate = ldp_obj.width/ll_oldwidth
							case 3
								ld_rate = min(ldp_obj.width/ll_oldwidth,ldp_obj.height/ll_oldheight)
							case 4
								ld_rate = max(ldp_obj.width/ll_oldwidth,ldp_obj.height/ll_oldheight)
						end choose
						ldp_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE monthcalendar!
					lmc_obj = ldo_obj
					of_getscale(lmc_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lmc_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lmc_obj.height/ll_oldheight
							case 2
								ld_rate = lmc_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lmc_obj.width/ll_oldwidth,lmc_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lmc_obj.width/ll_oldwidth,lmc_obj.height/ll_oldheight)
						end choose
						lmc_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE treeview!
					ltv_obj = ldo_obj
					of_getscale(ltv_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(ltv_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = ltv_obj.height/ll_oldheight
							case 2
								ld_rate = ltv_obj.width/ll_oldwidth
							case 3
								ld_rate = min(ltv_obj.width/ll_oldwidth,ltv_obj.height/ll_oldheight)
							case 4
								ld_rate = max(ltv_obj.width/ll_oldwidth,ltv_obj.height/ll_oldheight)
						end choose
						ltv_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE dropdownpicturelistbox!
					lddplb_obj = ldo_obj
					of_getscale(lddplb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lddplb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lddplb_obj.height/ll_oldheight
							case 2
								ld_rate = lddplb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lddplb_obj.width/ll_oldwidth,lddplb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lddplb_obj.width/ll_oldwidth,lddplb_obj.height/ll_oldheight)
						end choose
						lddplb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE picturelistbox!
					lplb_obj = ldo_obj
					of_getscale(lplb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lplb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lplb_obj.height/ll_oldheight
							case 2
								ld_rate = lplb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lplb_obj.width/ll_oldwidth,lplb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lplb_obj.width/ll_oldwidth,lplb_obj.height/ll_oldheight)
						end choose
						lplb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE listview!
					llv_obj = ldo_obj
					of_getscale(llv_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(llv_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = llv_obj.height/ll_oldheight
							case 2
								ld_rate = llv_obj.width/ll_oldwidth
							case 3
								ld_rate = min(llv_obj.width/ll_oldwidth,llv_obj.height/ll_oldheight)
							case 4
								ld_rate = max(llv_obj.width/ll_oldwidth,llv_obj.height/ll_oldheight)
						end choose
						llv_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE dropdownlistbox!
					lddlb_obj = ldo_obj
					of_getscale(lddlb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lddlb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lddlb_obj.height/ll_oldheight
							case 2
								ld_rate = lddlb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lddlb_obj.width/ll_oldwidth,lddlb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lddlb_obj.width/ll_oldwidth,lddlb_obj.height/ll_oldheight)
						end choose
						lddlb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE listbox!
					llb_obj = ldo_obj
					of_getscale(llb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(llb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = llb_obj.height/ll_oldheight
							case 2
								ld_rate = llb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(llb_obj.width/ll_oldwidth,llb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(llb_obj.width/ll_oldwidth,llb_obj.height/ll_oldheight)
						end choose
						llb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE groupbox!
					lgb_obj = ldo_obj
					of_getscale(lgb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lgb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lgb_obj.height/ll_oldheight
							case 2
								ld_rate = lgb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lgb_obj.width/ll_oldwidth,lgb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lgb_obj.width/ll_oldwidth,lgb_obj.height/ll_oldheight)
						end choose
						lgb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE editmask!
					lem_obj = ldo_obj
					of_getscale(lem_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lem_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lem_obj.height/ll_oldheight
							case 2
								ld_rate = lem_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lem_obj.width/ll_oldwidth,lem_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lem_obj.width/ll_oldwidth,lem_obj.height/ll_oldheight)
						end choose
						lem_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE multilineedit!
					lmle_obj = ldo_obj
					of_getscale(lmle_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lmle_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lmle_obj.height/ll_oldheight
							case 2
								ld_rate = lmle_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lmle_obj.width/ll_oldwidth,lmle_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lmle_obj.width/ll_oldwidth,lmle_obj.height/ll_oldheight)
						end choose
						lmle_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE singlelineedit!
					lsle_obj = ldo_obj
					of_getscale(lsle_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lsle_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lsle_obj.height/ll_oldheight
							case 2
								ld_rate = lsle_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lsle_obj.width/ll_oldwidth,lsle_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lsle_obj.width/ll_oldwidth,lsle_obj.height/ll_oldheight)
						end choose
						lsle_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE statichyperlink!
					lshl_obj = ldo_obj
					of_getscale(lshl_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lshl_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lshl_obj.height/ll_oldheight
							case 2
								ld_rate = lshl_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lshl_obj.width/ll_oldwidth,lshl_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lshl_obj.width/ll_oldwidth,lshl_obj.height/ll_oldheight)
						end choose
						lshl_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE statictext!
					lst_obj = ldo_obj
					of_getscale(lst_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lst_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lst_obj.height/ll_oldheight
							case 2
								ld_rate = lst_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lst_obj.width/ll_oldwidth,lst_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lst_obj.width/ll_oldwidth,lst_obj.height/ll_oldheight)
						end choose
						lst_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE ELSE
					of_getscale(ldo_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					of_internal_resize(ldo_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
			END CHOOSE
		CASE LINE
			lln_obj=au_uo.control[i]
			of_getscale(lln_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
			choose case mid(ls_flag,1,1)
					case '1'
						lln_obj.beginx=ai_newwidth*dec(ls_xbl)
					case '2'
						ll_interval = of_orginterval_x(lln_obj)
						if ll_interval = -1 then continue
						lln_obj.beginx = ai_newwidth - lln_obj.endx - ll_interval
			end choose
			choose case mid(ls_flag,2,1)
					case '1'
						lln_obj.beginy=ai_newheight*dec(ls_ybl)
					case '2'
						ll_interval = of_orginterval_y(lln_obj)
						if ll_interval = -1 then continue
						lln_obj.beginy = ai_newheight - lln_obj.endy - ll_interval
			end choose
			choose case mid(ls_flag,3,1)
					case '1'
						lln_obj.endx=ai_newwidth*dec(ls_wbl)
					case '2'
						lln_obj.endx=ai_newwidth - lln_obj.beginx
						ll_interval = of_orginterval_x(lln_obj)
						if ll_interval = -1 then return 
						lln_obj.endx=ai_newwidth - lln_obj.beginx - ll_interval
					case '3'
						ll_interval = of_orginterval_x(lln_obj)
						if ll_interval = -1 then continue
						lln_obj.endx=ai_newwidth - ll_interval*2
						lln_obj.beginx = ll_interval
					case '4'
						lln_obj.endx=ai_newwidth - lln_obj.beginx
					case '5'
						ll_interval = of_orginterval_x(lln_obj)
						if ll_interval = -1 then continue
						lln_obj.endx=ai_newwidth - ll_interval
						lln_obj.beginx = 0
			end choose
			choose case mid(ls_flag,4,1)
					case '1'
						lln_obj.endy=ai_newheight*dec(ls_hbl)
					case '2'
						ll_interval = of_orginterval_y(lln_obj)
						if ll_interval = -1 then return 
						lln_obj.endy=ai_newheight - lln_obj.beginy - ll_interval
					case '3'
						ll_interval = of_orginterval_y(lln_obj)
						if ll_interval = -1 then continue
						lln_obj.endy=ai_newheight - ll_interval*2
						lln_obj.beginy = ll_interval
					case '4'
						lln_obj.endy=ai_newheight - lln_obj.beginy
					case '5'
						ll_interval = of_orginterval_y(lln_obj)
						if ll_interval = -1 then continue
						lln_obj.endy=ai_newheight - ll_interval
						lln_obj.beginy = 0
			end choose
		CASE OVAL
			lov_obj = au_uo.control[i]
			of_getscale(lov_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
			  
		     choose case mid(ls_flag,1,1)
					case '1'
						lov_obj.x=ai_newwidth*dec(ls_xbl)
					case '2'
						ll_interval = of_orginterval_x(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.x = ai_newwidth - lov_obj.width - ll_interval
			end choose
			choose case mid(ls_flag,2,1)
					case '1'
						lov_obj.y=ai_newheight*dec(ls_ybl)
					case '2'
						ll_interval = of_orginterval_y(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.y = ai_newheight - lov_obj.height - ll_interval
			end choose
			choose case mid(ls_flag,3,1)
					case '1'
						lov_obj.width=ai_newwidth*dec(ls_wbl)
					case '2'
						ll_interval = of_orginterval_x(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.width=ai_newwidth - lov_obj.x - ll_interval
					case '3'
						ll_interval = of_orginterval_x(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.width=ai_newwidth - ll_interval*2
						lov_obj.x = ll_interval
					case '4'
						lov_obj.width=ai_newwidth - lov_obj.x
					case '5'
						ll_interval = of_orginterval_x(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.width=ai_newwidth - ll_interval
						lov_obj.x = 0
			end choose
			choose case mid(ls_flag,4,1)
					case '1'
						lov_obj.height=ai_newheight*dec(ls_hbl)
					case '2'
						ll_interval = of_orginterval_y(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.height=ai_newheight - lov_obj.y - ll_interval
					case '3'
						ll_interval = of_orginterval_y(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.height=ai_newheight - ll_interval*2
						lov_obj.y = ll_interval
					case '4'
						lov_obj.height=ai_newheight - lov_obj.y
					case '5'
						ll_interval = of_orginterval_y(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.height=ai_newheight - ll_interval
						lov_obj.y = 0
			end choose
		CASE RECTANGLE
			lrec_obj = au_uo.control[i]
			of_getscale(lrec_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
			choose case mid(ls_flag,1,1)
					case '1'
						lrec_obj.x=ai_newwidth*dec(ls_xbl)
					case '2'
						ll_interval = of_orginterval_x(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.x = ai_newwidth - lrec_obj.width - ll_interval
			end choose
			choose case mid(ls_flag,2,1)
					case '1'
						lrec_obj.y=ai_newheight*dec(ls_ybl)
					case '2'
						ll_interval = of_orginterval_y(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.y = ai_newheight - lrec_obj.height - ll_interval
			end choose
			choose case mid(ls_flag,3,1)
					case '1'
						lrec_obj.width=ai_newwidth*dec(ls_wbl)
					case '2'
						ll_interval = of_orginterval_x(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.width=ai_newwidth - lrec_obj.x - ll_interval
					case '3'
						ll_interval = of_orginterval_x(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.width=ai_newwidth - ll_interval*2
						lrec_obj.x = ll_interval
					case '4'
						lrec_obj.width=ai_newwidth - lrec_obj.x
					case '5'
						ll_interval = of_orginterval_x(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.width=ai_newwidth - ll_interval
						lrec_obj.x = 0
			end choose
			choose case mid(ls_flag,4,1)
					case '1'
						lrec_obj.height=ai_newheight*dec(ls_hbl)
					case '2'
						ll_interval = of_orginterval_y(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.height=ai_newheight - lrec_obj.y - ll_interval
					case '3'
						ll_interval = of_orginterval_y(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.height=ai_newheight - ll_interval*2
						lrec_obj.y = ll_interval
					case '4'
						lrec_obj.height=ai_newheight - lrec_obj.y
					case '5'
						ll_interval = of_orginterval_y(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.height=ai_newheight - ll_interval
						lrec_obj.y = 0
			end choose
		CASE ROUNDRECTANGLE
			lrrec_obj = au_uo.control[i]
			of_getscale(lrrec_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
			choose case mid(ls_flag,1,1)
					case '1'
						lrrec_obj.x=ai_newwidth*dec(ls_xbl)
					case '2'
						ll_interval = of_orginterval_x(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.x = ai_newwidth - lrrec_obj.width - ll_interval
			end choose
			choose case mid(ls_flag,2,1)
					case '1'
						lrrec_obj.y=ai_newheight*dec(ls_ybl)
					case '2'
						ll_interval = of_orginterval_y(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.y = ai_newheight - lrrec_obj.height - ll_interval
			end choose
			choose case mid(ls_flag,3,1)
					case '1'
						lrrec_obj.width=ai_newwidth*dec(ls_wbl)
					case '2'
						ll_interval = of_orginterval_x(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.width=ai_newwidth - lrrec_obj.x - ll_interval
					case '3'
						ll_interval = of_orginterval_x(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.width=ai_newwidth - ll_interval*2
						lrrec_obj.x = ll_interval
					case '4'
						lrrec_obj.width=ai_newwidth - lrrec_obj.x
					case '5'
						ll_interval = of_orginterval_x(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.width=ai_newwidth - ll_interval
						lrrec_obj.x = 0
			end choose
			choose case mid(ls_flag,4,1)
					case '1'
						lrrec_obj.height=ai_newheight*dec(ls_hbl)
					case '2'
						ll_interval = of_orginterval_y(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.height=ai_newheight - lrrec_obj.y - ll_interval
					case '3'
						ll_interval = of_orginterval_y(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.height=ai_newheight - ll_interval*2
						lrrec_obj.y = ll_interval
					case '4'
						lrrec_obj.height=ai_newheight - lrrec_obj.y
					case '5'
						ll_interval = of_orginterval_y(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.height=ai_newheight - ll_interval
						lrrec_obj.y = 0
			end choose
		CASE MDICLIENT
			lmdi_obj = au_uo.control[i]
			of_getscale(lmdi_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
			choose case mid(ls_flag,1,1)
					case '1'
						lmdi_obj.x=ai_newwidth*dec(ls_xbl)
					case '2'
						ll_interval = of_orginterval_x(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.x = ai_newwidth - lmdi_obj.width - ll_interval
			end choose
			choose case mid(ls_flag,2,1)
					case '1'
						lmdi_obj.y=ai_newheight*dec(ls_ybl)
					case '2'
						ll_interval = of_orginterval_y(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.y = ai_newheight - lmdi_obj.height - ll_interval
			end choose
			choose case mid(ls_flag,3,1)
					case '1'
						lmdi_obj.width=ai_newwidth*dec(ls_wbl)
					case '2'
						ll_interval = of_orginterval_x(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.width=ai_newwidth - lmdi_obj.x - ll_interval
					case '3'
						ll_interval = of_orginterval_x(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.width=ai_newwidth - ll_interval*2
						lmdi_obj.x = ll_interval
					case '4'
						lmdi_obj.width=ai_newwidth - lmdi_obj.x
					case '5'
						ll_interval = of_orginterval_x(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.width=ai_newwidth - ll_interval
						lmdi_obj.x = 0
			end choose
			choose case mid(ls_flag,4,1)
					case '1'
						lmdi_obj.height=ai_newheight*dec(ls_hbl)
					case '2'
						ll_interval = of_orginterval_y(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.height=ai_newheight - lmdi_obj.y - ll_interval
					case '3'
						ll_interval = of_orginterval_y(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.height=ai_newheight - ll_interval*2
						lmdi_obj.y = ll_interval
					case '4'
						lmdi_obj.height=ai_newheight - lmdi_obj.y
					case '5'
						ll_interval = of_orginterval_y(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.height=ai_newheight - ll_interval
						lmdi_obj.y = 0
			end choose
	END CHOOSE
NEXT



end subroutine

public subroutine of_resize (window aw_window, integer ai_newwidth, integer ai_newheight, boolean ab_recursion);//x: 0/no   1/scale  2/fixtoright  
//y: 0/no   1/scale  2/fixtobottom 
//width: 0/no   1/scale  2/scalefixtoright  3/scalefixtoleft 4/scaletoright 5/scaletoleft
//height: 0/no   1/scale  2/scalefixtobottom  3/scalefixtotop 4/scaletobottom 5/scaletotop
Integer li_controls,i
int  li_font
String ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize,ls_flag
decimal{6}  ld_rate
long ll_index,ll_interval
tab ltb_tmp
dragobject  ldo_obj
userobject luo_tmp
windowobject lwo
datawindow  ldw_obj
checkbox     lcbx_obj
radiobutton    lrb_obj
commandbutton lcb_obj
picturebutton lpb_obj
datepicker  ldp_obj
monthcalendar lmc_obj
treeview  ltv_obj
dropdownpicturelistbox  lddplb_obj
listbox  llb_obj
picturelistbox lplb_obj
listview llv_obj
dropdownlistbox lddlb_obj
groupbox lgb_obj
editmask lem_obj
multilineedit lmle_obj
singlelineedit lsle_obj
statichyperlink lshl_obj
statictext lst_obj
line         lln_obj
oval        lov_obj
rectangle   lrec_obj
roundrectangle  lrrec_obj
userobject   luo_obj
tab         lt_obj
mdiclient              lmdi_obj
long ll_oldwidth
long ll_oldheight
//ai_newwidth = aw_window.width
//ai_newheight = aw_window.height
if ib_stopall then return
li_controls=upperbound(aw_window.Control[])
FOR i=1 TO li_controls
	ll_oldwidth = 0
	ll_oldheight = 0
	if not of_resizable(aw_window.control[i]) then continue
	CHOOSE CASE 	of_typeof(aw_window.control[i])
		CASE DRAGOBJECT
			ldo_obj = aw_window.control[i]
			CHOOSE CASE ldo_obj.TypeOf()
				CASE datawindow!
					ldw_obj=ldo_obj
					of_getscale(ldw_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height)
					of_internal_resize(ldw_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldwidth = long(ls_width)
					ll_oldheight = long(ls_height)
					if ib_zoom then
						choose case ii_type
							case 1
								ld_rate = ldw_obj.height/ll_oldheight
							case 2
								ld_rate = ldw_obj.width/ll_oldwidth
							case 3
								ld_rate = min(ldw_obj.width/ll_oldwidth,ldw_obj.height/ll_oldheight)
							case 4
								ld_rate = max(ldw_obj.width/ll_oldwidth,ldw_obj.height/ll_oldheight)
						end choose
						if ld_rate > idec_maxrate then
							ld_rate = idec_maxrate
						end if
						if not isvalid(ldw_obj.object) then continue
						if ldw_obj.object.datawindow.processing = '3' or ldw_obj.object.datawindow.processing = '6' or ldw_obj.object.datawindow.processing = '7' then continue
						ldw_obj.object.datawindow.zoom = string(integer(ld_rate * 100))	
					end if
				CASE tab!
					ltb_tmp=ldo_obj
					of_getscale(ltb_tmp.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(ltb_tmp,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = ltb_tmp.height/ll_oldheight
							case 2
								ld_rate = ltb_tmp.width/ll_oldwidth
							case 3
								ld_rate = min(ltb_tmp.width/ll_oldwidth,ltb_tmp.height/ll_oldheight)
							case 4
								ld_rate = max(ltb_tmp.width/ll_oldwidth,ltb_tmp.height/ll_oldheight)
						end choose
						ltb_tmp.textsize = Ceiling(li_font*ld_rate)
					end if	
					for ll_index = 1 to upperbound(ltb_tmp.control)
						luo_tmp = ltb_tmp.control[ll_index]
						if not isvalid(luo_tmp) then continue
						if ab_recursion then
							of_resize(luo_tmp,ltb_tmp.width,ltb_tmp.height,true)
						end if
					next					
				CASE userobject!
					luo_obj=ldo_obj
					of_getscale(luo_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					of_internal_resize(luo_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					luo_tmp = luo_obj
					if ab_recursion then
						of_resize(luo_tmp,luo_tmp.width,luo_tmp.height,true)
					end if
				CASE checkbox!
					lcbx_obj = ldo_obj
					of_getscale(lcbx_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lcbx_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lcbx_obj.height/ll_oldheight
							case 2
								ld_rate = lcbx_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lcbx_obj.width/ll_oldwidth,lcbx_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lcbx_obj.width/ll_oldwidth,lcbx_obj.height/ll_oldheight)
						end choose
						lcbx_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE radiobutton!
					lrb_obj = ldo_obj
					of_getscale(lrb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lrb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lrb_obj.height/ll_oldheight
							case 2
								ld_rate = lrb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lrb_obj.width/ll_oldwidth,lrb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lrb_obj.width/ll_oldwidth,lrb_obj.height/ll_oldheight)
						end choose
						lrb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE commandbutton!
					lcb_obj = ldo_obj
					of_getscale(lcb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lcb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lcb_obj.height/ll_oldheight
							case 2
								ld_rate = lcb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lcb_obj.width/ll_oldwidth,lcb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lcb_obj.width/ll_oldwidth,lcb_obj.height/ll_oldheight)
						end choose
						lcb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE picturebutton!
					lpb_obj = ldo_obj
					of_getscale(lpb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lpb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lpb_obj.height/ll_oldheight
							case 2
								ld_rate = lpb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lpb_obj.width/ll_oldwidth,lpb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lpb_obj.width/ll_oldwidth,lpb_obj.height/ll_oldheight)
						end choose
						lpb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE datepicker!
					ldp_obj = ldo_obj
					of_getscale(ldp_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(ldp_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = ldp_obj.height/ll_oldheight
							case 2
								ld_rate = ldp_obj.width/ll_oldwidth
							case 3
								ld_rate = min(ldp_obj.width/ll_oldwidth,ldp_obj.height/ll_oldheight)
							case 4
								ld_rate = max(ldp_obj.width/ll_oldwidth,ldp_obj.height/ll_oldheight)
						end choose
						ldp_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE monthcalendar!
					lmc_obj = ldo_obj
					of_getscale(lmc_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lmc_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lmc_obj.height/ll_oldheight
							case 2
								ld_rate = lmc_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lmc_obj.width/ll_oldwidth,lmc_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lmc_obj.width/ll_oldwidth,lmc_obj.height/ll_oldheight)
						end choose
						lmc_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE treeview!
					ltv_obj = ldo_obj
					of_getscale(ltv_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(ltv_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = ltv_obj.height/ll_oldheight
							case 2
								ld_rate = ltv_obj.width/ll_oldwidth
							case 3
								ld_rate = min(ltv_obj.width/ll_oldwidth,ltv_obj.height/ll_oldheight)
							case 4
								ld_rate = max(ltv_obj.width/ll_oldwidth,ltv_obj.height/ll_oldheight)
						end choose
						ltv_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE dropdownpicturelistbox!
					lddplb_obj = ldo_obj
					of_getscale(lddplb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lddplb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lddplb_obj.height/ll_oldheight
							case 2
								ld_rate = lddplb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lddplb_obj.width/ll_oldwidth,lddplb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lddplb_obj.width/ll_oldwidth,lddplb_obj.height/ll_oldheight)
						end choose
						lddplb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE picturelistbox!
					lplb_obj = ldo_obj
					of_getscale(lplb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lplb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lplb_obj.height/ll_oldheight
							case 2
								ld_rate = lplb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lplb_obj.width/ll_oldwidth,lplb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lplb_obj.width/ll_oldwidth,lplb_obj.height/ll_oldheight)
						end choose
						lplb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE listview!
					llv_obj = ldo_obj
					of_getscale(llv_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(llv_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = llv_obj.height/ll_oldheight
							case 2
								ld_rate = llv_obj.width/ll_oldwidth
							case 3
								ld_rate = min(llv_obj.width/ll_oldwidth,llv_obj.height/ll_oldheight)
							case 4
								ld_rate = max(llv_obj.width/ll_oldwidth,llv_obj.height/ll_oldheight)
						end choose
						llv_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE dropdownlistbox!
					lddlb_obj = ldo_obj
					of_getscale(lddlb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lddlb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lddlb_obj.height/ll_oldheight
							case 2
								ld_rate = lddlb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lddlb_obj.width/ll_oldwidth,lddlb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lddlb_obj.width/ll_oldwidth,lddlb_obj.height/ll_oldheight)
						end choose
						lddlb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE listbox!
					llb_obj = ldo_obj
					of_getscale(llb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(llb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = llb_obj.height/ll_oldheight
							case 2
								ld_rate = llb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(llb_obj.width/ll_oldwidth,llb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(llb_obj.width/ll_oldwidth,llb_obj.height/ll_oldheight)
						end choose
						llb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE groupbox!
					lgb_obj = ldo_obj
					of_getscale(lgb_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lgb_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lgb_obj.height/ll_oldheight
							case 2
								ld_rate = lgb_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lgb_obj.width/ll_oldwidth,lgb_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lgb_obj.width/ll_oldwidth,lgb_obj.height/ll_oldheight)
						end choose
						lgb_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE editmask!
					lem_obj = ldo_obj
					of_getscale(lem_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lem_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lem_obj.height/ll_oldheight
							case 2
								ld_rate = lem_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lem_obj.width/ll_oldwidth,lem_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lem_obj.width/ll_oldwidth,lem_obj.height/ll_oldheight)
						end choose
						lem_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE multilineedit!
					lmle_obj = ldo_obj
					of_getscale(lmle_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lmle_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lmle_obj.height/ll_oldheight
							case 2
								ld_rate = lmle_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lmle_obj.width/ll_oldwidth,lmle_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lmle_obj.width/ll_oldwidth,lmle_obj.height/ll_oldheight)
						end choose
						lmle_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE singlelineedit!
					lsle_obj = ldo_obj
					of_getscale(lsle_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lsle_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lsle_obj.height/ll_oldheight
							case 2
								ld_rate = lsle_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lsle_obj.width/ll_oldwidth,lsle_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lsle_obj.width/ll_oldwidth,lsle_obj.height/ll_oldheight)
						end choose
						lsle_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE statichyperlink!
					lshl_obj = ldo_obj
					of_getscale(lshl_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lshl_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lshl_obj.height/ll_oldheight
							case 2
								ld_rate = lshl_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lshl_obj.width/ll_oldwidth,lshl_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lshl_obj.width/ll_oldwidth,lshl_obj.height/ll_oldheight)
						end choose
						lshl_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE statictext!
					lst_obj = ldo_obj
					of_getscale(lst_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_textsize)
					of_internal_resize(lst_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					ll_oldheight = long(ls_height)
					ll_oldwidth = long(ls_width)
					li_font = integer(ls_textsize)
					if ib_fontresize then
						choose case ii_fonttype
							case 1
								ld_rate = lst_obj.height/ll_oldheight
							case 2
								ld_rate = lst_obj.width/ll_oldwidth
							case 3
								ld_rate = min(lst_obj.width/ll_oldwidth,lst_obj.height/ll_oldheight)
							case 4
								ld_rate = max(lst_obj.width/ll_oldwidth,lst_obj.height/ll_oldheight)
						end choose
						lst_obj.textsize = Ceiling(li_font*ld_rate)
					end if
				CASE ELSE
					of_getscale(ldo_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
					of_internal_resize(ldo_obj,ls_flag,ai_newwidth,ai_newheight,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
			END CHOOSE
		CASE LINE
			lln_obj=aw_window.control[i]
			of_getscale(lln_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
			choose case mid(ls_flag,1,1)
					case '1'
						lln_obj.beginx=ai_newwidth*dec(ls_xbl)
					case '2'
						ll_interval = of_orginterval_x(lln_obj)
						if ll_interval = -1 then continue
						lln_obj.beginx = ai_newwidth - lln_obj.endx - ll_interval
			end choose
			choose case mid(ls_flag,2,1)
					case '1'
						lln_obj.beginy=ai_newheight*dec(ls_ybl)
					case '2'
						ll_interval = of_orginterval_y(lln_obj)
						if ll_interval = -1 then continue
						lln_obj.beginy = ai_newheight - lln_obj.endy - ll_interval
			end choose
			choose case mid(ls_flag,3,1)
					case '1'
						lln_obj.endx=ai_newwidth*dec(ls_wbl)
					case '2'
						lln_obj.endx=ai_newwidth - lln_obj.beginx
						ll_interval = of_orginterval_x(lln_obj)
						if ll_interval = -1 then return 
						lln_obj.endx=ai_newwidth - lln_obj.beginx - ll_interval
					case '3'
						ll_interval = of_orginterval_x(lln_obj)
						if ll_interval = -1 then continue
						lln_obj.endx=ai_newwidth - ll_interval*2
						lln_obj.beginx = ll_interval
					case '4'
						lln_obj.endx=ai_newwidth - lln_obj.beginx
					case '5'
						ll_interval = of_orginterval_x(lln_obj)
						if ll_interval = -1 then continue
						lln_obj.endx=ai_newwidth - ll_interval
						lln_obj.beginx = 0
			end choose
			choose case mid(ls_flag,4,1)
					case '1'
						lln_obj.endy=ai_newheight*dec(ls_hbl)
					case '2'
						ll_interval = of_orginterval_y(lln_obj)
						if ll_interval = -1 then return 
						lln_obj.endy=ai_newheight - lln_obj.beginy - ll_interval
					case '3'
						ll_interval = of_orginterval_y(lln_obj)
						if ll_interval = -1 then continue
						lln_obj.endy=ai_newheight - ll_interval*2
						lln_obj.beginy = ll_interval
					case '4'
						lln_obj.endy=ai_newheight - lln_obj.beginy
					case '5'
						ll_interval = of_orginterval_y(lln_obj)
						if ll_interval = -1 then continue
						lln_obj.endy=ai_newheight - ll_interval
						lln_obj.beginy = 0
			end choose
		CASE OVAL
			lov_obj = aw_window.control[i]
			of_getscale(lov_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
			  
		     choose case mid(ls_flag,1,1)
					case '1'
						lov_obj.x=ai_newwidth*dec(ls_xbl)
					case '2'
						ll_interval = of_orginterval_x(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.x = ai_newwidth - lov_obj.width - ll_interval
			end choose
			choose case mid(ls_flag,2,1)
					case '1'
						lov_obj.y=ai_newheight*dec(ls_ybl)
					case '2'
						ll_interval = of_orginterval_y(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.y = ai_newheight - lov_obj.height - ll_interval
			end choose
			choose case mid(ls_flag,3,1)
					case '1'
						lov_obj.width=ai_newwidth*dec(ls_wbl)
					case '2'
						ll_interval = of_orginterval_x(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.width=ai_newwidth - lov_obj.x - ll_interval
					case '3'
						ll_interval = of_orginterval_x(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.width=ai_newwidth - ll_interval*2
						lov_obj.x = ll_interval
					case '4'
						lov_obj.width=ai_newwidth - lov_obj.x
					case '5'
						ll_interval = of_orginterval_x(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.width=ai_newwidth - ll_interval
						lov_obj.x = 0
			end choose
			choose case mid(ls_flag,4,1)
					case '1'
						lov_obj.height=ai_newheight*dec(ls_hbl)
					case '2'
						ll_interval = of_orginterval_y(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.height=ai_newheight - lov_obj.y - ll_interval
					case '3'
						ll_interval = of_orginterval_y(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.height=ai_newheight - ll_interval*2
						lov_obj.y = ll_interval
					case '4'
						lov_obj.height=ai_newheight - lov_obj.y
					case '5'
						ll_interval = of_orginterval_y(lov_obj)
						if ll_interval = -1 then continue
						lov_obj.height=ai_newheight - ll_interval
						lov_obj.y = 0
			end choose
		CASE RECTANGLE
			lrec_obj = aw_window.control[i]
			of_getscale(lrec_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
			choose case mid(ls_flag,1,1)
					case '1'
						lrec_obj.x=ai_newwidth*dec(ls_xbl)
					case '2'
						ll_interval = of_orginterval_x(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.x = ai_newwidth - lrec_obj.width - ll_interval
			end choose
			choose case mid(ls_flag,2,1)
					case '1'
						lrec_obj.y=ai_newheight*dec(ls_ybl)
					case '2'
						ll_interval = of_orginterval_y(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.y = ai_newheight - lrec_obj.height - ll_interval
			end choose
			choose case mid(ls_flag,3,1)
					case '1'
						lrec_obj.width=ai_newwidth*dec(ls_wbl)
					case '2'
						ll_interval = of_orginterval_x(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.width=ai_newwidth - lrec_obj.x - ll_interval
					case '3'
						ll_interval = of_orginterval_x(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.width=ai_newwidth - ll_interval*2
						lrec_obj.x = ll_interval
					case '4'
						lrec_obj.width=ai_newwidth - lrec_obj.x
					case '5'
						ll_interval = of_orginterval_x(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.width=ai_newwidth - ll_interval
						lrec_obj.x = 0
			end choose
			choose case mid(ls_flag,4,1)
					case '1'
						lrec_obj.height=ai_newheight*dec(ls_hbl)
					case '2'
						ll_interval = of_orginterval_y(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.height=ai_newheight - lrec_obj.y - ll_interval
					case '3'
						ll_interval = of_orginterval_y(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.height=ai_newheight - ll_interval*2
						lrec_obj.y = ll_interval
					case '4'
						lrec_obj.height=ai_newheight - lrec_obj.y
					case '5'
						ll_interval = of_orginterval_y(lrec_obj)
						if ll_interval = -1 then continue
						lrec_obj.height=ai_newheight - ll_interval
						lrec_obj.y = 0
			end choose
		CASE ROUNDRECTANGLE
			lrrec_obj = aw_window.control[i]
			of_getscale(lrrec_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
			choose case mid(ls_flag,1,1)
					case '1'
						lrrec_obj.x=ai_newwidth*dec(ls_xbl)
					case '2'
						ll_interval = of_orginterval_x(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.x = ai_newwidth - lrrec_obj.width - ll_interval
			end choose
			choose case mid(ls_flag,2,1)
					case '1'
						lrrec_obj.y=ai_newheight*dec(ls_ybl)
					case '2'
						ll_interval = of_orginterval_y(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.y = ai_newheight - lrrec_obj.height - ll_interval
			end choose
			choose case mid(ls_flag,3,1)
					case '1'
						lrrec_obj.width=ai_newwidth*dec(ls_wbl)
					case '2'
						ll_interval = of_orginterval_x(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.width=ai_newwidth - lrrec_obj.x - ll_interval
					case '3'
						ll_interval = of_orginterval_x(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.width=ai_newwidth - ll_interval*2
						lrrec_obj.x = ll_interval
					case '4'
						lrrec_obj.width=ai_newwidth - lrrec_obj.x
					case '5'
						ll_interval = of_orginterval_x(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.width=ai_newwidth - ll_interval
						lrrec_obj.x = 0
			end choose
			choose case mid(ls_flag,4,1)
					case '1'
						lrrec_obj.height=ai_newheight*dec(ls_hbl)
					case '2'
						ll_interval = of_orginterval_y(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.height=ai_newheight - lrrec_obj.y - ll_interval
					case '3'
						ll_interval = of_orginterval_y(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.height=ai_newheight - ll_interval*2
						lrrec_obj.y = ll_interval
					case '4'
						lrrec_obj.height=ai_newheight - lrrec_obj.y
					case '5'
						ll_interval = of_orginterval_y(lrrec_obj)
						if ll_interval = -1 then continue
						lrrec_obj.height=ai_newheight - ll_interval
						lrrec_obj.y = 0
			end choose
		CASE MDICLIENT
			lmdi_obj = aw_window.control[i]
			of_getscale(lmdi_obj.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl)
			choose case mid(ls_flag,1,1)
					case '1'
						lmdi_obj.x=ai_newwidth*dec(ls_xbl)
					case '2'
						ll_interval = of_orginterval_x(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.x = ai_newwidth - lmdi_obj.width - ll_interval
			end choose
			choose case mid(ls_flag,2,1)
					case '1'
						lmdi_obj.y=ai_newheight*dec(ls_ybl)
					case '2'
						ll_interval = of_orginterval_y(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.y = ai_newheight - lmdi_obj.height - ll_interval
			end choose
			choose case mid(ls_flag,3,1)
					case '1'
						lmdi_obj.width=ai_newwidth*dec(ls_wbl)
					case '2'
						ll_interval = of_orginterval_x(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.width=ai_newwidth - lmdi_obj.x - ll_interval
					case '3'
						ll_interval = of_orginterval_x(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.width=ai_newwidth - ll_interval*2
						lmdi_obj.x = ll_interval
					case '4'
						lmdi_obj.width=ai_newwidth - lmdi_obj.x
					case '5'
						ll_interval = of_orginterval_x(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.width=ai_newwidth - ll_interval
						lmdi_obj.x = 0
			end choose
			choose case mid(ls_flag,4,1)
					case '1'
						lmdi_obj.height=ai_newheight*dec(ls_hbl)
					case '2'
						ll_interval = of_orginterval_y(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.height=ai_newheight - lmdi_obj.y - ll_interval
					case '3'
						ll_interval = of_orginterval_y(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.height=ai_newheight - ll_interval*2
						lmdi_obj.y = ll_interval
					case '4'
						lmdi_obj.height=ai_newheight - lmdi_obj.y
					case '5'
						ll_interval = of_orginterval_y(lmdi_obj)
						if ll_interval = -1 then continue
						lmdi_obj.height=ai_newheight - ll_interval
						lmdi_obj.y = 0
			end choose
	END CHOOSE
NEXT



end subroutine

public subroutine of_init (userobject au_uo, boolean ab_recursion);

of_init(au_uo,au_uo.width,au_uo.height,ab_recursion)
end subroutine

public subroutine of_resize (datawindow adw, integer ai_newwidth, integer ai_newheight, decimal ad_maxrate);long ll_oldwidth
long ll_oldheight
string ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_flag
decimal{6} ld_rate
of_getscale(adw.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height)
					
ll_oldwidth = long(ls_width)
ll_oldheight = long(ls_height)
adw.width = ai_newwidth
adw.height = ai_newheight
if ib_stopall then return
if ib_zoom then
	choose case ii_type
			case 1
				ld_rate = ai_newheight/ll_oldheight
			case 2
				ld_rate = ai_newwidth/ll_oldwidth
			case 3
				ld_rate = min(ai_newwidth/ll_oldwidth,ai_newheight/ll_oldheight)
			case 4
				ld_rate = max(ai_newwidth/ll_oldwidth,ai_newheight/ll_oldheight)
	end choose
	if ld_rate > ad_maxrate then
		ld_rate = ad_maxrate
	end if
	if not isvalid(adw.object) then return
	if adw.object.datawindow.processing = '3' or adw.object.datawindow.processing = '6' or adw.object.datawindow.processing = '7' then return
	adw.object.datawindow.zoom = string(integer(ld_rate * 100))	
end if
end subroutine

public subroutine of_resize (datawindow adw, integer ai_newwidth, integer ai_newheight, boolean ab_zoom, integer ai_type, decimal ad_maxrate);long ll_oldwidth
long ll_oldheight
string ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height,ls_flag
decimal{6} ld_rate
of_getscale(adw.tag,ls_flag,ls_xbl,ls_ybl,ls_wbl,ls_hbl,ls_width,ls_height)
					
ll_oldwidth = long(ls_width)
ll_oldheight = long(ls_height)
adw.width = ai_newwidth
adw.height = ai_newheight
if ib_stopall then return
if ab_zoom then
	choose case ai_type
			case 1
				ld_rate = ai_newheight/ll_oldheight
			case 2
				ld_rate = ai_newwidth/ll_oldwidth
			case 3
				ld_rate = min(ai_newwidth/ll_oldwidth,ai_newheight/ll_oldheight)
			case 4
				ld_rate = max(ai_newwidth/ll_oldwidth,ai_newheight/ll_oldheight)
	end choose
	if ld_rate > ad_maxrate then
		ld_rate = ad_maxrate
	end if
	if not isvalid(adw.object) then return
	if adw.object.datawindow.processing = '3' or adw.object.datawindow.processing = '6' or adw.object.datawindow.processing = '7' then return
	adw.object.datawindow.zoom = string(integer(ld_rate * 100))	
end if
end subroutine

public subroutine of_getscale (string as_input, ref string as_flag, ref string as_xscale, ref string as_yscale, ref string as_wscale, ref string as_hscale);//
string ls_array[]

of_stringtoarray(as_input,ls_array,'/')

if upperbound(ls_array) < 7 then return

as_flag = ls_array[3]
as_xscale = ls_array[4]
as_yscale = ls_array[5]
as_wscale = ls_array[6]
as_hscale = ls_array[7]
end subroutine

public subroutine of_getscale (string as_input, ref string as_flag, ref string as_xscale, ref string as_yscale, ref string as_wscale, ref string as_hscale, ref string as_width, ref string as_height);//
string ls_array[]

of_stringtoarray(as_input,ls_array,'/')

if upperbound(ls_array) < 9 then return

as_flag = ls_array[3]
as_xscale = ls_array[4]
as_yscale = ls_array[5]
as_wscale = ls_array[6]
as_hscale = ls_array[7]
as_width = ls_array[8]
as_height = ls_array[9]
end subroutine

public subroutine of_getscale (string as_input, ref string as_flag, ref string as_xscale, ref string as_yscale, ref string as_wscale, ref string as_hscale, ref string as_width, ref string as_height, ref string as_fontsize);//
string ls_array[]

of_stringtoarray(as_input,ls_array,'/')

if upperbound(ls_array) < 14 then return

as_flag = ls_array[3]
as_xscale = ls_array[4]
as_yscale = ls_array[5]
as_wscale = ls_array[6]
as_hscale = ls_array[7]
as_width = ls_array[8]
as_height = ls_array[9]
as_fontsize = ls_array[14]
end subroutine

public subroutine of_init_object (windowobject awo, decimal ad_xscale, decimal ad_yscale, decimal ad_wscale, decimal ad_hscale);
Long ll_width,ll_height
String ls_xscale,ls_yscale,ls_wscale,ls_hscale
string ls_array[]
string ls_tag
long ll_int
of_stringtoarray(awo.tag,ls_array,'/')
if upperbound(ls_array) > 3 then
	if ad_xscale > 0 then
		ls_xscale = string(ad_xscale)
		ls_array[4] = ls_xscale
	end if
	if ad_yscale > 0 then
		ls_yscale = string(ad_yscale)
		ls_array[5] = ls_yscale
	end if
	if ad_wscale > 0 then
		ls_wscale = string(ad_wscale)
		ls_array[6] = ls_wscale
	end if
	if ad_hscale > 0 then
		ls_hscale = string(ad_hscale)
		ls_array[7] = ls_hscale
	end if
	
	for ll_int = 1 to upperbound(ls_array)
		ls_tag += ls_array[ll_int]+"/"
	next
	
	ls_tag = mid(ls_tag,1,len(ls_tag) - 1)
	
	awo.tag = ls_tag
end if

end subroutine

public subroutine of_pause ();

ib_stopall = True
end subroutine

public subroutine of_recover ();

ib_stopall = false
end subroutine

public subroutine of_zoom (boolean ab_zoom, integer ai_type, decimal adec_rate);//

ib_zoom = ab_zoom
ii_type = ai_type
idec_maxrate = adec_rate

end subroutine

public function long of_orginterval_x (windowobject awo);string  ls_array[]
long ll_x,ll_parentw,ll_width,ll_return

of_stringtoarray(awo.tag,ls_array,'/')

if upperbound(ls_array) < 12 then return -1

ll_x = long(ls_array[10])
ll_width = long(ls_array[8])
ll_parentw = long(ls_array[12])
ll_return = ll_parentw - ll_width - ll_x
return ll_return
end function

public function long of_orginterval_y (windowobject awo);string  ls_array[]
long ll_y,ll_parenth,ll_height,ll_return

of_stringtoarray(awo.tag,ls_array,'/')

if upperbound(ls_array) < 13 then return -1

ll_y = long(ls_array[11])
ll_height = long(ls_array[9])
ll_parenth = long(ls_array[13])
ll_return = ll_parenth - ll_height - ll_y
return ll_return
end function

public function long of_orginterval_w (windowobject awo);string  ls_array[]
long ll_x,ll_parentw,ll_width,ll_return

of_stringtoarray(awo.tag,ls_array,'/')

if upperbound(ls_array) < 12 then return -1

ll_x = long(ls_array[10])
ll_width = long(ls_array[8])
ll_parentw = long(ls_array[12])
ll_return = ll_x
return ll_return
end function

public function long of_orginterval_h (windowobject awo);string  ls_array[]
long ll_y,ll_parenth,ll_height,ll_return

of_stringtoarray(awo.tag,ls_array,'/')

if upperbound(ls_array) < 13 then return -1

ll_y = long(ls_array[11])
ll_height = long(ls_array[9])
ll_parenth = long(ls_array[13])
ll_return =ll_y 
return ll_return
end function

public subroutine of_setflag (windowobject awo, string as_flag);//
string ls_array[]
string ls_tag
long ll_int
of_stringtoarray(awo.tag,ls_array,'/')

if upperbound(ls_array) < 3 then 
	Messagebox("Error",awo.classname()+" does not register")
	return
end if

ls_array[3] = as_flag

for ll_int = 1 to upperbound(ls_array)
	ls_tag += ls_array[ll_int]+"/"
next

ls_tag = mid(ls_tag,1,len(ls_tag) - 1)

awo.tag = ls_tag

end subroutine

public subroutine of_internal_resize (ref dragobject awo, string as_flag, integer ai_newwidth, integer ai_newheight, string as_xbl, string as_ybl, string as_wbl, string as_hbl);long ll_interval
choose case mid(as_flag,1,1)
		case '1'
			awo.x=ai_newwidth*dec(as_xbl)
		case '2'
			ll_interval = of_orginterval_x(awo)
			if ll_interval = -1 then return
			awo.x = ai_newwidth - awo.width - ll_interval
end choose
choose case mid(as_flag,2,1)
		case '1'
			awo.y=ai_newheight*dec(as_ybl)
		case '2'
			ll_interval = of_orginterval_y(awo)
			if ll_interval = -1 then return
			awo.y = ai_newheight - awo.height - ll_interval
end choose
choose case mid(as_flag,3,1)
		case '1'
			awo.width=ai_newwidth*dec(as_wbl)
		case '2'
			ll_interval = of_orginterval_x(awo)
			if ll_interval = -1 then return 
			awo.width=ai_newwidth - awo.x - ll_interval
		case '3'
			ll_interval = of_orginterval_x(awo)
			if ll_interval = -1 then return
			awo.width=ai_newwidth - ll_interval*2
			awo.x = ll_interval
		case '4'
			awo.width=ai_newwidth - awo.x
		case '5'
			ll_interval = of_orginterval_x(awo)
			if ll_interval = -1 then return
			awo.width=ai_newwidth - ll_interval
			awo.x = 0
end choose
choose case mid(as_flag,4,1)
		case '1'
			awo.height=ai_newheight*dec(as_hbl)
		case '2'
			ll_interval = of_orginterval_y(awo)
			if ll_interval = -1 then return
			awo.height=ai_newheight - awo.y - ll_interval
		case '3'
			ll_interval = of_orginterval_y(awo)
			if ll_interval = -1 then return
			awo.height=ai_newheight - ll_interval*2
			awo.y = ll_interval
		case '4'
			awo.height=ai_newheight - awo.y
		case '5'
			ll_interval = of_orginterval_y(awo)
			if ll_interval = -1 then return
			awo.height=ai_newheight - ll_interval
			awo.y = 0
end choose

end subroutine

public subroutine of_init_object (windowobject awo, boolean ab_recursion);userobject luo
tab ltb
window lw
long ll_parentw,ll_parenth

choose case awo.getparent().typeof()
                case userobject!
                                luo = awo.getparent()
                                ll_parentw = luo.width
                                ll_parenth = luo.height
                case tab!
                                ltb = awo.getparent()
                                ll_parentw = ltb.width
                                ll_parenth = ltb.height
                case window!
                                lw = awo.getparent()
                                ll_parentw = lw.width
                                ll_parenth = lw.height
end choose

of_init_object(awo,ll_parentw,ll_parenth,ab_recursion)

end subroutine

public subroutine of_refresh_object (dragobject ado);string ls_array[]
string ls_tag
long ll_x,ll_y,ll_width,ll_height,ll_pwidth,ll_pheight,ll_count
string ls_xscal,ls_yscal,ls_wscal,ls_hscal
of_stringtoarray(ado.tag,ls_array,'/')

if upperbound(ls_array) < 3 then 
	Messagebox("Error",ado.classname()+" does not register")
	return
end if

ll_x = ado.x
ll_y = ado.y
ll_width = ado.width
ll_height = ado.height
ll_pwidth = long(ls_array[12])
ll_pheight = long(ls_array[13])

ls_xscal = string(round(ll_x/ll_pwidth,3))
ls_yscal = string(round(ll_y/ll_pheight,3))
ls_wscal = string(round(ll_width/ll_pwidth,3))
ls_hscal = string(round(ll_height/ll_pheight,3))

ls_array[4] = ls_xscal
ls_array[5] = ls_yscal
ls_array[6] = ls_wscal
ls_array[7] = ls_hscal
ls_array[8] = string(ll_width)
ls_array[9] = string(ll_height)
ls_array[10] =string(ll_x)
ls_array[11] = string(ll_y)
ls_tag = ls_array[1]
for ll_count = 2 to upperbound(ls_array) 
	ls_tag = ls_tag+"/"+ls_array[ll_count]
next

ado.tag = ls_tag

end subroutine

on eon_appeon_resize.create
call super::create
TriggerEvent( this, "constructor" )
end on

on eon_appeon_resize.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

