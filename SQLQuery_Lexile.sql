create table #temp1
(
title nvarchar(250),
total_count int
)

create table #temp2
(
title nvarchar(250),
LEXILE_11_DESC nvarchar(250),
total_count int
)

create table #temp3
(
title nvarchar(250),
LEXILE_11_DESC nvarchar(250)
)

select title, count(title) as nullValues 
INTO #temp1
from [dbo].[Scholastic_Challenge_Dataset]
where LEXILE_11_DESC is null
group by title
order by nullValues desc

select title, LEXILE_11_DESC, count(LEXILE_11_DESC) as Number_of_rows_with_genre 
INTO #temp2
from [dbo].[Scholastic_Challenge_Dataset]
where title in (select title from #temp1)
and LEXILE_11_DESC is not null
group by LEXILE_11_DESC, title
order by title

Select #temp1.title, #temp2.LEXILE_11_DESC 
INTO #temp3
from #temp1
left join #temp2
on #temp1.title = #temp2.title
where #temp2.LEXILE_11_DESC is not null

select * from #temp3
order by title

Declare @title_name nvarchar(250)

while exists (select * from #temp3)
Begin 
	select @title_name = (select top 1 title from #temp3 order by title)

update [dbo].[Scholastic_Challenge_Dataset]
set LEXILE_11_DESC = (select top 1 LEXILE_11_DESC from #temp3 where #temp3.title = @title_name order by title)
where title = @title_name 
and LEXILE_11_DESC is null

Delete from #temp3 where title = @title_name

end

drop table #temp1
drop table #temp2
drop table #temp3