/******************************************************
		실습 데이터베이스 연결 : myshop2019
		실습 내용 - 기본적인 데이터 조회 	 
******************************************************/
show tables;

-- Q01) customer 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
desc customer;

-- Q02) employee 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
desc employee;

-- Q03) product 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
desc product;

-- Q04) order_header 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
desc order_header;

-- Q05) order_detail 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
desc order_detail;

-- Q06) 모든 고객의 아이디, 이름, 지역, 성별, 이메일, 전화번호를 조회하세요.
select customer_id, customer_name, city, gender, email, phone
from customer;

-- Q07) 모든 직원의 이름, 사원번호, 성별, 입사일, 전화번호를 조회하세요.
select employee_name, employee_id, gender, hire_date, phone
from employee;

-- Q08) 이름이 '홍길동'인 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where customer_name = '홍길동';

-- Q09) 여자 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where gender = 'f';

-- Q10) '울산' 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where city = '울산';

-- Q11) 포인트가 500,000 이상인 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where point >= 500000;

-- Q12) 이름에 공백이 들어간 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where customer_name like '% %';

-- Q13) 전화번호가 010으로 시작하지 않는 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where phone not like "010%";

-- Q14) 포인트가 500,000 이상 '서울' 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where point >= 500000 and city = '서울';

-- Q15) 포인트가 500,000 이상인 '서울' 이외 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where point >= 500000 and city != '서울';

-- Q16) 포인트가 400,000 이상인 '서울' 지역 남자 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where point >= 400000 and city = '서울' and gender = 'm';

-- Q17) '강릉' 또는 '원주' 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where city = '강릉' or city = '원주';

-- Q18) '서울' 또는 '부산' 또는 '제주' 또는 '인천' 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where city in ('서울','부산','제주','인천');

-- Q19) 포인트가 400,000 이상, 500,000 이하인 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where point between 400000 and 500000;

-- Q20) 1990년에 출생한 고객의 이름, 아이디, 성별, 지역, 전화번호, 생일, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where birth_date like '1990%';

-- Q21) 1990년에 출생한 여자 고객의 이름, 아이디, 성별, 지역, 전화번호, 생일, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where birth_date like '1990%' and gender = 'f';

-- Q22) 1990년에 출생한 '대구' 또는 '경주' 지역 남자 고객의 이름, 아이디, 성별, 지역, 전화번호, 생일, 포인트를 조회하세요.
select customer_name, customer_id, gender, city, phone, point
from customer
where birth_date like '1990%' and gender = 'm' and city in ('대구','경주');

-- Q23) 1990년에 출생한 남자 고객의 이름, 아이디, 성별, 지역, 전화번호, 생일, 포인트를 조회하세요.
--      단, 홍길동(gildong) 형태로 이름과 아이디를 묶어서 조회하세요.
select customer_name, customer_id , gender, city, phone, point
from customer
where birth_date like '1990%' and gender = 'm';

-- Q24) 근무중인 직원의 이름, 사원번호, 성별, 전화번호, 입사일를 조회하세요.
select employee_name, employee_id, gender, phone, hire_date
from employee
where retire_date is null;

-- Q25) 근무중인 남자 직원의 이름, 사원번호, 성별, 전화번호, 입사일를 조회하세요.
select employee_name, employee_id, gender, phone, hire_date
from employee
where retire_date is null and gender = 'm';

-- Q26) 퇴사한 직원의 이름, 사원번호, 성별, 전화번호, 입사일, 퇴사일를 조회하세요.
select employee_name, employee_id, gender, phone, hire_date, retire_date
from employee
where retire_date is not null;

-- Q28) 2019-01-01 ~ 2019-01-07 기간 주문의 주문번호, 고객아이디, 사원번호, 주문일시, 소계, 배송비, 전체금액을 조회하세요.
--      단, 고객아이디를 기준으로 오름차순 정렬해서 조회하세요.
select order_id, customer_id, employee_id, order_date, sub_total, delivery_fee, total_due
from order_header
where order_date between 20190101 and 20190107
order by customer_id asc;
    
-- Q29) 2019-01-01 ~ 2019-01-07 기간 주문의 주문번호, 고객아이디, 사원번호, 주문일시, 소계, 배송비, 전체금액을 조회하세요.
--      단, 전체금액을 기준으로 내림차순 정렬해서 조회하세요.
select order_id, customer_id, employee_id, order_date, sub_total, delivery_fee, total_due
from order_header
where order_date between 20190101 and 20190107
order by total_due desc;

