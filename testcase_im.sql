drop table fcwrnc purge;

create table fcwrnc (nc nvarchar2(1)) inmemory;

insert /*+append*/ into fcwrnc (nc) select mod(rownum, 2) from dual connect by level < 4000;

commit;

select count(*) from fcwrnc where nc like '1%';

exec sys.dbms_session.sleep(1);

select count(*) 
   from fcwrnc
   where nc like '1%';

select /*+ no_inmemory */ count(*) 
   from fcwrnc
   where nc like '1%';

alter session set "_kdz_pcode_flags" = 1;

select count(*) from fcwrnc where nc like '1%';

exit;


