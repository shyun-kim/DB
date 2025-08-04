use hrdb2019;
show tables;
select database();

/********************************************************************
	book_market_books : 도서리스트 테이블
    book_market_cart : 장바구니 테이블
    book_market_member : 회원 테이블
********************************************************************/


-- drop table book_market_books;
-- drop trigger trg_books;
create table book_market_books (
	isbn		char(8)			primary key, -- trigger 생성 필요
    title		varchar(20) 	not null,
    price		int,
    author		varchar(10),
    subtitle	varchar(30),
    genre		varchar(10),
    date		date
);

create table book_market_cart (
	isbn		char(8)			primary key,
    quantity	int,
    total_price	int
);

create table book_market_member (
	name		varchar(4)		not null,
    phone		char(11),
    address		varchar(30)
);

delimiter $$
create trigger trg_books
before insert on book_market_books
for each row
begin
declare max_code int;

select ifnull(max(cast(right(isbn,4) as unsigned)), 0)
into max_code
from book_market_books;

set new.isbn = concat('ISBN', lpad(max_code+1, 4, '0'));

end $$
delimiter ;

insert into book_market_books(title, price, author, subtitle, genre, date)
	values("쉽게 배우는 JSP 웹 프로그래밍", 27000, "송미영", "단계별로 쇼핑몰을 구현하며 배우는 JSP 웹 프로그래밍", "IT전문서", now());
    
insert into book_market_books(title, price, author, subtitle, genre, date)
	values("안드로이드 프로그래밍", 3300, "우재남", "실습 단계별 명쾌한 멘토링!", "IT전문서", now());

insert into book_market_books(title, price, author, subtitle, genre, date)
	values("스크래치", 22000, "고광일", "컴퓨팅 사고력을 키우는 블록 코딩", "컴퓨터 입문", curdate());


select *
from book_market_books;
desc book_market_member;

insert into book_market_member(name, phone, address)
	values("홍길동", '01012345678', "서울시 중구");

update book_market_books
			set title = '안드로이드 프로그래밍', price = 33000, author = '우재남', subtitle = '실습 단계별 명쾌한 멘토링!', genre = 'IT전문서'
			where isbn = 'isbn0002';
            
update book_market_member
	set phone = '01012345678'
    where name = '홍길동';
            
set sql_safe_updates = 0;

insert into book_market_cart(isbn, quantity, total_price)
values()
                