-- Q30) 2019-01-01 ~ 2019-01-07 기간 주문의 주문번호, 고객아이디, 사원번호, 주문일시, 소계, 배송비, 전체금액을 조회하세요.
--      단, 사원번호를 기준으로 오름차순, 같은 사원번호는 주문일시를 기준으로 내림차순 정렬해서 조회하세요.
select order_id, customer_id, employee_id, order_date, sub_total, delivery_fee, total_due
from order_header
where order_date between 20190101 and 20190107
order by employee_id asc, order_date desc;


/**
	그룹함수
**/
/** customer 테이블 사용 **/
-- Q01) 고객의 포인트 합을 조회하세요.
select sum(point)
from customer;

-- Q02) '서울' 지역 고객의 포인트 합을 조회하세요.
select sum(point)
from customer
where city = '서울';

-- Q03) '서울' 지역 고객의 수를 조회하세요.
select count(*)
from customer
where city = '서울';

-- Q04) '서울' 지역 고객의 포인트 합과 평균을 조회하세요.
select sum(point), floor(avg(point))
from customer
where city = "서울";
     
-- Q05) '서울' 지역 고객의 포인트 합, 평균, 최댓값, 최솟값을 조회하세요.
select sum(point), floor(avg(point)), max(point), min(point)
from customer
where city = '서울';

-- Q06) 남녀별 고객의 수를 조회하세요.
select sum(gender = 'f') as '여성', sum(gender = 'm') as '남성'
from customer;

-- Q07) 지역별 고객의 수를 조회하세요.
--      단, 지역 이름을 기준으로 오름차순 정렬해서 조회하세요.
select city, count(*) as 고객수
from customer
group by city
order by city asc;

-- Q08) 지역별 고객의 수를 조회하세요.
--      단, 고객의 수가 10명 이상인 행만 지역 이름을 기준으로 오름차순 정렬해서 조회하세요.
select city, count(*) as 고객수
from customer
group by city
having count(*) >= 10
order by city asc;
    
-- Q09) 남녀별 포인트 합을 조회하세요.
select gender, sum(point)
from customer
group by gender;
    
-- Q10) 지역별 포인트 합을 조회하세요.
--      단, 지역 이름을 기준으로 오름차순 정렬해서 조회하세요.
select city, sum(ifnull(point,0)) as 포인트합
from customer
group by city
order by city asc;
    
-- Q11) 지역별 포인트 합을 조회하세요.
--      단, 포인트 합이 1,000,000 이상인 행만 포인트 합을 기준으로 내림차순 정렬해서 조회하세요.
select city, sum(ifnull(point,0)) as 포인트합
from customer
group by city
having sum(ifnull(point,0)) >= 1000000
order by 포인트합 desc;
      
-- Q12) 지역별 포인트 합을 조회하세요.
--      단, 포인트 합을 기준으로 내림차순 정렬해서 조회하세요.
select city, sum(ifnull(point,0)) as 포인트합
from customer
group by city
order by 포인트합 desc;

-- Q13) 지역별 고객의 수, 포인트 합을 조회하세요.
--      단, 지역 이름을 기준으로 오름차순 정렬해서 조회하세요.
select city, sum(ifnull(point,0)) as 포인트합, count(*) as 고객수
from customer
group by city
order by city asc;


-- Q14) 지역별 포인트 합, 포인트 평균을 조회하세요.
--      단, 포인트가 NULL이 아닌 고객을 대상으로 하며, 지역 이름을 기준으로 오름차순 정렬해서 조회하세요.
select city, sum(point), floor(avg(point))
from customer
where point is not null
group by city
order by city asc;

-- Q15) '서울', '부산', '대구' 지역 고객의 지역별, 남녀별 포인트 합과 평균을 조회하세요.
--      단, 지역 이름을 기준으로 오름차순, 같은 지역은 성별을 기준으로 오름차순 정렬해서 조회하세요.
select city, gender, format(sum(point),0), format(avg(point),0)
from customer
where city in ('서울', '부산', '대구')
group by city, gender
order by city asc, gender asc;



/** order_header 테이블 사용 **/
    
-- Q16) 2019년 1월 주문에 대하여 고객아이디별 전체금액 합을 조회하세요.
select *
from order_header;

select order_date, customer_id, sum(total_due) as total_due
from order_header
where left(order_date, 4) = '2019' and substring(order_date, 6,2) = '01'
group by customer_id, order_date;

-- Q17) 주문연도별 전체금액 합계를 조회하세요.
select year(order_date), sum(total_due)
from order_header
group by year(order_date);

