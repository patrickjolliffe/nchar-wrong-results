alter session set "_serial_direct_read"=always;
alter session set "_small_table_threshold"=1;
drop table fcwrnc purge;
create table fcwrnc (b blob, nc nchar(30)) storage(cell_flash_cache keep);
alter session set cell_offload_processing=FALSE;
insert /*+append*/ into fcwrnc (b, nc) select null,  case when mod(rownum, 1000) = 0 then '7' else '0' end || '99_' from dual connect by level < 52604  ;
COMMIT;
select to_char(sysdate, 'hh24:mi:ss'), count(*) from fcwrnc where nc like '7%' group by to_char(sysdate, 'hh24:mi:ss');

alter session set cell_offload_processing=TRUE;
select to_char(sysdate, 'hh24:mi:ss'), count(*) from fcwrnc where nc like '7%' group by to_char(sysdate, 'hh24:mi:ss');
/*Wait a while, between 1 and 10 minutes*/ 
select to_char(sysdate, 'hh24:mi:ss'), count(*) from fcwrnc where nc like '7%' group by to_char(sysdate, 'hh24:mi:ss');
exit;