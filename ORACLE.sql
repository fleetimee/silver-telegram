-- Query Cek Jurnal
SELECT T.NO_TX,
       T.Kd_Kantor,
       T.NO_REK,
       n.NAMA_REK,
       T.KD_TX,
       T.JML_UANG,
       t.flg_tx,
       T.NO_SSBB,
       A.NAMA_REK SSBB,
       T.KETERANGAN,
       t.flg_rev,
       t.no_arsip,
       t.tgl_val,
       t.tgl_tx
FROM rek_daytx t
         LEFT JOIN
         (SELECT no_rek, nama_nsb nama_rek FROM view_rek_all) n
         ON T.NO_REK = N.NO_REK
         LEFT JOIN rek_loan l
                   ON T.NO_REK = L.NO_REK
         LEFT JOIN mst_acssbb a
                   ON T.NO_SSBB = A.NO_SSBB
WHERE NO_ARSIP IN ('266407638633')
ORDER BY no_tx, kd_kantor, flg_tx;

-- Query No arsip yang distinct dan berdasarkan tanggal
SELECT DISTINCT NO_ARSIP FROM REK_DAYTX WHERE TO_DATE(TGL_VAL)='14-JUN-2024'

