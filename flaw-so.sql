procedure lookup_map_ccl_table
                      (  p_id           IN VARCHAR2
                       , p_nav          IN VARCHAR2
                       , p_trace        IN PLS_INTEGER
                       , p_nl_ctry_cd   IN syn_cls_types.t_ctry_cd
                       , p_first_ccl_cd IN syn_cls_types.t_us_ccl_cd
                       , p_last_ccl_cd  IN syn_cls_types.t_us_ccl_cd
                       , p_page_size    IN PLS_INTEGER
                       , p_error_cd     IN syn_cls_errors.t_error_no
                       , p_us_ccl_cd    IN syn_cls_types.t_us_ccl_cd
                          , p_cims_ccl_cd  IN syn_cls_snf2_tmpl_cims.t_cims_us_ccl_cd
                         , p_tech_cd      IN syn_cls_snf2_tmpl_cims.t_cims_tech_cd
              , p_filter_us_ccl_cd IN syn_cls_types.t_us_ccl_cd
              , p_filter_cims_ccl_cd IN syn_cls_snf2_tmpl_cims.t_cims_us_ccl_cd               , p_filter_tech_cd IN syn_cls_snf2_tmpl_cims.t_cims_tech_cd
              , p_error_txt_passed IN VARCHAR2
-- The Parameter below is introduced for SWH SiteMinder
            , RememberMe    IN VARCHAR2                DEFAULT NULL
              )

is
   v_first_ccl_cd   syn_cls_types.t_us_ccl_cd;
   v_last_ccl_cd    syn_cls_types.t_us_ccl_cd;
   v_error_no       syn_cls_errors.t_error_no    := syn_cls_errors.ERR_OK;
   v_aktTrace       syn_cls_trace.t_trace        := syn_cls_trace.trace_init( p_Trace <> syn_cls_constants.CONST_FALSE_INT );
   v_output         syn_cls_www_template.t_outputcontents;
   v_line_output    syn_cls_www_template.t_outputcontents;
   v_cla_user       syn_cls_types.t_cla_user;
   v_cla_websession syn_cls_types.t_cla_websession;
   v_cid            PLS_INTEGER;
   v_ignore         PLS_INTEGER;

   v_base1_table    DBMS_SQL.VARCHAR2_TABLE;
   v_base2_table    DBMS_SQL.VARCHAR2_TABLE;
   v_base3_table    DBMS_SQL.VARCHAR2_TABLE;
   v_index_1        PLS_INTEGER := 1.0;
   v_index_2        PLS_INTEGER := 1.0;
   v_index_3        PLS_INTEGER := 1.0;
   v_no_found       PLS_INTEGER := 0.0;
   v_conv_table     owa_text.multi_line := owa_text.new_multi;  -- collect table output in here
   v_order_desc     BOOLEAN := (p_nav = syn_cls_constants.CONST_NAV_PREVIOUS
                              OR p_nav = syn_cls_constants.CONST_NAV_LAST );
   v_template_nm    syn_cls_types.t_template_nm  := SYN_CLS_SNF2_TMPL_CIMS.NAME_SNF2_ADM_US_CCL_MAP_TBL;
   v_heading        syn_cls_types.t_template_dtl := owa_util.ite(p_id = 'CIMS', SYN_CLS_SNF2_TMPL_CIMS.PAGETITLE_CIMS_TO_CLASS_MAP, SYN_CLS_SNF2_TMPL_CIMS.PAGETITLE_CLASS_TO_CIMS_MAP);
   v_where          syn_cls_admin_library.t_where;
   pagesize_option_list  syn_cls_types.t_template_dtl := '';
   curr_page_size   PLS_INTEGER;
   like_comand      syn_cls_types.t_template_dtl;
   v_ccl_cd         VARCHAR2(256);

   TBL_NAME         syn_cls_types.t_template_dtl;

   SELECT_CCL_TAB        syn_cls_types.t_template_dtl;
   ORDER_CCL_TAB_ASC     syn_cls_types.t_template_dtl;
   ORDER_CCL_TAB_DESC    syn_cls_types.t_template_dtl;

   v_line_idx           PLS_INTEGER;
