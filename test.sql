DECLARE OneCursor Cursor  for
	select st_name,st_age,st_remark from studio
	where cl_id=2

go

open OneCursor1               -- 打开游标

fetch next from OneCursor1    -- 读取游标

close OneCursor1              -- 关闭游标

deallocate onecursor1         -- 删除游标


declare onecursor2 Cursor
dynamic						  -- 改成动态的

for 
	select st_id,st_name,st_age,st_remark,cl_id from studio where st_id<=10
go

open onecursor2

fetch first from onecursor2

fetch last from onecursor2


--测试一个新的游标


declare into_test Cursor
for 
	select st_id,st_name from studio
go
open into_test

declare @id  int,@name varchar(10);

fetch next from into_test into @id,@name;

while @@fetch_status=0
begin
	print convert(char(2),@id) + "--------"+ @name;
	fetch next from into_test into @id,@name --移动到下一行，并将顺序填充到变量中
end
close into_test;
deallocate into_test;

--修改

 declare modify_test Cursor
 dynamic
 for 
 	select st_id,st_name from studio
 for 
 	update of st_id,st_name;
 go

 open modify_test;
 fecth last from modify_test;
 update studio set st_name="baaoma" where current of modify_test;

 close modify_test;
 deallocate modify_test;

 --定义一个函数

 create function getweekday
 (@date datetime)
 return int 
 as

 return datepart(weekday,$date)
 end;

 go
 -- 定义函数

 use  stu_test
 go
 create function dbo.getoutlay
 (@cl_id int ,@price money)
 return money
 as
 begin 
 	DECLARE $count int, @money money;
 	select @count=count(st_id) from studio where cl_id=@cl_id;
 	set @money=@count * @price;
 	return @money;
 end
 go
-- 调用
 select dbo.getoutlay(3,32.5)


 create function dbo.eligibility
 (@co_id int )
 returns @students table (
 	  id int primary key,
 	  st_name varchar(30),
 	  co_name varchar(50),
 	  result tinyint)

 as 
 begin	
 	--声明变量
 	declare @id int,@set_name varchar(30),@co_name varchar(50),@result tinyint;
 	--获得课程名称
 	select @co_name=co_name from courese where co_id=@co_id;
 	--声明游标
 	declare stu Cursor
 	for select st_id,st_name from studio;
 	open stu
 	fetch next from stu into @id,@stu_name  --读取游标并复制给变量
 	while @@fecth_status=0
 	begin 
 		if(@id>0) --如果学生编号大于0，将成绩查询出来给变量
 		begin	
 			select @result = a_number from achievement
 			while co_id=@co_id and st_id=@st_id
 			if(@result>=60)
 			begin
 				insert into @students(id,st_name,co_name,result) value (@id,@st_name,@co_name,@result);
 				end
 			end
 		fetch next from stu into @id,@st_name;

 	end
 	return
 end

go

--shiyong
select * from dbo.eligibility(2)


--查看自定义函数
--第一种方式
select definition from sys.sql_moduler where object_id=object_id('dbo.eligibility');

--第二种方式
select object_definition(object_jd("dbo.eligibility"));

--第三种方式
exec sp_helptext eligibility;

--修改函数
alter function dbo.eligibility

--删除函数
drop function dbo.eligibility

create proc thc_proc
	@in int =1

as	
	--下面这个select使用了上面的参数作为条件
	select * from studio where st_id =@id

go
--调用存储过程
execute thc_proc 2
go

--触发器

use stu_test
go

create trigger off_dropandalter
on database
for create_table,drop_table,alter_table
as
	print "创建表 不行"
	rollback;


--创建表触发器
use stu_test

create trigger tablemonitor
on database
for create_table  --触发器动作为创建表
as
begin
	DECLARE @tsqlcommand nvarechar(max);
	-- 使用eventdata 函数获取事件源
	 select $tsqlcommand=eventdata().value('(/event_instance/tsqlcommand)[1]','nvarchar(max)')
	 
	print original_login() + '使用了'+ @tsqlcommand +"创建了一个表";
end
-- 表触发器
use stu_test

go
create trigger tri_zone_insert
on zone
for insert
as	
	print "插入了一行新数据"

go

begin tran save_test
	delete from zone where id=18

save tran one;

	delete from zone where id=16;
declare @state int;

set @state = 0;

if (@state=0)
	rollback tran;
else if (@state=1)
	rollback tran one;
else
commit tran save_test;

--使用全文检索
select content,title from news where contains(title,'中国') and content like "%经济%";

select content,tile from news where contains (title,'formosof(inflectional,go)');

select id,content,title from news where contains(content,'"中国" near  "东盟"');

select id,content,title from news where contains(content,'isabout("国际" weight(0.3),"中国" weight(0.9))')

select id,content,title from news where freetext(content,"全世界的基金经理");

select n_tbl.title,n_tbl.content,key_tbl.rank from news as n_tbl inner join containstable(news,content,'isabout("中国" weight(0.8),"经济" weight(0.4),"证卷" weight(0.2))') as key_tbl
on n_tbl.id = key_tbl.[key] order by key_tbl.rank desc;

select id,content,title,exfile from news where contains(exfile,'数据库');
