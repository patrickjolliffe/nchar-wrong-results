alter session set "_small_table_threshold"=1;
drop table fcwrnc purge;
create table fcwrnc (nc nchar(8)) storage(cell_flash_cache keep);
alter session set cell_offload_processing=FALSE;
insert /*+append*/ into fcwrnc (nc) select case when mod(rownum, 1000) = 0 then '1' else '0' end from dual connect by level < 52604  ;
COMMIT;
select count(*) from fcwrnc where nc like '1%';
alter session set cell_offload_processing=TRUE;
select count(*) from fcwrnc where nc like '1%';
exec sys.dbms_session.sleep(1);
select count(*) from fcwrnc where nc like '1%';
exit;