begin

   if p_id = 'CLASS' then
    TBL_NAME := 'CLA_US_CCL_CLASS_TO_CIMS';
   elsif p_id = 'CIMS' then
    TBL_NAME := 'CLA_US_CCL_CIMS_TO_CLASS';
   end if;

   --syn_cls_trace.trace_it( p_Trace, TRACEUS_CCL_TABLE,'test');
  SELECT_CCL_TAB := 'SELECT US_CCL_CD, CIMS_US_CCL_CD, CIMS_TECH_CD  FROM ' || TBL_NAME;
  ORDER_CCL_TAB_ASC := 'ORDER BY US_CCL_CD ASC';
  ORDER_CCL_TAB_DESC := 'ORDER BY US_CCL_CD DESC';

  curr_page_size := syn_cls_admin_library.define_default_page_size(CCL_TBL_PAGE_SIZE_OPTS,pagesize_option_list,p_page_size);

  if (p_filter_us_ccl_cd is null OR INSTR(p_filter_us_ccl_cd, FILTER_ALL) = 0) then
        like_comand := ' (( US_CCL_CD ) Like ''' || p_filter_us_ccl_cd || FILTER_ALL  || ''') AND';
  else
        like_comand := ' (( US_CCL_CD ) Like ''' || p_filter_us_ccl_cd || ''') AND';
  end if;

  if (p_filter_cims_ccl_cd is null OR INSTR(p_filter_cims_ccl_cd, FILTER_ALL) = 0) then
      like_comand := like_comand || ' (( CIMS_US_CCL_CD ) Like ''' || p_filter_cims_ccl_cd || FILTER_ALL || ''') AND';
  else
      like_comand := like_comand || ' (( CIMS_US_CCL_CD ) Like ''' || p_filter_cims_ccl_cd || ''') AND';
  end if;

  if (p_filter_tech_cd is null OR INSTR(p_filter_tech_cd, FILTER_ALL) = 0) then
      like_comand := like_comand || ' (( CIMS_TECH_CD ) Like ''' || p_filter_tech_cd || FILTER_ALL || ''') ';
  else
      like_comand := like_comand || ' (( CIMS_TECH_CD ) Like ''' || p_filter_tech_cd || ''') ';
  end if;
/*
  like_comand := ' (( US_CCL_CD ) Like ''' || p_filter_us_ccl_cd  || ''') AND' ||
                 ' (( CIMS_US_CCL_CD ) Like ''' || p_filter_cims_ccl_cd || ''') AND' ||
                 ' (( CIMS_TECH_CD ) Like ''' || p_filter_tech_cd     || ''') ';
*/
  v_where( ASCII(syn_cls_constants.CONST_NAV_FIRST) )   := SELECT_CCL_TAB || ' Where' || like_comand || ORDER_CCL_TAB_ASC;
  v_where( ASCII(syn_cls_constants.CONST_NAV_LAST ) )   := SELECT_CCL_TAB || ' Where' || like_comand || ORDER_CCL_TAB_DESC;
  v_where( ASCII(syn_cls_constants.CONST_NAV_NEXT ) )   := SELECT_CCL_TAB || ' Where' || like_comand
                            || ' And ( US_CCL_CD >= ''' || p_last_ccl_cd  || ' '') ' || ORDER_CCL_TAB_ASC;
  v_where( ASCII(syn_cls_constants.CONST_NAV_PREVIOUS)) := SELECT_CCL_TAB || ' Where' || like_comand
                            || ' And ( US_CCL_CD <= ''' || p_first_ccl_cd || ' '') ' || ORDER_CCL_TAB_DESC;

  -- check user session, issue login screen if necessary
  syn_cls_www_access.checkAndInitUserSession( v_aktTrace
                                              , v_cla_user
                                              , v_cla_websession
                                              , v_template_nm
                                              , v_heading
                                              , v_error_no
                                              --, owa_util.ite(p_id='CIMS',syn_cls_grants.GRNT_ADMEXPUS,syn_cls_grants.GRNT_ADMEXPEU)
                                              , syn_cls_grants.GRNT_ADMCIMSMAP );
                                              --, syn_cls_grants.GRNT_INLOGIN );

   if ( v_error_no <> syn_cls_errors.ERR_OK ) then
      syn_cls_www_template.getOutputFields( v_aktTrace, v_output,v_template_nm);
      syn_cls_www_access.prepare_login_template(v_akttrace, v_output, v_error_no, FALSE);
      GOTO ccl_label;
   end if;

   -- read the HTML template for Main
   syn_cls_www_template.getOutputFields(  v_aktTrace
                                        , v_line_output
                                        , v_template_nm
                                        , p_nl_ctry_cd );

   -- compose the dynamic SQL-statement, bind local variables and execute it
   v_cid := DBMS_SQL.OPEN_CURSOR;
   dbms_sql.parse( v_cid, v_where( ASCII( p_nav)), dbms_sql.NATIVE );