create or replace function fn () 
returns numeric as $$
declare ind numeric := 1;
declare acabado bool := false;
begin
while not acabado loop 
	if (select count(*) from (select distinct caracter from (select * from b limit 4 offset ind) as t) as j) = 4 then
		acabado := true;
	end if;
	ind := ind +1;
end loop;
ind := ind + 3;
return ind;
end;
$$
LANGUAGE plpgsql;
select fn();