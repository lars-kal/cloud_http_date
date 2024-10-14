CLASS zcl_srv_lk_http_date DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_http_service_extension.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_srv_lk_http_date IMPLEMENTATION.

  METHOD if_http_service_extension~handle_request.

    DATA(user_formatted_name) = cl_abap_context_info=>get_user_formatted_name( ).
    DATA(system_date) = cl_abap_context_info=>get_system_date( ).

    DATA(res_html) = |<html> \n| &&
    |<body> \n| &&
    |<title>General Information</title> \n| &&
    |<p style="color:DodgerBlue;"> Hello there, { user_formatted_name } </p> \n | &&
    |<p> Today, the date is:  { system_date }| &&
    |<p> | &&
    |</body> \n| &&
    |</html> | .

    response->set_text( res_html ).

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    DATA(lv_date) = sy-datum.

    TRY.
        DATA(lo_fcal_run) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime(
                 iv_factorycalendar_id = 'Z_HR' ).
      CATCH cx_fhc_runtime INTO DATA(lx_err).
        "exception handling
    ENDTRY.

    TRY.

        DATA(lv_end) = lo_fcal_run->add_workingdays_to_date(
            iv_start                 = lv_date
            iv_number_of_workingdays = 5
        ).


        DATA(lv_check) = lo_fcal_run->is_date_workingday(
            iv_date       = lv_date
        ).

      CATCH cx_fhc_runtime.
        "handle exception
    ENDTRY.


    "subtract_workingdays_from_date


  ENDMETHOD.

ENDCLASS.
