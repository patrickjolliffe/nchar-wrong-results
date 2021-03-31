drop table fcwrnc purge;
create table fcwrnc (nc nvarchar2(1)) inmemory;
insert /*+append*/ into fcwrnc (nc) select mod(rownum, 10) from dual connect by level < 4000;
commit;
select count(*) from fcwrnc where nc like '1%';
exec sys.dbms_session.sleep(1);
select count(*) from fcwrnc where nc like '1%';
exit;
