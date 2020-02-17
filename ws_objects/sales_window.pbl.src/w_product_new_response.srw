$PBExportHeader$w_product_new_response.srw
$PBExportComments$Response window
forward
global type w_product_new_response from w_product_new
end type
end forward

global type w_product_new_response from w_product_new
integer width = 2240
integer height = 1016
boolean titlebar = true
string title = "Product Maintenance"
boolean controlmenu = true
windowtype windowtype = response!
windowstate windowstate = normal!
boolean center = true
end type
global w_product_new_response w_product_new_response

on w_product_new_response.create
call super::create
end on

on w_product_new_response.destroy
call super::destroy
end on

type cb_close from w_product_new`cb_close within w_product_new_response
boolean visible = true
end type

type cb_update from w_product_new`cb_update within w_product_new_response
boolean visible = true
end type

type dw_product from w_product_new`dw_product within w_product_new_response
end type

