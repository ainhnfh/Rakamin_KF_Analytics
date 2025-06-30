
SELECT 
  ft.transaction_id,
  ft.date,
  kc.branch_id,
  kc.branch_name,
  kc.kota,
  kc.provinsi,
  kc.rating AS rating_cabang,
  ft.customer_name,
  p.product_id,
  p.product_name,
  ft.price AS actual_price,
  ft.discount_percentage
,
  -- Hitung persentase gross laba
  CASE 
    WHEN ft.price <= 50000 THEN 0.10
    WHEN ft.price <= 100000 THEN 0.15
    WHEN ft.price <= 300000 THEN 0.20
    WHEN ft.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS persentase_gross_laba,

  -- Hitung nett sales
  ft.price - (ft.price * ft.discount_percentage) AS nett_sales,

  -- Hitung nett profit
  (ft.price - (ft.price * ft.discount_percentage)) * 
  CASE 
    WHEN ft.price <= 50000 THEN 0.10
    WHEN ft.price <= 100000 THEN 0.15
    WHEN ft.price <= 300000 THEN 0.20
    WHEN ft.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS nett_profit,
  ft.rating AS rating_transaksi 

FROM `commanding-way-464413-i0.Kimia_Farma.kf_final_transaction` ft
JOIN `commanding-way-464413-i0.Kimia_Farma.kf_kantor_cabang` kc
  ON ft.branch_id = kc.branch_id
JOIN `commanding-way-464413-i0.Kimia_Farma.kf_product` p
  ON ft.product_id = p.product_id