-- Q18) 2019.01 ~ 2019.06 기간 주문에 대하여 주문연도별, 주문월별 전체금액 합을 조회하세요.
select left(order_date, 4) as 연도, month(order_date) as 월별, sum(total_due) as 전체금액
from order_header
where left(order_date, 4)='2019'and month(order_date) >= '01' and month(order_date) <= '06'
group by left(order_date, 4), month(order_date);


-- Q19) 2019.01 ~ 2019.06 기간 주문에 대하여 주문연도별, 주문월별 전체금액 합과 평균을 조회하세요.
select left(order_date, 4) as 연도, month(order_date) as 월별, format(sum(total_due),0) as 전체금액, format(avg(total_due),0) as 평균금액
from order_header
where left(order_date, 4)='2019'and month(order_date) >= '01' and month(order_date) <= '06'
group by left(order_date, 4), month(order_date);

-- Q20) 주문연도별, 주문월별 전체금액 합과 평균을 조회하고, rollup 함수를 이용하여 소계와 총계를 출력해주세요.
/** select 	year(order_date)), '총계', ifnull(year(order_date), '총계2')),
		if(grouping(month(order_date)), '소계', ifnull(month(order_date), '소계2')), */
        
select 	substring(order_date, 1,4) as 연도,
		substring(order_date,6,2) as 월,
        format(sum(total_due),0) 금액합계, 
        format(avg(total_due),0) 금액평균
from order_header
group by substring(order_date, 1,4), substring(order_date,6,2) with rollup;


select 	if(grouping(substring(order_date, 1,4)), '총계', ANY_VALUE(substring(order_date, 1,4))) as 연도,
		if(grouping(substring(order_date,6,2)), '소계', ANY_VALUE(substring(order_date,6,2))) as 월,
        format(sum(total_due),0) 금액합계, 
        format(avg(total_due),0) 금액평균
from order_header
group by substring(order_date, 1,4), substring(order_date,6,2) with rollup;



select 	if(grouping(dept_id), '총합계', ifnull(dept_id, '-')) as dept_id,
		count(*) count,
        format(sum(ifnull(salary, 0)), 0) sum,
        format(avg(ifnull(salary, 0)), 0) avg
from employee
-- where salary is not null
group by dept_id with rollup;

/**
	테이블 조인 : 기본 SQL 방식, ANSI SQL
*/
-- Q01) 전체금액이 8,500,000 이상인 주문의 주문번호, 고객아이디, 사원번호, 주문일시, 전체금액을 조회하세요.
select oh.order_id 주문번호, c.customer_id 고객아이디, e.employee_id 사원번호, oh.order_date 주문일시, oh.total_due 전체금액
from order_header oh, customer c, employee e
where c.customer_id = oh.customer_id 
and e.employee_id = oh.employee_id
and oh.total_due >= 8500000;

select oh.order_id 주문번호, c.customer_id 고객아이디, e.employee_id 사원번호, oh.order_date 주문일시, oh.total_due 전체금액
from order_header oh inner join customer c on oh.customer_id = c.customer_id
					inner join employee e on oh.employee_id = e.employee_id
where oh.total_due >= 8500000;


-- Q02) 위에서 작성한 쿼리문을 복사해 붙여 넣은 후 고객이름도 같이 조회되게 수정하세요.
select oh.order_id 주문번호, c.customer_id 고객아이디, e.employee_id 사원번호, oh.order_date 주문일시, oh.total_due 전체금액, c.customer_name 고객이름 
from order_header oh, customer c, employee e
where c.customer_id = oh.customer_id 
and e.employee_id = oh.employee_id
and oh.total_due >= 8500000;

select oh.order_id 주문번호, c.customer_id 고객아이디, e.employee_id 사원번호, oh.order_date 주문일시, oh.total_due 전체금액, c.customer_name 고객이름 
from order_header oh inner join customer c on oh.customer_id = c.customer_id
					inner join employee e on oh.employee_id = e.employee_id
where oh.total_due >= 8500000;

-- Q03) Q01 쿼리를 복사해 붙여 넣은 후 직원이름도 같이 조회되게 수정하세요.
select oh.order_id 주문번호, c.customer_id 고객아이디, e.employee_id 사원번호, oh.order_date 주문일시, oh.total_due 전체금액, e.employee_name 직원이름
from order_header oh, customer c, employee e
where c.customer_id = oh.customer_id 
and e.employee_id = oh.employee_id
and oh.total_due >= 8500000;

