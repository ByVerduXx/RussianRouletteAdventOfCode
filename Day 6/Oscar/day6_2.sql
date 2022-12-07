create or replace function fn () 
returns numeric as $$
declare ind numeric := 1;
declare acabado bool := false;
begin
while not acabado and ind < 4096 loop 
	if (select count(*) from (select distinct caracter from (select * from b limit 14 offset ind) as t) as j) = 14 then
		acabado := true;
	end if;
	ind := ind +1;
end loop;
ind := ind + 13;
return ind;
end;
$$
LANGUAGE plpgsql;
select fn();