drop table fcwrnc purge;
create table fcwrnc (nc nchar(4)) inmemory;
insert /*+append*/ into fcwrnc (nc) select mod(rownum, 10) from dual connect by level < 80000  ;
commit;
select count(*) from fcwrnc where nc like '1%';
exec sys.dbms_session.sleep(1);
select /*+inmemory*/ count(*) from fcwrnc where nc like '1%';
select /*+no_inmemory*/ count(*) from fcwrnc where nc like '1%';
exit;