select oh.order_id 주문번호, c.customer_id 고객아이디, e.employee_id 사원번호, oh.order_date 주문일시, oh.total_due 전체금액, e.employee_name 직원이름
from order_header oh inner join customer c on oh.customer_id = c.customer_id
					inner join employee e on oh.employee_id = e.employee_id
where oh.total_due >= 8500000;

-- Q04) 위에서 작성한 쿼리문을 복사해 붙여 넣은 후 고객이름, 직원이름도 같이 조회되게 수정하세요.
select oh.order_id 주문번호, c.customer_id 고객아이디, e.employee_id 사원번호, oh.order_date 주문일시, oh.total_due 전체금액, c.customer_name 고객이름, e.employee_name 직원이름
from order_header oh, customer c, employee e
where c.customer_id = oh.customer_id 
and e.employee_id = oh.employee_id
and oh.total_due >= 8500000;

select oh.order_id 주문번호, c.customer_id 고객아이디, e.employee_id 사원번호, oh.order_date 주문일시, oh.total_due 전체금액, c.customer_name 고객이름, e.employee_name 직원이름
from order_header oh inner join customer c on oh.customer_id = c.customer_id
					inner join employee e on oh.employee_id = e.employee_id
where oh.total_due >= 8500000;

-- Q05) 위에서 작성한 쿼리문을 복사해 붙여 넣은 후 전체금액이 8,500,000 이상인 '서울' 지역 고객만 조회되게 수정하세요.
select oh.order_id 주문번호, c.customer_id 고객아이디, e.employee_id 사원번호, oh.order_date 주문일시, oh.total_due 전체금액, c.customer_name 고객이름, e.employee_name 직원이름
from order_header oh, customer c, employee e
where c.customer_id = oh.customer_id 
and e.employee_id = oh.employee_id
and oh.total_due >= 8500000 
and c.city = '서울';

select oh.order_id 주문번호, c.customer_id 고객아이디, e.employee_id 사원번호, oh.order_date 주문일시, oh.total_due 전체금액, c.customer_name 고객이름, e.employee_name 직원이름
from order_header oh inner join customer c on oh.customer_id = c.customer_id
					inner join employee e on oh.employee_id = e.employee_id
where oh.total_due >= 8500000
and c.city = '서울';

-- Q06) 위에서 작성한 쿼리문을 복사해 붙여 넣은 후 전체금액이 8,500,000 이상인 '서울' 지역 '남자' 고객만 조회되게 수정하세요.
select oh.order_id 주문번호, c.customer_id 고객아이디, e.employee_id 사원번호, oh.order_date 주문일시, oh.total_due 전체금액, c.customer_name 고객이름, e.employee_name 직원이름
from order_header oh, customer c, employee e
where c.customer_id = oh.customer_id 
and e.employee_id = oh.employee_id
and oh.total_due >= 8500000 
and c.city = '서울'
and c.gender = 'M';

select oh.order_id 주문번호, c.customer_id 고객아이디, e.employee_id 사원번호, oh.order_date 주문일시, oh.total_due 전체금액, c.customer_name 고객이름, e.employee_name 직원이름
from order_header oh inner join customer c on oh.customer_id = c.customer_id
					inner join employee e on oh.employee_id = e.employee_id
where oh.total_due >= 8500000
and c.city = '서울'
and c.gender = 'M';

-- Q07) 주문수량이 30개 이상인 주문의 주문번호, 상품코드, 주문수량, 단가, 지불금액을 조회하세요.
select oh.order_id 주문번호, od.product_id 상품코드, od.order_qty 주문수량, od.unit_price 단가, od.line_total 지불금액
from order_header oh, order_detail od
where oh.order_id = od.order_id
and od.order_qty >= 30;

select oh.order_id 주문번호, od.product_id 상품코드, od.order_qty 주문수량, od.unit_price 단가, od.line_total 지불금액
from order_header oh inner join order_detail od on oh.order_id = od.order_id
where od.order_qty >= 30;

-- Q08) 위에서 작성한 쿼리문을 복사해서 붙여 넣은 후 상품이름도 같이 조회되도록 수정하세요.
select oh.order_id 주문번호, od.product_id 상품코드, od.order_qty 주문수량, od.unit_price 단가, od.line_total 지불금액, p.product_name 상품이름
from order_header oh, order_detail od, product p
where oh.order_id = od.order_id 
and od.product_id=p.product_id
and od.order_qty >= 30;

select oh.order_id 주문번호, od.product_id 상품코드, od.order_qty 주문수량, od.unit_price 단가, od.line_total 지불금액, p.product_name 상품이름
from order_header oh inner join order_detail od on oh.order_id = od.order_id
					 inner join product p on od.product_id = p.product_id
