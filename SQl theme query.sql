create table #temp1
(
title nvarchar(250),
total_count int
)

create table #temp2
(
title nvarchar(250),
CH1_Theme nvarchar(250),
total_count int
)

create table #temp3
(
title nvarchar(250),
CH1_Theme nvarchar(250)
)

select title, count(title) as nullValues 
INTO #temp1
from [dbo].[Scholastic_Challenge_Dataset]
where CH1_THEME is null
group by title
order by nullValues desc

select title, CH1_THEME, count(CH1_THEME) as Number_of_rows_with_genre 
INTO #temp2
from [dbo].[Scholastic_Challenge_Dataset]
where title in (select title from #temp1)
and CH1_THEME is not null
group by CH1_THEME, title
order by title

Select #temp1.title, #temp2.CH1_THEME 
INTO #temp3
from #temp1
left join #temp2
on #temp1.title = #temp2.title
where #temp2.CH1_THEME is not null

select * from #temp3
order by title

Declare @title_name nvarchar(250)

while exists (select * from #temp3)
Begin 
	select @title_name = (select top 1 title from #temp3 order by title)

update [dbo].[Scholastic_Challenge_Dataset]
set CH1_THEME = (select top 1 CH1_THEME from #temp3 where #temp3.title = @title_name order by title)
where title = @title_name 
and CH1_THEME is null

Delete from #temp3 where title = @title_name

end

drop table #temp1
drop table #temp2
drop table #temp3