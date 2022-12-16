insert into orders (id, status) select i, left(md5(random()::text), 4) from generate_series(1, 10000000) s(i);
insert into order_product (quantity, order_id, product_id) select floor(1+random()*50)::int, i, 1 + floor(random()*6)::int % 6 from generate_series(1, 10000000) s(i);
