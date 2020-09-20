select * from [dbo].[Scholastic_Challenge_Dataset]
where title like '%Ten Little Pumpkins%' 
and CH1_GENRE is not null

select title from [dbo].[Scholastic_Challenge_Dataset]
where title like '%Puppy Dog Pals: Lucky Pups%' 
----and CH1_GENRE is not null
--order by CH1_THEME, title

select title, CH1_genre, ch1_theme from [dbo].[Scholastic_Challenge_Dataset]
where CH1_THEME = '[''Dinosaurs'', ''Reading & Literacy'', ''Behavior & Manners'', ''Animals'']'
and ch1_genre is not null

select title, CH1_genre, ch1_theme from [dbo].[Scholastic_Challenge_Dataset]
where CH1_THEME = '[''Kindness'', ''Character & Values'']'
and ch1_genre is not null

select distinct(CH1_genre),title,  ch1_theme from [dbo].[Scholastic_Challenge_Dataset]
where CH1_GENRE like '%fiction%'


--update [dbo].[Scholastic_Challenge_Dataset]
--set CH1_GENRE = '[''Records, Fun Facts & Interactive'', ''Informative Nonfiction'']'
--where title like '%Guinness World Records 2019%'


--update [dbo].[Scholastic_Challenge_Dataset]
--set CH1_GENRE = '[''Humor & Funny Stories'']'
--where title like '%Pete the Cat and the Missing Cupcakes%' 
--and CH1_GENRE is null

--update [dbo].[Scholastic_Challenge_Dataset]
--set CH1_GENRE = '[''Children''s Fiction'']'
--where title like '%Try a Little Kindness%' 
--and CH1_GENRE is null


--update [dbo].[Scholastic_Challenge_Dataset]
--set CH1_GENRE = '[''Juvenile Fiction'']'
--where title like '%Pete the Cat: Firefighter Pete%' 
--and CH1_GENRE is null

--update [dbo].[Scholastic_Challenge_Dataset]
--set CH1_GENRE = '[''Fiction'']'
--where title like '%Pete the Cat: Trick or Pete%' 
--and CH1_GENRE is null


--update [dbo].[Scholastic_Challenge_Dataset]
--set CH1_GENRE = '[''Fiction'']'
--where title like '%How Do Dinosaurs Learn to Read?%' 
--and CH1_GENRE is null

--update [dbo].[Scholastic_Challenge_Dataset]
--set CH1_GENRE = '[''Animal Stories'', ''Humor & Funny Stories'']'
--where title like '%Pig the Pug%' 
--and CH1_GENRE is null


--update [dbo].[Scholastic_Challenge_Dataset]
--set CH1_GENRE = '[''Fiction'']'
--where title like '%Pout-Pout Fish and the Bully-Bully Shark, The%' 
--and CH1_GENRE is null

--update [dbo].[Scholastic_Challenge_Dataset]
--set CH1_GENRE = '[''Fiction'']'
--where title in ('')
--and CH1_GENRE is null

--update [dbo].[Scholastic_Challenge_Dataset]
--set CH1_GENRE = '[''Fiction'', ''Bedtime Story'']'
--where title in ('Mighty, Mighty Construction Site')
--and CH1_GENRE is null

--update [dbo].[Scholastic_Challenge_Dataset]
--set CH1_GENRE = '[''Humor & Funny Stories'', ''Fiction'']'
--where title like '%We Are the Groovicorns?%' 
--and CH1_GENRE is null

update [dbo].[Scholastic_Challenge_Dataset]
set LEXILE_11_DESC = '450L'
where title like '%PAW Patrol: Chase''s Loose Tooth%' 
and LEXILE_11_DESC is null


select title, count(title) as nullValues from [dbo].[Scholastic_Challenge_Dataset]
where  LEXILE_11_DESC is null
group by title, CH1_GENRE, LEXILE_11_DESC
order by nullValues desc


select CH2_CATEGORY,LEXILE_11_DESC  from [dbo].[Scholastic_Challenge_Dataset]
--where  LEXILE_11_DESC is null
group by CH2_CATEGORY, LEXILE_11_DESC
order by CH2_CATEGORY desc

Select Distinct top 10 (LEXILE_11_DESC) from [dbo].[Scholastic_Challenge_Dataset]
where LEXILE_11_DESC is not null

select LEXILE_11_DESC from [dbo].[Scholastic_Challenge_Dataset] 
where LEXILE_11_DESC is null

select count(distinct(CH1_GENRE)) from [dbo].[Scholastic_Challenge_Dataset] 
where CH1_GENRE like '%Fiction%'

select HHI_Band, Sum(total_units) from [dbo].[Scholastic_Challenge_Dataset] 
group by HHI_BAND