where od.order_qty >= 30;

-- Q09) 상품코드, 상품이름, 소분류아이디를 조회하세요.
select p.product_id, p.product_name, sc.sub_category_id
from product p, sub_category sc
where p.sub_category_id = sc.sub_category_id;

select p.product_id, p.product_name, sc.sub_category_id
from product p inner join sub_category sc on p.sub_category_id = sc.sub_category_id;

-- Q10) 위에서 작성한 쿼리문을 복사해서 붙여 넣은 후 소분류이름, 대분류아이디가 조회되게 수정하세요.
select p.product_id 상품코드, p.product_name 상품이름, sc.sub_category_id 소분류아이디, sc.sub_category_name 소분류이름, c.category_id 대분류아이디
from product p, sub_category sc, category c
where p.sub_category_id = sc.sub_category_id
and sc.category_id = c.category_id;

select p.product_id 상품코드, p.product_name 상품이름, sc.sub_category_id 소분류아이디, sc.sub_category_name 소분류이름, c.category_id 대분류아이디
from product p inner join sub_category sc on p.sub_category_id = sc.sub_category_id
			   inner join category c on sc.category_id = c.category_id;

-- Q11) 다정한 사원이 2019년에 주문한 상품명을 모두 출력해주세요.
select distinct product_name
from employee e, order_header oh, order_detail od, product p
where e.employee_id = oh.employee_id
and oh.order_id = od.order_id
and od.product_id = p.product_id
and left(oh.order_date,4) = '2019';

select distinct product_name
from employee e inner join order_header oh on e.employee_id = oh.employee_id
				inner join order_detail od on oh.order_id = od.order_id
                inner join product p on od.product_id = od.product_id;

-- Q12) 청소기를 구입한 고객아이디, 사원번호, 주문번호, 주문일시를 조회하세요.
select oh.order_id, oh.employee_id, oh.order_id, oh.order_date
from order_header oh, order_detail od, product p
where oh.order_id = od.order_id
and od.product_id = p.product_id
and p.product_name like '%청소기';

/**
	서브쿼리
*/
-- Q13) 'mtkim', 'odoh', 'soyoukim', 'winterkim' 고객 주문의 주문번호, 고객아이디, 주문일시, 전체금액을 조회하세요. 
select oh.order_id, oh.customer_id, oh.order_date, oh.total_due
from order_header oh
where customer_id in (select customer_id from order_header where customer_id in ('mtkim', 'odoh', 'soyoukim', 'winterkim'));
   
-- Q14) '전주' 지역 고객의 아이디를 조회하세요.
select customer_id
from customer 
where city in (select city from customer where city='전주');

-- Q15) 위 두 쿼리문을 조합해서 하위 쿼리를 사용해 '전주' 지역 고객 주문의 주문번호, 고객아이디, 주문일시, 전체금액을 조회하세요.
select order_id 주문번호, customer_id 고객아이디, order_date 주문일시, total_due 전체금액
from order_header
where customer_id in (select customer_id
					  from customer 
					  where city in (select city from customer where city='전주'));
                      
-- Q16) 고객의 포인트 최댓값을 조회하세요.
select max(point)
from customer;

-- Q17) 하위 쿼리를 사용해 가장 포인트가 많은 고객의 이름, 아이디, 등록일, 포인트를 조회하세요.
select customer_name, customer_id, register_date, point
from customer
where point = (select max(point) from customer);

-- Q18) 하위 쿼리를 사용해 홍길동(gdhong) 고객보다 포인트가 많은 고객 이름, 아이디, 등록일, 포인트를 조회하세요.
select customer_name, customer_id, register_date, point
from customer
where point > (select point from customer where customer_name = '홍길동');

-- Q19) 하위 쿼리를 사용해 홍길동(gdhong) 고객과 같은 지역의 고객 이름, 아이디, 지역, 등록일, 포인트를 조회하세요.
--      단, 고객 이름을 기준으로 오름차순 정렬해서 조회하세요.
select customer_name 고객이름, customer_id 아이디, city 지역, register_date 등록일, point 포인트
from customer
where city = (select city from customer where customer_id = 'gdhong')
order by 고객이름;

-- Q20) 하위 쿼리를 사용해 홍길동(gdhong) 고객보다 포인트가 많은 고객 이름, 아이디, 등록일, 포인트를 조회하고, 행번호를 추가하여 출력하세요.

select row_number() over() as rno, customer_name 고객이름, customer_id 아이디, register_date 등록일, point 포인트
from customer
where point > (select point from customer where customer_name = '홍길동');

