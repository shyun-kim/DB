use hrdb2019;
select database();

-- 테이블 3개 생성, book_tj, book_yes24, book_aladin
-- bid: pk('B001', 트리거 생성), title, author, price, isbn(랜덤 정수 4자리 생성), bdate

insert into book_tj(title, author, price, isbn, bdate)
values('A', '김갑수', 15000, rand()*10000, now());

select*
from book_tj;

delete from book_tj
where title = 'A';
set sql_safe_updates = 0;

select * from information_schema.triggers;

drop table book_aladin;
drop trigger trg_book_tj_bid;
drop trigger trg_book_yes24_bid;
drop trigger trg_book_aladin_bid;

create table book_tj(
	bid		char(4)			primary key,
    title	varchar(20)	not null,
    author	varchar(4),
    price	int,
    isbn	int,
    bdate	datetime
);

create table book_yes24(
	bid		char(4)		primary key,
    title	varchar(20)	not null,
    author	varchar(4),
    price	int,
    isbn	int,
    bdate	datetime
);

create table book_aladin(
	bid		char(4)		primary key,
    title	varchar(20)	not null,
    author	varchar(4),
    price	int,
    isbn	int,
    bdate	datetime
);

/***********************************************************/
delimiter $$
create trigger trg_book_tj_bid
before insert on book_tj -- 테이블명
for each row
begin
-- bid 생성 시 B001 생성
declare max_code int;

-- 현재 저장된 값 중 가장 큰 값을 가져옴
select ifnull(max(cast(right(bid,3) as unsigned)), 0)
into max_code
from book_tj;

-- 'B001' 형식으로 아이디 생성, LPAD(값, 크기, 채워지는 문자 형식)
-- 왼쪽이 아니라 오른쪽에 0을 붙이고 싶으면 RPAD 사용
set new.bid = concat('B', lpad(max_code+1, 3, '0'));

end $$
/***********************************************************/

/***********************************************************/
delimiter $$
create trigger trg_book_yes24_bid
before insert on book_yes24 -- 테이블명
for each row
begin
-- bid 생성 시 B001 생성
declare max_code int;

-- 현재 저장된 값 중 가장 큰 값을 가져옴
select ifnull(max(cast(right(bid,3) as unsigned)), 0)
into max_code
from book_yes24;

-- 'B001' 형식으로 아이디 생성, LPAD(값, 크기, 채워지는 문자 형식)
-- 왼쪽이 아니라 오른쪽에 0을 붙이고 싶으면 RPAD 사용
set new.bid = concat('B', lpad(max_code+1, 3, '0'));

end $$
/***********************************************************/

/***********************************************************/
delimiter $$
create trigger trg_book_aladin_bid
before insert on book_aladin -- 테이블명
for each row
begin
-- bid 생성 시 B001 생성
declare max_code int;

-- 현재 저장된 값 중 가장 큰 값을 가져옴
select ifnull(max(cast(right(bid,3) as unsigned)), 0)
into max_code
from book_aladin;

-- 'B001' 형식으로 아이디 생성, LPAD(값, 크기, 채워지는 문자 형식)
-- 왼쪽이 아니라 오른쪽에 0을 붙이고 싶으면 RPAD 사용
set new.bid = concat('B', lpad(max_code+1, 3, '0'));

end $$
/***********************************************************/

-- Connection 확인
show status like 'Threads_connected'; 	-- 접속 커넥션 수
show processlist;					 	-- 활성중인 커넥션
show variables like 'max_connections';	-- 최대 접속 가능 커넥션 수


select row_number() over(order by bid) as rno,
	bid, title, author, isbn, price, bdate
from book_tj;