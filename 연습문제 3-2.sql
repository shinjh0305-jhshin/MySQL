/*1. 마당서점 도서의 총 개수*/
SELECT	COUNT(*) as '도서 개수'
FROM 	book;
/*2. 마당서점에 도서를 출고하는 출판사의 총 개수*/
SELECT 	COUNT(DISTINCT publisher) as '출판사 개수'
FROM 	book;
/*3. 모든 고객의 이름, 주소*/
SELECT	name, address
FROM	customer;
/*4. 2014년 7월 4일 ~ 7월 7일 사이에 주문받은 도서의 주문번호*/
SELECT 	orderid
FROM	orders
WHERE	orderdate >= '2014-07-04' AND orderdate <= '2014-07-07';
/*5. 2014년 7월 4일 ~ 7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호*/
SELECT	orderid
FROM 	orders
WHERE	orderdate < '2014-07-04' OR orderdate > '2014-07-07';
/*6. 성이 '김'씨인 고객의 이름과 주소*/
SELECT	name, address
FROM	customer
WHERE	name LIKE '김%';
/*7. 성이 '김'씨고 이름이 '아'로 끝나는 고객의 이름과 주소*/
SELECT	name, address
FROM	customer
WHERE	name LIKE '김_아';
/*8. 주문하지 않은 고객의 이름(부속질의 사용)*/
SELECT	name
FROM	customer
WHERE	custid NOT IN (
	SELECT	custid
    FROM	orders
);
/*9. 주문 금액의 총액과 주문의 평균 금액*/
SELECT	SUM(saleprice) AS '주문 금액', AVG(saleprice) AS '평균 금액'
FROM	orders;
/*10. 고객의 이름과 고객별 구매액*/
SELECT 		name, SUM(saleprice)
FROM		orders LEFT JOIN customer ON orders.custid = customer.custid
GROUP BY 	name;
/*11. 고객의 이름과 고객이 구매한 도서 목록*/
SELECT 		name, bookname	
FROM		((orders, book) LEFT JOIN customer ON orders.custid = customer.custid)
WHERE		orders.bookid = book.bookid
ORDER BY 	name;
/*12. 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문*/
SELECT		*
FROM		orders, book
WHERE		orders.bookid = book.bookid AND book.price - orders.saleprice = (
	SELECT	MAX(price - saleprice)
    FROM	orders, book
    WHERE	orders.bookid = book.bookid
);
/*13. 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름*/
SELECT		name
FROM		customer cs
WHERE		(
	SELECT		AVG(saleprice)
	FROM		orders od
	WHERE		cs.custid = od.custid
) > (
	SELECT		AVG(saleprice)
	FROM		orders
)
